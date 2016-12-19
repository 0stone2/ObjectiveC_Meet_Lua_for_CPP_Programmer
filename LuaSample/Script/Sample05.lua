--[[
Lua (Sample05.lua)코드입니다.
--]]

DbgString("Sample05.lua\n")
nStart = 1
nStop = 10
nSum = Sum(nStart, nStop)
DbgString(string.format("sum(%d, %d) : %d\n", nStart, nStop, nSum))