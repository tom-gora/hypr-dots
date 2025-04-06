-- helpers for modyifying highlights

local M = {}

local valid_hl_keys = {
	fg = true,
	bg = true,
	bold = true,
	italic = true,
	underline = true,
	undercurl = true,
	strikethrough = true,
	inverse = true,
	nocombine = true,
	link = true,
	force = true,
}

M.modify_hl_group = function(hl_name, opts)
	local ok, _ = pcall(vim.api.nvim_get_hl, 0, { name = hl_name })
	if ok then
		local update = {}
		for k, v in pairs(opts) do
			if valid_hl_keys[k] then
				update[k] = v
			else
				vim.notify("Invalid highlight key: " .. k, vim.log.levels.WARN)
			end
		end

		vim.api.nvim_set_hl(0, hl_name, update)
	end
end

M.get_color = function(hl_name, arg)
	local ok, hl_def = pcall(vim.api.nvim_get_hl, 0, { name = hl_name })
	if not ok then
		return
	end
	return hl_def[arg] or "NONE"
end

local function clamp(x)
	return math.floor(math.min(255, math.max(0, x)))
end

M.darken = function(color, amount)
	amount = math.min(math.max(amount, 0), 1)

	local r = bit.rshift(color, 16)
	local g = bit.band(bit.rshift(color, 8), 255)
	local b = bit.band(color, 255)

	r = clamp(r * (1 - amount))
	g = clamp(g * (1 - amount))
	b = clamp(b * (1 - amount))

	return bit.lshift(r, 16) + bit.lshift(g, 8) + b
end

M.lighten = function(color, amount)
	amount = math.min(math.max(amount, 0), 1)

	local r = bit.rshift(color, 16)
	local g = bit.band(bit.rshift(color, 8), 255)
	local b = bit.band(color, 255)

	r = clamp(r + (255 - r) * amount)
	g = clamp(g + (255 - g) * amount)
	b = clamp(b + (255 - b) * amount)

	return bit.lshift(r, 16) + bit.lshift(g, 8) + b
end

M.muted_variant = function(color)
	local r = bit.rshift(color, 16)
	local g = bit.band(bit.rshift(color, 8), 255)
	local b = bit.band(color, 255)

	r = clamp(r * 0.767)
	g = clamp(g * 0.767)
	b = clamp(b * 0.767)

	return bit.lshift(r, 16) + bit.lshift(g, 8) + b
end

M.saturate = function(color, amount)
	amount = math.min(math.max(amount, 0), 1)

	local r = bit.rshift(color, 16)
	local g = bit.band(bit.rshift(color, 8), 255)
	local b = bit.band(color, 255)

	-- Convert RGB to HSL
	local max_val = math.max(r, g, b)
	local min_val = math.min(r, g, b)
	local l = (max_val + min_val) / 2

	local s = 0
	if max_val ~= min_val then
		s = (l < 128) and ((max_val - min_val) / (max_val + min_val))
			or ((max_val - min_val) / (2 * 255 - max_val - min_val))
	end

	local h = 0
	if max_val == r then
		h = (g - b) / (max_val - min_val)
	elseif max_val == g then
		h = 2 + (b - r) / (max_val - min_val)
	else
		h = 4 + (r - g) / (max_val - min_val)
	end
	h = (h * 60 + 360) % 360

	-- Increase saturation
	s = s + s * amount
	s = math.min(s, 1)

	-- Convert HSL back to RGB
	local c = (1 - math.abs(2 * l / 255 - 1)) * s
	local x = c * (1 - math.abs((h / 60) % 2 - 1))
	local m = l / 255 - c / 2

	local r_prime, g_prime, b_prime
	if h < 60 then
		r_prime, g_prime, b_prime = c, x, 0
	elseif h < 120 then
		r_prime, g_prime, b_prime = x, c, 0
	elseif h < 180 then
		r_prime, g_prime, b_prime = 0, c, x
	elseif h < 240 then
		r_prime, g_prime, b_prime = 0, x, c
	elseif h < 300 then
		r_prime, g_prime, b_prime = x, 0, c
	else
		r_prime, g_prime, b_prime = c, 0, x
	end

	r = math.floor((r_prime + m) * 255)
	g = math.floor((g_prime + m) * 255)
	b = math.floor((b_prime + m) * 255)

	r = clamp(r)
	g = clamp(g)
	b = clamp(b)

	return bit.lshift(r, 16) + bit.lshift(g, 8) + b
end

return M
