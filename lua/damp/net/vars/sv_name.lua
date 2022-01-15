local net_wstr=net.WriteString;

local function send(value)
	net_wstr(value);
end
damp_net_new("name",send,true);

function damp_player_name_get(pl)
	return damp_cache_get_key(pl:SteamID(),"name");
end