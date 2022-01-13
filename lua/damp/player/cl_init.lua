local hook_add=hook.Add;
local hook_remove=hook.Remove
local net_start=net.Start;
local net_send=net.SendToServer;
local net_wstr=net.WriteString;
local ran=false;

function damp_player_first_tick(pl,mov)
	hook_remove("PlayerTick","damp_player_first_tick");
	if ran then return; end
	ran=true;
	net_start("damp_player_first_tick");
	net_wstr(pl:SteamID());
	net_send();
end
hook_add("PlayerTick","damp_player_first_tick",damp_player_first_tick);