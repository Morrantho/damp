local net_rcv=net.Receive;
local net_ru32=net.ReadUInt;
local net_rstr=net.ReadString;
local add_text=chat.AddText;

function damp_player_msgc(pl,txt,col_str)
	local col=damp_color_get_by_key(col_str);
	add_text(txt,col);
end

local function damp_player_on_msgc()
	local col=damp_color_get_by_id(net_ru32(8));
	local txt=net_rstr();
	add_text(col,txt);
end
net_rcv("damp_player_msgc",damp_player_on_msgc);