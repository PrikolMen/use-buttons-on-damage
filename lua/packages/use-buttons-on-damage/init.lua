install( "packages/glua-extensions", "https://github.com/Pika-Software/glua-extensions" )

local IsValid = IsValid

local function findButton( entity, blacklist )
    if not IsValid( entity ) then return end
    if blacklist[ entity ] then return end
    blacklist[ entity ] = true

    if entity:IsButton() then
        return entity
    end

    return findButton( entity:GetParent(), blacklist )
end

hook.Add( "EntityTakeDamage", "Entity Damaged", function( entity, damageInfo )
    local button = findButton( entity, {} )
    if not button then return end

    button:Use( damageInfo:GetAttacker(), damageInfo:GetInflictor() )
end )