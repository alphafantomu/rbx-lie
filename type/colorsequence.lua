
local name = 'ColorSequence';

local colorsequencekeypoint = require('rbx-lie/type/struct/colorsequencekeypoint');

local to = function(blob, keypoints)
	local keypoint_count = #keypoints;
	blob:u32(keypoint_count);
	colorsequencekeypoint.arrayTo(blob, keypoints);
end;

local from = function(blob)
	local keypoint_count = blob:u32();
	local keypoints = colorsequencekeypoint.arrayFrom(blob, keypoint_count);
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