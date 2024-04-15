require "PaintVehicle.lua"

local vehiclePaintTable = {
    ["Base.ATAMustang66"] = {
        ["PaintRed"] = 1,
    },
    ["Base.ATAMustang66Custom"] = {
        ["PaintRed"] = 1,
    },
}


local function doFillMenuOutsideVehicle(playerObj, context, vehicle, test)
    local playerInv = playerObj:getInventory()
    local paintTable = vehiclePaintTable[vehicle:getScriptName()]

    if paintTable then
        
        local paintMenuOpt, paintSubMenu = PaintVehicle.getOrCreatePaintMenu(context)
        local menuAvailable = false

        if (vehicle:getSkinIndex()%2) == 0 then
            menuAvailable = PaintVehicle.createPaintMenuOpt(paintSubMenu,
                                                            playerObj,
                                                            context,
                                                            vehicle,
                                                            vehicle:getSkinIndex()+1,
                                                            getText("ContextMenu_Vehicle_Write_STRAYS"),
                                                            paintTable)
        else
            menuAvailable = PaintVehicle.createCleanMenuOpt(paintSubMenu,
                                                            playerObj,
                                                            context,
                                                            vehicle,
                                                            vehicle:getSkinIndex()-1,
                                                            getText("ContextMenu_Vehicle_Clean_STRAYS"),
                                                            1)
        end

        if not menuAvailable then
            paintMenuOpt.notAvailable = true
        end

    end
end


local function onfillMenuOutsideVehicleMenu(player, context, worldobjects, test)
    PaintVehicle.doPrepareOutsideVehicleMenu(player, doFillMenuOutsideVehicle, context, worldobjects, test)
end


Events.OnFillWorldObjectContextMenu.Add(onfillMenuOutsideVehicleMenu)