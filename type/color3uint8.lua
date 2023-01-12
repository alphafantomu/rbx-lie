
local name = 'Color3uint8';

local uint8_arrayTo = function(blob, arr)
	local n = #arr;
	for i = 1, n do
		blob:u8(arr[i]);
	end;
end;

local uint8_arrayFrom = function(blob, count)
	local values = {};
	for i = 1, count do
		values[i] = blob:u8();
	end;
	return values;
end;

local to = function(blob, r, g, b)
	blob:u8(r);
	blob:u8(g);
	blob:u8(b);
end;

local from = function(blob)
	local r, g, b = blob:u8(), blob:u8(), blob:u8();
	return r, g, b;
end;

local arrayTo = function(blob, arr)
	local array_r, array_g, array_b = {}, {}, {};
	local n = #arr;

	for i = 1, n do
		local color3uint8 = arr[i];
		local r, g, b = color3uint8[1], color3uint8[2], color3uint8[3];
		array_r[i], array_g[i], array_b[i] = r, g, b;
	end;

	uint8_arrayTo(blob, array_r);
	uint8_arrayTo(blob, array_g);
	uint8_arrayTo(blob, array_b);
end;

local arrayFrom = function(blob, count)
	local array_r = uint8_arrayFrom(blob, count);
	local array_g = uint8_arrayFrom(blob, count);
	local array_b = uint8_arrayFrom(blob, count);

	local values = {};

	for i = 1, count do
		values[i] = {array_r[i], array_g[i], array_b[i]};
	end;

	return values;
end;

return {
	name = name;
	to = to;
	from = from;
	arrayTo = arrayTo;
	arrayFrom = arrayFrom;
};