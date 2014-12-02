//
//  main.m
//  LuaC
//
//  Created by moxin.xt on 14-5-18.
//  Copyright (c) 2014年 taobao. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#include <stdio.h>
#include "lua.h"
#include "lauxlib.h"
#include "lualib.h"

void handleError(lua_State* L, const char* fmt, ...);
void stackDump(lua_State* L);


int main(int argc, const char * argv[])
{
//    return NSApplicationMain(argc, argv);

    char buff [256];
    memset(buff, 0, 256);
    
    int error;
    lua_State* L = luaL_newstate();

    luaL_openlibs(L);
    
    //test stack:
//    lua_pushboolean(L, 0);
//    lua_pushnumber(L, 10);
//    lua_pushstring(L, "HELLO");
//    lua_pushnil(L);
//    stackDump(L);
    
    NSLog(@"type lua expression:");
    
    stackDump(L);

    while (strcmp(fgets(buff, sizeof(buff), stdin),"quit\n") != 0)
    {
        error = luaL_loadbuffer(L, buff, strlen(buff), "line");
        stackDump(L);
        
        if (error) {
            handleError(L,"%s",lua_tostring(L , -1));
        }
        else
        {
            //call
            lua_pcall(L, 0, 0, 0);
            stackDump(L);
        }
    }
    
    NSLog(@"quit console");
    
    lua_pop(L, 1);
    //lua_settop(L, 0);
    lua_close(L);

    return 0;
    

}

void handleError(lua_State* L, const char* fmt, ...)
{
    va_list args;
    va_start(args, fmt);
    
    vfprintf(stderr, fmt, args);
    
    va_end(args);
    
    lua_pop(L, 1);
    lua_close(L);
    exit(0);
}

void stackDump(lua_State* L)
{
    //get length of the stack
    int length = lua_gettop(L);
    
    printf("--- begin dump ---\n");
    printf("length of the stack:%d \n",length);
    
    for (int i=0; i<=length; i++) {
        
        int t = lua_type(L , i);
        printf("{index:%d, type:%d}",i,t);
        
        switch (t) {
            case LUA_TSTRING:
            {
                printf("string: '%s'",lua_tostring(L, i));
                break;
            }
            
            case LUA_TBOOLEAN:
            {
                printf(lua_toboolean(L, i) ? "true":"false");
                break;
            }
            
            case LUA_TNUMBER:
            {
                printf("number : %g",lua_tonumber(L, i));
                break;
            }
            
            case LUA_TFUNCTION:
            {
                printf("function:%p",lua_tocfunction(L, i));
                break;
            }
       

            default:
            {
                printf("defult : %s",lua_typename(L, i));
                
                break;
            }
        }
        
        printf("\n");
    }
    
    printf("---end dump---\n");
}
