require "TimedActions/ISBaseTimedAction"


ISPaintVehicleAction = ISBaseTimedAction:derive("ISPaintVehicleAction")


function ISPaintVehicleAction:isValid()
    return self.vehicle:isInArea(self.area, self.character) and self.resourceItem ~= nil
end

function ISPaintVehicleAction:waitToStart()
    self.character:faceThisObject(self.vehicle)
    return self.character:shouldBeTurning()
end


function ISPaintVehicleAction:start()
    if self.is_clean then
        self:setActionAnim(CharacterActionAnims.Pour)
    else
        self:setActionAnim(CharacterActionAnims.Paint)
    end
    self:setOverrideHandModels("PaintBrush", nil)
end

function ISPaintVehicleAction:stop()
    ISBaseTimedAction.stop(self)
end


function ISPaintVehicleAction:perform()
	if self.resourceItem:getType() == 'Bleach' then
		local bleach = self.resourceItem
		-- DONT why add %5, but if NOT, will use whole bottle.
		bleach:setThirstChange(bleach:getThirstChange() + 0.05)
		if bleach:getThirstChange() > -0.05 then
			bleach:Use()
		end
	else
		for i = 0, self.use_quantity - 1 do
			self.resourceItem:Use()
		end
	end
    self.vehicle:setSkinIndex(self.skinIndex)
    self.vehicle:updateSkin()
    local args = {
        vehicle = self.vehicle:getId(),
        index = self.skinIndex,
    }
    sendClientCommand(self.character, 'vehicle', 'setSkinIndex', args)
    -- sendClientCommand(self.character, 'commonlib', 'updatePaintVehicle', {vehicle = self.vehicle:getId(), index = self.skinIndex})
    -- needed to remove from queue / start next.
    ISBaseTimedAction.perform(self)
end

function ISPaintVehicleAction:create()
    ISBaseTimedAction.create(self)
end

function ISPaintVehicleAction:new(character, vehicle, area, skinIndex, res, use_quantity, is_clean)
    if type(character) == 'number' then
        character = getSpecificPlayer(character)
        -- getSpecificPlayer param as int (player num).
    end
    local o = {}
    setmetatable(o, self)
    self.__index = self

    o.stopOnWalk = true
    o.stopOnRun = true
    o.character = character
    o.resourceItem = res
    o.use_quantity = use_quantity or 1
    o.vehicle = vehicle
    o.area = area
    o.skinIndex = skinIndex
    o.maxTime = o.use_quantity * 100
    o.is_clean = is_clean
    return o
end
