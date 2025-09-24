export FZF_DEFAULT_OPTS="
	--color=bg:{{ background | saturate(0.2) | darken(0.9) | blend("#000000")}},fg:{{ color12 }},hl:{{ color3 }},selected-fg:{{ foreground }}
	--color=fg+:bright-white,bg+:{{background | saturate(0.2) | darken(0.6)}},hl+:{{ color3 }},gutter:-1,selected-fg:{{ foreground }}
	--color=border:{{ color5 }},header:{{ color5 }},border:bold
	--color=spinner:{{color6 | saturate(0.2) | blend("#EAC341")}},info:{{ color8 }},separator:{{background |  saturate(0.4) | lighten(0.1)}}
	--color=pointer:{{color7 | saturate(0.2) | blend("#6AA07E")}},marker:{{color4 | saturate(0.2) | blend("#D52915")}},prompt:{{ color12 }}
  --preview-window right:60%:wrap
  --bind ctrl-p:toggle-preview
  --bind ctrl-j:down,ctrl-k:up,ctrl-a:accept-non-empty"
