
local name = 'String';

local to = function(blob, str)
	local length = str:len();
	blob:u32(length);
	blob:raw(str);
end;

local from = function(blob)
	local length = blob:u32();
	return blob:raw(length);
end;

local arrayTo = function(blob, arr)
	--maybe add a check
	local n = #arr;
	for i = 1, n do
		to(blob, arr[i]);
	end;
end;

local arrayFrom = function(blob, count)
	--maybe add a check
	local values = {};
	for i = 1, count do
		values[i] = from(blob);
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