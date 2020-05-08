function isInVehicle(ped)
    ped = ped or PlayerPedId()

    local vehicle = GetVehiclePedIsIn(ped)
    if vehicle == 0 then
        return false
    else
        return vehicle
    end
end

exports('isInVehicle',isInVehicle)

--- @return vector3
function getPlayerPos()
    local ped = PlayerPedId()
    return GetEntityCoords(ped)
end

exports('getPlayerPos', getPlayerPos)

--- @param x number
--- @param y number
--- @param z number
--- @param text string
function draw3DText(pos, text, options)
    options = options or { }
    local color = options.color or {r = 255, g = 255, b = 255, a = 255}
    local scaleOption = options.size or 0.8

    local camCoords      = GetGameplayCamCoords()
    local dist           = GetDistanceBetweenCoords(camCoords.x, camCoords.y, camCoords.z, pos.x, pos.y, pos.z, 1)
    local scale = (scaleOption / dist) * 2
    local fov   = (1 / GetGameplayCamFov()) * 100
    local scaleMultiplier = scale * fov
    SetDrawOrigin(pos.x, pos.y, pos.z, 0);
    SetTextFont(getFontId())
    SetTextProportional(0)
    SetTextScale(0.0 * scaleMultiplier, 0.55 * scaleMultiplier)
    SetTextColour(color.r,color.g,color.b,color.a)
    SetTextDropshadow(0, 0, 0, 0, 255)
    SetTextEdge(2, 0, 0, 0, 150)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()
end

exports('draw3DText', draw3DText)

function deleteVehicle(vehicle)
    SetEntityAsMissionEntity(vehicle, false, true)
    DeleteVehicle(vehicle)
end

exports('deleteVehicle', deleteVehicle)
