//
//  LuaExt.h
//  LuaExt
//
//  Created by 박 창진 on 2016. 10. 22..
//  Copyright © 2016년 박 창진. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "lua.h"
#import "lualib.h"
#import "lauxlib.h"

@interface LuaExt : NSObject

@end

int luaopen_libLuaExt(lua_State *pLuaState);
int DbgString(lua_State *pLuaState);
int SumAndAverage(lua_State *pLuaState);
