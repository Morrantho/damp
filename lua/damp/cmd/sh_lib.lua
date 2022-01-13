local push=table.insert;
local pop=table.remove;
local cat=table.concat;
local str_split=string.Split;
local str_sub=string.sub;
local str_lower=string.lower;
local cmd_add=concommand.Add;
local hook_add=hook.Add;

local cmds={};

function damp_cmd_new(cmd)
	for i=1,#cmd.aliases do
		cmds[cmd.aliases[i]]=cmd;
		cmd_add(cmd.aliases[i],function(pl,_cmd,args)
			local ret=cmd.run(pl,args);
			return ret;
		end);
	end
end

local function player_say(pl,txt,team)
	local args=str_split(txt," ");
	if str_sub(args[1],1,1)=="/" then
		args[1]=str_lower(str_sub(args[1],2,#args[1]));
		local cmd=cmds[args[1]];
		if cmd then
			pl:ConCommand(cat(args," "));
		else
			pl:ChatPrint("Command: "..args[1].." not found.");
		end
		return "";
	end
	return txt;
end
hook_add("PlayerSay","damp_cmd_player_say",player_say);