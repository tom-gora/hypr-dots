local M

M = {
	"tom-gora/BigSheetGardna.nvim",
	event = { "BufNewFile", "BufRead" }, -- if lazy load
	config = function()
		---@param size integer
		---@return integer
		local sizeInMib = function(size)
			return size * 1024 * 1024
		end
		require("big_sheet_gardna").setup({
			notify = true, -- Show notification for large files
			size_threshold = sizeInMib(2),
		})
	end,
}

return M
