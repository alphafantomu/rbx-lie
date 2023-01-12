
local name = 'NumberSequenceKeypoint';

local to = function(blob, time, value, envelope)
	blob:f32(time);
	blob:f32(value);
	blob:f32(envelope);
end;

local from = function(blob)
	local time = blob:f32();
	local value = blob:f32();
	local envelope = blob:f32();
	return time, value, envelope;
end;

local arrayTo = function(blob, arr)
	local n = #arr;
	for i = 1, n do
		local keypoint = arr[i];
		local time, value, envelope = keypoint[1], keypoint[2], keypoint[3];
		to(blob, time, value, envelope);
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