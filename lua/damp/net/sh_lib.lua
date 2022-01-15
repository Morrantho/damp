local net_start=net.Start;
local net_rcv=net.Receive;
local net_wu32=net.WriteUInt;
local net_wstr=net.WriteString;
local net_rstr=net.ReadString;
local net_ru32=net.ReadUInt;
local ply_get_all=player.GetAll;
local ply_by_sid=player.GetBySteamID;
local net_sends={[false]=net.Send,[true]=net.SendToServer};
local net_send=net_sends[DAMP_REALM];
local net_strs={[false]="damp_net_sv",[true]="damp_net_cl"};
local msgc=MsgC;
local tostr=tostring;
local send_col=nil;

if SERVER then
	local net_str=util.AddNetworkString;
	net_str("damp_net_sv");
	net_str("damp_net_cl");
end

local fns={};
local vars={};
local broadcasts={}; -- Only matters for initial.

function damp_net_new(key,fn,is_broadcast)
	-- if vars[key] then return; end
	local id=#vars+1;
	vars[id]=key;
	vars[key]=id;
	fns[id]=fn;
	broadcasts[id]=is_broadcast;
end

local function receive()
	local id=net_ru32(8);
	local sid=net_rstr();
	local fn=fns[id];
	local key=vars[id];
	local value=fn();
	damp_cache_set(sid,key,value);
end
net_rcv(net_strs[!DAMP_REALM],receive);

function damp_net_send(pl,to,key,value)
	if !vars[key] then return; end
	local sid=pl:SteamID();
	local id=vars[key];
	net_start(net_strs[DAMP_REALM]);
	net_wu32(id,8);
	net_wstr(sid);
	fns[id](value);
	net_send(to||ply_get_all());
	damp_cache_set(sid,key,value);
end
--First Load only
function damp_net_init(pl,data)
	if !send_col then send_col=damp_color_get_by_key("green1"); end
	local sid=pl:SteamID();
	local to=nil;
	-- Send registered vars
	for i=1,#vars do
		local k=vars[i];
		msgc(send_col,DAMP.." | NET | "..sid.." | "..k.." | "..tostr(data[k]).."\n");
		to=pl;
		if broadcasts[i] then to=nil; end --Let send() get all players
		damp_net_send(pl,to,k,data[k]);
	end
end