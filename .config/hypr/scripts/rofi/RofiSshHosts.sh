#!/usr/bin/env bash
# shellcheck disable=SC1090

# MIT license (c) 2022-2024 https://github.com/slowpeek
# Homepage: https://github.com/slowpeek/rofi-ssh-user

set -eu

# Alternative rofi ssh picker.

SCRIPT_VERSION=0.1.3+git

t_green=$'\e[32m'
t_red=$'\e[31m'
t_yellow=$'\e[33m'
t_reset=$'\e(B\e[m'

_log() {
	((verb < $1)) && return
	echo "$2" "${@:3}" >&2
}

log_info() { _log 3 "${t_green}info:${t_reset}" "$@"; }
log_warn() { _log 2 "${t_yellow}warning:${t_reset}" "$@"; }
log_err() { _log 1 "${t_red}error:${t_reset}" "$@"; }

bye() {
	local pre=()
	[[ -z ${bye_prefix:-} ]] || pre+=("${bye_prefix}:")

	log_err "${pre[@]}" "$@"
	exit 1
}

tilderize() {
	[[ $1 == "$HOME"* ]] && echo "~${1#"$HOME"}" || echo "$1"
}

check_empty() {
	[[ -n $1 ]] || bye "${@:2}"
}

check_path() {
	local op path=$1
	shift

	local bye_prefix=$path

	for op; do
		case $op in
		e) [[ -e $path ]] || bye no such file ;;
		f) [[ -f $path ]] || bye not a regular file ;;
		r) [[ -r $path ]] || bye the file is not readable ;;
		x) [[ -x $path ]] || bye the file is not executable ;;
		esac
	done
}

check_exec() {
	if [[ $1 == */* ]]; then
		check_path "$1" e f r x
	else
		type -P "$1" &>/dev/null || bye "'$1'" is not available in \$PATH
	fi
}

version() {
	echo "rofi-ssh-user $SCRIPT_VERSION"
	exit
}

usage() {
	cat <<EOF
USAGE --

${BASH_SOURCE[0]##*/} [options] [-- [rofi options]]

Generic options:
-a, --align                Align menu items in two columns. Only meaningful for monospace fonts
-c, --config <config>      Use custom ssh config instead of default ~/.ssh/config
-t, --terminal <terminal>  Use custom terminal app instead of default x-terminal-emulator.
                           It can be either a path or a binary name available in \$PATH

Special options:
-h, --help                 Show usage
-q                         Less verbose output: mute info messages
-qq                        Less verbose output: mute info and warning messages
-s                         Simulate mode: dump the command to be run instead of running it
-ss                        Simulate mode: dump the list of items parsed from the ssh config
-V, --version              Show version

Extra options after '--' are passed directly to rofi.

Default generic options and those tailored for rofi can be set in
$(tilderize "$defaults") with options() and rofi_options()
arrays in bash syntax.

'Host' sections in ssh config file can contain commands to alter the
menu. Command syntax: '#+ command arg1 arg2 ...'. Available commands:

alt                        Alternative users to use with the host
hide                       Do not show this host in menu

More details and examples at https://github.com/slowpeek/rofi-ssh-user
EOF

	exit
}

parse_ssh_config() {
	local user hosts=() hide alts
	[[ $2 == result ]] || local -n result=$2
	result=()

	reset_vars() {
		user=
		hide=n
		alts=()
	}

	end_section() {
		[[ ! -v hosts ]] && return

		if [[ $hide == n ]]; then
			local users=("${user:+$user@}" "${alts[@]/%/@}") h

			for h in "${hosts[@]}"; do
				# Skip patterns and negations.
				[[ $h == *[*?!]* ]] && continue

				result+=("${users[@]/%/$h}")
			done
		fi

		reset_vars
	}

	reset_vars

	local token line seek=y
	while read -r token line; do
		if [[ $seek == y ]]; then
			if [[ ${token,,} == host ]]; then
				seek=n
				read -ra hosts <<<"$line"
			fi
		else
			case ${token,,} in
			match)
				end_section
				seek=y
				;;

			host)
				end_section
				read -ra hosts <<<"$line"
				;;

			user)
				[[ -n $user ]] || user=$line
				;;

			'#+')
				read -r token line <<<"$line"

				case ${token,,} in
				hide)
					hide=y
					;;
				alt)
					[[ -v alts ]] || read -ra alts <<<"$line"
					;;
				esac
				;;
			esac
		fi
	done <"$1"

	end_section
	unset -f reset_vars end_section
}

# Align user@host list in two columns.
align_list() {
	local IFS=@ user host len=0 list=()

	while read -r user host; do
		((${#user} > len)) && len=${#user}
		list+=("$user" "$host")
	done

	((len += 2))
	printf "%-${len}s@%s\n" "${list[@]}"
}

opt_parse() {
	# jetopt aalign cconfig: hhelp q s tterminal: Vversion
	getopt -o ac:hqst:V -l align,config:,help,terminal:,version -- "$@"
}

# Apply options only meaningful as direct cli args. In particular
# $verb must be set early, before sourcing the defaults file.
opt_first_pass() {
	while (($#)); do
		case $1 in
		--)
			break
			;;
		-c | --config | -t | --terminal)
			shift
			;;
		-h | --help)
			usage
			;;
		-q)
			((--verb)) || verb=1
			;;
		-s)
			((++simulate))
			;;
		-V | --version)
			version
			;;
		esac

		shift
	done
}

source_defaults() {
	if [[ -e $defaults ]]; then
		log_info found defaults file "$(tilderize "$defaults")"
		check_path "$defaults" f r
		source "$defaults"
	fi
}

# Insert $rofi_options into $options after first '--'. Both are
# arrays.
inject_options_rofi() {
	local -n dst=options
	local -n src=options_rofi

	set -- "${dst[@]}"
	dst=()

	while (($#)); do
		dst+=("$1")

		if [[ $1 == -- ]]; then
			shift
			dst+=("${src[@]}" "$@")
			break
		fi

		shift
	done
}

main() {
	local \
		config=~/.ssh/config \
		defaults=~/.config/rofi-ssh-user.defaults \
		format=tee \
		simulate=0 \
		terminal="wezterm"
	verb=3

	local opts
	opts=$(opt_parse "$@") || exit
	eval set -- "$opts"

	opt_first_pass "$@"

	local options=() options_rofi=()
	source_defaults

	if [[ -v options ]]; then
		log_info default options: "${options[@]}"
		set -- "${options[@]}" "$@"
	fi

	opts=$(opt_parse "$@") || exit
	eval set -- "$opts"

	if [[ -v options_rofi ]]; then
		log_info default rofi options: "${options_rofi[@]}"

		options=("$@")
		inject_options_rofi
		set -- "${options[@]}"
	fi

	# Opt second pass
	while (($#)); do
		case $1 in
		--)
			shift
			break
			;;
		-a | --align)
			format=align_list
			;;
		-c | --config)
			config=$2
			shift
			;;
		-t | --terminal)
			terminal=$2
			shift
			;;
		esac

		shift
	done

	check_exec rofi

	check_empty "$config" -c value is empty
	check_path "$config" e f r

	check_empty "$terminal" -t value is empty
	check_exec "$terminal"

	# Done with options

	local items_raw=()
	parse_ssh_config "$config" items_raw

	if [[ ! -v items_raw ]]; then
		log_warn No hosts found in "$(tilderize "$config")"
		exit
	fi

	if ((simulate > 1)); then
		printf '%s\n' "${items_raw[@]}"
		exit
	fi

	local items=() item
	for item in "${items_raw[@]}"; do
		[[ $item == *@* ]] || item='<default>@'$item
		items+=("$item")
	done

	item=$(printf "%s\n" "${items[@]}" | sort -u -t@ -k2,2 -k1,1 | "$format" |
		rofi -dmenu -p ssh "$@")
	[[ -n $item ]] || exit

	item=${item// /}
	local cmd=("$terminal" -e ssh -F "$config" "${item#<default>@}")

	((simulate)) || exec "${cmd[@]}"

	echo "${cmd[@]}"
}

[[ ! ${BASH_SOURCE[0]##*/} == "${0##*/}" ]] || main "$@"
