vim.b.yaml = true

-- NOTE:
-- not every yaml file is a docker compose file so this is very simple
-- implementatio that attempts to only attach docker lsp where appropriate

local filename = vim.fn.expand("%:t")

if string.find(filename, "compose") or string.find(filename, "docker") then
	vim.bo.filetype = "yaml.docker-compose"
	require("lspconfig").docker_compose_language_service.setup({})
end
