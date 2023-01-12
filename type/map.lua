
local map = {
	[0x1] 	= require('rbx-lie/type/string');
	[0x2] 	= require('rbx-lie/type/boolean');
	[0x3] 	= require('rbx-lie/type/int32');
	[0x4] 	= require('rbx-lie/type/float');
	[0x5] 	= require('rbx-lie/type/double');
	[0x6] 	= require('rbx-lie/type/udim');
	[0x7] 	= require('rbx-lie/type/udim2');
	[0x8] 	= require('rbx-lie/type/ray');
	[0x9] 	= require('rbx-lie/type/faces'); --incomplete
	[0xA] 	= require('rbx-lie/type/axes'); --incomplete
	[0xB] 	= require('rbx-lie/type/brickcolor');
	[0xC] 	= require('rbx-lie/type/color3');
	[0xD] 	= require('rbx-lie/type/vector2');
	[0xE] 	= require('rbx-lie/type/vector3');
	[0x10] 	= require('rbx-lie/type/cframe'); --incomplete
	[0x12] 	= require('rbx-lie/type/enum');
	[0x13] 	= require('rbx-lie/type/referent');
	[0x14] 	= require('rbx-lie/type/vector3int16');
	[0x15] 	= require('rbx-lie/type/numbersequence');
	[0x16] 	= require('rbx-lie/type/colorsequence');
	[0x17] 	= require('rbx-lie/type/numberrange');
	[0x18] 	= require('rbx-lie/type/rect');
	[0x19] 	= require('rbx-lie/type/physicalproperties');
	[0x1A] 	= require('rbx-lie/type/color3uint8');
	[0x1B] 	= require('rbx-lie/type/int64');
	[0x1C] 	= require('rbx-lie/type/sharedstring');
	[0x1E] 	= require('rbx-lie/type/optionalcoordinateframe'); --incomplete
};

local map_lookup;

local generateLookup = function()
	if (not map_lookup) then
		map_lookup = {};
		for datatype_id, handler in next, map do
			local name = assert(handler.name, 'type handler missing name');
			map_lookup[name] = datatype_id;
		end;
	end;
end;

local get = function(id)
	local handler = map[id];
	if (not handler) then
		print('rbx-lie: type "'..id..'" not supported');
	end;
	return handler;
end;

local getByName = function(name)
	generateLookup();
	local datatype_id = map_lookup[name];
	if (datatype_id) then
		return map[datatype_id];
	end;
end;

return {
	get = get;
	getByName = getByName;
};