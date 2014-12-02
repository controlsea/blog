//
//  main.m
//  LuaC
//
//  Created by moxin.xt on 14-5-18.
//  Copyright (c) 2014年 taobao. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#include <stdio.h>
#include <limits.h>
#include "lua.h"
#include "lauxlib.h"
#include "lualib.h"


typedef struct {char* name; unsigned char r,g,b;} ColorMap;

void handleError(lua_State* L, const char* fmt, ...);
void stackDump(lua_State* L);
void load(lua_State* L,const char* name, int *w , int *h, ColorMap* color);
int getfield(lua_State* L, const char* key);
void setColor(lua_State* L, ColorMap* ct);
double f(double x, double y, lua_State* L);

int main(int argc, const char * argv[])
{
//    return NSApplicationMain(argc, argv);

    char buff [256];
    memset(buff, 0, 256);
    
    lua_State* L = luaL_newstate();

    luaL_openlibs(L);
    
    int w,h;
    ColorMap colortable[] ={ {"WHITE",255,255,255},{"RED",255,0,0},{"GREEN",0,255,0},{"BLUE",0,0,255},{NULL,0,0,0}};
    
    int i=0;
    while (colortable[i].name != NULL) {
        setColor(L,&colortable[i++]);
    }
    
    
    const char* path = [[[NSBundle mainBundle] pathForResource:@"chap25" ofType:@".lua"] UTF8String];

    load(L, path, &w, &h,colortable);
    NSLog(@"width:%d,height %d",w,h);
    
    
    double r = f(10.0, 9.0,L);
    printf("result : %f",r);

    

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

void load(lua_State* L,const char* name, int *w , int *h, ColorMap* color)
{
    if (luaL_loadfile(L , name))
        //load file error
        handleError(L , "cannot open file:%s",lua_tostring(L, -1));
    else
    {
        stackDump(L);
        
        //call function
        if(lua_pcall(L, 0, 0, 0))
        {
            //run chunk error
            handleError(L , "cannot open file:%s",lua_tostring(L, -1));
        }
        else
        {
            stackDump(L);
            
            //put  global values on stack
            lua_getglobal(L, "width");
            lua_getglobal(L, "height");
            lua_getglobal(L,"WHITE" );
            
            stackDump(L);
            
            //WIDTH
            if (!lua_isnumber(L, -3)) {
                handleError(L, "width type is wrong!");
                
            }
            else
                *w = lua_tonumber(L, -3);
            
            //HEIGHT
            if (!lua_isnumber(L, -2)) {
                handleError(L, "height type is wrong!");
            }
            else
                *h = lua_tonumber(L, -2);
            
            //COLOR
            if (!lua_istable(L, -1)) {
               handleError(L, "color type is wrong!");
            }
            else
            {
                int r = getfield(L, "r");
                int g = getfield(L, "g");
                int b = getfield(L, "b");
                (*color).r = r;
                (*color).g = g;
                (*color).b = b;
                
                
                
            }
        }
    }
}

int getfield(lua_State* L, const char* key)
{
    //now, the table's index is -1
    //get table:
    lua_getfield(L, -1, key);
    
    //now the value is on top
    if (!lua_isnumber(L , -1)) {
        handleError(L, "color value is wrong!");
    }
    
    int result = (int)lua_tonumber(L , -1);
    lua_pop(L, 1);
    
    return result;
}

void setfield(lua_State* L,const char* index, int value)
{
    //now, the table's index is -1
    lua_pushnumber(L, (double)value/255.0);
    
    //now, the value is on top, table's index is -2
    lua_setfield(L, -2, index);
}

void setColor(lua_State* L, ColorMap* ct)
{
    
    lua_newtable(L);
    setfield(L, "r", ct->r);
    setfield(L, "g", ct->g);
    setfield(L, "b", ct->b);
    lua_setglobal(L, ct->name);
}


//调用lua中的f(x,y)
double f(double x, double y, lua_State* L)
{
    double z;
    
    //get f(x,y)
    lua_getglobal(L , "f");
    lua_pushnumber(L, x);
    lua_pushnumber(L, y);
    
    //2 ARGS, 1 result
    if(!lua_pcall(L, 2, 1, 0))
    {
        stackDump(L);
  
        z = lua_tonumber(L, -1);
        lua_pop(L, 1);
        
        if (z>0) {
            return z;
        }
        
    }
    return z;
}

//generic call
void call_va(lua_State* L, const char* func, const char* sig,...)
{
    va_list vl;
    int narg,nres;
    
    va_start(vl, sig);
    lua_getglobal(L, func);
    
    for (narg = 0; *sig; narg++) {
        
        //check stack
        luaL_checkstack(L, 1, "too many arguments!");
    }
    

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
            case LUA_TTABLE:
            {
                printf("table: %p",lua_topointer(L, i));
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
