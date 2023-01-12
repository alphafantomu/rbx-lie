
local referent = require('rbx-lie/type/referent');

local supported_versions = {
	[0] = true;
};

local supportsVersion = function(version)
	return supported_versions[version] or false;
end;

local to = function(blob)

end;

local from = function(blob)
	local version = blob:u8(); assert(supportsVersion(version), 'no version support for ('..version..')');
	local n_objects = blob:s32();
	local child_referents = referent.arrayFrom(blob, n_objects);
	local parent_referents = referent.arrayFrom(blob, n_objects);
	return version, n_objects, child_referents, parent_referents;
end;

return {
	to = to;
	from = from;
	supportsVersion = supportsVersion;
};