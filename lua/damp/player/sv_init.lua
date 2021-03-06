local hook_add=hook.Add;
local hook_call=hook.Call;
local stamp=util.DateStamp;
local net_rcv=net.Receive;
local net_str=util.AddNetworkString;
local net_rstr=net.ReadString;
local ply_by_sid=player.GetBySteamID;

net_str("damp_player_first_tick");

function damp_player_new(pl)
	local default_admins=damp_cfg_get("default_admins");
	local role_str=default_admins[pl:SteamID()]||damp_cfg_get("starting_role");
	local role=damp_role_get(role_str);
	local data=
	{
		name=pl:Name(),
		sid=pl:SteamID(),
		role=role,
		joined=stamp()
	};
	damp_query_insert(data);
	damp_player_load(pl,data);
end

function damp_player_load(pl,data)
	damp_cache_init(pl:SteamID(),data);
end

function damp_player_init(pl)
	local cached=damp_cache_get(pl:SteamID());
	if cached then
		damp_player_load(pl:SteamID(),cached);
		return;
	end
	local data=damp_query_find(pl);
	if !data then
		damp_player_new(pl);
	else
		damp_player_load(pl,data);
	end
end

function damp_player_initial_spawn(pl)
	damp_player_init(pl);
end
hook_add("PlayerInitialSpawn","damp_player_initial_spawn",damp_player_initial_spawn);

function damp_player_first_tick()
	local sid=net_rstr();
	local pl=ply_by_sid(sid);
	local data=damp_cache_get(sid);
	damp_net_init(pl,data);
end
net_rcv("damp_player_first_tick",damp_player_first_tick);