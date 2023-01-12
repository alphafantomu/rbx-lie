
local tstring = require('rbx-lie/type/string');

local supported_versions = {
	[0] = true;
};

local supportsVersion = function(version)
	return supported_versions[version] or false;
end;

local to = function(blob)

end;

local from = function(blob)
	local version = blob:u32(); assert(supportsVersion(version), 'no version support for ('..version..')');
	local shared_string_count = blob:u32();
	local values = {};
	for i = 1, shared_string_count do
		local md5_hash = blob:raw(16);
		local shared_string = tstring(blob);
		values[i] = {md5_hash, shared_string};
	end;
	return values;
end;

return {
	to = to;
	from = from;
};