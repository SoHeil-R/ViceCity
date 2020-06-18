Config = {}

Config.JailPositions = {
	["Cell"] = { ["x"] = 1717.82, ["y"] = 2534.27, ["z"] = -43.72, ["h"] = 335.13 },
	["Solitary"] = { ["x"] = 1741.38, ["y"] = 2516.86, ["z"] = -43.72, ["h"] = 268.86 },
	["Solitarytwo"] = { ["x"] = 1741.44, ["y"] = 2519.39, ["z"] = -43.72, ["h"] = 271.39 },
	["Solitarythree"] = { ["x"] = 1750.17, ["y"] = 2519.3, ["z"] = -43.72, ["h"] = 88.89 },
	["Solitaryfour"] = { ["x"] = 1750.23, ["y"] = 2517.06, ["z"] = -43.72, ["h"] = 90.31 },
	["bjailone"] = { ["x"] = 460.36, ["y"] = -994.09, ["z"] = 24.91, ["h"] = 266.82 },
	["bjailtwo"] = { ["x"] = 460.12, ["y"] = -997.85, ["z"] = 24.91, ["h"] = 261.85 },
	["bjailthree"] = { ["x"] = 459.73, ["y"] = -1001.54, ["z"] = 24.91, ["h"] = 271.58 },
	["bjailfour"] = { ["x"] = 468.54, ["y"] = -1001.58, ["z"] = 24.91, ["h"] = 88.13 },
	["bjailfour"] = { ["x"] = 467.96, ["y"] = -997.76, ["z"] = 24.91, ["h"] = 86.86 }
}

Config.Teleport = {
	["PD"] = { ["x"] = 444.5, ["y"] = -987.78, ["z"] = 30.69, ["h"] = 355.29 }
}

Config.Cutscene = {
	--["PhotoPosition"] = { ["x"] = 402.91567993164, ["y"] = -996.75970458984, ["z"] = -99.000259399414, ["h"] = 186.22499084473 },
	["PhotoPosition"] = { ["x"] = 1735.82, ["y"] = 2508.07, ["z"] = -43.72, ["h"] = 91.24 },

	--["CameraPos"] = { ["x"] = 402.88830566406, ["y"] = -1003.8851318359, ["z"] = -97.419647216797, ["rotationX"] = -15.433070763946, ["rotationY"] = 0.0, ["rotationZ"] = -0.31496068835258, ["cameraId"] = 0 },
	["CameraPos"] = { ["x"] = 1726.15, ["y"] = 2506.13, ["z"] = -41.72, ["rotationX"] = -20.433070763946, ["rotationY"] = 0.0, ["rotationZ"] = -70.0, ["cameraId"] = 0 },

	--["PolicePosition"] = { ["x"] = 402.91702270508, ["y"] = -1000.6376953125, ["z"] = -99.004028320313, ["h"] = 356.88052368164 }
	["PolicePosition"] = { ["x"] = 1732.83, ["y"] = 2507.57, ["z"] = -43.72, ["h"] = 267.48 }
}

Config.PrisonWork = {
	["DeliverPackage"] = { ["x"] = 1027.2347412109, ["y"] = -3101.419921875, ["z"] = -38.999870300293, ["h"] = 267.89135742188 },

	["Packages"] = {
		[1] = { ["x"] = 1003.6661987305, ["y"] = -3108.4221191406, ["z"] = -38.999866485596, ["state"] = true },
		[2] = { ["x"] = 1006.0420532227, ["y"] = -3103.0024414063, ["z"] = -38.999866485596, ["state"] = true },
		[3] = { ["x"] = 1015.7958374023, ["y"] = -3102.8337402344, ["z"] = -38.99991607666, ["state"] = true },
		[4] = { ["x"] = 1012.8907470703, ["y"] = -3108.2907714844, ["z"] = -38.999912261963, ["state"] = true },
		[5] = { ["x"] = 1018.2017822266, ["y"] = -3109.1982421875, ["z"] = -38.999897003174, ["state"] = true },
		[6] = { ["x"] = 1018.0194091797, ["y"] = -3096.5700683594, ["z"] = -38.999897003174, ["state"] = true },
		[7] = { ["x"] = 1015.6422119141, ["y"] = -3091.7392578125, ["z"] = -38.999897003174, ["state"] = true },
		[8] = { ["x"] = 1010.7862548828, ["y"] = -3096.6135253906, ["z"] = -38.999897003174, ["state"] = true },
		[9] = { ["x"] = 1005.7819824219, ["y"] = -3096.8415527344, ["z"] = -38.999897003174, ["state"] = true },
		[10] = { ["x"] = 1003.4543457031, ["y"] = -3096.7048339844, ["z"] = -38.999897003174, ["state"] = true }
	}
}

Config.Teleports = {
	["Prison Work"] = { 
		["x"] = 1690.69, 
		["y"] = 2591.48, 
		["z"] = 45.91, 
		["h"] = 180.32, 
		["goal"] = { 
			"Jail" 
		} 
	},

	["Boiling Broke"] = { 
		["x"] = 1845.6022949219, 
		["y"] = 2585.8029785156, 
		["z"] = 45.672061920166, 
		["h"] = 92.469093322754, 
		["goal"] = { 
			"Security" 
		} 
	},

	["Jail"] = { 
		["x"] = 1734.87, 
		["y"] = 2512.89, 
		["z"] = -43.72, 
		["h"] = 269.95, 
		["goal"] = { 
			"Prison Work"
		} 
	},

	["Security"] = { 
		["x"] = 1686.86,
		["y"] = 2486.2, 
		["z"] = -43.72, 
		["h"] = 185.61, 
		["goal"] = { 
			"Boiling Broke"
		} 
	},

	["CB"] = {
		["x"] = 1710.15, 
		["y"] = 2555.24, 
		["z"] = -43.72, 
		["h"] = 4.95, 
		["goal"] = { 
			"Outside" 
		} 
	},
	
	["Outside"] = {
		["x"] = 1636.27, 
		["y"] = 2565.42, 
		["z"] = 45.56, 
		["h"] = 3.77, 
		["goal"] = { 
			"CB" 
		} 
	},

	["News"] = {
		["x"] = -1078.04, 
		["y"] = -254.59, 
		["z"] = 37.76, 
		["h"] = 206.41, 
		["goal"] = { 
			"Roof" 
		} 
	},

	["Roof"] = {
		["x"] = -1072.54, 
		["y"] = -246.52, 
		["z"] = 54.01, 
		["h"] = 123.6, 
		["goal"] = { 
			"News" 
		} 
	},

	["mhouse1"] = {
		["x"] = -1570.72, 
		["y"] = 22.53, 
		["z"] = 59.55, 
		["h"] = 347.49, 
		["goal"] = { 
			"mhouseinterior" 
		} 
	},

	["mhouseinterior"] = {
		["x"] = -774.73, 
		["y"] = 331.28, 
		["z"] = 160.0, 
		["h"] = 357.57, 
		["goal"] = { 
			"mhouse1" 
		} 
	},

	["mhouseout1"] = {
		["x"] = -792.23, 
		["y"] = 326.1, 
		["z"] = 158.6, 
		["h"] = 184.35, 
		["goal"] = { 
			"mhouseout2" 
		} 
	},

	["mhouseout2"] = {
		["x"] = -1561.19, 
		["y"] = 16.37, 
		["z"] = 62.17, 
		["h"] = 82.1, 
		["goal"] = { 
			"mhouseout1" 
		} 
	},

	["mhouseout3"] = {
		["x"] = -773.1, 
		["y"] = 340.5, 
		["z"] = 160.0, 
		["h"] = 277.67, 
		["goal"] = { 
			"mhouseout4" 
		} 
	},

	["pdbase1"] = {
		["x"] = 470.73, 
		["y"] = -984.89, 
		["z"] = 30.69, 
		["h"] = 92.37, 
		["goal"] = { 
			"pdbase2" 
		} 
	},

	["pdbase2"] = {
		["x"] = -1118.11, 
		["y"] = -824.89, 
		["z"] = -42.87, 
		["h"] = 218.53, 
		["goal"] = { 
			"pdbase1" 
		} 
	},

	["casino1"] = {
		["x"] = 947.81, 
		["y"] = 50.8, 
		["z"] = 75.12, 
		["h"] = 114.2, 
		["goal"] = { 
			"casino2" 
		} 
	},

	["casino2"] = {
		["x"] = 964.99, 
		["y"] = 58.54, 
		["z"] = 112.55, 
		["h"] = 58.7, 
		["goal"] = { 
			"casino1" 
		} 
	},

	["mhouseout4"] = {
		["x"] = -1585.89, 
		["y"] = 19.52, 
		["z"] = 65.79, 
		["h"] = 74.23, 
		["goal"] = { 
			"mhouseout3" 
		} 
	}
	
}