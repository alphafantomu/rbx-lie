
local openssl = require('openssl');

local MAGIC_NUMBER = '<roblox!';
local SIGNATURE = '89ff0d0a1a0a';
local RESERVED = '0000000000000000';

local supported_versions = {
	[0] = true;
};

local supportsVersion = function(version)
	return supported_versions[version] or false;
end;

local to = function(blob, version, classes, instances)
	blob:raw(MAGIC_NUMBER);
	blob:raw(openssl.hex(SIGNATURE, false));
	blob:u16(version);
	blob:s32(classes);
	blob:s32(instances);
	blob:raw(openssl.hex(RESERVED, false));
end;

local from = function(blob)
	local magic_number = blob:raw(8); assert(magic_number == MAGIC_NUMBER, 'bad magic number');
	local signature = blob:raw(6); assert(openssl.hex(signature) == SIGNATURE, 'bad signature');
	local version = blob:u16(); assert(supportsVersion(version), 'no version support for ('..version..')');
	local n_unique_types = blob:s32();
	local n_objects = blob:s32();
	local reserved = blob:raw(8);
	if (openssl.hex(reserved) ~= RESERVED) then
		print('Header reserved bytes are not zeros');
	end;
	return version, n_unique_types, n_objects;
end;

return {
	to = to;
	from = from;
	supportsVersion = supportsVersion;
};