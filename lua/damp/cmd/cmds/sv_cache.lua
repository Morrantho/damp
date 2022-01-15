local cmd={};
cmd.aliases={"cache"};
cmd.role="root";
cmd.usage="";
cmd.description="";

function cmd.run(pl,args)
	local cache=damp_cache_get_all();
	local col=damp_color_get_by_key("sv");
	damp_util_log_table(cache,col);
end

damp_cmd_new(cmd);