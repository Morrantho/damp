local net_ru32=net.ReadUInt;

function receive()
	return net_ru32(8);
end
damp_net_new("role",nil,receive);