local file_find=file.Find;
local file_open=file.Open;
local file_read=file.Read;
local file_exists=file.Exists;
local file_write=file.Write;
local file_append=file.Append;
local file_size=file.Size;

local str_find=string.find;
local str_sub=string.sub;
local str_lower=string.lower;

local curtime=CurTime;
local hook_add=hook.Add;
local color=Color;
local send_lua=AddCSLuaFile;
local include=include;
local msgc=MsgC;
local player_all=player.GetAll;
local get_tick_rate=engine.TickInterval;

local sv_col=color(3,169,244,255);
local cl_col=color(222,169,9,255);
local src_dir="damp/*";
local poll_ticks=0;
local poll_interval=1; --Execs per second
local tick_rate=(1/get_tick_rate())/poll_interval;
local cache={};

local function damp_loader_load_dir(dir,fn)
	local fil,fol=file_find(dir,"LUA");
	dir=str_sub(dir,1,#dir-1);
	for i=1,#fil do fn(dir..fil[i]); end
	for i=1,#fol do
		local sub_dir=dir..fol[i].."/*";
		damp_loader_load_dir(sub_dir,fn);
	end
end

local function on_load_src(file)
	if str_find(file,"loader") then return; end
	local fsz=file_size(file,"LUA");
	local csz=cache[file];
	if fsz==0||fsz==csz then return; end
	local sv=str_find(file,"sv_");
	local sh=str_find(file,"sh_");
	local cl=str_find(file,"cl_");
	if SERVER&&sv then
		msgc(sv_col,DAMP.." | SERVER | "..file.."\n");
		include(file);
	elseif SERVER&&sh then
		msgc(sv_col,DAMP.." | SENDING | "..file.."\n");
		AddCSLuaFile(file);
		msgc(sv_col,DAMP.." | SHARED | "..file.."\n");
		include(file);
	elseif SERVER&&cl then
		msgc(sv_col,DAMP.." | SENDING | "..file.."\n");
		AddCSLuaFile(file);
	elseif CLIENT&&sh then
		msgc(cl_col,DAMP.." | SHARED | "..file.."\n");
		include(file);
	elseif CLIENT&&cl then
		msgc(cl_col,DAMP.." | CLIENT | "..file.."\n");
		include(file);
	end
	cache[file]=fsz;
end

function damp_loader_poll()
	poll_ticks=poll_ticks+1;
	if poll_ticks>=tick_rate then
		damp_loader_load_dir(src_dir,on_load_src);
		poll_ticks=0;
	end
end
hook_add("Tick","damp_loader_poll",damp_loader_poll);

damp_loader_load_dir(src_dir,on_load_src);