
local INT32_SIZE, FLOAT32_SIZE = 4, 4;
local INT64_SIZE = 8;
local DEFAULT_ENDIAN = '<';

local readableOnly = function(s)
	local length = s:len();
	local filtered_s = '';
	for i = 1, length do
		local char = s:sub(i, i);
		local byte = string.byte(char);
		if (byte >= 32 and byte <= 126) then
			filtered_s = filtered_s..char;
		end;
	end;
	return filtered_s;
end;

return {
	DEFAULT_ENDIAN = DEFAULT_ENDIAN;
	INT32_SIZE = INT32_SIZE;
	INT64_SIZE = INT64_SIZE;
	FLOAT32_SIZE = FLOAT32_SIZE;
	readableOnly = readableOnly;
};