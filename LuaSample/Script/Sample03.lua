--[[
Lua (Sample03.lua)코드입니다.
--]]

szWelcomMessage = "Hello World"
szWhoamI = "Sample02.lua"

function myfunc_1 ()
	szWhoamI = "myfunc_1"
end

function myfunc_2 ()
	szWhoamI = "myfunc_2"

	return "Success";
end

function myfunc_3 ()
	szWhoamI = "myfunc_3"

	return "Success", true;
end

function myfunc_4 (szMyName)
	szWhoamI = szMyName

	return "Success", true;
end

function myfunc_5 (szMyName, bReturnValue)
	szWhoamI = szMyName

	return "Success", bReturnValue;
end