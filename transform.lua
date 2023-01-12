
local int = function(x)
	return x >= 0 and (2 * x) or x < 0 and (2 * -x - 1);
end;

local reverseInt = function(x)
	return x % 2 == 0 and (x/2) or -(x + 1)/2;
end;

return {
	int = int;
	reverseInt = reverseInt;
};