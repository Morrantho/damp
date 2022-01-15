local lower=string.lower;

local cmd={};
cmd.aliases={"set_role"};
cmd.role="admin";
cmd.usage="<player> <role>";
cmd.description="Set's a player's role.";

function cmd.run(pl,args)
	if #args<2 then return true; end
	local pl2=damp_player_find(args[1]);
	if !pl2 then return "Player: "..args[1].." not found."; end
	local role=damp_role_get(lower(args[2]));
	if !role then return "Invalid Role: "..args[2]; end
	print("lel");
	-- damp_player_msgc(pl,txt,col_str);
	-- damp_query_update(pl2,{role=role});
	-- damp_net_send();
	return false;
end
damp_cmd_new(cmd);