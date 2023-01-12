
local name = 'UDim';

local float = require('rbx-lie/type/float');
local int32 = require('rbx-lie/type/int32');

local to = function(blob, scale, offset)
	float.to(blob, scale);
	int32.to(blob, offset);
end;

local from = function(blob)
	local scale = float.from(blob);
	local offset = int32.from(blob);
	return scale, offset;
end;

local arrayTo = function(blob, arr)
	local array_scale, array_offset = {}, {};
	local n = #arr;

	for i = 1, n do
		local udim = arr[i];
		local scale, offset = udim[1], udim[2];
		array_scale[i], array_offset[i] = scale, offset;
	end;

	float.arrayTo(blob, array_scale);
	int32.arrayTo(blob, array_offset);
end;

local arrayFrom = function(blob, count)
	local array_scale = float.arrayFrom(blob, count);
	local array_offset = int32.arrayFrom(blob, count);

	local values = {};

	for i = 1, count do
		values[i] = {array_scale[i], array_offset[i]};
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