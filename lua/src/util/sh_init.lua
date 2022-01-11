-- Cached Methods
local file_find=file.Find;
local str_find=string.find;
local str_sub=string.sub;
local str_lower=string.lower;
local color=Color;
local send_lua=AddCSLuaFile;
local include=include;
local msgc=MsgC;
-- Private Locals
local sv_col=color(3,169,244,255);
local cl_col=color(222,169,9,255);
local sh_col=color(76,175,80,255);
local send_col=color(231,76,60,255);
local src_dir="addons/damp/lua/src/*";

-- Why this game doesn't have a recursive folder find is beyond me.
function damp_util_load_dir(dir,fn)
	local fil,fol=file_find(dir,"GAME","nameasc");
	for i=1,#fol do
		local sub_dir=str_sub(dir,1,#dir-1)..fol[i].."/*";
		damp_util_load_dir(sub_dir,fn);
	end
	dir=str_sub(dir,1,#dir-1);
	for i=1,#fil do fn(dir..fil[i]); end
end

local function on_sendable_lua_found(file)
	-- Ignore server files.
	if str_find(file,"sv_") then return; end
	file="src/"..str_sub(file,#src_dir,#file);
	msgc(send_col,"DAMP | SENDING | "..file.."\n");
	send_lua(file);
end

function damp_util_send_lua()
	damp_util_load_dir(src_dir,on_sendable_lua_found);
end

local function on_sh_src_found(file)
	if not str_find(file,"sh_") then return; end
	file="src/"..str_sub(file,#src_dir,#file);
	msgc(sh_col,"DAMP | SHARED | "..file.."\n");
	-- include(file);
end

function damp_util_include_sh(file)
	damp_util_load_dir(src_dir,on_sh_src_found);
end

local function on_cl_src_found(file)
	if not str_find(file,"cl_") then return; end
	file="src/"..str_sub(file,#src_dir,#file);
	msgc(cl_col,"DAMP | CLIENT | "..file.."\n");
	include(file);
end

function damp_util_include_cl()
	damp_util_load_dir(src_dir,on_cl_src_found);
end

local function on_sv_src_found(file)
	if not str_find(file,"sv_") then return; end
	file="src/"..str_sub(file,#src_dir,#file);
	msgc(sv_col,"DAMP | SERVER | "..file.."\n");
	include(file);
end

function damp_util_include_sv()
	damp_util_load_dir(src_dir,on_sv_src_found);
end

function damp_util_find_player(id)
	if type(id)~="string" then return; end
	id=str_lower(id);
	local plys=all();
	for i=1,#plys do
		local pl=plys[i];
		local is_nick=str_find(str_lower(pl:Nick()));
		local is_name=str_find(str_lower(pl:Name()));
		local is_sid=str_find(str_lower(pl:SteamID()));
		if is_nick||is_name||is_sid then return pl; end
	end
end