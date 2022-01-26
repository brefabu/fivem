--[[
    This script is inspired by vRP.

    Explain of logic:
        Tunnel is a hub of interfaces, by events other scripts requests data from it!
]]
local rid = 0;

function new(identifier, interface)
    RegisterServerEvent(identifier..":tunnel_req")
    AddEventHandler(identifier..":tunnel_req", function()
        local source = source

        TriggerClientEvent(identifier..":tunnel_res", source, interface)
    end);
    
    RegisterServerEvent(identifier..":tunnel_exec")
    AddEventHandler(identifier..":tunnel_exec", function(_fname, _params)
        if #_params > 0 then
            interface[_fname](table.unpack(_params));
        else
            interface[_fname]();
        end;
    end);
end;

function get(identifier, callback)
    RegisterServerEvent(identifier..":tunnel_res")
    AddEventHandler(identifier..":tunnel_res", function(interface)
        local source = source;
        local data = {};

        for i,v in pairs(interface) do
            data[i] = function(source, params, cb)
                rid = rid + 1;
                TriggerClientEvent(identifier..":tunnel_exec", source, i, params, rid);

                if cb ~= nil then
                    RegisterServerEvent(identifier.."_"..i..":cb_"..rid)
                    AddEventHandler(identifier.."_"..i..":cb_"..rid, function(result)
                        cb(result);
                    end);
                end;
            end;
        end;

        callback(data);
    end);

    TriggerClientEvent(identifier..":tunnel_req", -1);
end;

exports("new", new);
exports("get", get);
