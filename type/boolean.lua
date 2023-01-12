
local name = 'Bool';

local FALSE = 0x00;
local TRUE 	= 0x01;

local to = function(blob, v)
	blob:u8(v == true and TRUE or FALSE);
end;

local from = function(blob)
	local bool = blob:u8();
	assert(bool == FALSE or bool == TRUE, 'bool byte is neither false or true');
	return bool == TRUE and true or bool == FALSE and false;
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