local push=table.insert;
local pop=table.remove;
local cat=table.concat;
local str_split=string.Split;
local str_sub=string.sub;
local str_lower=string.lower;
local cmd_add=concommand.Add;
local hook_add=hook.Add;
local cmds={};
local prefix="damp_";

-- TODO: Make command error strings shared / pass an error code instead of writing a whole damn string.
-- Look up the string on opposing realm and log it.

function damp_cmd_new(cmd)
	for i=1,#cmd.aliases do
		cmds[cmd.aliases[i]]=cmd;
		cmd_add(prefix..DAMP_REALM_PRE..cmd.aliases[i],function(pl,_cmd,args)
			local fmt="Cmd: "..cmd.aliases[i].."\n";
			fmt=fmt.."Usage: "..cmd.usage.."\n";
			fmt=fmt.."Description: "..cmd.description.."\n";
			fmt=fmt.."Error: ";
			local pl_role=damp_cache_get_key(pl:SteamID(),"role");
			local cmd_role=damp_role_get(cmd.role);
			if pl_role<cmd_role then
				fmt=fmt.."You don't have the privilege to run "..cmd.aliases[i]..".";
				damp_player_msgc(pl,fmt,"red1");
				return;
			end
			local ret=cmd.run(pl,args);
			if !ret then return; end
			if type(ret)=="string" then
				fmt=fmt..ret;
			else
				fmt=fmt.."Invalid Usage.";
			end
			damp_player_msgc(pl,fmt,"red1");
		end);
	end
end

local function player_say(pl,txt,team)
	local args=str_split(txt," ");
	if str_sub(args[1],1,1)=="/" then
		args[1]=str_lower(str_sub(args[1],2,#args[1]));
		local cmd=cmds[args[1]];
		if cmd then
			pl:ConCommand(prefix..DAMP_REALM_PRE..cat(args," "));
		else
			damp_player_msgc(pl,"Cmd: "..args[1].." not found.","red1");
		end
		return "";
	end
	return txt;
end
hook_add("PlayerSay","damp_cmd_player_say",player_say);