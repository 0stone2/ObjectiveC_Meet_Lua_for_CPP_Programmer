//
//  LuaExt.m
//  LuaExt
//
//  Created by 박 창진 on 2016. 10. 22..
//  Copyright © 2016년 박 창진. All rights reserved.
//

#import "LuaExt.h"

@implementation LuaExt

@end

int luaopen_libLuaExt(lua_State *pLuaState)
{
    BOOL bSuccess = FALSE;
    
    @try {
        if (NULL == pLuaState) return 1;
        
        lua_register(pLuaState, "DbgString", DbgString);
        lua_register(pLuaState, "SumAndAverage", SumAndAverage);
        
        bSuccess = TRUE;
    }
    @finally {
        
    }
    
    lua_pushnumber(pLuaState, 1);
    return 1;
}

int DbgString(lua_State *pLuaState)
{
    /* get number of arguments */
    int nTop = 0;
    
    @try {
        nTop = lua_gettop(pLuaState);
        if (1 != nTop) return 0;
        if (!lua_isstring(pLuaState, nTop)) return 0;
        
        NSLog(@"%s", lua_tostring(pLuaState, nTop));
        
    }
    @finally {
        
    }
    
    return 0;
}


int SumAndAverage(lua_State *pLuaState)
{
    /* get number of arguments */
    int nTop = 0;
    int nStartVar = 0;
    int nStopVar = 0;
    int nSum = 0;
    int nAverage = 0;
    int nNumberOfReternValues = 0;
    
    @try {
        nTop = lua_gettop(pLuaState);
        if (2 != nTop) return nNumberOfReternValues;
        if (!lua_isnumber(pLuaState, nTop)) return nNumberOfReternValues;
        if (!lua_isnumber(pLuaState, nTop - 1)) return nNumberOfReternValues;
        
        nStopVar = lua_tonumber(pLuaState, nTop);
        nStartVar = lua_tonumber(pLuaState, nTop - 1);
        
        for (int nIndex = nStartVar; nIndex <= nStopVar; nIndex++)
        {
            nSum += nIndex;
        }
        
        nAverage = nSum / (nStopVar - nStartVar + 1);
        lua_pushnumber(pLuaState, nSum);
        lua_pushnumber(pLuaState, nAverage);
        nNumberOfReternValues = 2;
    }
    @finally {
        
    }
    
    return nNumberOfReternValues;
}
