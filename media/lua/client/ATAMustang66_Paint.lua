require "TimedActions/ISPaintVehicleAction.lua"

local vehicleTable = {
    ["Base.ATAMustang66"] = "PaintRed",
    ["Base.ATAMustang66Custom"] = "PaintRed",
}

-- local paintTable = {
--     ["PaintWhite"] = 0,
--     ["PaintGrey"] = 2,
--     ["PaintBlack"] = 4,
--     ["PaintPink"] = 6,
--     ["PaintRed"] = 8,
--     ["PaintPurple"] = 10,
--     ["PaintBlue"] = 12,
--     ["PaintLightBlue"] = 14,
--     ["PaintCyan"] = 16,
--     ["PaintTurquoise"] = 18,
--     ["PaintGreen"] = 20,
--     ["PaintLightBrown"] = 22,
--     ["PaintBrown"] = 24,
--     ["PaintYellow"] = 26,
--     ["PaintOrange"] = 28,
-- }

local PaintVehicle = {}
PaintVehicle.ghs = " <RGB:" .. getCore():getGoodHighlitedColor():getR() .. "," .. getCore():getGoodHighlitedColor():getG() .. "," .. getCore():getGoodHighlitedColor():getB() .. "> "
PaintVehicle.bhs = " <RGB:" .. getCore():getBadHighlitedColor():getR() .. "," .. getCore():getBadHighlitedColor():getG() .. "," .. getCore():getBadHighlitedColor():getB() .. "> "


-- PaintVehicle.paintVehicle = function(playerObj, vehicle, newSkinIndex, paintBrush, paintCan, uses)
--     if paintBrush and paintCan and paintCan:getCurrentUses() * 10 >= uses then
--         ISWorldObjectContextMenu.transferIfNeeded(playerObj, paintBrush)
--         ISWorldObjectContextMenu.transferIfNeeded(playerObj, paintCan)
--         ISTimedActionQueue.add(ISPathFindAction:pathToVehicleArea(playerObj, vehicle, "Engine"))
--         ISTimedActionQueue.add(ISPaintVehicleAction:new(playerObj, vehicle, "Engine", newSkinIndex, paintCan, uses, 50))
--     end
-- end

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
    local graffitiType = vehicleTable[vehicle:getScriptName()]

    if graffitiType then
        
        local paintMenuOpt = context:addOption(getText("ContextMenu_Vehicle_PAINT"), nil, nil)
        local subMenuAvailable = false
        local subMenu = ISContextMenu:getNew(context)
        context:addSubMenu(paintMenuOpt, subMenu)

        -- Paint words

        if (vehicle:getSkinIndex()%2) == 0 then
            local paintBrush = playerInv:getFirstTypeRecurse("Paintbrush")
            local paintCan = playerInv:getFirstTypeRecurse(graffitiType)
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
                    desc_write = desc_write .. PaintVehicle.ghs .. getText("Tooltip_Item_Paintbrush") .. " <LINE> "
                else
                    desc_write = desc_write ..  PaintVehicle.bhs .. getText("Tooltip_Item_Paintbrush") .. " <LINE> "
                    writeOpt.onSelect = nil
                    writeOpt.notAvailable = true
                end
                local have_uses = 0
                
                if paintCan then
                    have_uses = math.floor(paintCan:getCurrentUses() * 10) -- less 1 unit, otherwise will be the other item as empty.
                    desc_write = desc_write .. PaintVehicle.ghs..getText("Tooltip_Item_"..graffitiType) .. " ".. have_uses .."/1 unit <LINE> "
                else
                    desc_write = desc_write .. PaintVehicle.bhs..getText("Tooltip_Item_"..graffitiType) .. " ".. have_uses .."/1 unit <LINE> "
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
                    desc_clean = desc_clean ..  PaintVehicle.ghs .. getText("Tooltip_Item_Sponge") .. " <LINE> "
                else
                    desc_clean = desc_clean ..  PaintVehicle.bhs .. getText("Tooltip_Item_Sponge") .. " <LINE> "
                    cleanOpt.onSelect = nil
                    cleanOpt.notAvailable = true
                end
                if bleach and bleach:getCurrentUses() > 0 then
                    desc_clean = desc_clean .. PaintVehicle.ghs..getText("Tooltip_Item_Bleach") .. " <LINE> "
                else
                    desc_clean = desc_clean .. PaintVehicle.bhs..getText("Tooltip_Item_Bleach") .. " <LINE> "
                    cleanOpt.onSelect = nil
                    cleanOpt.notAvailable = true
                end
                cleanOpt.toolTip.description = desc_clean
            end
        end

        -- DO NOT paint full car, in the end of day, it is not reasonable.
        -- -- Paint car

        -- if playerObj:getPerkLevel(Perks.Woodwork) < 10 and not isDebugEnabled() then
        --     return
        -- end

        -- for k, v in pairs(paintTable) do
        --     local paintBrush = playerInv:getFirstTypeRecurse("Paintbrush")
        --     local paintCan = playerInv:getFirstTypeRecurse(k)
        --     local uses = 10
            
        --     local opt = subMenu:addOption(getText(k), playerObj, PaintVehicle.paintVehicle, vehicle, v, paintBrush, paintCan, uses)
        --     opt.toolTip = ISWorldObjectContextMenu.addToolTip()
        --     opt.toolTip:setName(getText(k))
            
        --     local tooltip_desc = getText("Tooltip_Vehicle_PAINT") .. "<LINE><LINE>"

        --     if paintBrush then
        --         tooltip_desc = tooltip_desc .. PaintVehicle.ghs .. getText("Tooltip_Item_Paintbrush") .. " <LINE>"
        --     else
        --         tooltip_desc = tooltip_desc .. PaintVehicle.bhs .. getText("Tooltip_Item_Paintbrush") .. " <LINE>"
        --         opt.onSelect = nil
        --         opt.notAvailable = true
        --     end

        --     local have_uses = 0
        --     if paintCan then
        --         have_uses = math.floor(paintCan:getCurrentUses() * 10)
        --     end
            
        --     if paintCan and have_uses >= uses then
        --         tooltip_desc = tooltip_desc .. PaintVehicle.ghs .. getText("Tooltip_Item_"..k)
        --         tooltip_desc = tooltip_desc .. " " .. have_uses .."/" .. uses .. " unit <LINE>"
        --     else
        --         tooltip_desc = tooltip_desc .. PaintVehicle.bhs .. getText("Tooltip_Item_"..k)
        --         tooltip_desc = tooltip_desc .. " " .. have_uses .."/" .. uses .. " unit <LINE>"
        --         opt.onSelect = nil
        --         opt.notAvailable = true
        --     end

        --     opt.toolTip.description = tooltip_desc

        --     if not opt.notAvailable then
        --         subMenuAvailable = true
        --     end
        -- end

        if not subMenuAvailable then
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