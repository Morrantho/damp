local cmd={};
cmd.aliases={"damp_sv_cache"};
cmd.role="root";

function cmd.run(pl,args)
	local cache=damp_cache_get_all();
	local col=damp_color_get("sv");
	damp_util_log_table(cache,col);
end

damp_cmd_new(cmd);