local cfg={};
cfg.starting_role="user";
cfg.default_admins=
{
	-- ["STEAM_0:0:18578874"]="root", 		--pyg
	-- ["STEAM_0:0:636185670"]="root",		--pyg alt
};

function damp_cfg_get(key)
	return cfg[key];
end