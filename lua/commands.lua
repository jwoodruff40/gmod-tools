concommand.Add("givemaxammo", function(ply, cmd, args)
    local weap = ply:GetActiveWeapon()
    local ammo = weap:GetPrimaryAmmoType()
    local ammo2 =weap:GetSecondaryAmmoType()

	ply:GiveAmmo(game.GetAmmoMax(ammo), ammo)

    if weap.Base == "cw_base" or weap.Base == "cw_kk_ins2_base" then
        for category, data in pairs (weapons.GetStored(weap:GetClass())["Attachments"]) do
            if category != "+use" then
                for key, att in ipairs(data.atts) do
                    if(string.match(att, "_gl_") or string.match(att, "m203")) then
                        ply:GiveAmmo(game.GetAmmoMax(game.GetAmmoID("40MM")), "40MM")
                    end
                end
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