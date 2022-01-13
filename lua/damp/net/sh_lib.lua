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

if SERVER then
	local net_str=util.AddNetworkString;
	net_str("damp_net_sv");
	net_str("damp_net_cl");
end

local send_fns={};
local rcv_fns={};
local vars={};

function damp_net_new(key,send_fn,rcv_fn)
	if vars[key] then return; end
	local id=#vars;
	vars[id]=key;
	vars[key]=id;
	send_fns[id]=send_fn;
	rcv_fns[id]=rcv_fn;
end

local function receive()
	local id=net_ru32(8);
	local sid=net_rstr();
	local fn=rcv_fns[id];
	if !fn then return; end
	local key=vars[id];
	local value=fn();
	damp_cache_set(sid,key,value);
end
net_rcv(net_strs[!DAMP_REALM],receive);

function damp_net_send(pl,to,key,value)
	if !vars[key]||!send_fns[vars[key]] then return; end
	local sid=pl:SteamID();
	net_start(net_strs[DAMP_REALM]);
	net_wu32(vars[key],8);
	net_wstr(sid);
	send_fns[vars[key]](value);
	net_send(to||ply_get_all());
	damp_cache_set(sid,key,value);
end