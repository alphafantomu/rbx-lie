
local name = 'Axes';

--SINGLE BYTE

--concept and export purpose is unknown?

local to = function(blob, x, y, z)
	
end;

local from = function(blob)
	local byte = blob:raw(1);
	
end;

local arrayTo = function(blob, arr)
	local n = #arr;
	for i = 1, n do
		local face = arr[i];
		local front, back = face[1], face[2];
		local top, bottom = face[3], face[4];
		local left, right = face[5], face[6];
		to(stream, front, back, top, bottom, left, right);
	end;
end;

local arrayFrom = function(blob, count)
	local values = {};
	for i = 1, count do
		values[i] = {from(stream)};
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