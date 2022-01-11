-- Cached Methods
local file_find=file.Find;
local str_find=string.find;
local str_sub=string.sub;
local str_lower=string.lower;
local color=Color;
local send_lua=AddCSLuaFile;
local include=include;
local msgc=MsgC;
local player_all=player.GetAll;
-- Private Locals
local sv_col=color(3,169,244,255);
local cl_col=color(222,169,9,255);
local sh_col=color(76,175,80,255);
local src_dir="addons/damp/lua/src/*";

function damp_util_load_dir(dir,fn)
	local fil,fol=file_find(dir,"GAME","nameasc");
	for i=1,#fol do
		local sub_dir=str_sub(dir,1,#dir-1)..fol[i].."/*";
		damp_util_load_dir(sub_dir,fn);
	end
	dir=str_sub(dir,1,#dir-1);
	for i=1,#fil do fn(dir..fil[i]); end
end

local function on_load_src(file)
	file="src/"..str_sub(file,#src_dir,#file);
	if str_find(file,"sh_")&&!str_find(file,"util/sh_init") then
		msgc(sh_col,DAMP.." | SHARED | "..file.."\n");
		AddCSLuaFile(file);
		include(file);
	elseif str_find(file,"sv_")&&SERVER then
		msgc(sv_col,DAMP.." | SERVER | "..file.."\n");
		include(file);
	elseif str_find(file,"cl_")&&CLIENT then
		msgc(cl_col,DAMP.." | CLIENT | "..file.."\n");
		include(file);
	end
end

function damp_util_load_src()
	damp_util_load_dir(src_dir,on_load_src);
end

function damp_util_find_player(id)
	if type(id)!="string" then return; end
	id=str_lower(id);
	local plys=player_all();
	for i=1,#plys do
		local pl=plys[i];
		local is_nick=str_find(str_lower(pl:Nick()));
		local is_name=str_find(str_lower(pl:Name()));
		local is_sid=str_find(str_lower(pl:SteamID()));
		if is_nick||is_name||is_sid then return pl; end
	end
end