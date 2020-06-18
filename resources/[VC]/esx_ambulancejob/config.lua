Config                            = {}

Config.DrawDistance               = 100.0

Config.Marker                     = { type = 1, x = 1.5, y = 1.5, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false }

Config.ReviveReward               = 250  -- revive reward, set to 0 if you don't want it enabled
Config.AntiCombatLog              = true -- enable anti-combat logging?
Config.LoadIpl                    = true -- disable if you're using fivem-ipl or other IPL loaders

Config.Locale                     = 'en'

local second = 1000
local minute = 60 * second

Config.EarlyRespawnTimer          = 15 * minute  -- Time til respawn is available
Config.BleedoutTimer              = 10 * minute -- Time til the player bleeds out

Config.EnablePlayerManagement     = true

Config.RemoveWeaponsAfterRPDeath  = true
Config.RemoveCashAfterRPDeath     = true
Config.RemoveItemsAfterRPDeath    = true

-- Let the player pay for respawning early, only if he can afford it.
Config.EarlyRespawnFine           = false
Config.EarlyRespawnFineAmount     = 500

Config.RespawnPoint = { coords = vector3(363.79, -578.72, 28.84), heading = 206.36 }

Config.Hospitals = {

	CentralLosSantos = {

		Blip = {
			coords = vector3(364.81, -591.5, 28.69),
			sprite = 61,
			scale  = 1.2,
			color  = 2
		},

		AmbulanceActions = {
			vector3(336.3, -580.37, 27.79)
		},

		Pharmacies = {
			vector3(335.03, -585.14, 27.79)
		},

		Vehicles = {
			{
				Spawner = vector3(329.0, -557.72, 28.74),
				InsideShop = vector3(365.22, -565.07, 39.06),
				Marker = { type = 36, x = 1.0, y = 1.0, z = 1.0, r = 100, g = 50, b = 200, a = 100, rotate = true },
				SpawnPoints = {
					{ coords = vector3(335.08, -542.29, 28.53), heading = 179.95, radius = 4.0 },
					{ coords = vector3(329.39, -542.59, 28.53), heading = 179.95, radius = 4.0 },
					{ coords = vector3(323.7, -542.88, 28.53), heading = 179.95, radius = 4.0 },
					{ coords = vector3(317.88, -547.85, 28.53), heading = 268.55, radius = 4.0 }
				}
			}
		},

		Helicopters = {
			{
				Spawner = vector3(341.1, -590.1, 74.14),
				InsideShop = vector3(312.59, -575.68, 93.65),
				Marker = { type = 34, x = 1.5, y = 1.5, z = 1.5, r = 100, g = 150, b = 150, a = 100, rotate = true },
				SpawnPoints = {
					{ coords = vector3(351.87, -588.15, 73.34), heading = 341.15, radius = 10.0 }
				}
			}
		},

		FastTravels = {
			
		},

		FastTravelsPrompt = {
			{
				From = vector3(340.49, -595.27, 27.79),
				To = { coords = vector3(343.13, -595.51, 74.17), heading = 247.11 },
				Marker = { type = 1, x = 2.0, y = 2.0, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false },
				Prompt = _U('helipad')
			},

			{
				From = vector3(339.74, -584.33, 73.17),
				To = { coords = vector3(337.76, -594.37, 28.79), heading = 68.35 },
				Marker = { type = 1, x = 2.0, y = 2.0, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false },
				Prompt = _U('inside')
			}
		}

	},
	
	PaletoBay = {

		Blip = {
			coords = vector3(-241.07, 6324.89, 32.43),
			sprite = 61,
			scale  = 1.2,
			color  = 2
		},

		AmbulanceActions = {
			vector3(-264.37, 6314.03, 31.44)
		},

		Pharmacies = {
			vector3(-252.41, 6327.8, 31.43)
		},

		Vehicles = {
			{
				Spawner = vector3(-237.0, 6331.75, 32.39),
				InsideShop = vector3(-272.9, 6328.34, 31.33),
				Marker = { type = 36, x = 1.0, y = 1.0, z = 1.0, r = 100, g = 50, b = 200, a = 100, rotate = true },
				SpawnPoints = {
					{ coords = vector3(-238.77, 6333.31, 31.42), heading = 221.61, radius = 4.0 }
				}
			}
		},

		Helicopters = {
		},

		FastTravels = {
			
		},

		FastTravelsPrompt = {
			{
				From = vector3(340.49, -595.27, 27.79),
				To = { coords = vector3(343.13, -595.51, 74.17), heading = 247.11 },
				Marker = { type = 1, x = 2.0, y = 2.0, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false },
				Prompt = _U('helipad')
			},

			{
				From = vector3(339.74, -584.33, 73.17),
				To = { coords = vector3(337.76, -594.37, 28.79), heading = 68.35 },
				Marker = { type = 1, x = 2.0, y = 2.0, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false },
				Prompt = _U('inside')
			}
		}

	},

	Sandy = {

		Blip = {
			coords = vector3(1838.82, 3673.6, 34.28),
			sprite = 61,
			scale  = 1.2,
			color  = 2
		},

		AmbulanceActions = {
			vector3(1837.36, 3670.62, 9.73)
		},

		Pharmacies = {
			vector3(1834.93, 3669.99, 9.69)
		},

		Vehicles = {
			{
				Spawner = vector3(1842.4, 3667.07, 33.68),
				InsideShop = vector3(1830.4, 3633.24, 34.4),
				Marker = { type = 36, x = 1.0, y = 1.0, z = 1.0, r = 100, g = 50, b = 200, a = 100, rotate = true },
				SpawnPoints = {
					{ coords = vector3(1848.8, 3670.44, 33.28), heading = 298.6, radius = 4.0 }
				}
			}
		},

		Helicopters = {
			{
				Spawner = vector3(1843.25, 3641.65, 35.83),
				InsideShop = vector3(1769.8, 3239.73, 42.12),
				Marker = { type = 34, x = 1.5, y = 1.5, z = 1.5, r = 100, g = 150, b = 150, a = 100, rotate = true },
				SpawnPoints = {
					{ coords = vector3(1844.9, 3639.13, 35), heading = 31.37, radius = 10.0 }
				}
			}
		},

		FastTravels = {
			{
				From = vector3(1840.75, 3673.59, 33.28),
				To = { coords = vector3(1840.88, 3673.52, 9.69), heading = 31.74 },
				Marker = { type = 1, x = 2.0, y = 2.0, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false }
			},

			{
				From = vector3(1841.66, 3671.35, 9.96),
				To = { coords = vector3(1838.24, 3672.11, 33.28), heading = 0.0 },
				Marker = { type = 1, x = 2.0, y = 2.0, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false }
			},
			
		},

		FastTravelsPrompt = {
			{
				From = vector3(237.4, -1373.8, 26.0),
				To = { coords = vector3(251.9, -1363.3, 38.5), heading = 0.0 },
				Marker = { type = 1, x = 1.5, y = 1.5, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false },
				Prompt = _U('fast_travel')
			}
		}

	}
}

Config.AuthorizedVehicles = {

	emtb = {
		{ model = 'ambulance', label = 'Ambulance Van'},
		{ model = 'qrv', label = 'C288'},
		{ model = '1200rt', label = 'ambulance cycle'},
		{ model = 'lguard', label = 'LifeGuard Granger'}
	},

	emti = {
		{ model = 'ambulance', label = 'Ambulance Van'},
		{ model = 'qrv', label = 'C288'},
		{ model = '1200rt', label = 'ambulance cycle'},
		{ model = 'lguard', label = 'LifeGuard Granger'},
	},

	emta = {
		{ model = 'ambulance', label = 'Ambulance Van'},
		{ model = 'qrv', label = 'C288'},
		{ model = '1200rt', label = 'ambulance cycle'},
		{ model = 'fbi2', label = 'Granger'},
		{ model = 'lguard', label = 'LifeGuard Granger'}
	},

	paramedic = {
		{ model = 'ambulance', label = 'Ambulance Van'},
		{ model = 'qrv', label = 'C288'},
		{ model = '1200rt', label = 'ambulance cycle'},
		{ model = 'fbi2', label = 'Granger'},
		{ model = 'lguard', label = 'LifeGuard Granger'}
	},

	paramedics = {
		{ model = 'ambulance', label = 'Ambulance Van'},
		{ model = 'qrv', label = 'C288'},
		{ model = '1200rt', label = 'ambulance cycle'},
		{ model = 'fbi2', label = 'Granger'},
		{ model = 'lguard', label = 'LifeGuard Granger'}
	},

	commander = {
		{ model = 'ambulance', label = 'Ambulance Van'},
		{ model = 'qrv', label = 'C288'},
		{ model = '1200rt', label = 'ambulance cycle'},
		{ model = 'fbi2', label = 'Granger'},
		{ model = 'lguard', label = 'LifeGuard Granger'}
	},
	
	boss = {
		{ model = 'ambulance', label = 'Ambulance Van'},
		{ model = 'qrv', label = 'C288'},
		{ model = '1200rt', label = 'ambulance cycle'},
		{ model = 'fbi2', label = 'Granger'},
		{ model = 'lguard', label = 'LifeGuard Granger'}
	}

}

Config.AuthorizedHelicopters = {

	ambulance = {},

	emtb = {
		
	},

	emti = {
		
	},

	emta = {
		{ model = 'polmav', label = 'Ambulance Helicopter'}
	},

	paramedic = {
		{ model = 'polmav', label = 'Ambulance Helicopter'}
	},

	paramedics = {
		{ model = 'polmav', label = 'Ambulance Helicopter'}
	},

	commander = {
		{ model = 'polmav', label = 'Ambulance Helicopter'}
	},

	boss = {
		{ model = 'polmav', label = 'Ambulance Helicopter'}
	}

}