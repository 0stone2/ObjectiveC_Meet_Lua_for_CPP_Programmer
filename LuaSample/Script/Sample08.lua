--[[
Lua (Sample08.lua)코드입니다.
--]]

package.cpath = package.cpath .. ";./?.dylib"
require ("libLuaExt")

DbgString("Sample08.lua 입니다\n")
nStart = 1
nStop = 10

nSum, nAverage = SumAndAverage(nStart, nStop)
DbgString(string.format("SumAndAverage(%d, %d) : 합 => %d, 평균 => %d\n", nStart, nStop, nSum, nAverage))