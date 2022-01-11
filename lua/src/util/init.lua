local file_find=file.Find;
local str_find=string.find;
local str_sub=string.sub;
local src_dir="addons/damp/lua/src/*";
local send_lua=AddCSLuaFile;

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

function damp_util_send_lua()
	damp_util_load_dir("addons/damp/lua/src/*",function(file)
		if str_find(file,"shared.lua") or str_find(file,"cl_init.lua") then
			-- SEND THE BULLSHIT ALREADY.
			file="src/"..str_sub(file,#src_dir,#file);
			send_lua(file);
			-- print(file);
		end
	end);
end