
local referent = require('rbx-lie/type/referent');
local tstring = require('rbx-lie/type/string');
local boolean = require('rbx-lie/type/boolean');

local to = function(blob)

end;

local from = function(blob)
	local type_id = blob:u32();
	local type_name = tstring.from(blob);
	local has_additional_data_present = boolean.from(blob);
	local n_objects = blob:u32();
	local referents = referent.arrayFrom(blob, n_objects);
	if (has_additional_data_present) then --helps check for amount of services the place has
		blob:raw(n_objects);
	end;
	return type_id, type_name, has_additional_data_present, n_objects, referents;
end;

return {
	to = to;
	from = from;
};