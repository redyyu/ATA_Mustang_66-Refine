
local vehicleTable = {
    ["Base.ATAMustang66"] = 1,
    ["Base.ATAMustang66Custom"] = 1
}

local paintTable = {
    ["PaintGreen"] = 0,
    ["PaintRed"] = 2,
    ["PaintBlue"] = 4,
    ["PaintGrey"] = 6,
    ["PaintBlack"] = 8,
    ["PaintLightBlue"] = 10,
    ["PaintCyan"] = 12,
    ["PaintYellow"] = 14,
    ["PaintLightBrown"] = 16,
}


local paintBus = function(playerObj, vehicle, newSkinIndex, paintBrush, paintCan, uses)
    if paintBrush and paintCan and paintCan:getUses() * 10 >= uses then
        ISWorldObjectContextMenu.transferIfNeeded(playerObj, paintBrush)
        ISWorldObjectContextMenu.transferIfNeeded(playerObj, paintCan)
        ISTimedActionQueue.add(ISPathFindAction:pathToVehicleArea(playerObj, vehicle, "Engine"))
        ISTimedActionQueue.add(ISPaintBus:new(playerObj, vehicle, "Engine", newSkinIndex))
        for i=0, uses - 1 do
            paintCan:Use()
        end
    end
end

local cleanBus = function(playerObj, vehicle, newSkinIndex, sponge, bleach)
    if sponge and bleach and bleach:getType() == "Bleach" and bleach.ThirstChange > 10 then
        ISWorldObjectContextMenu.transferIfNeeded(playerObj, sponge)
        ISWorldObjectContextMenu.transferIfNeeded(playerObj, bleach)
        ISTimedActionQueue.add(ISPathFindAction:pathToVehicleArea(playerObj, vehicle, "Engine"))
        ISTimedActionQueue.add(ISPaintBus:new(playerObj, vehicle, "Engine", newSkinIndex))
        bleach.ThirstChange = bleach.ThirstChange - 10
    end
end



local function fillMenuOutsideVehicle(playerObj, context, vehicle, test)
    local playerInv = playerObj:getInventory()
    
    if (vehicleTable[vehicle:getScriptName()]) then 
        
        local paintMenuOpt = context:addOption(getText("ContextMenu_Vehicle_PAINT"), nil, nil)
        local subMenuAvailable = false
        local subMenu = ISContextMenu:getNew(context)
        context:addSubMenu(paintMenuOpt, subMenu)

        -- Paint words

        if (vehicle:getSkinIndex()%2) == 0 then
            local paintBrush = playerInv:getFirstTypeRecurse("Paintbrush")
            local paintCan = playerInv:getFirstTypeRecurse("PaintRed")
            writeOpt = subMenu:addOptionOnTop(getText("ContextMenu_Vehicle_STRAYS"), 
                                              playerObj, paintBus, vehicle, vehicle:getSkinIndex()+1, paintBrush, paintCan, 1)
            if vehicle and paintBrush and paintCan and paintCan:getUses() * 10 >= 1 then
                subMenuAvailable = true
            else
                writeOpt.toolTip = ISWorldObjectContextMenu.addToolTip()
                writeOpt.toolTip:setName(getText("ContextMenu_Vehicle_STRAYS"))
                writeOpt.toolTip.description = ISBuildMenu.bhs .. getText("Tooltip_Vehicle_NEED_PAINTBRUSH_PAINTRED")
            end
        else
            local sponge = playerInv:getFirstTypeRecurse("Sponge")
            local bleach = playerInv:getFirstTypeRecurse("Bleach")
            cleanOpt = subMenu:addOptionOnTop(getText("ContextMenu_Vehicle_CLEAN_STRAYS"),
                                              playerObj, cleanBus, vehicle, vehicle:getSkinIndex()-1, sponge, bleach)
            if vehicle and sponge and bleach and bleach.ThirstChange > 10 then
                subMenuAvailable = true
            else
                writeOpt.toolTip = ISWorldObjectContextMenu.addToolTip()
                writeOpt.toolTip:setName(getText("ContextMenu_Vehicle_CLEAN_STRAYS"))
                writeOpt.toolTip.description = ISBuildMenu.bhs .. getText("Tooltip_Vehicle_NEED_SPONGE_BLEACH")
            end
        end

        -- Paint car

        for k, v in pairs(paintTable) do
            local paintBrush = playerInv:getFirstTypeRecurse("Paintbrush")
            local paintCan = playerInv:getFirstTypeRecurse(k)
            local uses = 5
            local opt = subMenu:addOption(getText(k), playerObj, paintBus, vehicle, v, paintBrush, paintCan, uses)
            opt.toolTip = ISWorldObjectContextMenu.addToolTip()
            opt.toolTip:setName(getText(k))
            opt.toolTip.description = getText("Tooltip_Vehicle_PAINT")

            if paintBrush then
                opt.toolTip.description = opt.toolTip.description .. "<LINE>" .. ISBuildMenu.ghs .. getText('Paintbrush') .. " 1/1 <LINE> "
            else
                opt.toolTip.description = opt.toolTip.description .. "<LINE>" .. ISBuildMenu.bhs .. getText('Paintbrush') .. " 0/1 <LINE> "
                if not ISBuildMenu.cheat then
                    opt.onSelect = nil
                    opt.notAvailable = true
                end
            end

            local have_uses = 0
            if PaintCan then
                have_uses = paintCan:getUses() * 10
            end

            if paintCan and have_uses >= uses then
                opt.toolTip.description = opt.toolTip.description .. "<LINE>" .. ISBuildMenu.ghs .. getText(k) .. " "..paintCan:getUses().."/".. uses .." <LINE> "
            else
                opt.toolTip.description = opt.toolTip.description .. "<LINE>" .. ISBuildMenu.bhs .. getText(k) .. " "..have_uses.."/".. uses .." <LINE> "
                if not ISBuildMenu.cheat then
                    opt.onSelect = nil
                    opt.notAvailable = true
                end
            end
            if not opt.notAvailable then
                subMenuAvailable = true
            end
        end

        if not subMenuAvailable and not ISBuildMenu.cheat then
            paintMenuOpt.notAvailable = true
        end

    end
end


local onfillMenuOutsideVehicleMenu = function(player, context, worldobjects, test)
    local playerObj = getSpecificPlayer(player)
    local vehicle = playerObj:getVehicle()
    if not vehicle then
        if JoypadState.players[player+1] then
            local px = playerObj:getX()
            local py = playerObj:getY()
            local pz = playerObj:getZ()
            local sqs = {}
            sqs[1] = getCell():getGridSquare(px, py, pz)
            local dir = playerObj:getDir()
            if (dir == IsoDirections.N) then        sqs[2] = getCell():getGridSquare(px-1, py-1, pz); sqs[3] = getCell():getGridSquare(px, py-1, pz);   sqs[4] = getCell():getGridSquare(px+1, py-1, pz);
            elseif (dir == IsoDirections.NE) then   sqs[2] = getCell():getGridSquare(px, py-1, pz);   sqs[3] = getCell():getGridSquare(px+1, py-1, pz); sqs[4] = getCell():getGridSquare(px+1, py, pz);
            elseif (dir == IsoDirections.E) then    sqs[2] = getCell():getGridSquare(px+1, py-1, pz); sqs[3] = getCell():getGridSquare(px+1, py, pz);   sqs[4] = getCell():getGridSquare(px+1, py+1, pz);
            elseif (dir == IsoDirections.SE) then   sqs[2] = getCell():getGridSquare(px+1, py, pz);   sqs[3] = getCell():getGridSquare(px+1, py+1, pz); sqs[4] = getCell():getGridSquare(px, py+1, pz);
            elseif (dir == IsoDirections.S) then    sqs[2] = getCell():getGridSquare(px+1, py+1, pz); sqs[3] = getCell():getGridSquare(px, py+1, pz);   sqs[4] = getCell():getGridSquare(px-1, py+1, pz);
            elseif (dir == IsoDirections.SW) then   sqs[2] = getCell():getGridSquare(px, py+1, pz);   sqs[3] = getCell():getGridSquare(px-1, py+1, pz); sqs[4] = getCell():getGridSquare(px-1, py, pz);
            elseif (dir == IsoDirections.W) then    sqs[2] = getCell():getGridSquare(px-1, py+1, pz); sqs[3] = getCell():getGridSquare(px-1, py, pz);   sqs[4] = getCell():getGridSquare(px-1, py-1, pz);
            elseif (dir == IsoDirections.NW) then   sqs[2] = getCell():getGridSquare(px-1, py, pz);   sqs[3] = getCell():getGridSquare(px-1, py-1, pz); sqs[4] = getCell():getGridSquare(px, py-1, pz);
            end
            for _, sq in ipairs(sqs) do
                vehicle = sq:getVehicleContainer()
                if vehicle then
                    return fillMenuOutsideVehicle(playerObj, context, vehicle, test)
                end
            end
            return
        end
        
        vehicle = IsoObjectPicker.Instance:PickVehicle(getMouseXScaled(), getMouseYScaled())
        if vehicle then
            return fillMenuOutsideVehicle(playerObj, context, vehicle, test)
        end
    end
end


Events.OnFillWorldObjectContextMenu.Add(onfillMenuOutsideVehicleMenu)