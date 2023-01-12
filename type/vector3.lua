
local name = 'Vector3';

local float = require('rbx-lie/type/float');

local to = function(blob, x, y, z)
	float.to(blob, x);
	float.to(blob, y);
	float.to(blob, z);
end;

local from = function(blob)
	local x, y, z = float.from(blob), float.from(blob), float.from(blob);
	return x, y, z;
end;

local arrayTo = function(blob, arr)
	local array_x, array_y, array_z = {}, {}, {};
	local n = #arr;

	for i = 1, n do
		local vector3 = arr[i];
		local x, y, z = vector3[1], vector3[2], vector3[3];
		array_x[i], array_y[i], array_z[i] = x, y, z;
	end;

	float.arrayTo(blob, array_x);
	float.arrayTo(blob, array_y);
	float.arrayTo(blob, array_z);
end;

local arrayFrom = function(blob, count)
	local array_x = float.arrayFrom(blob, count);
	local array_y = float.arrayFrom(blob, count);
	local array_z = float.arrayFrom(blob, count);

	local values = {};

	for i = 1, count do
		values[i] = {array_x[i], array_y[i], array_z[i]};
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