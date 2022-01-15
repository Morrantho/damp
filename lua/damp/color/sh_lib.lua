local color=Color;

local colors={};

function damp_color_new(key,r,g,b,a)
	if colors[key] then return; end
	local id=#colors+1;
	colors[key]=id;
	colors[id]=color(r,g,b,a);
	return colors[key];
end

function damp_color_get_id(key)
	return colors[key];
end

function damp_color_get_by_key(key)
	return colors[colors[key]];
end

function damp_color_get_by_id(id)
	return colors[id];
end

damp_color_new("sv",3,169,244,255);
damp_color_new("cl",222,169,9,255);
damp_color_new("sh",76,175,80,255);
damp_color_new("red1",231,76,60);
damp_color_new("green1",46,204,113);
damp_color_new("blue1",52,152,219);
damp_color_new("yellow1",241,196,15);
damp_color_new("orange1",230,126,34);
damp_color_new("purple1",155,89,182);