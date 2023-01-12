
return {
	type = require('rbx-lie/type');
	chunk = require('rbx-lie/chunk');
	verify = require('rbx-lie/verify');
	parse = {
		rbxm = {
			read = require('rbx-lie/parse/rbxm/read');
			write = require('rbx-lie/parse/rbxm/write');
		};
		rbxmx = {
			read = require('rbx-lie/parse/rbxmx/read');
			write = require('rbx-lie/parse/rbxmx/write');
		};
	};
};