
local name = 'Rect';

local float = require('rbx-lie/type/float');

local to = function(blob, min_x, min_y, max_x, max_y)
	float.to(blob, min_x);
	float.to(blob, min_y);
	float.to(blob, max_x);
	float.to(blob, max_y);
end;

local from = function(blob)
	local min_x = float.from(blob);
	local min_y = float.from(blob);
	local max_x = float.from(blob);
	local max_y = float.from(blob);
	return min_x, min_y, max_x, max_y;
end;

local arrayTo = function(blob, arr)
	local array_min_x, array_min_y, array_max_x, array_max_y = {}, {}, {}, {};
	local n = #arr;

	for i = 1, n do
		local rect = arr[i];
		local min_x, min_y, max_x, max_y = rect[1], rect[2], rect[3], rect[4];
		array_min_x[i], array_min_y[i], array_max_x[i], array_max_y[i] = min_x, min_y, max_x, max_y;
	end;

	float.arrayTo(blob, array_min_x);
	float.arrayTo(blob, array_min_y);
	float.arrayTo(blob, array_max_x);
	float.arrayTo(blob, array_max_y);
end;

local arrayFrom = function(blob, count)
	local array_min_x = float.arrayFrom(blob, count);
	local array_min_y = float.arrayFrom(blob, count);
	local array_max_x = float.arrayFrom(blob, count);
	local array_max_y = float.arrayFrom(blob, count);

	local values = {};

	for i = 1, count do
		values[i] = {array_min_x[i], array_min_y[i], array_max_x[i], array_max_y[i]};
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