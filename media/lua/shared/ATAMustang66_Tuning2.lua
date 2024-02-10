require "ATA2TuningTable"

local function copy(obj, seen)
  if type(obj) ~= 'table' then return obj end
  if seen and seen[obj] then return seen[obj] end
  local s = seen or {}
  local res = setmetatable({}, getmetatable(obj))
  s[obj] = res
  for k, v in pairs(obj) do res[copy(k, s)] = copy(v, s) end
  return res
end

local carRecipe = "ATAMustangRecipes"

local NewCarTuningTable = {}
NewCarTuningTable["ATAMustang66"] = {
    addPartsFromVehicleScript = "",
    parts = {}
}

NewCarTuningTable["ATAMustang66"].parts["ATA2Bumper"] = {
    Bumper2 = {
        icon = "media/ui/tuning2/datsun_bumper_2.png",
        name = "IGUI_ATA2_Bullbar",
        category = "Bumpers",
        secondModel = "Bumper2_light",
        spawnChance = 10,
        protection = {"HeadlightLeft", "HeadlightRight", "EngineDoor"},
        install = {
            weight = "auto",
            animation = "ATA_PickLock",
            transmitFirstItemCondition = true,
            use = {
                Autotsar__ATAMustang66BullbarItem = 1,
                Screws=5,
            },
            tools = {
                primary = "Base.Wrench",
            },
            skills = {
                Mechanics = 4,
            },
            recipes = {"Advanced Mechanics"},
            time = 30, 
        },
        uninstall = {
            weight = "auto",
            animation = "ATA_PickLock",
            tools = {
                primary = "Base.Wrench",
            },
            skills = {
                Mechanics = 3,
            },
            recipes = {"Advanced Mechanics"},
            transmitConditionOnFirstItem = true,
            result = {
                Autotsar__ATAMustang66BullbarItem = 1,
            },
            time = 20,
        }
    },
    Bumper1 = {
        icon = "media/ui/tuning2/datsun_bumper_1.png",
        name = "IGUI_ATA2_Bumper_Classic",
        category = "Bumpers",
        spawnChance = 100,
        install = {
            weight = "auto",
            animation = "ATA_PickLock",
            transmitFirstItemCondition = true,
            use = {
                Autotsar__ATAMustang66BumperItem = 1,
                Screws=5,
            },
            tools = {
                primary = "Base.Wrench",
            },
            skills = {
                Mechanics = 4,
            },
            recipes = {"Advanced Mechanics"},
            time = 30, 
        },
        uninstall = {
            weight = "auto",
            animation = "ATA_PickLock",
            tools = {
                primary = "Base.Wrench",
            },
            skills = {
                Mechanics = 3,
            },
            recipes = {"Advanced Mechanics"},
            transmitConditionOnFirstItem = true,
            result = {
                Autotsar__ATAMustang66BumperItem = 1,
            },
            time = 20,
        }
    },
    Bumper3 = {
        icon = "media/ui/tuning2/dadge_bullbar_3.png",
        name = "IGUI_ATA2_Bullbar_Lethal",
        category = "Bumpers",
        protection = {"HeadlightLeft", "HeadlightRight", "EngineDoor"},
        install = {
            weight = "auto",
            animation = "ATA_PickLock",
            use = {
                MetalPipe = 3,
                SheetMetal = 6,
                MetalBar=6,
                BlowTorch = 10,
                Screws=6,
            },
            tools = {
                bodylocation = "Base.WeldingMask",
                primary = "Base.Wrench",
            },
            skills = {
                Mechanics = 4,
                MetalWelding = 6,
            },
            recipes = {"Intermediate Mechanics", carRecipe},
            time = 60, 
        },
        uninstall = {
            animation = "ATA_Crowbar_DoorLeft",
            use = {
                BlowTorch=4,
            },
            tools = {
                bodylocation = "Base.WeldingMask",
                both = "Base.Crowbar",
            },
            skills = {
                MetalWelding = 2,
            },
            result = "auto",
            time = 30,
        }
    }
}

NewCarTuningTable["ATAMustang66"].parts["ATA2BumperRear"] = {
    Bumper1 = {
        icon = "media/ui/tuning2/datsun_bumper_1.png",
        name = "IGUI_ATA2_Bumper_Rear_Classic",
        category = "Bumpers",
        spawnChance = 100,
        install = {
            weight = "auto",
            animation = "ATA_PickLock",
            transmitFirstItemCondition = true,
            use = {
                Autotsar__ATAMustang66BumperRearItem = 1,
                Screws=5,
            },
            tools = {
                primary = "Base.Wrench",
            },
            skills = {
                Mechanics = 4,
            },
            recipes = {"Advanced Mechanics"},
            time = 30, 
        },
        uninstall = {
            weight = "auto",
            animation = "ATA_PickLock",
            tools = {
                primary = "Base.Wrench",
            },
            skills = {
                Mechanics = 3,
            },
            recipes = {"Advanced Mechanics"},
            transmitConditionOnFirstItem = true,
            result = {
                Autotsar__ATAMustang66BumperRearItem = 1,
            },
            time = 20,
        }
    },
    Bumper2 = {
        icon = "media/ui/tuning2/datsun_bumper_3.png",
        name = "IGUI_ATA2_Bumper_Rear_Handmade",
        category = "Bumpers",
        protection = {"TrunkDoor"},
        install = {
            weight = "auto",
            animation = "ATA_PickLock",
            use = {
                MetalPipe = 5,
                MetalBar=2,
                BlowTorch = 6,
                Screws=5,
            },
            tools = {
                bodylocation = "Base.WeldingMask",
                primary = "Base.Wrench",
            },
            skills = {
                Mechanics = 4,
                MetalWelding = 4,
            },
            recipes = {"Intermediate Mechanics", carRecipe},
            time = 60, 
        },
        uninstall = {
            animation = "ATA_Crowbar_DoorLeft",
            use = {
                BlowTorch=4,
            },
            tools = {
                bodylocation = "Base.WeldingMask",
                both = "Base.Crowbar",
            },
            skills = {
                MetalWelding = 2,
            },
            result = "auto",
            time = 30,
        }
    }
}

NewCarTuningTable["ATAMustang66"].parts["ATA2ProtectionWindowFrontLeft"] = {
    Default = {
        icon = "media/ui/tuning2/protection_window_side.png",
        modelList = {"StaticPart", "StaticPart2"},
        category = "Protection",
        protection = {"WindowFrontLeft"},
        install = {
            weight = "auto",
            use = {
                SmallSheetMetal = 3,
                SheetMetal = 2,
                MetalBar=5,
                Screws=5,
                BlowTorch = 10,
            },
            tools = {
                bodylocation = "Base.WeldingMask",
                primary = "Base.Wrench",
            },
            skills = {
                MetalWelding = 5,
            },
            recipes = {carRecipe},
            requireInstalled = {"WindowFrontLeft"},
            time = 65,
        },
        uninstall = {
            animation = "ATA_IdleLeverOpenMid",
            use = {
                BlowTorch=5,
            },
            tools = {
                bodylocation = "Base.WeldingMask",
                both = "Base.Crowbar",
            },
            skills = {
                MetalWelding = 2,
            },
            result = "auto",
            time = 40,
        }
    }
}

NewCarTuningTable["ATAMustang66"].parts["ATA2ProtectionWindowFrontRight"] = copy(NewCarTuningTable["ATAMustang66"].parts["ATA2ProtectionWindowFrontLeft"])
NewCarTuningTable["ATAMustang66"].parts["ATA2ProtectionWindowFrontRight"].Default.protection = {"WindowFrontRight"}
NewCarTuningTable["ATAMustang66"].parts["ATA2ProtectionWindowFrontRight"].Default.install.requireInstalled = {"WindowFrontRight"}


NewCarTuningTable["ATAMustang66"].parts["ATA2ProtectionWindshield"] = {
    Default = {
        removeIfBroken = true,
        icon = "media/ui/tuning2/protection_window_windshield.png",
        category = "Protection",
        protection = {"Windshield"},
        install = {
            area = "TireFrontLeft",
            weight = "auto",
            use = {
                MetalPipe = 7,
                SheetMetal=2,
                Screws=6,
                BlowTorch = 8,
            },
            tools = {
                bodylocation = "Base.WeldingMask",
                primary = "Base.Screwdriver",
            },
            skills = {
                MetalWelding = 4,
            },
            recipes = {carRecipe},
            requireInstalled = {"Windshield"},
            time = 65,
        },
        uninstall = {
            area = "TireFrontLeft",
            animation = "ATA_Crowbar_DoorLeft",
            use = {
                BlowTorch=4,
            },
            tools = {
                bodylocation = "Base.WeldingMask",
                both = "Base.Crowbar",
            },
            skills = {
                MetalWelding = 2,
            },
            result = "auto",
            time = 40,
        }
    }
}

NewCarTuningTable["ATAMustang66"].parts["ATA2ProtectionWindshieldRear"] = {
    Default = {
        icon = "media/ui/tuning2/protection_window_windshield.png",
        category = "Protection",
        protection = {"WindshieldRear"},
        removeIfBroken = true,
        install = {
            weight = "auto",
            area = "TireRearRight",
            use = {
                MetalPipe = 8,
                Screws = 8,
                BlowTorch = 5,
            },
            tools = {
                bodylocation = "Base.WeldingMask",
            },
            skills = {
                MetalWelding = 4,
            },
            recipes = {carRecipe},
            requireInstalled = {"WindshieldRear"},
            time = 65, 
        },
        uninstall = {
            area = "TireRearRight",
            animation = "ATA_IdleLeverOpenMid",
            tools = {
                both = "Base.Crowbar",
            },
            result = "auto",
            time = 65,
        }
    }
}

NewCarTuningTable["ATAMustang66"].parts["ATA2InteractiveTrunkRoofRack"] = {
    ATARoofrack = {
        icon = "media/ui/tuning2/roof_rack_1.png",
        category = "Trunks",
        containerCapacity = 50,
        interactiveTrunk = {
            filling = {"ATARoofBag1", "ATARoofBag2", "ATARoofBag3"},
            items = {
                {
                    itemTypes = {"Suitcase"},
                    modelNameByCount = {"ATARoofCase1", "ATARoofCase1"}
                },
                {
                    itemTypes = {"Bag_BigHikingBag", "Bag_ALICEpack_Army", "Bag_ALICEpack", "Bag_NormalHikingBag"},
                    modelNameByCount = {"BigHikingBagBlue", "BigHikingBagGreen"}
                },
                {
                    itemTypes = {"Cooler"},
                    modelNameByCount = {"ATACooler"}
                },
                {
                    itemTypes = {"PetrolCan", "EmptyPetrolCan"},
                    modelNameByCount = {"ATAGasCan1", "ATAGasCan2", "ATAGasCan3"}
                },
            }
        },
        install = {
            weight = "auto",
            use = {
                MetalPipe = 4,
                SheetMetal = 7,
                MetalBar=4,
                Screws=4,
                BlowTorch = 10,
            },
            tools = {
                bodylocation = "Base.WeldingMask",
                primary = "Base.Screwdriver",
            },
            skills = {
                Mechanics = 3,
                MetalWelding = 5,
            },
            recipes = {carRecipe},
            time = 65, 
        },
        uninstall = {
            animation = "ATA_IdleLeverOpenHigh",
            use = {
                BlowTorch=4,
            },
            tools = {
                bodylocation = "Base.WeldingMask",
                both = "Base.Crowbar",
            },
            skills = {
                MetalWelding = 2,
            },
            result = "auto",
            time = 40,
        }
    }
}

NewCarTuningTable["ATAMustang66"].parts["ATA2VisualSkirtsSide"] = {
    Default = {
        icon = "media/ui/tuning2/datsun_skirts.png",
        category = "Visual",
        install = {
            animation = "VehicleWorkOnTire",
            use = {
                MetalPipe = 2,
                SheetMetal = 2,
                MetalBar=4,
                Screws=5,
                BlowTorch = 5,
            },
            tools = {
                bodylocation = "Base.WeldingMask",
                primary = "Base.Screwdriver",
            },
            skills = {
                Mechanics = 5,
            },
            recipes = {"Advanced Mechanics"},
            time = 30,
        },
        uninstall = {
            animation = "VehicleWorkOnTire",
            use = {
                BlowTorch=3,
            },
            tools = {
                bodylocation = "Base.WeldingMask",
            },
            recipes = {"Advanced Mechanics"},
            skills = {
                Mechanics = 4,
            },
            result = "auto",
            time = 30,
        }
    }
}

NewCarTuningTable["ATAMustang66"].parts["ATA2RoofLightFront"] = {
    Default = {
        spawnChance = 10,
        icon = "media/ui/tuning2/datsun_roof_light.png",
        modelList = {"SecondModel"},
        category = "Visual",
        install = {
            area = "ATARoof",
            transmitFirstItemCondition = true,
            use = {
                Autotsar__ATAMustang66RoofLightItem = 1,
                Screws=4,
            },
            tools = {
                primary = "Base.Screwdriver",
            },
            skills = {
                Mechanics = 5,
            },
            recipes = {"Advanced Mechanics"},
            time = 30,
        },
        uninstall = {
            area = "ATARoof",
            tools = {
                primary = "Base.Screwdriver",
            },
            recipes = {"Advanced Mechanics"},
            skills = {
                Mechanics = 4,
            },
            transmitConditionOnFirstItem = true,
            result = {
                Autotsar__ATAMustang66RoofLightItem=1,
            },
            time = 30,
        }
    }
}

NewCarTuningTable["ATAMustang66"].parts["ATA2ProtectionWheels"] = {
    ATAProtection = {
        removeIfBroken = true,
        icon = "media/ui/tuning2/wheel_chain.png",
        category = "Protection", 
        protectionModel = true, 
        protection = {"TireFrontLeft", "TireFrontRight", "TireRearLeft", "TireRearRight"}, 
        install = { 
            sound = "ATA2InstallWheelChain",
            use = { 
                ATAProtectionWheelsChain = 1,
                BlowTorch = 4,
            },
            tools = { 
                bodylocation = "Base.WeldingMask", 
                primary = "Base.Wrench",
            },
            skills = {
                Mechanics = 2,
                MetalWelding = 3,
            },
            recipes = {"Basic Tuning"},
            requireInstalled = {"TireFrontLeft", "TireFrontRight", "TireRearLeft", "TireRearRight"},
            time = 65, 
        },
        uninstall = {
            sound = "ATA2InstallWheelChain",
            use = {
                BlowTorch=4,
            },
            tools = {
                bodylocation = "Base.WeldingMask",
                both = "Base.Crowbar",
            },
            skills = {
                MetalWelding = 2,
            },
            result = {
                UnusableMetal=2,
            },
            time = 40,
        }
    }
}

NewCarTuningTable["ATAMustang66Custom"] = NewCarTuningTable["ATAMustang66"]

ATA2Tuning_AddNewCars(NewCarTuningTable)
