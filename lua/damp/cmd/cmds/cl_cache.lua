local cmd={};
cmd.aliases={"damp_cl_cache"};
cmd.role="root";

function cmd.run(pl,args)
	local cache=damp_cache_get_all();
	local col=damp_color_get_by_key("cl");
	damp_util_log_table(cache,col);
end

damp_cmd_new(cmd);