
local blobreader = require('blobreader');

local header = require('rbx-lie/header');
local chunk = require('rbx-lie/chunk');

local fillWithArray = function(t, index, value)
	local list = t[index];
	if (not list) then
		list = {};
		t[index] = list;
	end;
	table.insert(list, value);
end;

return function(body)
	assert(type(body) == 'string', 'string required to parse data');

	local result = {};
	local types = {};
	local reader = blobreader(body);
	local version, n_unique_types, n_objects = header.from(reader);
	result.HEADER = {
		version = version;
		classes = n_unique_types;
		instances = n_objects;
	};

	while (true) do
		local chunk_name, chunk_blob = chunk.from(reader);
		local chunk_handler = chunk.map.get(chunk_name);
		if (chunk_handler) then
			if (chunk_name == 'INST') then
				local type_id, type_name, is_service, n_instances, referents = chunk_handler.from(chunk_blob);
				local INST_data = {
					id = type_id;
					name = type_name;
					is_service = is_service;
					instances = n_instances;
					referents = referents;
				};
				types[type_id] = INST_data;
				fillWithArray(result, chunk_name, INST_data);
			elseif (chunk_name == 'PROP') then
				local type_id, property_name, datatype_id, values = chunk_handler.from(chunk_blob, types);
				local PROP_data = {
					id = type_id;
					name = property_name;
					datatype = datatype_id;
					values = values;
				};
				fillWithArray(result, chunk_name, PROP_data);
			elseif (chunk_name == 'PRNT') then
				local prnt_version, prnt_n_objects, child_referents, parent_referents = chunk_handler.from(chunk_blob);
				result[chunk_name] = {
					version = prnt_version;
					instances = prnt_n_objects;
					child_referents = child_referents;
					parent_referents = parent_referents;
				};
			elseif (chunk_name == 'META') then
				local map = chunk_handler.from(chunk_blob);
				result[chunk_name] = map;
			elseif (chunk_name == 'SSTR') then
				local values = chunk_handler.from(chunk_blob);
				result[chunk_name] = values;
			elseif (chunk_name == 'END') then
				local magic_number_confirm = chunk_handler.from(chunk_blob);
				assert(magic_number_confirm, 'END chunk bad magic number');
				result[chunk_name] = magic_number_confirm;
				break;
			end;
		end;
	end;
	return result, types;
end;