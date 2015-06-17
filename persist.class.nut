// Copyright (c) 2015 Electric Imp
// This file is licensed under the MIT License
// http://opensource.org/licenses/MIT

class AgentStorage {
    static version = [1,0,0];

    _cache = null;  // A local cache of the data

    // Class ctor - creates object and loads data
    constructor(b = null) {
        _cache = server.load();
    }

    // Reads a value from the cache
    // Parameters:
    //      key:    The key of the data we're requesting
    //
    // Returns:     The value (if the key exists)
    //              null (if the key doesn'y exist)
    function read(key) {
        return key in _cache ? _cache[key] : null;
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
    function setDefault(key, value){
        // If it exists, return the existing value
        if (key in _cache) { return _cache[key]; }

        // Otherwise write the value and return the written value
        return write(key, value);
    }

    // Inserts or updates data in the cache
    // Parameters:
    //      key:    The key of the data we're writing
    //      value:  The data we're writing
    //
    // Returns:     nothing
    function write(key, value) {
        _cache[key] <- value;
        server.save(_cache);
        return value;
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
    // Returns:     nothing
    function remove(key) {
        if (key in _cache) {
            delete _cache[key];
            server.save(_cache);
        }
    }

    // Resets the server.save table
    //
    // Returns:     nothing.
    function clear() {
        _cache = {};
        server.save(_cache);
    }

    // Returns the number of top level elements in the server.save table
    //
    // Returns:     Number of top level elements in server.save table.
    function len() {
        return _cache.len();
    }
}
