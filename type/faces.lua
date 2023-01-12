
local name = 'Faces';

-- SINGLE BYTE

-- concept unknown

local to = function(stream, front, back, top, bottom, left, right)
	stream:writeU8(front);
	stream:writeU8(back);
	stream:writeU8(top);
	stream:writeU8(bottom);
	stream:writeU8(left);
	stream:writeU8(right);
	stream:writeU8(0);
	stream:writeU8(0);
end;

local from = function(stream)
	local front, back = stream:readU8(1), stream:readU8(1);
	local top, bottom = stream:readU8(1), stream:readU8(1);
	local left, right = stream:readU8(1), stream:readU8(1);
	-- read two remaining bytes
	stream:readU8(1);
	stream:readU8(1);
	return front, back, top, bottom, left, right;
end;

local arrayTo = function(stream, arr)
	local n = #arr;
	for i = 1, n do
		local face = arr[i];
		local front, back = face[1], face[2];
		local top, bottom = face[3], face[4];
		local left, right = face[5], face[6];
		to(stream, front, back, top, bottom, left, right);
	end;
end;

local arrayFrom = function(stream, count)
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