DAMP="D.A.M.P.";
if SERVER then
	DAMP_REALM=false;
	DAMP_REALM_STR="SERVER";
	DAMP_REALM_PRE="sv_";
else
	DAMP_REALM=true;
	DAMP_REALM_STR="CLIENT";
	DAMP_REALM_PRE="cl_";
end
AddCSLuaFile("damp/loader/sh_lib.lua");
include("damp/loader/sh_lib.lua");