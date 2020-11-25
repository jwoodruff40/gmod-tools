if SERVER then

util.AddNetworkString("heal")
util.AddNetworkString("sethealth")

net.Receive("heal", function(len, ply)
    gmtHeal(ply, net.ReadTable())
    end
)

net.Receive("sethealth", function(len, ply)
    gmtSetHealth(ply, net.ReadTable())
    end    
)

function gmtHeal(ply, args)
    ply:SetHealth(ply:GetMaxHealth())
end

function gmtSetHealth(ply, args)
    if !args[1] then return end 
    ply:SetHealth(args[1])
end

end

if CLIENT then

concommand.Add("heal", function(ply, cmd, args)
    net.Start("heal")
    net.WriteTable(args)
    net.SendToServer()
    end
, nil, nil, FCVAR_CHEAT)

concommand.Add("sethealth", function(ply, cmd, args)
    net.Start("sethealth")
    net.WriteTable(args)
    net.SendToServer()
    end
, nil, nil, FCVAR_CHEAT)

end