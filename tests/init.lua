

local blobwriter = require('blobwriter');
local blobreader = require('blobreader');
local int32 = require('../type/referent');
local util = require('util');
local stream = require('stream');

local rbxm_file = blobwriter('<');

local integers = {1, 8, 4, 17};

int32.arrayTo(rbxm_file, integers);
p('Sent', integers);

local data = rbxm_file:tostring();
local rbxm_file_read = blobreader(data, '<');

local parsed_integers = int32.arrayFrom(rbxm_file_read, #integers);
p('Got', parsed_integers, parsed_integers == integers);

