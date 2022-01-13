DAMP="D.A.M.P.";
if SERVER then
	DAMP_REALM=false;
	DAMP_REALM_STR="SERVER";
else
	DAMP_REALM=true;
	DAMP_REALM_STR="CLIENT";
end
AddCSLuaFile("damp/loader/sh_lib.lua");
include("damp/loader/sh_lib.lua");