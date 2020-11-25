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
    local target

    if args[1] then
        for k, v in ipairs(player.GetAll()) do
            if string.find(v:Nick(), args[1]) then target = v end
        end
    end
    local target = target or ply
    
    target:SetHealth(target:GetMaxHealth())
end

function gmtSetHealth(ply, args)
    local target
    local health = args[2] or args[1]

    if !health then return end 

    if args[2] then
        for k, v in ipairs(player.GetAll()) do
            if string.find(v:Nick(), args[1]) then target = v end
        end
    end
    local target = target or ply

    target:SetHealth(health)
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