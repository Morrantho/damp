require("mongodb");
local connection=nil;
local db=nil;
local players=nil;
local uri="mongodb://127.0.0.1:27017";

function damp_mongo_connect()
	connection=mongodb.Client(uri,"whatisthis");
	db=connection:Database("damp");
	players=db:GetCollection("players");
end

function damp_mongo_find(filter)
	return players:Find(filter);
end

function damp_mongo_find_one(filter)
	return players:Find(filter)[1];
end
--Broken for who knows what reason
function damp_mongo_insert(data)
	players:Insert(data);
end
--Use me as insert instead, even if for only one document.
function damp_mongo_bulk(data)
	local bulk=players:Bulk({});
	bulk:Insert(data);
	local res=bulk:Execute();
end

function damp_mongo_update(filter,data)
	players:Update(filter,data);
end

function damp_mongo_remove(filter)
	return players:Remove(filter);
end

damp_mongo_connect();