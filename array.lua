
local blobwriter = require('blobwriter');
local blobreader = require('blobreader');

local deinterleaveBytes = function(data, value_size)
	local n_data = #data;
	assert(n_data % value_size == 0, 'data length must be a multiple of value size');
	local deinterleaved = {};
	local n_values = n_data/value_size;
	for i = 0, n_values - 1 do
		for e = 1, value_size do
			deinterleaved[i * value_size + e] = data:sub(i + (n_values * (e - 1)) + 1, i + (n_values * (e - 1)) + 1);
		end;
	end;
	assert(#deinterleaved == n_data, 'bad deinterleaved length');
	return table.concat(deinterleaved);
end;

local interleaveBytes = function(data, value_size)
	local n_data = #data;
	assert(n_data % value_size == 0, 'data length must be a multiple of value size');
	local build = {};
	local n_values = n_data/value_size;
	for i = 0, n_values - 1 do
		for e = 1, value_size do
			build[i + (n_values * (e - 1)) + 1] = data:sub(i * value_size + e, i * value_size + e);
		end;
	end;
	assert(#build == n_data, 'bad build length');
	return table.concat(build);
end;

local blobDeinterleaveBytes = function(read_blob, count, value_size)
	local data = read_blob:raw(count * value_size);
	local deinterleaved = deinterleaveBytes(data, value_size);
	return blobreader(deinterleaved, '<');
end;

local blobInterleaveBytes = function(write_blob, arr, value_size, write)
	local n = #arr;
	local array_blob = blobwriter('<');
	for i = 1, n do
		write(array_blob, arr[i]);
	end;
	local bytes = array_blob:tostring();
	local interleaved = interleaveBytes(bytes, value_size);
	write_blob:raw(interleaved);
end;

return {
	deinterleaveBytes = deinterleaveBytes;
	interleaveBytes = interleaveBytes;
	blobDeinterleaveBytes = blobDeinterleaveBytes;
	blobInterleaveBytes = blobInterleaveBytes;
};