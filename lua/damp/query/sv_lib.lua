function damp_query_insert(data)
	-- damp_mongo_insert(data); -- b0rk3d
	damp_mongo_bulk(data);
end

function damp_query_find(pl)
	return damp_mongo_find_one({sid=pl:SteamID()});
end

function damp_query_update(pl,data)
	damp_mongo_update({sid=pl:SteamID()},data);
end

function damp_query_remove(pl)
	damp_mongo_remove({sid=pl:SteamID()});
end