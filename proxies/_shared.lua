storage = {};

function add(identifier, package)
    Citizen.CreateThread(function()
        storage[identifier] = package;
    end);
end;

function get(identifier, callback)
    Citizen.CreateThread(function()
        callback(storage[identifier]);
    end);
end;

exports("add", add);
exports("get", get);
