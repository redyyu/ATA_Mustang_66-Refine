--[[
Use this file to alter or add vehicle spawning logic.
 the type should be the one you define in the zone in WorldEd (VehicleZoneDistribution.trailerpark will be used for trailerpark zone type)
 if no type is defined in the zone, parkingstall is used instead.
 
 When adding a car, you define it's skin index defined in the vehicle's template (-1 mean a random skin in the skin list)
 spawnChance is used to define the odds of spawning this car or another (the total for a zone should always be 100)
 
 You have a range of variable to configure your spawning logic:
 * chanceToPartDamage : Chance of having a damaged part, this number is added to the inventory item's damaged spawn chance of the part (so an old tire will have more chance to be damaged than a good one in a same zone). Default is 0.
 * baseVehicleQuality : Define the base quality for part, if a part should be spawned as damaged, this will define it's max condition (so a 0.7 mean if a part spawn as damaged, it's max condition will be 70%). Default is 1.0.
 * chanceToSpawnSpecial : Use this to define a random chance of spawning special car (picked randomly in every type with specialCar = true) on a zone. Default is 5.
 * chanceToSpawnBurnt : Use this to define a random chance of spawning burnt car like in junkyard (picked randomly at 80% in normalburnt list & 20% in specialburnt list) on a zone. Default is 0.
 * chanceToSpawnNormal : Use this to define a random chance of spawning a normal car (will be picked in the parkingstall zone). Used so the special parking lots don't have only special cars (so a spiffo parking lot will have lots of normal car, and sometimes a spiffo van). Default is 80(%).
 * spawnRate : Base chance of adding a vehicle in a zone, default is 16(%).
 * chanceOfOverCar : Chance to spawn another car over the spawned one (used in trailerpark). Default is 0.
 * randomAngle : Are cars aligned on a grid or random angle. Default is false.
 * chanceToSpawnKey : Define the chance to spawn a key for this car (either on the ground, directly in the car, in a near zombie or container...) Default is 70(%).
 * specialCar : Define if the car is a special one (police, fire dept...) used to get a list of special car when trying to spawn a special car if chanceToSpawnSpecial is triggered. a special car will also make the corresponding vehicle's key not colored. Can still be used as a normal zone.
 ]]
--

VehicleZoneDistribution = VehicleZoneDistribution or {};

-- VehicleZoneDistribution.trailerpark.vehicles["Base.ATAMustang66"] = {index = -1, spawnChance = 0.5}
-- VehicleZoneDistribution.trailerpark.vehicles["Base.ATAMustang66Custom"] = {index = -1, spawnChance = 0.5}

VehicleZoneDistribution.parkingstall.vehicles["Base.ATAMustang66"] = {index = -1, spawnChance = 1}
VehicleZoneDistribution.parkingstall.vehicles["Base.ATAMustang66Custom"] = {index = -1, spawnChance = 1}

VehicleZoneDistribution.good.vehicles["Base.ATAMustang66"] = {index = -1, spawnChance = 2}
VehicleZoneDistribution.good.vehicles["Base.ATAMustang66Custom"] = {index = -1, spawnChance = 2}

VehicleZoneDistribution.sport.vehicles["Base.ATAMustang66"] = {index = -1, spawnChance = 5}
VehicleZoneDistribution.sport.vehicles["Base.ATAMustang66Custom"] = {index = -1, spawnChance = 5}

VehicleZoneDistribution.junkyard.vehicles["Base.ATAMustang66"] = {index = -1, spawnChance = 1}
VehicleZoneDistribution.junkyard.vehicles["Base.ATAMustang66Custom"] = {index = -1, spawnChance = 1}

VehicleZoneDistribution.trafficjamw.vehicles["Base.ATAMustang66"] = {index = -1, spawnChance = 0.5}
VehicleZoneDistribution.trafficjamw.vehicles["Base.ATAMustang66Custom"] = {index = -1, spawnChance = 0.5}

VehicleZoneDistribution.trafficjame.vehicles["Base.ATAMustang66"] = {index = -1, spawnChance = 0.5}
VehicleZoneDistribution.trafficjame.vehicles["Base.ATAMustang66Custom"] = {index = -1, spawnChance = 0.5}

VehicleZoneDistribution.trafficjamn.vehicles["Base.ATAMustang66"] = {index = -1, spawnChance = 0.5}
VehicleZoneDistribution.trafficjamn.vehicles["Base.ATAMustang66Custom"] = {index = -1, spawnChance = 0.5}

VehicleZoneDistribution.trafficjams.vehicles["Base.ATAMustang66"] = {index = -1, spawnChance = 0.5}
VehicleZoneDistribution.trafficjams.vehicles["Base.ATAMustang66Custom"] = {index = -1, spawnChance = 0.5}