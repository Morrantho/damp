local tostr=tostring;
local msgc=MsgC;

function damp_util_log_table(value,col,indent,key)
	if !indent then indent=""; end
	if type(value)=="table" then
		for a,b in pairs(value) do
			if type(b)=="table" then
				msgc(col,indent..tostr(a).."="..indent.."\n{\n");
			end
			damp_util_log_table(b,col,"\t"..indent,a);
		end
		if indent=="" then return; end
		msgc(col,indent:sub(1,#indent-1).."}\n");
	else
		if key then
			msgc(col,indent:sub(1,#indent-1)..key.."="..tostr(value).."\n");
		end
	end
end