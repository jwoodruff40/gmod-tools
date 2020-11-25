if SERVER then

util.AddNetworkString("maxammo")
util.AddNetworkString("allammo")

net.Receive("maxammo", function(len, ply)
    gmtGiveAmmo(ply, net.ReadTable())
    end
)

net.Receive("allammo", function(len, ply)
    gmtAllAmmo(ply, net.ReadTable())
    end
)

function gmtGiveAmmo(ply, args)
    local weap = ply:GetActiveWeapon()
    local ammo = weap:GetPrimaryAmmoType()
    local ammo2 =weap:GetSecondaryAmmoType()

	ply:GiveAmmo(game.GetAmmoMax(ammo), ammo)

    if (weap.Base == "cw_base" or weap.Base == "cw_kk_ins2_base") then
        for category, data in pairs (weap.Attachments) do
            local last = weap.Attachments[category].last
            
            if ((data.header == "Under" or data.header == "Barrel") and (last) and (string.match(data.atts[last], "_gl_") or string.match(data.atts[last], "m203"))) then
                ply:GiveAmmo(game.GetAmmoMax(game.GetAmmoID("40MM")), "40MM")
            end
        end
    elseif ammo2 then
        ply:GiveAmmo(game.GetAmmoMax(ammo2), ammo2)
    end
end

function gmtAllAmmo(ply, args)
    local types =game.GetAmmoTypes()

    for id, name in pairs (types) do
        ply:GiveAmmo(game.GetAmmoMax(id), id)
    end
end

end

if CLIENT then

concommand.Add("givemaxammo", function(ply, cmd, args)
    net.Start("maxammo")
    net.WriteTable(args)
    net.SendToServer()
    end
, nil, nil, FCVAR_CHEAT)

concommand.Add("giveallammo", function(ply, cmd, args)
    net.Start("allammo")
    net.WriteTable(args)
    net.SendToServer()
    end
, nil, nil, FCVAR_CHEAT)

end