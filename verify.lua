
local header = require('rbx-lie/header');
local dtype = require('rbx-lie/type');
local chunk_PRNT = require('rbx-lie/chunk/PRNT');

return function(data, types)
	local HEADER = data.HEADER;
	local array_INST, array_PROP, PRNT, META, SSTR, END = data.INST, data.PROP, data.PRNT, data.META, data.SSTR, data.END;

	-- Check for necessary chunks --
	assert(HEADER, 'File Header missing');
	assert(PRNT, 'PRNT chunk missing');
	assert(END, 'END chunk missing or bad magic number');

	local header_version = assert(HEADER.version, 'header version missing');
	local classes = assert(HEADER.classes, 'header class count missing');
	local instances = assert(HEADER.instances, 'header instance count missing');

	assert(header.supportsVersion(header_version), 'header has no version support for ('..header_version..')')
	assert(instances >= classes, 'there are more classes than instances');

	-- Check number of chunks --
	assert(META and #META == 0 or not META, 'too many META chunks');
	assert(SSTR and #SSTR == 0 or not SSTR, 'too many SSTR chunks');

	-- Check Chunk Data --

	local referents = {};

	if (array_INST) then
		local n = #array_INST;
		local n_referents = 0;
		assert(classes == n, 'missing INST chunks for class data');
		for i = 1, n do
			local INST = array_INST[i];
			local id = assert(INST.id, 'INST type id missing');
			local name = assert(INST.name, 'INST type name missing');
			local class_instances = assert(INST.instances, 'INST instance count missing');
			local class_referents = assert(INST.referents, 'INST referents missing');
			local is_service = INST.is_service;
			local n_class_referents = #class_referents;

			assert(is_service ~= nil, 'INST service identifier missing');
			assert(n_class_referents == class_instances, 'INST instance count is different from number of referents');
			assert(n_class_referents > 0, 'INST not enough referents');

			if (types) then
				assert(types[id], 'INST type data missing from types table');
			end;

			for e = 1, n_class_referents do
				local referent = class_referents[e];
				assert(referents[referent] == nil, 'INST referent is repeating');
				referents[referent] = 0;
				n_referents = n_referents + 1;
			end;
		end;
		assert(n_referents == instances, 'INST referent count is different from instance count');
	end;

	if (array_PROP) then
		local n = #array_PROP;
		for i = 1, n do
			local PROP = array_PROP[i];
			local id = assert(PROP.id, 'PROP type id missing');
			local name = assert(PROP.name, 'PROP property name missing');
			local datatype = assert(PROP.datatype, 'PROP datatype missing');
			local values = assert(PROP.values, 'PROP values missing');

			local n_values = #values;

			assert(dtype.map.getByName(datatype), 'PROP datatype not supported by rbx-lie');
			assert(n_values > 0, 'PROP not enough values');

			if (types) then
				local class_data = assert(types[id], 'PROP type data missing from types table');
				local class_instances = assert(class_data.instances, 'PROP type data instance count missing');
				assert(n_values == class_instances, 'PROP number of values is different from instance count');
			end;
		end;
	end;

	local PRNT_version = assert(PRNT.version, 'PRNT version missing');
	local PRNT_instances = assert(PRNT.instances, 'PRNT instance count missing');
	local PRNT_child_referents = assert(PRNT.child_referents, 'PRNT child referents missing');
	local PRNT_parent_referents = assert(PRNT.parent_referents, 'PRNT parent referents missing');
	local n_child_referents = #PRNT_child_referents;
	local n_parent_referents = #PRNT_parent_referents;

	assert(chunk_PRNT.supportsVersion(PRNT_version), 'PRNT has no version support for ('..PRNT_version..')')
	assert(PRNT_instances == instances, 'PRNT instances is different from header instance count');
	assert(n_child_referents == n_parent_referents, 'PRNT child referent and parent referent arrays have different sizes');
	assert(PRNT_instances == n_child_referents, 'PRNT child referents length is different from PRNT instance count');
	assert(PRNT_instances == n_parent_referents, 'PRNT parent referents length is different from PRNT instance count');

	-- we dont check meta chunk because it's too flexible, but just incase here is the code for it

	if (META) then
		assert(META.ExplicitAutoJoints ~= nil, 'META does not have ExplicitAutoJoints defined');
	end;
end;