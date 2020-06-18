Config = {}
Config.Locale = 'en'

Config.MarkerType   = 1
Config.DrawDistance = 100.0
Config.MarkerSize   = {x = 2.0, y = 2.0, z = 1.0}
Config.MarkerColor  = {r = 102, g = 102, b = 204}

Config.BlipHospital = {
	Sprite = 403,
	Color = 2,
	Display = 2,
	Scale = 1.0
}

Config.Price = 1000 -- Edit this to your liking.

Config.EnableUnemployedOnly = true -- If true it will only show Blips to Unemployed Players | false shows it to Everyone.
Config.EnableBlips = true -- If true then it will show blips | false does the Opposite.
Config.EnablePeds = true -- If true then it will add Peds on Markers | false does the Opposite.

Config.Locations = {
	{ x = 452.4, y = -996.63, z = 24.77, heading = 180.9 },
	{ x = 447.36, y = -996.44, z = 24.77, heading = 180.9 },
	{ x = 436.42, y = -996.16, z = 24.78, heading = 180.9 },
	{ x = 431.25, y = -996.14, z = 24.78, heading = 180.9 },
	{ x = 1853.45, y= 3676.62, z = 32.79, heading = 180.9 }
	
}

Config.Zones = {}

for i=1, #Config.Locations, 1 do
	Config.Zones['Shop_' .. i] = {
		Pos   = Config.Locations[i],
		Size  = Config.MarkerSize,
		Color = Config.MarkerColor,
		Type  = Config.MarkerType
	}
end
