concommand.Add("givemaxammo", function(ply, cmd, args)
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
end)

concommand.Add("giveallammo", function(ply, cmd, args)
    local types =game.GetAmmoTypes()

    for id, name in pairs (types) do
        ply:GiveAmmo(game.GetAmmoMax(id), id)
    end
end)