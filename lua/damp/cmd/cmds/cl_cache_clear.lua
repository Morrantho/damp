local cmd={};
cmd.aliases={"damp_cl_cache_clear"};
cmd.role="root";

function cmd.run(pl,args)
	damp_cache_clear();
end
damp_cmd_new(cmd);