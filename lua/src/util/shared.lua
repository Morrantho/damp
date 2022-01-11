local all=player.GetAll;
local str_find=string.find;
local str_sub=string.sub;
local str_lower=string.lower;

function damp_util_find_player(id)
	if type(id)~="string" then return; end
	id=str_lower(id);
	local plys=all();
	for i=1,#plys do
		local pl=plys[i];
		local is_nick=str_find(str_lower(pl:Nick()));
		local is_name=str_find(str_lower(pl:Name()));
		local is_sid=str_find(str_lower(pl:SteamID()));
		if is_nick||is_name||is_sid then return pl; end
	end
end