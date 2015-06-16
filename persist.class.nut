// Copyright (c) 2015 Electric Imp
// This file is licensed under the MIT License
// http://opensource.org/licenses/MIT

class Persist {
    static version = [1,0,0];

    _cache = null;  // A local cache of the data

    // Class ctor - creates object and loads data
    constructor() {
        _cache = server.load();
    }

    // Reads a value from the cache
    // Parameters:
    //      key:    The key of the data we're requesting
    //
    // Returns:     The value (if the key exists)
    //              null (if the key doesn't exist)
    function read(key) {
        return (key in _cache) ? _cache[key] : null;
    }

    // Inserts or updates data in the cache
    // Parameters:
    //      key:    The key of the data we're writing
    //      value:  The data we're writing
    //
    // Returns:     The data we wrote
    function write(key, value) {
        if (!(key in _cache)) {
            _cache[key] <- value;
            server.save(_cache);
        } else if (_cache[key] != value) {
            _cache[key] = value;
            server.save(_cache);
        }

        return value;
    }

    // Initializes a field in the cache. If the key does not
    // exist, the value is written to that key, if the key
    // does exist, no action is taken
    // Parameters:
    //      key:    The key of the data we're intitializing
    //      value:  The default value
    //
    // Returns:     The data at the specified key (the default value
    //              if the key was created, or the existing data in the
    //              cache if the key was already initialized).
    function init(key, value){
        if(!(key in _cache)){
            _cache[key] <- value;
            server.save(_cache);
        }
        return _cache[key];
    }

    // Returns whether or not a key exists in the cache
    // Parameters:
    //      key:    The key we're checking
    //
    // Returns:     True if the key exists in the cache
    //              False if the key does not exist in the cache.
    function exists(key) {
        return key in _cache;
    }

    // Removes a field from the cache.
    // Parameters:
    //      key:    The key of the data we're removing.
    //
    // Returns:     True if the data existed and we removed it
    //              False if the data did not exist
    function remove(key) {
        if (key in _cache) {
            delete _cache[key];
            server.save(_cache);
            return true;
        }
        return false;
    }

    // Clears the server.save table.
    // Returns:     An empty table
    function clear() {
        local data = {};
        server.save(data);
        _cache = data;
        return data;
    }
}
