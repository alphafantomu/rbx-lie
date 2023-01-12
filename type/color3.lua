
local name = 'Color3';

local float = require('rbx-lie/type/float');

local to = function(blob, r, g, b)
	float.to(blob, r);
	float.to(blob, g);
	float.to(blob, b);
end;

local from = function(blob)
	local r, g, b = float.from(blob), float.from(blob), float.from(blob);
	return r, g, b;
end;

local arrayTo = function(blob, arr)
	local array_r, array_g, array_b = {}, {}, {};
	local n = #arr;

	for i = 1, n do
		local color3 = arr[i];
		local r, g, b = color3[1], color3[2], color3[3];
		array_r[i], array_g[i], array_b[i] = r, g, b;
	end;

	float.arrayTo(blob, array_r);
	float.arrayTo(blob, array_g);
	float.arrayTo(blob, array_b);
end;

local arrayFrom = function(blob, count)
	local array_r = float.arrayFrom(blob, count);
	local array_g = float.arrayFrom(blob, count);
	local array_b = float.arrayFrom(blob, count);

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