
local name = 'Enum';

local array = require('rbx-lie/array');
local util = require('rbx-lie/util');

local to = function(blob, n)
	blob:setByteOrder('>');
	blob:u32(n);
	blob:setByteOrder(util.DEFAULT_ENDIAN);
end;

local from = function(blob)
	blob:setByteOrder('>');
	local n = blob:u32();
	blob:setByteOrder(util.DEFAULT_ENDIAN);
	return n;
end;

local arrayTo = function(blob, arr)
	array.blobInterleaveBytes(blob, arr, util.INT32_SIZE, to);
end;

local arrayFrom = function(blob, count)
	local values = {};
	local arr = array.blobDeinterleaveBytes(blob, count, util.INT32_SIZE);
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