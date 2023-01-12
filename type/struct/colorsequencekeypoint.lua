
local name = 'ColorSequenceKeypoint';

local to = function(blob, time, r, g, b, envelope)
	blob:f32(time);
	blob:f32(r);
	blob:f32(g);
	blob:f32(b);
	blob:f32(envelope);
end;

local from = function(blob)
	local time = blob:f32();
	local r = blob:f32();
	local g = blob:f32();
	local b = blob:f32();
	local envelope = blob:f32();
	return time, r, g, b, envelope;
end;

local arrayTo = function(blob, arr)
	local n = #arr;
	for i = 1, n do
		local keypoint = arr[i];
		local time, r, g, b, envelope = keypoint[1], keypoint[2], keypoint[3], keypoint[4], keypoint[5];
		to(blob, time, r, g, b, envelope);
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