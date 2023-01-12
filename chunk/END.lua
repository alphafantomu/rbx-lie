
local MAGIC_NUMBER = '</roblox>';

local to = function(blob)
	blob:raw(MAGIC_NUMBER);
end;

local from = function(blob)
	return blob:raw(9) == MAGIC_NUMBER;
end;

return {
	to = to;
	from = from;
}