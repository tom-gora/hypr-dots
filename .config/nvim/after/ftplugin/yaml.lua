vim.b.yaml = true

-- NOTE:
-- not every yaml file is a docker compose file so this is very simple
-- implementatio that attempts to only attach docker lsp where appropriate

local filename = vim.fn.expand("%:t")

if string.find(filename, "compose") or string.find(filename, "docker") then
	vim.bo.filetype = "yaml.docker-compose"

	-- vim.lsp.enable("docker-compose-language-service")
	-- vim.lsp.start({
	-- 	name = "docker-compose-language-service",
	-- 	cmd = { "docker-compose-language-service", "--stdio" },
	-- 	root_dir = vim.fs.root(0, { "compose.yml", "docker-compose", "docker-compose.yml" }),
	-- })
end
