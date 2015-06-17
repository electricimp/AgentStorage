# Persist
The Persist library helps you more easily manage data in the [server.save](https://electricimp.com/docs/api/server/save/) table.

NOTE: If you are using the persist class, it is *highly* recommended that you remove all `server.save` and `server.load` commands from your code, and replace them with persist commands.

## Constructor

The Persist class constructor creates a new persist object and loads that data currently in the `server.save` table.

```squirrel
#require "persist.class.nut:1.0.0"
db <- Persist();
```

## read(key)
The read method attempts to read a value from the persist cache. If the key exists, it's value will be returned, otherwise the read method returns 'null'.

```squirrel
local apiKey = db.read("apiKey");
if (apiKey != null) {
    webRequest(apiKey);
}
```

## write(key, data)
The write method inserts or updates data at the specified key, and returns inserted/updated value.

```squirrel
http.onrequest(function(req, resp) {
    if ("apiKey" in req.query) {
        db.write("apiKey", req.query.apiKey);
    }
    resp.send(200, "OK");
});
```

## setDefault(key, data)
The setDefault method initializes a field in the cache. If the key does not exist, the value is written to that key, if the key already exist, no action is taken.

```squirrel
db <- Persist();
// Write 1 to timesRun if it doesn't exist yet
timesRun <- db.setDefault("timesRun", 1);

server.log("This code has run " + timesRun + " times");

db.write("timesRun", timesRun+1);
```

## exists(key)
Returns whether or not a key exists in the persist cache.

```squirrel
if(!(db.exists("username")) {
    throw "Missing required field 'username'";
} else {
    webRequest(username);
}
```

## remove(key)
Removes a field from the cache.

```squirrel
db.write("field", 123);
server.log(db.read("field"));
db.remove("field");
server.log(db.read("field"));
```

## clear
The *clear* method clears the `server.save` table and persist cache.

```
http.onrequest(function(req, resp) {
    local path = req.path.tolower();
    if (path == "/reset" || path == "/reset/") {
        db.clear();
    }
    resp.send(200, "OK");
});
```

# License
The Persist library is licensed under the [MIT License](./LICENSE).
