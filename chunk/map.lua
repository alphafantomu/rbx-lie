
local util = require('rbx-lie/util');

local map = {
	META = require('rbx-lie/chunk/META');
	SSTR = require('rbx-lie/chunk/SSTR');
	INST = require('rbx-lie/chunk/INST');
	PROP = require('rbx-lie/chunk/PROP');
	PRNT = require('rbx-lie/chunk/PRNT');
	END = require('rbx-lie/chunk/END');
};

local get = function(name)
	name = util.readableOnly(name:upper());
	local handler = map[name];
	if (not handler) then
		print('rbx-lie: chunk "'..name..'" not supported');
	end;
	return handler;
end;

return {
	get = get;
};