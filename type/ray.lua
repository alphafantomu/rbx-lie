
local name = 'Ray';

local to = function(blob, origin_x, origin_y, origin_z, direction_x, direction_y, direction_z)
	blob:f32(origin_x);
	blob:f32(origin_y);
	blob:f32(origin_z);
	blob:f32(direction_x);
	blob:f32(direction_y);
	blob:f32(direction_z);
end;

local from = function(blob)
	local origin_x 		= blob:f32();
	local origin_y 		= blob:f32();
	local origin_z 		= blob:f32();
	local direction_x 	= blob:f32();
	local direction_y 	= blob:f32();
	local direction_z 	= blob:f32();
	return origin_x, origin_y, origin_z, direction_x, direction_y, direction_z;
end;

local arrayTo = function(blob, arr)
	local n = #arr;
	for i = 1, n do
		local ray = arr[i];
		local origin_x, origin_y, origin_z, direction_x, direction_y, direction_z = ray[1], ray[2], ray[3], ray[4], ray[5], ray[6];
		to(blob, origin_x, origin_y, origin_z, direction_x, direction_y, direction_z);
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