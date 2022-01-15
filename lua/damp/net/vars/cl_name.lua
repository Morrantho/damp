local net_rstr=net.ReadString;

function receive()
	return net_rstr();
end
damp_net_new("name",receive);

function damp_player_name_get(pl)
	return damp_cache_get_key(pl:SteamID(),"name");
end