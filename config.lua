Config = {}

Config.SQL = {
    tablename = 'player_jobvehicles'
}

Config.Blip = {
    need = true, -- true to draw
    sprite = 50,
    color = 3,
    scale = 0.4,
    label = 'Фракционный гараж'
}


Config.UseTarget = GetConvar('UseTarget', 'false') == 'true'

Config.Locations = {
    ['police'] = {
        [1] = {
            coords = vector4(-1124.83, -856.04, 13.53, 49.15),
            ped_model = 'mp_m_waremech_01',
            scenario = 'WORLD_HUMAN_COP_IDLES',
            name = 'mainGaragePolice',
            spawnCoords = vector4(-1129.13, -852.55, 13.54, 133.58),
            returnCoords = vector3(-1121.02, -857.83, 13.52),
        },
        [2] = {
            coords = vector4(441.83, -1014.19, 28.64, 172.44),
            ped_model = 'mp_m_waremech_01',
            scenario = 'WORLD_HUMAN_COP_IDLES',
            name = 'GaragePolice',
            spawnCoords = vector4(439.47, -1017.68, 28.73, 101.88),
            returnCoords = vector3(435.03, -1011.67, 28.7),
        },
        [3] = {
            coords = vector4(458.91, -979.02, 43.69, 114.23),
            ped_model = 's_m_m_pilot_02',
            scenario = 'WORLD_HUMAN_COP_IDLES',
            name = 'GaragePoliceHeli',
            spawnCoords = vector4(449.43, -981.35, 43.69, 87.87),
            returnCoords = vector3(448.52, -981.32, 43.69),
        }
    },
    ["ambulance"] = {
        [1] = {
            coords = vector4(333.75, -561.74, 28.74, 348.02),
            ped_model = 'mp_m_waremech_01',
            scenario = 'WORLD_HUMAN_COP_IDLES',
            name = 'mainGarageAmbulance',
            spawnCoords = vector4(335.35, -553.68, 28.74, 277.65),
            returnCoords = vector3(327.91, -555.68, 28.74),
        }, 
    }
}

Config.Cars = {
    ['police'] = {
        [1] = {
            model = 'police2',
            plate = 'LSPD0005',
            garage = 'mainGaragePolice',
            rang = 0
        },
        [2] = {
            model = 'police3',
            plate = 'LSPD0006',
            garage = 'mainGaragePolice',
            rang = 0
        },
        [3] = {
            model = 'police',
            plate = 'LSPD0008',
            garage = 'GaragePolice',
            rang = 0
        },
        [4] = {
            model = 'police4',
            plate = 'LSPD0009',
            garage = 'GaragePolice',
            rang = 0
        },
        [5] = {
            model = 'polmav',
            plate = 'ZULU0001',
            garage = 'GaragePoliceHeli',
            rang = 0
        },
    },
    ['ambulance'] = {
        [1] = {
            model = 'ambulance',
            plate = 'EMS00005',
            garage = 'mainGarageAmbulance',
            rang = 0
        },
    }
}

Config.JobCarItems = {}

Config.CarItems = {
    ["police"] = {
        [1] = {
            name = "heavyarmor",
            amount = 2,
            info = {},
            type = "item",
            slot = 1,
        },
        [2] = {
            name = "empty_evidence_bag",
            amount = 10,
            info = {},
            type = "item",
            slot = 2,
        },
        [3] = {
            name = "police_stormram",
            amount = 1,
            info = {},
            type = "item",
            slot = 3,
        },
    }, 
}