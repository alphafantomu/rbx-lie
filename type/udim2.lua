
local name = 'UDim2';

local float = require('rbx-lie/type/float');
local int32 = require('rbx-lie/type/int32');

local to = function(blob, x_scale, y_scale, x_offset, y_offset)
	float.to(blob, x_scale);
	float.to(blob, y_scale);
	int32.to(blob, x_offset);
	int32.to(blob, y_offset);
end;

local from = function(blob)
	local x_scale = float.from(blob);
	local y_scale = float.from(blob);
	local x_offset = int32.from(blob);
	local y_offset = int32.from(blob);
	return x_scale, y_scale, x_offset, y_offset;
end;

local arrayTo = function(blob, arr)
	local array_x_scale, array_y_scale, array_x_offset, array_y_offset = {}, {}, {}, {};
	local n = #arr;

	for i = 1, n do
		local udim2 = arr[i];
		local x_scale, y_scale, x_offset, y_offset = udim2[1], udim2[2], udim2[3], udim2[4];
		array_x_scale[i], array_y_scale[i], array_x_offset[i], array_y_offset[i] = x_scale, y_scale, x_offset, y_offset;
	end;

	float.arrayTo(blob, array_x_scale);
	float.arrayTo(blob, array_y_scale);
	int32.arrayTo(blob, array_x_offset);
	int32.arrayTo(blob, array_y_offset);
end;

local arrayFrom = function(blob, count)
	local array_x_scale = float.arrayFrom(blob, count);
	local array_y_scale = float.arrayFrom(blob, count);
	local array_x_offset = int32.arrayFrom(blob, count);
	local array_y_offset = int32.arrayFrom(blob, count);

	local values = {};

	for i = 1, count do
		values[i] = {array_x_scale[i], array_y_scale[i], array_x_offset[i], array_y_offset[i]};
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