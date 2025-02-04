vim.b.yaml = true

local filename = vim.fn.expand("%:t")

if string.find(filename, "compose") or string.find(filename, "docker") then
	vim.bo.filetype = "yaml.docker-compose"

	require("lspconfig").docker_compose_language_service.setup({})
end
