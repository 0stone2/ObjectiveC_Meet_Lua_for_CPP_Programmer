--[[
Lua (Sample07.lua)코드입니다.
--]]

DbgString("Sample07.lua 입니다\n")
nStart = 1
nStop = 10

nSum, nAverage = SumAndAverage(nStart, nStop)
DbgString(string.format("SumAndAverage(%d, %d) : 합 => %d, 평균 => %d\n", nStart, nStop, nSum, nAverage))