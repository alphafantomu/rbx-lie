
local name = 'PhysicalProperties';

local customphysicalproperties = require('rbx-lie/type/struct/customphysicalproperties');

local to = function(blob, properties)
	local customproperties = properties and 1 or 0;
	blob:u8(customproperties);
	if (customproperties == 1) then
		customphysicalproperties.to(blob, properties[1], properties[2], properties[3], properties[4], properties[5]);
	end;
end;

local from = function(blob)
	local customproperties = blob:u8(); assert(customproperties == 1 or customproperties == 0, 'custom properties must either be 0 or 1');
	local has_customphysicalproperties = customproperties == 1 and true or customproperties == 0 and false;
	if (has_customphysicalproperties) then
		return has_customphysicalproperties, customphysicalproperties.from(blob);
	end;
	return has_customphysicalproperties;
end;

local arrayTo = function(blob, arr)
	local n = table.maxn(arr);
	for i = 1, n do
		to(blob, arr[i]);
	end;
end;

local arrayFrom = function(blob, count)
	local values = {};
	for i = 1, count do
		values[i] = {from(blob)};
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