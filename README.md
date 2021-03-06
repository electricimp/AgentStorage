# AgentStorage #

The AgentStorage library helps you more easily manage data in the [server.save](https://electricimp.com/docs/api/server/save/) table.

**Note** If you are using the AgentStorage class, it is *highly* recommended that you remove all other [**server.save()**](https://developer.electricimp.com/api/server/save) and [**server.load()**](https://developer.electricimp.com/api/server/load) commands from your code.

## Class Usage ##

The class constructor creates a new AgentStorage object and loads that data currently in the [**server.save()**](https://developer.electricimp.com/api/server/save) table.

```squirrel
#require "agentstorage.class.nut:1.0.0"
db <- AgentStorage();
```

## Class Methods ##

### read(key) ###

This method attempts to read a value from the [**server.save()**](https://developer.electricimp.com/api/server/save) table. If the key exists, it's value will be returned, otherwise the read method returns `null`.

```squirrel
local apiKey = db.read("apiKey");
if (apiKey != null) {
  webRequest(apiKey);
}
```

### write(key, data) ###

This method inserts or updates data in the [**server.save()**](https://developer.electricimp.com/api/server/save) table and returns the inserted/updated value.

```squirrel
http.onrequest(function(req, resp) {
  if ("apiKey" in req.query) {
    db.write("apiKey", req.query.apiKey);
  }
  
  resp.send(200, "OK");
});
```

### setDefault(key, data) ###

This method ensures the specified key exists in the [**server.save()**](https://developer.electricimp.com/api/server/save) table. If the key does not yet exists, *setDefault()* writes that data and returns what was written. If the key already exists, *setDefault()* does not modify the [**server.save()**](https://developer.electricimp.com/api/server/save) table, and returns the existing data.

```squirrel
db <- AgentStorage();

// Write 1 to timesRun if it doesn't exist yet
timesRun <- db.setDefault("timesRun", 1);

server.log("This code has run " + timesRun + " times");

db.write("timesRun", timesRun+1);
```

### exists(*key*) ###

This method returns whether or not a key exists in the [**server.save()**](https://developer.electricimp.com/api/server/save) table.

```squirrel
if (!(db.exists("username")) {
  throw "Missing required field 'username'";
} else {
  webRequest(username);
}
```

### remove(*key*) ###

Removes a field from the [**server.save()**](https://developer.electricimp.com/api/server/save) table, and returns the removed value. If the key was not found, *remove* returns `null`.

```squirrel
// Write a value
db.write("field", 123);
server.log(db.read("field"));

// Remove a value
db.remove("field");
server.log(db.read("field"));
```

### clear() ##

This method clears the [**server.save()**](https://developer.electricimp.com/api/server/save) table.

```squirrel
http.onrequest(function(req, resp) {
  local path = req.path.tolower();
  if (path == "/reset" || path == "/reset/") {
    db.clear();
  }
  
  resp.send(200, "OK");
});
```

### len() ###

This method returns the number of top level elements in the [**server.save()**](https://developer.electricimp.com/api/server/save) table.

```squirrel
if (db.len() == 0) {
  // No data in server.save yet
  // Do something..
}
```

## License ##

The AgentStorage library is licensed under the [MIT License](./LICENSE).
