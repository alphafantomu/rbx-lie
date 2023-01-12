
local name = 'Referent';

local blobwriter = require('blobwriter');
local array = require('rbx-lie/array');
local transform = require('rbx-lie/transform');
local util = require('rbx-lie/util');

local to = function(blob, n)
	blob:setByteOrder('>');
	n = transform.int(n);
	blob:s32(n);
	blob:setByteOrder(util.DEFAULT_ENDIAN);
end;

local from = function(blob)
	blob:setByteOrder('>');
	local v = blob:s32();
	v = transform.reverseInt(v);
	blob:setByteOrder(util.DEFAULT_ENDIAN);
	return v;
end;

local arrayTo = function(blob, arr)
	local last = 0;
	local n = #arr;
	local array_blob = blobwriter('<');
	for i = 1, n do
		local v = arr[i];
		local difference = v - last;
		to(array_blob, difference);
		last = v;
	end;
	local bytes = array_blob:tostring();
	local interleaved = array.interleaveBytes(bytes, util.INT32_SIZE);
	blob:raw(interleaved);
end;

local arrayFrom = function(blob, count)
	local values = {};
	local arr = array.blobDeinterleaveBytes(blob, count, util.INT32_SIZE);
	local last = 0;
	for i = 1, count do
		local v = from(arr);
		v = v + last;
		values[i] = v;
		last = v;
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