
local dtype = require('rbx-lie/type');
local tstring = require('rbx-lie/type/string');

local to = function(blob)

end;

local from = function(blob, types)
	local type_id = blob:u32();
	local property_name = tstring.from(blob);
	local data_type = blob:u8();
	local type_data = assert(types[type_id], 'type data for id ('..type_id..') not found');
	local instances = type_data.instances;
	local type_handler = dtype.map.get(data_type);
	local values = type_handler.arrayFrom(blob, instances);
	return type_id, property_name, type_handler.name, values;
end;

return {
	to = to;
	from = from;
};