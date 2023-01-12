
local name = 'Double';

local to = function(blob, n)
	blob:f64(n);
end;

local from = function(blob)
	return blob:f64();
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