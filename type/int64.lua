
local name = 'Int64';

local array = require('rbx-lie/array');
local transform = require('rbx-lie/transform');
local util = require('rbx-lie/util');

local to = function(blob, n)
	blob:setByteOrder('>');
	local transformed = transform.int(n);
	blob:s64(transformed);
	blob:setByteOrder(util.DEFAULT_ENDIAN);
end;

local from = function(blob)
	blob:setByteOrder('>');
	local transformed = blob:s64();
	local detransformed = transform.reverseInt(transformed);
	blob:setByteOrder(util.DEFAULT_ENDIAN);
	return detransformed;
end;

local arrayTo = function(blob, arr)
	array.blobInterleaveBytes(blob, arr, util.INT64_SIZE, to);
end;

local arrayFrom = function(blob, count)
	local values = {};
	local arr = array.blobDeinterleaveBytes(blob, count, util.INT64_SIZE);
	for i = 1, count do
		values[i] = from(arr);
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