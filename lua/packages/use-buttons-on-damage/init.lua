require( "packages/glua-extensions", "https://github.com/Pika-Software/glua-extensions" )

local IsValid = IsValid

local function findButton( ent, blacklist )
    if not IsValid( ent ) then return end

    if not blacklist then blacklist = {} end
    if blacklist[ ent ] then return end
    blacklist[ ent ] = true

    if ent:IsButton() then return ent end
    return findButton( ent:GetParent(), blacklist )
end

hook.Add( "EntityTakeDamage", "Activate Buttons on Damage", function( entity, dmg )
    local button = findButton( entity )
    if not IsValid( button ) then return end
    button:Use( dmg:GetAttacker(), dmg:GetInflictor() )
end )