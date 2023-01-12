
local name = 'Vector3int16';

local to = function(blob, x, y, z)
	blob:s16(x);
	blob:s16(y);
	blob:s16(z);
end;

local from = function(blob)
	local x, y, z = blob:s16(), blob:s16(), blob:s16();
	return x, y, z;
end;

local arrayTo = function(blob, arr)
	local n = #arr;

	for i = 1, n do
		local vector3int16 = arr[i];
		local x, y, z = vector3int16[1], vector3int16[2], vector3int16[3];
		to(x, y, z);
	end;
end;

local arrayFrom = function(blob, count)
	local values = {};

	for i = 1, count do
		values[i] = {from(blob)};
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