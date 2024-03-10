
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

local PaintVehicle = {}
PaintVehicle.cheat = false or getDebug()
PaintVehicle.ghs = " <RGB:" .. getCore():getGoodHighlitedColor():getR() .. "," .. getCore():getGoodHighlitedColor():getG() .. "," .. getCore():getGoodHighlitedColor():getB() .. "> "
PaintVehicle.bhs = " <RGB:" .. getCore():getBadHighlitedColor():getR() .. "," .. getCore():getBadHighlitedColor():getG() .. "," .. getCore():getBadHighlitedColor():getB() .. "> "


PaintVehicle.paintBus = function(playerObj, vehicle, newSkinIndex, paintBrush, paintCan, uses)
    if paintBrush and paintCan and paintCan:getUses() >= uses then
        ISWorldObjectContextMenu.transferIfNeeded(playerObj, paintBrush)
        ISWorldObjectContextMenu.transferIfNeeded(playerObj, paintCan)
        ISTimedActionQueue.add(ISPathFindAction:pathToVehicleArea(playerObj, vehicle, "Engine"))
        ISTimedActionQueue.add(ISPaintVehicleAction:new(playerObj, vehicle, "Engine", newSkinIndex, paintCan, uses, 50))
    end
end

PaintVehicle.paintWords = function(playerObj, vehicle, newSkinIndex, paintBrush, paintCan)
    if paintBrush and paintCan then
        ISWorldObjectContextMenu.transferIfNeeded(playerObj, paintBrush)
        ISWorldObjectContextMenu.transferIfNeeded(playerObj, paintCan)
        ISTimedActionQueue.add(ISPathFindAction:pathToVehicleArea(playerObj, vehicle, "Engine"))
        ISTimedActionQueue.add(ISPaintVehicleAction:new(playerObj, vehicle, "Engine", newSkinIndex, paintCan))
    end
end

PaintVehicle.cleanWords = function(playerObj, vehicle, newSkinIndex, sponge, bleach)
    if sponge and bleach then
        ISWorldObjectContextMenu.transferIfNeeded(playerObj, sponge)
        ISWorldObjectContextMenu.transferIfNeeded(playerObj, bleach)
        ISTimedActionQueue.add(ISPathFindAction:pathToVehicleArea(playerObj, vehicle, "Engine"))
        ISTimedActionQueue.add(ISPaintVehicleAction:new(playerObj, vehicle, "Engine", newSkinIndex, bleach))
    end
end



PaintVehicle.doFillMenuOutsideVehicle = function(playerObj, context, vehicle, test)
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
                                              playerObj, PaintVehicle.paintWords, vehicle, 
                                              vehicle:getSkinIndex()+1, paintBrush, paintCan)
            if vehicle and paintBrush and paintCan then
                subMenuAvailable = true
            else
                writeOpt.toolTip = ISWorldObjectContextMenu.addToolTip()
                writeOpt.toolTip:setName(getText("ContextMenu_Vehicle_STRAYS"))
                local desc_write = ""
                if paintBrush then
                    desc_write = desc_write .. PaintVehicle.ghs .. getText("Tooltip_Item_Paintbrush") .. " 1/1 <LINE> "
                else
                    desc_write = desc_write ..  PaintVehicle.bhs .. getText("Tooltip_Item_Paintbrush") .. " 0/1 <LINE> "
                    writeOpt.onSelect = nil
                    writeOpt.notAvailable = true
                end
                if paintCan and paintCan:getCurrentUses() > 1 then
                    desc_write = desc_write .. PaintVehicle.ghs..getText("Tooltip_Item_PaintRed").." <LINE> "
                else
                    desc_write = desc_write .. PaintVehicle.bhs..getText("Tooltip_Item_PaintRed").." <LINE> "
                    writeOpt.onSelect = nil
                    writeOpt.notAvailable = true
                end
                writeOpt.toolTip.description = desc_write
            end
        else
            local sponge = playerInv:getFirstTypeRecurse("Sponge")
            local bleach = playerInv:getFirstTypeRecurse("Bleach")

            cleanOpt = subMenu:addOptionOnTop(getText("ContextMenu_Vehicle_CLEAN_STRAYS"),
                                              playerObj, PaintVehicle.cleanWords, vehicle, vehicle:getSkinIndex()-1, sponge, bleach)
            if vehicle and sponge and bleach then
                subMenuAvailable = true
            else
                cleanOpt.toolTip = ISWorldObjectContextMenu.addToolTip()
                cleanOpt.toolTip:setName(getText("ContextMenu_Vehicle_CLEAN_STRAYS"))
                local desc_clean = ""
                if sponge then
                    desc_clean = desc_clean ..  PaintVehicle.ghs .. getText("Tooltip_Item_Sponge") .. " 1/1 <LINE> "
                else
                    desc_clean = desc_clean ..  PaintVehicle.bhs .. getText("Tooltip_Item_Sponge") .. " 0/1 <LINE> "
                    cleanOpt.onSelect = nil
                    cleanOpt.notAvailable = true
                end
                if bleach and bleach:getCurrentUses() > 0 then
                    desc_clean = desc_clean .. PaintVehicle.ghs..getText("Tooltip_Item_Bleach").." <LINE>"
                else
                    desc_clean = desc_clean .. PaintVehicle.bhs..getText("Tooltip_Item_Bleach").." <LINE>"
                    cleanOpt.onSelect = nil
                    cleanOpt.notAvailable = true
                end
                cleanOpt.toolTip.description = desc_clean
            end
        end

        -- Paint car

        for k, v in pairs(paintTable) do
            local paintBrush = playerInv:getFirstTypeRecurse("Paintbrush")
            local paintCan = playerInv:getFirstTypeRecurse(k)
            local uses = 10
            
            local opt = subMenu:addOption(getText(k), playerObj, PaintVehicle.paintBus, vehicle, v, paintBrush, paintCan, uses)
            opt.toolTip = ISWorldObjectContextMenu.addToolTip()
            opt.toolTip:setName(getText(k))
            
            local tooltip_desc = getText("Tooltip_Vehicle_PAINT") .. "<LINE><LINE>"

            if paintBrush then
                tooltip_desc = tooltip_desc .. PaintVehicle.ghs .. getText("Tooltip_Item_Paintbrush") .. " 1/1 <LINE>"
            else
                tooltip_desc = tooltip_desc .. PaintVehicle.bhs .. getText("Tooltip_Item_Paintbrush") .. " 0/1 <LINE>"
                if not PaintVehicle.cheat then
                    opt.onSelect = nil
                    opt.notAvailable = true
                end
            end

            local have_uses = 0
            if PaintCan then
                have_uses = math.floor(paintCan:getUses() * 10)
            end

            if paintCan and have_uses >= uses then
                tooltip_desc = tooltip_desc .. PaintVehicle.ghs .. getText("Tooltip_Item_"..k)
                tooltip_desc = tooltip_desc .. " " .. tostring(have_uses) .."/" .. tostring(uses) .. "<LINE>"
            else
                tooltip_desc = tooltip_desc .. PaintVehicle.bhs .. getText("Tooltip_Item_"..k)
                tooltip_desc = tooltip_desc .. " " .. tostring(have_uses) .."/" .. tostring(uses) .. "<LINE>"
                if not PaintVehicle.cheat then
                    opt.onSelect = nil
                    opt.notAvailable = true
                end
            end

            opt.toolTip.description = tooltip_desc

            if not opt.notAvailable then
                subMenuAvailable = true
            end
        end

        if not subMenuAvailable and not PaintVehicle.cheat then
            paintMenuOpt.notAvailable = true
        end

    end
end


PaintVehicle.onfillMenuOutsideVehicleMenu = function(player, context, worldobjects, test)
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
                    return PaintVehicle.doFillMenuOutsideVehicle(playerObj, context, vehicle, test)
                end
            end
            return
        end
        
        vehicle = IsoObjectPicker.Instance:PickVehicle(getMouseXScaled(), getMouseYScaled())
        if vehicle then
            return PaintVehicle.doFillMenuOutsideVehicle(playerObj, context, vehicle, test)
        end
    end
end


Events.OnFillWorldObjectContextMenu.Add(PaintVehicle.onfillMenuOutsideVehicleMenu)