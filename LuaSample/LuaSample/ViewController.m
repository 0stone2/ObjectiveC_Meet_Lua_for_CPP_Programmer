//
//  ViewController.m
//  LuaSample
//
//  Created by 박 창진 on 2016. 10. 16..
//  Copyright © 2016년 박 창진. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.

}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

- (IBAction)OnExit:(id)sender {
    [NSApp terminate:self];
}


// 1장 - C에서 루아 호출하기
- (IBAction)OnExam1:(id)sender {
    NSLog(@"Enter %@", NSStringFromSelector(_cmd));
    
    lua_State * pLuaState = NULL;
    
    @try {
        pLuaState = luaL_newstate();
        if(NULL == pLuaState) {
            NSLog(@"luaL_newstate Error");
            return;
        }
        
        if (luaL_dofile(pLuaState, "/Users/crazevil/Projects/EBook/objcpp/LuaSample/Script/Sample01.lua")) {
            
            const char *pError = lua_tostring(pLuaState, -1);
            NSLog(@"error running function `f': %s\n", pError);
            return;
        }
        
    } @finally {
        if (NULL != pLuaState) lua_close(pLuaState);
    }

    NSLog(@"Leave %@", NSStringFromSelector(_cmd));
}
- (IBAction)OnExam2:(id)sender {
    NSLog(@"Enter %@", NSStringFromSelector(_cmd));

    lua_State * pLuaState = NULL;
    const char *	szWelcomMessage =  NULL;
    const char *	szWhoamI =  NULL;
    
    @try {
        pLuaState = luaL_newstate();
        if(NULL == pLuaState) {
            NSLog(@"luaL_newstate Error");
            return;
        }
        
        if (luaL_dofile(pLuaState, "/Users/crazevil/Projects/EBook/objcpp/LuaSample/Script/Sample02.lua")) {
            
            const char *pError = lua_tostring(pLuaState, -1);
            NSLog(@"error running function `f': %s\n", pError);
            return;
        }
        
        // Lua의 전역 변수 읽어 오기
        lua_getglobal(pLuaState, "szWelcomMessage");
        lua_getglobal(pLuaState, "szWhoamI");
        
        if (!lua_isstring(pLuaState, -1)) {
            NSLog(@"`szWhoAmI' should be a string\n");
            return;
        }
        
        szWhoamI = lua_tostring(pLuaState, -1);
        
        if (!lua_isstring(pLuaState, -2)) {
            NSLog(@"`szWelcomMessage' should be a string\n");
            return;
        }

        szWelcomMessage = lua_tostring(pLuaState, -2);
        
        
        
        NSLog(@"\n\n**** Lua 전역 변수 변경 전****\n");
        NSLog(@"Lua의 전역 변수 szWhoamI의 값은 ? %s\n", szWhoamI);
        NSLog(@"Lua의 전역 변수 szWelcomMessage의 값은 ? %s\n", szWelcomMessage);
        
        
        lua_pushstring(pLuaState, "I am Sample02.lua");
        lua_setglobal(pLuaState, "szWhoamI");
        lua_pushstring(pLuaState, "Hello World^^");
        lua_setglobal(pLuaState, "szWelcomMessage");
        
        
        lua_getglobal(pLuaState, "szWelcomMessage");
        lua_getglobal(pLuaState, "szWhoamI");
        
        
        if (!lua_isstring(pLuaState, -1)) {
            NSLog(@"`szWhoAmI' should be a string\n");
            return;
        }
        
        szWhoamI = lua_tostring(pLuaState, -1);
        
        if (!lua_isstring(pLuaState, -2)) {
            NSLog(@"`szWelcomMessage' should be a string\n");
            return;
        }
        
        szWelcomMessage = lua_tostring(pLuaState, -2);
        
        
        NSLog(@"****Lua 전역 변수 변경 후****\n");
        NSLog(@"Lua의 전역 변수 szWhoamI의 값은 ? %s\n", szWhoamI);
        NSLog(@"Lua의 전역 변수 szWelcomMessage의 값은 ? %s\n", szWelcomMessage);
        
        
        szWelcomMessage = lua_tostring(pLuaState, 1);
        szWhoamI = lua_tostring(pLuaState, 2);
        
    } @finally {
        if (NULL != pLuaState) lua_close(pLuaState);
    }
    
    NSLog(@"Leave %@", NSStringFromSelector(_cmd));
}

- (IBAction)OnExam3:(id)sender {
    NSLog(@"Enter %@", NSStringFromSelector(_cmd));
    lua_State * pLuaState = NULL;
    const char *	szWelcomMessage =  NULL;
    const char *	szWhoamI =  NULL;
    const char *	szReturn1 =  NULL;
    int             bReturn2 =  NULL;
    

    
    @try {
        pLuaState = luaL_newstate();
        if(NULL == pLuaState) {
            NSLog(@"luaL_newstate Error");
            return;
        }
        
        if (luaL_dofile(pLuaState, "/Users/crazevil/Projects/EBook/objcpp/LuaSample/Script/Sample03.lua")) {
            NSLog(@"error running function `f': %s\n", lua_tostring(pLuaState, -1));
            return;
        }
        
        ////////////////////////////////////////////////////////////////////////////////////////////
        //
        // 인자와 리턴값이 없는 함수 호출하기
        //
        lua_getglobal(pLuaState, "myfunc_1");
        
        //DumpLuaStack(pLuaState);
        
        if (lua_pcall(pLuaState, 0, 0, 0) != 0) {
            NSLog(@"error running function `f': %s\n", lua_tostring(pLuaState, -1));
            return;
        }
        
        
        lua_getglobal(pLuaState, "szWelcomMessage");
        lua_getglobal(pLuaState, "szWhoamI");
        
        
        if (!lua_isstring(pLuaState, -1)) {
            NSLog(@"`szWhoAmI' should be a string\n");
            return;
        }
        szWhoamI = lua_tostring(pLuaState, -1);
        
        if (!lua_isstring(pLuaState, -2)) {
            NSLog(@"`szWelcomMessage' should be a string\n");
            return;
        }
        szWelcomMessage = lua_tostring(pLuaState, -2);
        
        NSLog(@"\n****Lua 함수 func_1 호출 후****\n");
        NSLog(@"Lua의 전역 변수 szWhoamI의 값은 ? %s\n", szWhoamI);
        NSLog(@"Lua의 전역 변수 szWelcomMessage의 값은 ? %s\n", szWelcomMessage);

        
        
        ////////////////////////////////////////////////////////////////////////////////////////////
        //
        // 인자는 없지만 리턴값이 하나인 함수 호출하기
        //
        lua_getglobal(pLuaState, "myfunc_2");
        
        if (lua_pcall(pLuaState, 0, 1, 0) != 0) {
            NSLog(@"error running function `f': %s\n", lua_tostring(pLuaState, -1));
            return;
        }
        
        if (!lua_isstring(pLuaState, -1)) {
            NSLog(@"Return Value' should be a string\n");
        }
        szReturn1 = lua_tostring(pLuaState, -1);
        
        lua_getglobal(pLuaState, "szWelcomMessage");
        lua_getglobal(pLuaState, "szWhoamI");
        
        
        if (!lua_isstring(pLuaState, -1)) {
            NSLog(@"`szWhoAmI' should be a string\n");
            return;
        }
        szWhoamI = lua_tostring(pLuaState, -1);
        
        if (!lua_isstring(pLuaState, -2)) {
            NSLog(@"`szWelcomMessage' should be a string\n");
            return;
        }
        szWelcomMessage = lua_tostring(pLuaState, -2);
        
        NSLog(@"\n****Lua 함수 func_3 호출 후****\n");
        NSLog(@"Lua의 함수 func_3의 리턴값은 ? %s\n", szReturn1);
        NSLog(@"Lua의 전역 변수 szWhoamI의 값은 ? %s\n", szWhoamI);
        NSLog(@"Lua의 전역 변수 szWelcomMessage의 값은 ? %s\n", szWelcomMessage);

        
        
        
        ////////////////////////////////////////////////////////////////////////////////////////////
        //
        // 인자는 없지만 리턴값이 여러개인 함수 호출하기
        //
        lua_getglobal(pLuaState, "myfunc_3");
        
        if (lua_pcall(pLuaState, 0, 2, 0) != 0) {
            NSLog(@"error running function `f': %s\n", lua_tostring(pLuaState, -1));
            return;        }
        
        if (!lua_isboolean(pLuaState, -1)) {
            NSLog(@"Return Value' should be a boolean\n");
        }
        bReturn2 = lua_toboolean(pLuaState, -1);
        
        if (!lua_isstring(pLuaState, -2)) {
            NSLog(@"Return Value' should be a string\n");
        }
        szReturn1 = lua_tostring(pLuaState, -2);
        
        
        
        
        lua_getglobal(pLuaState, "szWelcomMessage");
        lua_getglobal(pLuaState, "szWhoamI");
        
        
        if (!lua_isstring(pLuaState, -1)) {
            NSLog(@"`szWhoAmI' should be a string\n");
            return;
        }
        szWhoamI = lua_tostring(pLuaState, -1);
        
        if (!lua_isstring(pLuaState, -2)) {
            NSLog(@"`szWelcomMessage' should be a string\n");
            return;
        }
        szWelcomMessage = lua_tostring(pLuaState, -2);
        
        NSLog(@"\n****Lua 함수 func_3 호출 후****\n");
        NSLog(@"Lua의 함수 func_3의 리턴값은 ? %s, %d\n", szReturn1, bReturn2);
        NSLog(@"Lua의 전역 변수 szWhoamI의 값은 ? %s\n", szWhoamI);
        NSLog(@"Lua의 전역 변수 szWelcomMessage의 값은 ? %s\n", szWelcomMessage);

        
        
        
        ////////////////////////////////////////////////////////////////////////////////////////////
        //
        // 인자는 하나 리턴값이 여러개인 함수 호출하기
        //
        lua_getglobal(pLuaState, "myfunc_4");
        lua_pushstring(pLuaState, "myfunc_4");
        if (lua_pcall(pLuaState, 1, 2, 0) != 0) {
            NSLog(@"error running function `f': %s\n", lua_tostring(pLuaState, -1));
            return;
        }
        
        if (!lua_isboolean(pLuaState, -1)) {
            NSLog(@"Return Value' should be a boolean\n");
        }
        bReturn2 = lua_toboolean(pLuaState, -1);
        
        if (!lua_isstring(pLuaState, -2)) {
            NSLog(@"Return Value' should be a string\n");
        }
        szReturn1 = lua_tostring(pLuaState, -2);
        
        
        
        
        lua_getglobal(pLuaState, "szWelcomMessage");
        lua_getglobal(pLuaState, "szWhoamI");
        
        
        if (!lua_isstring(pLuaState, -1)) {
            NSLog(@"`szWhoAmI' should be a string\n");
            return;
        }
        szWhoamI = lua_tostring(pLuaState, -1);
        
        if (!lua_isstring(pLuaState, -2)) {
            NSLog(@"`szWelcomMessage' should be a string\n");
            return;
        }
        szWelcomMessage = lua_tostring(pLuaState, -2);
        
        NSLog(@"\n****Lua 함수 func_4 호출 후****\n");
        NSLog(@"Lua의 함수 func_4의 리턴값은 ? %s, %d\n", szReturn1, bReturn2);
        NSLog(@"Lua의 전역 변수 szWhoamI의 값은 ? %s\n", szWhoamI);
        NSLog(@"Lua의 전역 변수 szWelcomMessage의 값은 ? %s\n", szWelcomMessage);
        
        
        
        ////////////////////////////////////////////////////////////////////////////////////////////
        //
        // 인자와 리턴값이 여러개인 함수 호출하기
        //
        
        lua_getglobal(pLuaState, "myfunc_5");
        lua_pushstring(pLuaState, "myfunc_5");
        lua_pushboolean(pLuaState, FALSE);
        
        //DumpLuaStack(pLuaState);
        if (lua_pcall(pLuaState, 2, 2, 0) != 0) {
            NSLog(@"error running function `f': %s\n", lua_tostring(pLuaState, -1));
            return;
        }
        
        if (!lua_isboolean(pLuaState, -1)) {
            NSLog(@"Return Value' should be a boolean\n");
        }
        bReturn2 = lua_toboolean(pLuaState, -1);
        
        if (!lua_isstring(pLuaState, -2)) {
            NSLog(@"Return Value' should be a string\n");
        }
        szReturn1 = lua_tostring(pLuaState, -2);
        
        
        
        
        lua_getglobal(pLuaState, "szWelcomMessage");
        lua_getglobal(pLuaState, "szWhoamI");
        
        
        if (!lua_isstring(pLuaState, -1)) {
            NSLog(@"`szWhoAmI' should be a string\n");
            return;
        }
        szWhoamI = lua_tostring(pLuaState, -1);
        
        if (!lua_isstring(pLuaState, -2)) {
            NSLog(@"`szWelcomMessage' should be a string\n");
            return;
        }
        szWelcomMessage = lua_tostring(pLuaState, -2);
        
        NSLog(@"\n****Lua 함수 func_5 호출 후****\n");
        NSLog(@"Lua의 함수 func_5의 리턴값은 ? %s, %d\n", szReturn1, bReturn2);
        NSLog(@"Lua의 전역 변수 szWhoamI의 값은 ? %s\n", szWhoamI);
        NSLog(@"Lua의 전역 변수 szWelcomMessage의 값은 ? %s\n", szWelcomMessage);
        
    } @finally {
        if (NULL != pLuaState) lua_close(pLuaState);
    }
    
    NSLog(@"Leave %@", NSStringFromSelector(_cmd));
}


// 2장 - 루아에서 C 호출하기
static int MyDbgString1(lua_State *pLuaState)
{
    NSLog(@"MyDbgString 호출됨 \n");
    
    return 0;
}

static int MyDbgString2(lua_State *pLuaState)
{
    /* get number of arguments */
    int nTop = 0;
    
    @try {
        nTop = lua_gettop(pLuaState);
        if (1 != nTop) return 0;
        if (!lua_isstring(pLuaState, nTop)) return 0;
        
        NSLog(@"%s\n", lua_tostring(pLuaState, nTop));
    }
    @finally {
        
    }
    
    return 0;
}

static int MyDbgString3(lua_State *pLuaState)
{
    /* get number of arguments */
    int nTop = 0;
    
    @try {
        nTop = lua_gettop(pLuaState);
        if (1 != nTop) return 0;
        if (!lua_isstring(pLuaState, nTop)) return 0;
        
        NSLog(@"%s\n", lua_tostring(pLuaState, nTop));
    }
    @finally {
        
    }
    
    return 0;
}

static int MySum(lua_State *pLuaState)
{
    /* get number of arguments */
    int nTop = 0;
    int nStartVar = 0;
    int nStopVar = 0;
    int nSum = 0;
    
    @try {
        nTop = lua_gettop(pLuaState);
        if (2 != nTop) return 1;
        if (!lua_isnumber(pLuaState, nTop)) return 1;
        if (!lua_isnumber(pLuaState, nTop - 1)) return 1;
        
        nStopVar = lua_tonumber(pLuaState, nTop);
        nStartVar = lua_tonumber(pLuaState, nTop - 1);
        
        for (int nIndex = nStartVar; nIndex <= nStopVar; nIndex++)
        {
            nSum += nIndex;
        }
        
        lua_pushnumber(pLuaState, nSum);
    }
    @finally {
        
    }
    
    return 1;
}

static int MySumAndAverage(lua_State *pLuaState)
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

- (IBAction)OnExam4:(id)sender {
    NSLog(@"Enter %@", NSStringFromSelector(_cmd));

    lua_State *		pLuaState = NULL;
    
   @try {
        pLuaState = luaL_newstate();
        if (NULL == pLuaState) return;
        
        /* register our function */
        lua_register(pLuaState, "DbgString", MyDbgString1);
        
        if (luaL_dofile(pLuaState, "/Users/crazevil/Projects/EBook/objcpp/LuaSample/Script/Sample04.lua")) {
            NSLog(@"error running function `f': %s\n", lua_tostring(pLuaState, -1));
            return;
        }
    }
    @finally {
        if (NULL != pLuaState) lua_close(pLuaState);
    }
    
    NSLog(@"Leave %@", NSStringFromSelector(_cmd));
}

- (IBAction)OnExam5:(id)sender {
    NSLog(@"Enter %@", NSStringFromSelector(_cmd));
    
    lua_State *		pLuaState = NULL;
    
    @try {
        pLuaState = luaL_newstate();
        if (NULL == pLuaState) return;
        
        luaL_openlibs(pLuaState);
        
        /* register our function */
        lua_register(pLuaState, "DbgString", MyDbgString2);
        lua_register(pLuaState, "Sum", MySum);
        
        
        if (luaL_dofile(pLuaState, "/Users/crazevil/Projects/EBook/objcpp/LuaSample/Script/Sample05.lua")) {
            NSLog(@"error running function `f': %s\n", lua_tostring(pLuaState, -1));
            return;
        }
    }
    @finally {
        if (NULL != pLuaState) lua_close(pLuaState);
    }
    
    NSLog(@"Leave %@", NSStringFromSelector(_cmd));
}

- (IBAction)OnExam6:(id)sender {
    NSLog(@"Enter %@", NSStringFromSelector(_cmd));
    
    lua_State *		pLuaState = NULL;
    
    @try {
        pLuaState = luaL_newstate();
        if (NULL == pLuaState) return;
        
        luaL_openlibs(pLuaState);
        
        /* register our function */
        lua_register(pLuaState, "DbgString", MyDbgString3);
        lua_register(pLuaState, "SumAndAverage", MySumAndAverage);
        
        if (luaL_dofile(pLuaState, "/Users/crazevil/Projects/EBook/objcpp/LuaSample/Script/Sample06.lua")) {
            NSLog(@"error running function `f': %s\n", lua_tostring(pLuaState, -1));
            return;
        }
    }
    @finally {
        if (NULL != pLuaState) lua_close(pLuaState);
    }
    
    NSLog(@"Leave %@", NSStringFromSelector(_cmd));
}



// 3장 - 루아 확장 모듈 만들기
- (IBAction)OnExam7:(id)sender {
    NSLog(@"Enter %@", NSStringFromSelector(_cmd));
    
    lua_State *	pLuaState = NULL;
    void *      hLuaExt = NULL;
    int         (*DbgString)(lua_State *pLuaState) = NULL;
    int         (*SumAndAverage)(lua_State *pLuaState) = NULL;
    
    
    @try {
        hLuaExt = dlopen("/Users/crazevil/Projects/EBook/objcpp/LuaSample/Script/libLuaExt.dylib", RTLD_LOCAL|RTLD_LAZY);
        if (NULL == hLuaExt) {
            NSLog(@"[%s] Unable to load library: %s\n", __FILE__, dlerror());
            return;
        }

        DbgString = dlsym(hLuaExt, "DbgString");
        if (NULL == DbgString) {
            NSLog(@"[%s] Unable to get symbol: %s\n", __FILE__, dlerror());
            return;
        }
        
        SumAndAverage = dlsym(hLuaExt, "SumAndAverage");
        if (NULL == DbgString) {
            NSLog(@"[%s] Unable to get symbol: %s\n", __FILE__, dlerror());
            return;
        }
        
        
        pLuaState = luaL_newstate();
        if (NULL == pLuaState) return;
        
        luaL_openlibs(pLuaState);
        
        lua_register(pLuaState, "DbgString", DbgString);
        lua_register(pLuaState, "SumAndAverage", SumAndAverage);
        
        
        if (luaL_dofile(pLuaState, "/Users/crazevil/Projects/EBook/objcpp/LuaSample/Script/Sample07.lua")) {
            NSLog(@"error running function `f': %s\n", lua_tostring(pLuaState, -1));
            return;
        }
    }
    @finally {
        if (NULL != hLuaExt) {
            dlclose(hLuaExt);
        }
    }
    
    NSLog(@"Leave %@", NSStringFromSelector(_cmd));
}

- (IBAction)OnExam8:(id)sender {
    NSLog(@"Enter %@", NSStringFromSelector(_cmd));
    
    NSLog(@"Leave %@", NSStringFromSelector(_cmd));
}


@end
