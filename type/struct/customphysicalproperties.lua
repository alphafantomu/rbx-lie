
local name = 'CustomPhysicalProperties';

local to = function(blob, density, friction, elasticity, friction_weight, elasticity_weight)
	blob:f32(density);
	blob:f32(friction);
	blob:f32(elasticity);
	blob:f32(friction_weight);
	blob:f32(elasticity_weight);
end;

local from = function(blob)
	local density = blob:f32();
	local friction = blob:f32();
	local elasticity = blob:f32();
	local friction_weight = blob:f32();
	local elasticity_weight = blob:f32();
	return density, friction, elasticity, friction_weight, elasticity_weight;
end;

local arrayTo = function(blob, arr)
	local n = #arr;
	for i = 1, n do
		local keypoint = arr[i];
		local density, friction, elasticity, friction_weight, elasticity_weight = keypoint[1], keypoint[2], keypoint[3], keypoint[4], keypoint[5];
		to(blob, density, friction, elasticity, friction_weight, elasticity_weight);
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