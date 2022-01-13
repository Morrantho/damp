local str_caps=string.upper;

local roles={};

function damp_role_new(str,lvl)
	roles[str]=lvl;
	roles[lvl]=str;
end

function damp_role_get(id)
	return roles[id];
end

damp_role_new("user",1);
damp_role_new("moderator",2);
damp_role_new("admin",3);
damp_role_new("superadmin",4);
damp_role_new("root",99);