local net_wu32=net.WriteUInt;

local function send(value)
	net_wu32(value,8);
end
damp_net_new("role",send,true);