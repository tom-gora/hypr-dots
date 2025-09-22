-- function to use in theme files
--
return function(h, s, l)
	s = s / 100.0
	l = l / 100.0

	local C = (1 - math.abs(2 * l - 1)) * s
	local X = C * (1 - math.abs(h / 60 % 2 - 1))
	local m = l - C / 2

	local r_prime, g_prime, b_prime = 0.0, 0.0, 0.0

	if 0 <= h and h < 60 then
		r_prime, g_prime, b_prime = C, X, 0
	elseif 60 <= h and h < 120 then
		r_prime, g_prime, b_prime = X, C, 0
	elseif 120 <= h and h < 180 then
		r_prime, g_prime, b_prime = 0, C, X
	elseif 180 <= h and h < 240 then
		r_prime, g_prime, b_prime = 0, X, C
	elseif 240 <= h and h < 300 then
		r_prime, g_prime, b_prime = X, 0, C
	elseif 300 <= h and h < 360 then
		r_prime, g_prime, b_prime = C, 0, X
	end

	local r = math.floor((r_prime + m) * 255 + 0.5)
	local g = math.floor((g_prime + m) * 255 + 0.5)
	local b = math.floor((b_prime + m) * 255 + 0.5)

	return string.format("#%02x%02x%02x", r, g, b)
end
