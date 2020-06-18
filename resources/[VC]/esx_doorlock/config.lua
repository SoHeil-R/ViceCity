Config = {}
Config.Locale = 'en'

Config.DoorList = {

	--
	-- Mission Row First Floor
	--

	-- Entrance Doors
	{
		textCoords = vector3(434.7, -982.0, 31.5),
		authorizedJobs = { 'police' },
		locked = false,
		distance = 2.5,
		doors = {
			{
				objName = 'v_ilev_ph_door01',
				objYaw = -90.0,
				objCoords = vector3(434.7, -980.6, 30.8)
			},

			{
				objName = 'v_ilev_ph_door002',
				objYaw = -90.0,
				objCoords = vector3(434.7, -983.2, 30.8)
			}
		}
	},

	-- To locker room & roof
	{
		objName = 'v_ilev_ph_gendoor004',
		objYaw = 90.0,
		objCoords  = vector3(449.6, -986.4, 30.6),
		textCoords = vector3(450.1, -986.3, 31.7),
		authorizedJobs = { 'police', 'offpolice' },
		locked = true
	},

	-- Rooftop
	{
		objName = 'v_ilev_gtdoor02',
		objYaw = 90.0,
		objCoords  = vector3(464.3, -984.6, 43.8),
		textCoords = vector3(464.3, -984.0, 44.8),
		authorizedJobs = { 'police' },
		locked = true
	},

	-- Hallway to roof
	{
		objName = 'v_ilev_arm_secdoor',
		objYaw = 90.0,
		objCoords  = vector3(461.2, -985.3, 30.8),
		textCoords = vector3(461.5, -986.0, 31.5),
		authorizedJobs = { 'police' },
		locked = true
	},
    
	-- Armory
	{
		objName = 'v_ilev_arm_secdoor',
		objYaw = -90.0,
		objCoords  = vector3(452.6, -982.7, 30.6),
		textCoords = vector3(453.0, -982.6, 31.7),
		authorizedJobs = { 'police' },
		locked = true
	},

	{
		textCoords = vector3(464.8, -989.92, 26.0),
		authorizedJobs = { 'police' },
		locked = true,
		distance = 2,
		doors = {
			{
				objName = 'V_ILev_PH_GenDoor003',
				objYaw = 90.0,
				objCoords = vector3(465.6, -989.37, 24.91)
			},

			{
				objName = 'V_ILev_PH_GenDoor003',
				objYaw = 270.0,
				objCoords = vector3(465.1, -990.04, 24.91)
			}
		}
	},

	{
		objName = 'v_ilev_ph_gendoor005',
		objYaw = 0.0,
		objCoords  = vector3(471.8, -988.5, 24.9),
		textCoords = vector3(471.8, -988.5, 24.9),
		authorizedJobs = { 'police' },
		locked = true
	},

	{
		objName = 'v_ilev_ph_gendoor005',
		objYaw = 0.0,
		objCoords  = vector3(472.1, -991.57, 24.9),
		textCoords = vector3(472.1, -991.57, 24.9),
		authorizedJobs = { 'police' },
		locked = true
	},

	{
		objName = 'v_ilev_ph_gendoor005',
		objYaw = 0.0,
		objCoords  = vector3(477.6, -991.57, 24.9),
		textCoords = vector3(477.6, -991.57, 24.9),
		authorizedJobs = { 'police' },
		locked = true
	},

	{
		objName = 'v_ilev_ph_gendoor005',
		objYaw = 0.0,
		objCoords  = vector3(477.61, -988.37, 24.9),
		textCoords = vector3(477.61, -988.37, 24.9),
		authorizedJobs = { 'police' },
		locked = true
	},
	
	{
		objName = 'v_ilev_ph_cellgate',
		objYaw = 0.0,
		objCoords  = vector3(482.0, -988.5, 24.9),
		textCoords = vector3(482.0, -988.5, 24.9),
		authorizedJobs = { 'police' },
		locked = true
	},

	{
		objName = 'v_ilev_ph_cellgate',
		objYaw = 0.0,
		objCoords  = vector3(482.0, -991.4, 24.9),
		textCoords = vector3(482.0, -991.4, 24.9),
		authorizedJobs = { 'police' },
		locked = true
	},

	{
		objName = 'v_ilev_ph_cellgate',
		objYaw = 90.0,
		objCoords  = vector3(465.7, -1001.9, 24.9),
		textCoords = vector3(465.9, -1002.2, 25.1),
		authorizedJobs = { 'police' },
		locked = true
	},

	{
		objName = 'v_ilev_ph_cellgate',
		objYaw = 90.0,
		objCoords  = vector3(466.0, -998.34, 24.9),
		textCoords = vector3(466.0, -998.34, 24.9),
		authorizedJobs = { 'police' },
		locked = true
	},

	-- Captain Office
	{
		objName = 'v_ilev_ph_gendoor002',
		objYaw = -180.0,
		objCoords  = vector3(447.2, -980.6, 30.6),
		textCoords = vector3(447.2, -980.0, 31.7),
		authorizedJobs = { 'police' },
		locked = true
	},

	-- To downstairs (double doors)
	{
		textCoords = vector3(444.6, -989.4, 31.7),
		authorizedJobs = { 'police' },
		locked = false,
		distance = 4,
		doors = {
			{
				objName = 'v_ilev_ph_gendoor005',
				objYaw = 180.0,
				objCoords = vector3(443.9, -989.0, 30.6)
			},

			{
				objName = 'v_ilev_ph_gendoor005',
				objYaw = 0.0,
				objCoords = vector3(445.3, -988.7, 30.6)
			}
		}
	},

	-- BANK

	{
		textCoords = vector3(259.63, 204.08, 107.28),
		authorizedJobs = { 'police' },
		locked = true,
		distance = 4,
		doors = {
			{
				objName = 'hei_prop_hei_bankdoor_new',
				objCoords = vector3(258.63, 204.49, 106.28)
			},

			{
				objName = 'hei_prop_hei_bankdoor_new',
				objCoords = vector3(260.44, 203.84, 106.28)
			}
		}
	},

	--
	-- Mission Row Cells
	--

	-- Main Cells
	{
		objName = 'v_ilev_ph_cellgate',
		objYaw = 0.0,
		objCoords  = vector3(463.8, -992.6, 24.9),
		textCoords = vector3(463.3, -992.6, 25.1),
		authorizedJobs = { 'police' },
		locked = true
	},

	-- Cell 1
	{
		objName = 'v_ilev_ph_cellgate',
		objYaw = -90.0,
		objCoords  = vector3(462.3, -993.6, 24.9),
		textCoords = vector3(461.8, -993.3, 25.0),
		authorizedJobs = { 'police' },
		locked = true
	},

	-- Cell 2
	{
		objName = 'v_ilev_ph_cellgate',
		objYaw = 90.0,
		objCoords  = vector3(462.3, -998.1, 24.9),
		textCoords = vector3(461.8, -998.8, 25.0),
		authorizedJobs = { 'police' },
		locked = true
	},

	-- Cell 3
	{
		objName = 'v_ilev_ph_cellgate',
		objYaw = 90.0,
		objCoords  = vector3(462.7, -1001.9, 24.9),
		textCoords = vector3(461.8, -1002.4, 25.0),
		authorizedJobs = { 'police' },
		locked = true
	},

	-- To Back
	{
		objName = 'v_ilev_gtdoor',
		objYaw = 0.0,
		objCoords  = vector3(463.4, -1003.5, 25.0),
		textCoords = vector3(464.0, -1003.5, 25.5),
		authorizedJobs = { 'police' },
		locked = true
	},

	--
	-- Mission Row Back
	--

	-- Back (double doors)
	{
		textCoords = vector3(468.6, -1014.4, 27.1),
		authorizedJobs = { 'police' },
		locked = true,
		distance = 4,
		doors = {
			{
				objName = 'v_ilev_rc_door2',
				objYaw = 0.0,
				objCoords  = vector3(467.3, -1014.4, 26.5)
			},

			{
				objName = 'v_ilev_rc_door2',
				objYaw = 180.0,
				objCoords  = vector3(469.9, -1014.4, 26.5)
			}
		}
	},

	-- Back Gate
	{
		objName = 'hei_prop_station_gate',
		objYaw = 90.0,
		objCoords  = vector3(488.8, -1017.2, 27.1),
		textCoords = vector3(488.8, -1020.2, 30.0),
		authorizedJobs = { 'police' },
		locked = true,
		distance = 14,
		size = 2
	},

	{
		textCoords = vector3(446.36, -986.57, 26.67),
		authorizedJobs = { 'police' },
		locked = true,
		distance = 4,
		doors = {
			{
				objName = 'V_ILev_PH_GenDoor003',
				objYaw = 90.0,
				objCoords  = vector3(445.63, -985.25, 26.67)
			},

			{
				objName = 'V_ILev_PH_GenDoor003',
				objYaw = 270.0,
				objCoords  = vector3(445.54, -987.74, 26.67)
			}
		}
	},

	{
		textCoords = vector3(452.17, -984.3, 26.67),
		authorizedJobs = { 'police' },
		locked = true,
		distance = 4,
		doors = {
			{
				objName = 'V_ILev_PH_GenDoor003',
				objYaw = 180.0,
				objCoords  = vector3(450.64, -984.31, 26.67)
			},

			{
				objName = 'V_ILev_PH_GenDoor003',
				objYaw = 0.0,
				objCoords  = vector3(453.45, -984.24, 26.67)
			}
		}
	},

	{
		objName = 'V_ILev_PH_GenDoor006',
		objYaw = 270.0,
		objCoords  = vector3(470.9, -985.55, 24.91),
		textCoords = vector3(470.9, -985.55, 24.91),
		authorizedJobs = { 'police' },
		locked = true,
		distance = 2,
		size = 1
	},

	{
		objName = 'V_ILev_PH_GenDoor006',
		objYaw = 90.0,
		objCoords  = vector3(463.5, -981.28, 24.91),
		textCoords = vector3(463.5, -981.28, 24.91),
		authorizedJobs = { 'police' },
		locked = true,
		distance = 2,
		size = 1
	},

	{
		objName = 'V_ILev_PH_GenDoor006',
		objYaw = 180.0,
		objCoords  = vector3(468.3, -978.1, 24.91),
		textCoords = vector3(468.3, -978.1, 24.91),
		authorizedJobs = { 'police' },
		locked = true,
		distance = 2,
		size = 1
	},

	--
	-- Sandy Shores
	--

	-- Entrance
	{
		objName = 'v_ilev_shrfdoor',
		objYaw = 30.0,
		objCoords  = vector3(1855.1, 3683.5, 34.2),
		textCoords = vector3(1855.1, 3683.5, 35.0),
		authorizedJobs = { 'police', 'offpolice' },
		locked = false
	},

	--
	-- Paleto Bay
	--

	-- Entrance (double doors)
	{
		textCoords = vector3(-443.5, 6016.3, 32.0),
		authorizedJobs = { 'police' },
		locked = false,
		distance = 2.5,
		doors = {
			{
				objName = 'v_ilev_shrf2door',
				objYaw = -45.0,
				objCoords  = vector3(-443.1, 6015.6, 31.7),
			},

			{
				objName = 'v_ilev_shrf2door',
				objYaw = 135.0,
				objCoords  = vector3(-443.9, 6016.6, 31.7)
			}
		}
	},

	--
	-- Bolingbroke Penitentiary
	--

	-- Entrance (Two big gates)
	{
		objName = 'prop_gate_prison_01',
		objCoords  = vector3(1844.9, 2604.8, 44.6),
		textCoords = vector3(1844.9, 2608.5, 48.0),
		authorizedJobs = { 'police' },
		locked = true,
		distance = 12,
		size = 2
	},

	{
		objName = 'prop_gate_prison_01',
		objCoords  = vector3(1818.5, 2604.8, 44.6),
		textCoords = vector3(1818.5, 2608.4, 48.0),
		authorizedJobs = { 'police' },
		locked = true,
		distance = 12,
		size = 2
    },
    

	--
	-- Addons
	--
       
    -- gate blain country
	{
		objName = 'p_gate_prison_01_s',
		objCoords  = vector3(-461.46, 6027.857, 30.339),
		textCoords = vector3(-458.44, 6025.58, 34.339),
		authorizedJobs = { 'police' },
		locked = true,
		distance = 12,
		size = 2
	},
    -- heli gate police
    {
		objName = 'prop_facgate_01',
		objCoords  = vector3(1857.1255, 3657.1543, 33.0147),
		textCoords = vector3(1859.33, 3658.75, 36.0147),
		authorizedJobs = { 'police' },
		locked = true,
		distance = 12,
		size = 2
    },
    -- heli gate medic
    {
		objName = 'prop_facgate_01',
		objCoords  = vector3(1835.8856, 3645.0862, 33.2223),
		textCoords = vector3(1838.11, 3647.37, 36.2223),
		authorizedJobs = { 'ambulance' },
		locked = true,
		distance = 12,
		size = 2
	},
    -- main gate interior zendan
    {
		objName = 'prop_fnclink_09gate1',
		objCoords  = vector3(1689.1713, 2499.3757, -43.4438),
		textCoords = vector3(1689.1713, 2499.3757, -43.4438),
		authorizedJobs = { 'police' },
		locked = true,
		objYaw = 0.0,
		distance = 3,
		size = 1
    },
    -- second gate interior zendan
    {
		objName = 'prop_fnclink_02gate7',
		objCoords  = vector3(1678.2024, 2504.9021, -43.4438),
		textCoords = vector3(1678.2024, 2504.9021, -43.4438),
		authorizedJobs = { 'police' },
        locked = true,
        objYaw = 0.0,
		distance = 3,
		size = 1
    },
    -- dare otagh amozesh
	{
		objName = 'apa_heist_apart2_door',
		objCoords  = vector3(1689.4746, 2510.0684, -43.5733),
		textCoords = vector3(1689.4746, 2510.0684, -43.5733),
		authorizedJobs = { 'police' },
        locked = true,
        objYaw = 0.0,
		distance = 3,
		size = 1
    },
    -- armory interior zendan
    {
		objName = 'v_ilev_ph_cellgate02',
		objCoords  = vector3(1700.8767, 2505.1138, -43.6058),
		textCoords = vector3(1700.8767, 2505.1138, -43.6058),
		authorizedJobs = { 'police' },
        locked = true,
        objYaw = 0.0,
		distance = 3,
		size = 1
    },
    -- dare lobby interior zendan
    {
		objName = 'v_ilev_ph_cellgate02',
		objCoords  = vector3(1706.9487, 2506.4087, -43.6023),
		textCoords = vector3(1706.9487, 2506.4087, -43.6023),
		authorizedJobs = { 'police' },
        locked = true,
        objYaw = 90.0,
		distance = 3,
		size = 1
    },
    -- dare bordan zendani be samte lobby be zendan
    {
		objName = 'v_ilev_ph_cellgate02',
		objCoords  = vector3(1719.4128, 2512.8159, -43.5950),
		textCoords = vector3(1719.4128, 2512.8159, -43.5950),
		authorizedJobs = { 'police' },
        locked = true,
        objYaw = 90.0,
		distance = 3,
		size = 1
    },
    -- dare aslie interior zendan
    {
		objName = 'v_ilev_ph_cellgate02',
		objCoords  = vector3(1717.1321, 2522.5620, -43.6023),
		textCoords = vector3(1717.1321, 2522.5620, -43.6023),
		authorizedJobs = { 'police' },
        locked = true,
        objYaw = 180.0,
		distance = 3,
		size = 1
    },
    -- dare otagh taviz lebas
    {
		objName = 'hei_prop_heist_cutscene_doorc_l',
		objCoords  = vector3(1725.2661, 2511.5200, -43.5904),
		textCoords = vector3(1725.2661, 2511.5200, -43.5904),
		authorizedJobs = { 'police' },
		locked = true,
		objYaw = 180.0,
		distance = 1,
		size = 1
    },
    -- dare otagh aks
    {
		objName = 'hei_prop_heist_cutscene_doorc_r',
		objCoords  = vector3(1726.0580, 2511.5381, -43.5904),
		textCoords = vector3(1726.0580, 2511.5381, -43.5904),
		authorizedJobs = { 'police' },
        locked = true,
        objYaw = 180.0,
		distance = 1,
		size = 1
    },
    -- cell 1
    {
		objName = 'v_ilev_fingate',
		objCoords  = vector3(1722.4220, 2524.8499, -43.4945),
		textCoords = vector3(1722.4220, 2524.8499, -43.4945),
		authorizedJobs = { 'police' },
        locked = false,
        objYaw = 90.0,
		distance = 3,
		size = 1
	},
    -- cell 2
    {
		objName = 'v_ilev_fingate',
		objCoords  = vector3(1722.3837, 2529.6780, -43.4945),
		textCoords = vector3(1722.3837, 2529.6780,-43.4945),
        authorizedJobs = { 'police' },
        objYaw = 90.0,
		locked = false,
		distance = 3,
		size = 1
    },
    -- cell 3
    {
		objName = 'v_ilev_fingate',
		objCoords  = vector3(1722.3557, 2534.4763, -43.4945),
		textCoords = vector3(1722.3557, 2534.4763, -43.4945),
        authorizedJobs = { 'police' },
        objYaw = 90.0,
		locked = false,
		distance = 3,
		size = 1
    },
    -- cell 4
    {
		objName = 'v_ilev_fingate',
		objCoords  = vector3(1722.3335, 2539.3083, -43.4945),
		textCoords = vector3(1722.3335, 2539.3083, -43.4945),
        authorizedJobs = { 'police' },
        objYaw = 90.0,
		locked = false,
		distance = 3,
		size = 1
    },
    -- cell 5
    {
		objName = 'v_ilev_fingate',
		objCoords  = vector3(1722.4386, 2544.1079, -43.4945),
		textCoords = vector3(1722.4386,2544.1079, -43.4945),
        authorizedJobs = { 'police' },
        objYaw = 90.0,
		locked = false,
		distance = 3,
		size = 1
    },
    -- cell 6
	{
		objName = 'v_ilev_fingate',
		objCoords  = vector3(1721.7828, 2548.8232, -43.4945),
		textCoords = vector3(1721.7828, 2548.8232, -43.4945),
        authorizedJobs = { 'police' },
        objYaw = 90.0,
		locked = false,
		distance = 3,
		size = 1
    },
    -- cell 7
    {
		objName = 'v_ilev_fingate',
		objCoords  = vector3(1713.4502, 2550.4194, -43.494),
		textCoords = vector3(1713.4502, 2550.4194, -43.4945),
        authorizedJobs = { 'police' },
        objYaw = -90.0,
		locked = false,
		distance = 3,
		size = 1
    },
    -- cell 8
    {
		objName = 'v_ilev_fingate',
		objCoords  = vector3(1713.1820, 2545.6841, -43.4945),
		textCoords = vector3(1713.1820, 2545.6841, -43.4945),
        authorizedJobs = { 'police' },
        objYaw = -90.0,
		locked = false,
		distance = 3,
		size = 1
    },
    -- cell 9
    {
		objName = 'v_ilev_fingate',
		objCoords  = vector3(1713.1283, 2540.8857, -43.4945),
        textCoords = vector3(1713.1283, 2540.8857, -43.4945),
        objYaw = -90.0,
		authorizedJobs = { 'police' },
		locked = false,
		distance = 3,
		size = 1
    },
    -- cell 10
    {
		objName = 'v_ilev_fingate',
		objCoords  = vector3(1713.1748, 2535.9827, -43.4945),
		textCoords = vector3(1713.1748, 2535.9827,  -43.4945),
        authorizedJobs = { 'police' },
        objYaw = -90.0,
		locked = false,
		distance = 3,
		size = 1
    },
    -- cell 11
    {
		objName = 'v_ilev_fingate',
		objCoords  = vector3(1713.1650, 2531.1462, -43.4945),
		textCoords = vector3(1713.1650, 2531.1462, -43.4945),
        authorizedJobs = { 'police' },
        objYaw = -90.0,
		locked = false,
		distance = 3,
		size = 1
    },
    -- cell 12
    {
		objName = 'v_ilev_fingate',
		objCoords  = vector3(1713.1317, 2526.3252, -43.4945),
		textCoords = vector3(1713.1317, 2526.3252, -43.4945),
        authorizedJobs = { 'police' },
        objYaw = -90.0,
		locked = false,
		distance = 3,
		size = 1
    },
    -- dare samte hayat
    {
		objName = 'v_ilev_ph_cellgate02',
		objCoords  = vector3(1717.3939, 2552.0103, -43.6023),
        textCoords = vector3(1717.3939, 2552.0103, -43.6023),
        objYaw = 180.0,
		authorizedJobs = { 'police' },
		locked = false,
		distance = 3,
		size = 1
    },
	{
        objName = 'prop_lrggate_02_ld',
        objCoords  = vector3(-1583.7, 40.2, 60.1),
        textCoords = vector3(-1586.5, 40.8, 61.1),
        authorizedJobs = { 'offpolice','police' },
        locked = true,
        distance = 9
    },
    
    {
        objName = 'prop_lrggate_02_ld',
        objCoords  = vector3(-1552.7, 33.2, 58.1),
        textCoords = vector3(-1550.3, 33.2, 59.1),
        authorizedJobs = { 'offpolice','police' },
        locked = true,
        distance = 9
	},

-- dare poshti medic
	{
        objName = 'v_ilev_cor_firedoorwide',
        objCoords  = vector3(332.70, -587.72, 28.80),
		textCoords = vector3(332.70, -587.72, 28.80),
		authorizedJobs = { 'ambulance' },
		objYaw = 160.0,
        locked = true,
        distance = 2
	},
-- dare jeloyi medic
	{
        objName = 'v_ilev_cor_firedoorwide',
        objCoords  = vector3(337.5, -583.44, 28.79),
        textCoords = vector3(337.5, -583.44, 28.79),
		authorizedJobs = { 'ambulance' },
		objYaw = -110.0,
        locked = true,
        distance = 2
	},
	
-- dare boos taxi
{
	textCoords = vector3(900.28, -162.83, 83.49),
	authorizedJobs = { 'taxi' },
	locked = true,
	distance = 2.5,
	doors = {
		{
			objName = 'apa_p_mp_yacht_door_02',
			objYaw = -210.0,
			objCoords  = vector3(899.17, -161.86, 83.65),
		},

		{
			objName = 'apa_p_mp_yacht_door_02',
			objYaw = -32.0,
			objCoords  = vector3(901.35, -163.17, 83.65)
		}
	}
},
--- dare mechanici
{
	objName = 'lr_prop_supermod_door_01',
	objCoords  = vector3(-205.8, -1310.7, 32.0),
	textCoords = vector3(-205.8, -1310.7, 33.2),
	authorizedJobs = { 'mechanic', 'police' },
	locked = true,
	distance = 15
},

--Mahyar House
{
        objName = 'prop_sec_barrier_ld_01a',
        objCoords  = vector3(-993.39, 42.43, 51.3),
        textCoords = vector3(-993.39, 42.43, 51.3),
        authorizedJobs = { 'police' },
        locked = false
    },
    {
        objName = 'prop_sec_barrier_ld_01a',
        objCoords  = vector3(-1001.93, 56.07, 51.86),
        textCoords = vector3(-1001.93, 56.07, 51.86),
        authorizedJobs = { 'police' },
        locked = false
    },
	  {
        objName = 'apa_p_mp_yacht_door_02',
        objCoords  = vector3(-1129.79, 143.55, 66.29),
        textCoords = vector3(-1129.79, 143.55, 66.29),
        authorizedJobs = { 'police' },
        locked = false
    },
	    {
        objName = 'apa_p_mp_yacht_door_02',
        objCoords  = vector3(-1125.43, 146.76, 66.28),
        textCoords = vector3(-1125.43, 146.76, 66.28),
        authorizedJobs = { 'police' },
        locked = false
    },
    {
        objName = 'apa_p_mp_yacht_door_02',
        objCoords  = vector3(-1120.55, 141.96, 66.31),
        textCoords = vector3(-1120.55, 141.96, 66.31),
        authorizedJobs = { 'police' },
        locked = false
    },
-- Voroudi sheriff
{
	objName = 'v_ilev_ph_gendoor004',
	objYaw = 30.0,
	objCoords  = vector3(1849.33, 3691.13, 34.41),
	textCoords = vector3(1849.33, 3691.13, 34.41),
	authorizedJobs = { 'police', 'offpolice' },
	locked = true,
	distance = 2
},
-- dare samte rast vorodi sheriff
{
	objName = 'v_ilev_ph_gendoor004',
	objYaw = 30.0,
	objCoords  = vector3(1857.26, 3690.27, 34.41),
	textCoords = vector3(1857.26, 3690.27, 34.41),
	authorizedJobs = { 'police' },
	locked = true,
	distance = 2
},
-- dare poshti samte rast vorodi sheriff
{
	objName = 'v_ilev_ph_gendoor004',
	objYaw = 30.0,
	objCoords  = vector3(1854.92, 3694.33, 34.41),
	textCoords = vector3(1854.92, 3694.33, 34.41),
	authorizedJobs = { 'police' },
	locked = true,
	distance = 2
},
-- dare dakheli samte rast
{
	objName = 'v_ilev_ph_gendoor004',
	objYaw = 120.0,
	objCoords  = vector3(1850.83, 3694.54, 34.41),
	textCoords = vector3(1850.83, 3694.54, 34.41),
	authorizedJobs = { 'police' },
	locked = true,
	distance = 2
},
-- dare locker
{
	objName = 'v_ilev_ph_gendoor004',
	objYaw = -60.0,
	objCoords  = vector3(1843.25, 3690.31, 34.42),
	textCoords = vector3(1843.25, 3690.31, 34.42),
	authorizedJobs = { 'police' },
	locked = true,
	distance = 2
},
-- dare khoroji jail sheriff
{
	objName = 'v_ilev_ph_gendoor004',
	objYaw = 30.0,
	objCoords  = vector3(1846.11, 3689.26, 34.41),
	textCoords = vector3(1846.11, 3689.26, 34.41),
	authorizedJobs = { 'police' },
	locked = true,
	distance = 2
},
-- dare vorodi jail sheriff
{
	objName = 'v_ilev_ph_gendoor004',
	objYaw = 120.0,
	objCoords  = vector3(1850.37, 3683.45, 34.40),
	textCoords = vector3(1850.37, 3683.45, 34.40),
	authorizedJobs = { 'police' },
	locked = true,
	distance = 2
},
-- jail sheriff #1
{
	objName = 'v_ilev_ph_cellgate',
	objYaw = 120.0,
	objCoords  = vector3(1847.98, 3681.68, 34.40),
	textCoords = vector3(1847.98, 3681.68, 34.40),
	authorizedJobs = { 'police' },
	locked = true,
	distance = 2
},
-- jail sheriff #2
{
	objName = 'v_ilev_ph_cellgate',
	objYaw = -60.0,
	objCoords  = vector3(1846.39, 3684.45, 34.40),
	textCoords = vector3(1846.39, 3684.45, 34.40),
	authorizedJobs = { 'police' },
	locked = true,
	distance = 2
},
{
	objName = 'v_ilev_ph_cellgate02',
	objYaw = 358.79,
	objCoords  = vector3(1706.1, 2509.7, -43.7),
	textCoords = vector3(1706.1, 2509.7, -43.7),
	authorizedJobs = { 'police' },
	locked = true
},

{
	objName = 'v_ilev_ph_cellgate02',
	objYaw = 88.56,
	objCoords  = vector3(1703.14, 2511.06, -43.7),
	textCoords = vector3(1703.14, 2511.06, -43.7),
	authorizedJobs = { 'police' },
	locked = true
},

{
	objName = 'v_ilev_ph_cellgate02',
	objYaw = 357.47,
	objCoords  = vector3(1699.6, 2522.23, -43.7),
	textCoords = vector3(1699.6, 2522.23, -43.7),
	authorizedJobs = { 'police' },
	locked = true
},

{
	objName = 'prop_facgate_07b',
	objCoords  = vector3(-395.42, -104.92, 38.69),
	textCoords = vector3(-398.53, -106.88, 38.68),
	authorizedJobs = { 'mechanic','police' },
	locked = true,
	distance = 10
},


{
	objName = 'prop_gate_airport_01',
	objCoords  = vector3(-378.54, -74.73, 45.65),
	textCoords = vector3(-377.33, -71.13, 46.66),
	authorizedJobs = { 'mechanic','police' },
	locked = true,
	distance = 10
},


{
	objName = 'prop_lrggate_06a',
	objCoords  = vector3(-358.22, -182.89, 37.57),
	textCoords = vector3(-355.28, -181.25, 38.77),
	authorizedJobs = { 'mechanic','police' },
	locked = true,
	distance = 10
},

{
	objName = 'prop_com_ls_door_01',
	objCoords  = vector3(-356.27, -134.75, 38.99),
	textCoords = vector3(-356.27, -134.75, 40.50),
	authorizedJobs = { 'mechanic','police' },
	locked = true,
	distance = 10
},
--[[
	-- Entrance Gate (Mission Row mod) https://www.gta5-mods.com/maps/mission-row-pd-ymap-fivem-v1
	{
		objName = 'prop_gate_airport_01',
		objCoords  = vector3(420.1, -1017.3, 28.0),
		textCoords = vector3(420.1, -1021.0, 32.0),
		authorizedJobs = { 'police' },
		locked = true,
		distance = 14,
		size = 2
	}
	--]]
}