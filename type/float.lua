
local name = 'RbxFloat32';

local bit = require('bit');
local array = require('rbx-lie/array');
local util = require('rbx-lie/util');

local bit_btest = function(x, y)
	return bit.band(x, y) ~= 0;
end;

local float32ToUInt32 = function (float)
    local sign = float < 0;
    if (sign) then
        float = -float;
    end;

    if (float == math.huge) then
        return sign and 0xff800000 or 0x7f800000; -- negative and positive infinities
    elseif (float ~= float) then
        return 0xffeeddcc; -- Arbitrary NaN
    elseif (float == 0) then
        return 0x00000000;
    end;

    local mantissa, exponent = math.frexp(float);

    if (exponent + 127 <= 1) then
        mantissa = math.floor(mantissa * 0x800000 + 0.5);
        return (sign and 0x80000000 or 0x00000000) + mantissa;
    else
        mantissa = math.floor((mantissa - 0.5) * 0x1000000 + 0.5);
        return (sign and 0x80000000 or 0x00000000) + bit.lshift(exponent + 126, 23) + mantissa;
    end;
end;

local uint32ToFloat32 = function(int)
    local sign = bit_btest(int, 0x80000000);
    local exponent = bit.band(bit.rshift(int, 23), 0xff);
    local mantissa = bit.band(int, 0x7fffff);

    if (exponent == 0xff) then
        if (mantissa == 0) then
            return sign and -math.huge or math.huge;
		else return 0 / 0;
        end;
    elseif (exponent == 0) then
        if (mantissa == 0) then
            return 0;
		else return sign and -math.ldexp(mantissa / 0x800000, -126) or math.ldexp(mantissa / 0x800000, -126);
        end;
    else return sign and -math.ldexp((mantissa / 0x800000) + 1, exponent - 127) or math.ldexp((mantissa / 0x800000) + 1, exponent - 127);
    end;
end;

local to = function(blob, n)
	blob:u32(bit.rol(float32ToUInt32(n), 1));
end;

local from = function(blob)
	local int = blob:u32();
	return uint32ToFloat32(int);
end;

local arrayTo = function(blob, arr)
    array.blobInterleaveBytes(blob, arr, util.FLOAT32_SIZE, to);
end;

local arrayFrom = function(blob, count)
	local values = {};
	local arr = array.blobDeinterleaveBytes(blob, count, util.FLOAT32_SIZE);
	for i = 1, count do
		values[i] = from(arr);
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