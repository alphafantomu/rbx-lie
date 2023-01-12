
local name = 'NumberRange';

local to = function(blob, min, max)
	blob:f32(min);
	blob:f32(max);
end;

local from = function(blob)
	local min = blob:f32();
	local max = blob:f32();
	return min, max;
end;

local arrayTo = function(blob, arr)
	local n = #arr;
	for i = 1, n do
		local numberrange = arr[i];
		local min, max = numberrange[1], numberrange[2];
		to(blob, min, max);
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