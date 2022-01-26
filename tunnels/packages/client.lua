function new(identifier, interface)
    RegisterNetEvent(identifier..":tunnel_req")
    AddEventHandler(identifier..":tunnel_req", function()
        TriggerServerEvent(identifier..":tunnel_res", interface)
    end);

    TriggerServerEvent(identifier..":tunnel_res", interface);
    
    RegisterNetEvent(identifier..":tunnel_exec")
    AddEventHandler(identifier..":tunnel_exec", function(_fname, _params, _id)
        local result = 0;

        if #_params > 0 then
            result = interface[_fname](table.unpack(_params));
        else
            result = interface[_fname]();
        end;

        TriggerServerEvent(identifier.."_".._fname..":cb_".._id, result)
    end);
end;

function get(identifier, callback)
    RegisterNetEvent(identifier..":tunnel_res")
    AddEventHandler(identifier..":tunnel_res", function(interface)
        local data = {};

        for i,v in pairs(interface) do
            data[i] = function(source, params)
                TriggerServerEvent(identifier..":tunnel_exec", i, params);
            end
        end

        callback(data);
    end);
    
    TriggerServerEvent(identifier..":tunnel_req");
end;

exports("new", new);
exports("get", get);
