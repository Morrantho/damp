local net_ru32=net.ReadUInt;

function receive()
	return net_ru32(8);
end
damp_net_new("role",receive);

function damp_player_role_get(pl)
	return damp_cache_get_key(pl:SteamID(),"role");
end