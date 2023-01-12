
local name = 'NumberSequence';

local numbersequencekeypoint = require('rbx-lie/type/struct/numbersequencekeypoint');

local to = function(blob, keypoints)
	local keypoint_count = #keypoints;
	blob:u32(keypoint_count);
	numbersequencekeypoint.arrayTo(blob, keypoints);
end;

local from = function(blob)
	local keypoint_count = blob:u32();
	local keypoints = numbersequencekeypoint.arrayFrom(blob, keypoint_count);
	return keypoint_count, keypoints;
end;

local arrayTo = function(blob, arr)
	local n = #arr;
	for i = 1, n do
		to(blob, arr[i]);
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