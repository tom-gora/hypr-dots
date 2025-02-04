#!/bin/bash

# Create or truncate the target XML file
menufile="$HOME/.config/waybar/ollama-model-menu.xml" >"$menufile"
modulesfile="$HOME/.config/waybar/modules.json"
names=()
while IFS= read -r name; do
	names+=("$name")
done < <(ollama ls | awk '{ print $1 }' | tail -n +2)

rewrite_menufile() {
	# Start writing the XML header and opening tags
	cat <<EOF >>"$menufile"
<?xml version="1.0" encoding="UTF-8"?>
<interface>
  <object class="GtkMenu" id="menu">
EOF
	# Append each name to the XML file
	for name in "${names[@]}"; do
		cat <<EOF >>"$menufile"
    <child>
        <object class="GtkMenuItem" id="$name">
            <property name="label">$name</property>
        </object>
    </child>
EOF
	done

	# Append the closing tags
	cat <<EOF >>"$menufile"
  </object>
</interface>
EOF
}

rewrite_modulesfile() {
	jq --argjson names "$(printf '%s\n' "${names[@]}" | jq -R . | jq -s .)" \
		'."custom/ollama-model" |= ( . + { "menu-actions": (."menu-actions" // {}) } | 
        ."menu-actions" += ( reduce $names[] as $name ({}; .[$name] = "ollama run " + $name ) ) )' \
		"$modulesfile" >"${modulesfile}.tmp" && mv "${modulesfile}.tmp" "$modulesfile"

	#  need the code for this function. high level description of steps:
	#
	#  Inside of "modulesfile" using jq find object under the following key: "custom/ollama-model".
	#  It will have a structure like so:
	#  "custom/ollama-model": {
	#      "format": "{}",
	#      "exec": "$HOME/.config/hypr/scripts/utils/OllamaModel.sh",
	#      "interval": 1,
	#      "tooltip": "false",
	#      "menu": "on-click",
	#      "menu-file": "$HOME/.config/waybar/ollama-model-menu.xml",
	#      "menu-actions": {
	#      // some items from previous setup
	#      }
	#    },
	#
	#  In it this "menu-actions" key object, for each $name arg insert a new key like so and save
	#        "$name": "ollama run ${name}" so each named key corresponds to name, to id in the xml above
	#        and the value is the command to run (which is ollama run {model nname})
	#
	#  only output rewrite_moodulesfile() function the rest of the code stays the same
}

rewrite_menufile
rewrite_modulesfile
