#!/bin/bash

menufile="$HOME/.config/waybar/ollama-model-menu.xml" >"$menufile"
modulesfile="$HOME/.config/waybar/modules.json"
names=()
while IFS= read -r name; do
	names+=("$name")
done < <(ollama ls | awk '{ print $1 }' | tail -n +2)

rewrite_menufile() {
	cat <<EOF >>"$menufile"
<?xml version="1.0" encoding="UTF-8"?>
<interface>
  <object class="GtkMenu" id="menu">
EOF
	for name in "${names[@]}"; do
		cat <<EOF >>"$menufile"
    <child>
        <object class="GtkMenuItem" id="$name">
            <property name="label">$name</property>
        </object>
    </child>
EOF
	done

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
}

rewrite_menufile
rewrite_modulesfile
