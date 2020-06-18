Config = {}

Config.Animations = {

	{
		name  = 'festives',
		label = 'عمومی',
		items = {
			{label = "سیگار کشیدن", type = "scenario", data = {anim = "WORLD_HUMAN_SMOKING"}},
			{label = "اجرا موزیک", type = "scenario", data = {anim = "WORLD_HUMAN_MUSICIAN"}},
			{label = "دی جی", type = "anim", data = {lib = "anim@mp_player_intcelebrationmale@dj", anim = "dj"}},
			{label = "آب میوه", type = "scenario", data = {anim = "WORLD_HUMAN_DRINKING"}},
			{label = "دلستر", type = "scenario", data = {anim = "WORLD_HUMAN_PARTYING"}},
			--{label = "گیتار الکی", type = "anim", data = {lib = "anim@mp_player_intcelebrationmale@air_guitar", anim = "air_guitar"}},
			{label = "تکون دادن", type = "anim", data = {lib = "anim@mp_player_intcelebrationfemale@air_shagging", anim = "air_shagging"}},
			{label = "راک", type = "anim", data = {lib = "mp_player_int_upperrock", anim = "mp_player_int_rock"}},
			--{label = "Fumer un joint", type = "scenario", data = {anim = "WORLD_HUMAN_SMOKING_POT"}},
			{label = "خمار", type = "anim", data = {lib = "amb@world_human_bum_standing@drunk@idle_a", anim = "idle_a"}},
			--{label = "بالا آوردن", type = "anim", data = {lib = "oddjobs@taxi@tie", anim = "vomit_outside"}},
		}
	},

	{
		name  = 'greetings',
		label = 'سلام علیک',
		items = {
			{label = "سلام", type = "anim", data = {lib = "gestures@m@standing@casual", anim = "gesture_hello"}},
			{label = "بفرمایید", type = "anim", data = {lib = "mp_common", anim = "givetake1_a"}},
			{label = "بزن قدش", type = "anim", data = {lib = "mp_ped_interaction", anim = "handshake_guy_a"}},
			{label = "بغل کردن", type = "anim", data = {lib = "mp_ped_interaction", anim = "hugs_guy_a"}},
			{label = "احترام نظامی", type = "anim", data = {lib = "mp_player_int_uppersalute", anim = "mp_player_int_salute"}},
		}
	},

	{
		name  = 'work',
		label = 'فعالیت',
		items = {
			{label = "مجرم: زانو زدن", type = "anim", data = {lib = "random@arrests@busted", anim = "idle_c"}},
			{label = "ماهی گیری", type = "scenario", data = {anim = "world_human_stand_fishing"}},
			--{label = "پلیس: بررسی زمین", type = "anim", data = {lib = "amb@code_human_police_investigate@idle_b", anim = "idle_f"}},
			--{label = "پلیس: بی سیم", type = "anim", data = {lib = "random@arrests", anim = "generic_radio_chatter"}},
			--{label = "پلیس: حرکت کن", type = "scenario", data = {anim = "WORLD_HUMAN_CAR_PARK_ATTENDANT"}},
			--{label = "پلیس: دوربین شکاری", type = "scenario", data = {anim = "WORLD_HUMAN_BINOCULARS"}},
			{label = "کندن زمین", type = "scenario", data = {anim = "world_human_gardener_plant"}},
			{label = "تعمیر ماشین", type = "anim", data = {lib = "mini@repair", anim = "fixing_a_ped"}},
			{label = "بررسی زمین", type = "scenario", data = {anim = "CODE_HUMAN_MEDIC_KNEEL"}},
			--{label = "Taxi : parler au client", type = "anim", data = {lib = "oddjobs@taxi@driver", anim = "leanover_idle"}},
			--{label = "Taxi : donner la facture", type = "anim", data = {lib = "oddjobs@taxi@cyi", anim = "std_hand_off_ps_passenger"}},
			--{label = "Epicier : donner les courses", type = "anim", data = {lib = "mp_am_hold_up", anim = "purchase_beerbox_shopkeeper"}},
			--{label = "Barman : servir un shot", type = "anim", data = {lib = "mini@drinking", anim = "shots_barman_b"}},
			--{label = "Journaliste : Prendre une photo", type = "scenario", data = {anim = "WORLD_HUMAN_PAPARAZZI"}},
			{label = "بررسی دفتر", type = "scenario", data = {anim = "WORLD_HUMAN_CLIPBOARD"}},
			{label = "چکش زدن", type = "scenario", data = {anim = "WORLD_HUMAN_HAMMERING"}},
			{label = "گدایی", type = "scenario", data = {anim = "WORLD_HUMAN_BUM_FREEWAY"}},
			{label = "مجسمه", type = "scenario", data = {anim = "WORLD_HUMAN_HUMAN_STATUE"}},
		}
	},

	{
		name  = 'humors',
		label = 'شکلک',
		items = {
			{label = "دست زدن", type = "scenario", data = {anim = "WORLD_HUMAN_CHEERING"}},
			{label = "آفرین", type = "anim", data = {lib = "mp_action", anim = "thanks_male_06"}},
			{label = "هی تو", type = "anim", data = {lib = "gestures@m@standing@casual", anim = "gesture_point"}},
			{label = "بیا", type = "anim", data = {lib = "gestures@m@standing@casual", anim = "gesture_come_here_soft"}}, 
			{label = "چی میگی؟", type = "anim", data = {lib = "gestures@m@standing@casual", anim = "gesture_bring_it_on"}},
			{label = "من!!!", type = "anim", data = {lib = "gestures@m@standing@casual", anim = "gesture_me"}},
			{label = "دزدی از قفسه", type = "anim", data = {lib = "anim@am_hold_up@male", anim = "shoplift_high"}},
			--{label = "الکی ایستادن", type = "scenario", data = {lib = "amb@world_human_jog_standing@male@idle_b", anim = "idle_d"}},
			---{label = "Je suis dans la merde", type = "scenario", data = {lib = "amb@world_human_bum_standing@depressed@idle_a", anim = "idle_a"}},
			{label = "آخه این چی بود؟", type = "anim", data = {lib = "anim@mp_player_intcelebrationmale@face_palm", anim = "face_palm"}},
			{label = "آرام باش", type = "anim", data = {lib = "gestures@m@standing@casual", anim = "gesture_easy_now"}},
			{label = "چیکار میکنی؟", type = "anim", data = {lib = "oddjobs@assassinate@multi@", anim = "react_big_variations_a"}},
			{label = "نهههههههه", type = "anim", data = {lib = "amb@code_human_cower_stand@male@react_cowering", anim = "base_right"}},
			{label = "دلت کتک میخوادا", type = "anim", data = {lib = "anim@deathmatch_intros@unarmed", anim = "intro_male_unarmed_e"}},
			{label = "ای بابا!!", type = "anim", data = {lib = "gestures@m@standing@casual", anim = "gesture_damn"}},
			--{label = "Enlacer", type = "anim", data = {lib = "mp_ped_interaction", anim = "kisses_guy_a"}},
			{label = "فحش", type = "anim", data = {lib = "mp_player_int_upperfinger", anim = "mp_player_int_finger_01_enter"}},
			--{label = "Branleur", type = "anim", data = {lib = "mp_player_int_upperwank", anim = "mp_player_int_wank_01"}},
			{label = "بای", type = "anim", data = {lib = "mp_suicide", anim = "pistol"}},
		}
	},

	{
		name  = 'sports',
		label = 'ورزشی',
		items = {
			--{label = "Montrer ses muscles", type = "anim", data = {lib = "amb@world_human_muscle_flex@arms_at_side@base", anim = "base"}},
			--{label = "Barre de musculation", type = "anim", data = {lib = "amb@world_human_muscle_free_weights@male@barbell@base", anim = "base"}},
			{label = "شنا", type = "anim", data = {lib = "amb@world_human_push_ups@male@base", anim = "base"}},
			{label = "دراز نشست", type = "anim", data = {lib = "amb@world_human_sit_ups@male@base", anim = "base"}},
			{label = "یوگا", type = "anim", data = {lib = "amb@world_human_yoga@male@base", anim = "base_a"}},
		}
	},

	{
		name  = 'misc',
		label = 'غیره',
		items = {
			--{label = "Boire un café", type = "anim", data = {lib = "amb@world_human_aa_coffee@idle_a", anim = "idle_a"}},
			{label = "کار با گوشی نشسته", type = "anim", data = {lib = "anim@heists@prison_heistunfinished_biztarget_idle", anim = "target_idle"}},
			{label = "کار با گوشی ایستاده", type = "scenario", data = {anim = "world_human_leaning"}},
			{label = "دراز کشیدن", type = "scenario", data = {anim = "WORLD_HUMAN_SUNBATHE_BACK"}},
			{label = "دمر خوابیدن", type = "scenario", data = {anim = "WORLD_HUMAN_SUNBATHE"}},
			{label = "پاک کردن شیشه", type = "scenario", data = {anim = "world_human_maid_clean"}},
			{label = "کباب درست کردن", type = "scenario", data = {anim = "PROP_HUMAN_BBQ"}},
			--{label = "Position de Fouille", type = "anim", data = {lib = "mini@prostitutes@sexlow_veh", anim = "low_car_bj_to_prop_female"}},
			{label = "سلفی", type = "scenario", data = {anim = "world_human_tourist_mobile"}},
			{label = "فال گوش", type = "anim", data = {lib = "mini@safe_cracking", anim = "idle_base"}}, 
		}
	},

	-- {
		-- name  = 'attitudem',
		-- label = 'Attitudes',
		-- items = {
			-- {label = "Normal M", type = "attitude", data = {lib = "move_m@confident", anim = "move_m@confident"}},
			-- {label = "Normal F", type = "attitude", data = {lib = "move_f@heels@c", anim = "move_f@heels@c"}},
			-- {label = "Depressif", type = "attitude", data = {lib = "move_m@depressed@a", anim = "move_m@depressed@a"}},
			-- {label = "Depressif F", type = "attitude", data = {lib = "move_f@depressed@a", anim = "move_f@depressed@a"}},
			-- {label = "Business", type = "attitude", data = {lib = "move_m@business@a", anim = "move_m@business@a"}},
			-- {label = "Determine", type = "attitude", data = {lib = "move_m@brave@a", anim = "move_m@brave@a"}},
			-- {label = "Casual", type = "attitude", data = {lib = "move_m@casual@a", anim = "move_m@casual@a"}},
			-- {label = "Trop mange", type = "attitude", data = {lib = "move_m@fat@a", anim = "move_m@fat@a"}},
			-- {label = "Hipster", type = "attitude", data = {lib = "move_m@hipster@a", anim = "move_m@hipster@a"}},
			-- {label = "Blesse", type = "attitude", data = {lib = "move_m@injured", anim = "move_m@injured"}},
			-- {label = "Intimide", type = "attitude", data = {lib = "move_m@hurry@a", anim = "move_m@hurry@a"}},
			-- {label = "Hobo", type = "attitude", data = {lib = "move_m@hobo@a", anim = "move_m@hobo@a"}},
			-- {label = "Malheureux", type = "attitude", data = {lib = "move_m@sad@a", anim = "move_m@sad@a"}},
			-- {label = "Muscle", type = "attitude", data = {lib = "move_m@muscle@a", anim = "move_m@muscle@a"}},
			-- {label = "Choc", type = "attitude", data = {lib = "move_m@shocked@a", anim = "move_m@shocked@a"}},
			-- {label = "Sombre", type = "attitude", data = {lib = "move_m@shadyped@a", anim = "move_m@shadyped@a"}},
			-- {label = "Fatigue", type = "attitude", data = {lib = "move_m@buzzed", anim = "move_m@buzzed"}},
			-- {label = "Pressee", type = "attitude", data = {lib = "move_m@hurry_butch@a", anim = "move_m@hurry_butch@a"}},
			-- {label = "Fier", type = "attitude", data = {lib = "move_m@money", anim = "move_m@money"}},
			-- {label = "Petite course", type = "attitude", data = {lib = "move_m@quick", anim = "move_m@quick"}},
			-- {label = "Mangeuse d'homme", type = "attitude", data = {lib = "move_f@maneater", anim = "move_f@maneater"}},
			-- {label = "Impertinent", type = "attitude", data = {lib = "move_f@sassy", anim = "move_f@sassy"}},	
			-- {label = "Arrogante", type = "attitude", data = {lib = "move_f@arrogant@a", anim = "move_f@arrogant@a"}},
		-- }
	-- },
	-- {
		-- name  = 'porn',
		-- label = 'PEGI 21',
		-- items = {
			-- {label = "Homme se faire su*** en voiture", type = "anim", data = {lib = "oddjobs@towing", anim = "m_blow_job_loop"}},
			-- {label = "Femme faire une gaterie en voiture", type = "anim", data = {lib = "oddjobs@towing", anim = "f_blow_job_loop"}},
			-- {label = "Homme bais** en voiture", type = "anim", data = {lib = "mini@prostitutes@sexlow_veh", anim = "low_car_sex_loop_player"}},
			-- {label = "Femme bais** en voiture", type = "anim", data = {lib = "mini@prostitutes@sexlow_veh", anim = "low_car_sex_loop_female"}},
			-- {label = "Se gratter les couilles", type = "anim", data = {lib = "mp_player_int_uppergrab_crotch", anim = "mp_player_int_grab_crotch"}},
			-- {label = "Faire du charme", type = "anim", data = {lib = "mini@strip_club@idles@stripper", anim = "stripper_idle_02"}},
			-- {label = "Pose michto", type = "scenario", data = {anim = "WORLD_HUMAN_PROSTITUTE_HIGH_CLASS"}},
			-- {label = "Montrer sa poitrine", type = "anim", data = {lib = "mini@strip_club@backroom@", anim = "stripper_b_backroom_idle_b"}},
			-- {label = "Strip Tease 1", type = "anim", data = {lib = "mini@strip_club@lap_dance@ld_girl_a_song_a_p1", anim = "ld_girl_a_song_a_p1_f"}},
			-- {label = "Strip Tease 2", type = "anim", data = {lib = "mini@strip_club@private_dance@part2", anim = "priv_dance_p2"}},
			-- {label = "Stip Tease au sol", type = "anim", data = {lib = "mini@strip_club@private_dance@part3", anim = "priv_dance_p3"}},
		-- }
	-- }
}