function damp_player_role_set(pl,role_str)
	local role=damp_role_get(role_str);
	if !role then return 0; end
	damp_query_update(pl,{role=role});
	damp_net_send(pl,nil,"role",role); -- Broadcast
	return 1;
end

function damp_player_role_get(pl)
	return damp_cache_get(pl:SteamID()).role;
end