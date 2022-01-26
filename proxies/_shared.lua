Proxy = {
    storage = {}
};

function add(identifier, package)
    Citizen.CreateThread(function()
        Proxy.storage[_iname] = _idata;
    end);
end;

function get(_iname, _callback)
    Citizen.CreateThread(function()
        _callback(Proxy.storage[_iname]);
    end);
end;

exports("add", add);
exports("get", get);
