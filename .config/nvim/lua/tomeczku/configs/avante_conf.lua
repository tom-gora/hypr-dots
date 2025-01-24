-- avante_conf.lua

local M = {}

M.opts = {
	-- provider = "ollama",
	-- vendors = {
	-- 	ollama = {
	-- 		__inherited_from = "openai",
	-- 		api_key_name = "",
	-- 		endpoint = "http://127.0.0.1:11434/v1",
	-- 		model = "qwen2.5-coder:14b",
	-- 		temperature = 0.3,
	-- 		max_tokens = 2048,
	-- 	},
	-- },
	--
	-- fix from:
	-- https://github.com/yetone/avante.nvim/issues/1067#issuecomment-2585550870
	debug = true,
	provider = "ollama",
	vendors = {
		---@type AvanteProvider
		ollama = {
			api_key_name = "",
			ask = "",
			endpoint = "http://127.0.0.1:11434/api",
			model = "phi4",
			-- model = "qwen2.5-coder:14b",
			-- model = "llama3.1:latest",
			parse_curl_args = function(opts, code_opts)
				return {
					url = opts.endpoint .. "/chat",
					headers = {
						["Accept"] = "application/json",
						["Content-Type"] = "application/json",
					},
					body = {
						model = opts.model,
						options = {
							num_ctx = 16384,
						},
						messages = require("avante.providers").copilot.parse_messages(code_opts), -- you can make your own message, but this is very advanced
						stream = true,
					},
				}
			end,
			parse_stream_data = function(data, handler_opts)
				-- Parse the JSON data
				local json_data = vim.fn.json_decode(data)
				-- Check if the response contains a message
				if json_data and json_data.message and json_data.message.content then
					-- Extract the content from the message
					local content = json_data.message.content
					-- Call the handler with the content
					handler_opts.on_chunk(content)
				end
			end,
		},
	},
}

M.deps = {
	"stevearc/dressing.nvim",
	"nvim-lua/plenary.nvim",
	"MunifTanjim/nui.nvim",
	"hrsh7th/nvim-cmp",
	"nvim-tree/nvim-web-devicons",
	{
		"MeanderingProgrammer/render-markdown.nvim",
		opts = {
			file_types = { "markdown", "Avante" },
		},
		ft = { "markdown", "Avante" },
	},
}

return M
