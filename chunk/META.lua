
local tstring = require('rbx-lie/type/string');

local to = function(blob)

end;

local from = function(blob)
	local n_entries = blob:u32();
	local map = {};
	for _ = 1, n_entries do
		local key = tstring.from(blob);
		local value = tstring.from(blob);
		map[key] = value;
	end;
	return map;
end;

return {
	to = to;
	from = from;
};