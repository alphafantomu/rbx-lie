

local lz4 = require('luv-lz4');
local openssl = require('openssl');
local blobreader = require('blobreader');
local util = require('rbx-lie/util');

local RESERVED = '00000000';

local parse = function(blob)
	local chunk_name = blob:raw(4);
	local compressed_length = blob:u32();
	local uncompressed_length = blob:u32();
	local reserved = blob:raw(4);
	if (openssl.hex(reserved) ~= RESERVED) then
		print('Chunk reserved bytes are not zeros');
	end;
	return util.readableOnly(chunk_name), compressed_length, uncompressed_length;
end;

local to = function(blob)

end;

local from = function(blob)
	local chunk_name, compressed_length, uncompressed_length = parse(blob);
	local raw_chunk = compressed_length == 0 and blob:raw(uncompressed_length) or nil;
	if (not raw_chunk) then
		local compressed_chunk = blob:raw(compressed_length);
		-- can remove this later
		assert(compressed_length == #compressed_chunk, 'compressed length and size of compressed chunk are not the same?');
		local decompressed_chunk, decompressed_length = lz4.decompress(compressed_chunk, uncompressed_length);
		assert(decompressed_length == uncompressed_length, 'lz4.decompress_safe failed?');
		raw_chunk = decompressed_chunk;
	end;
	return chunk_name, blobreader(raw_chunk);
end;

return {
	to = to;
	from = from;
	parse = parse;
	map = require('rbx-lie/chunk/map');
};