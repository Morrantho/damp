DAMP="D.A.M.P.";
-------------------------------------------------------------------------------
-- 1. Send all Shared and Client Lua
-- 2. Include all shared, server, and client Lua.
-- 3. Pray that async loading doesn't break your code.
-------------------------------------------------------------------------------
AddCSLuaFile("src/util/sh_init.lua");
include("src/util/sh_init.lua");
damp_util_load_src();