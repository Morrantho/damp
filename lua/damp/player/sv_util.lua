local net_str=util.AddNetworkString;
local net_start=net.Start;
local net_send=net.Send;
local net_wu32=net.WriteUInt;
local net_wstr=net.WriteString;

net_str("damp_player_msgc");

function damp_player_msgc(pl,txt,col_str)
	local col_id=damp_color_get_id(col_str);
	net_start("damp_player_msgc");
	net_wu32(col_id,8);
	net_wstr(txt);
	net_send(pl);
end