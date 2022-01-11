-------------------------------------------------------------------------------
-- 1. Send all Shared and Client Lua
-- 2. Include all shared lua.
-- 3. Include all server lua.
-- 4. Include all client lua.
-- 5. Pray that async loading doesn't break your code.
-------------------------------------------------------------------------------
include("src/util/sh_init.lua");
if SERVER then damp_util_send_lua(); end
damp_util_include_sh();
if SERVER then damp_util_include_sv(); end
if CLIENT then damp_util_include_cl(); end