
local name = 'Vector2';

local float = require('rbx-lie/type/float');

local to = function(blob, x, y)
	float.to(blob, x);
	float.to(blob, y);
end;

local from = function(blob)
	local x, y = float.from(blob), float.from(blob);
	return x, y;
end;

local arrayTo = function(blob, arr)
	local array_x, array_y = {}, {};
	local n = #arr;

	for i = 1, n do
		local vector2 = arr[i];
		local x, y = vector2[1], vector2[2];
		array_x[i], array_y[i] = x, y;
	end;

	float.arrayTo(blob, array_x);
	float.arrayTo(blob, array_y);
end;

local arrayFrom = function(blob, count)
	local array_x = float.arrayFrom(blob, count);
	local array_y = float.arrayFrom(blob, count);

	local values = {};

	for i = 1, count do
		values[i] = {array_x[i], array_y[i]};
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