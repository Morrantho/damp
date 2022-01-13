local cache={};

function damp_cache_init(sid,data)
	cache[sid]=data;
end

function damp_cache_set(sid,key,data)
	if !cache[sid] then cache[sid]={}; end
	cache[sid][key]=data;
end

function damp_cache_get(sid)
	return cache[sid];
end

function damp_cache_get_key(sid,key)
	return cache[sid][key];
end

function damp_cache_get_all()
	return cache;
end

function damp_cache_clear()
	cache={};
end