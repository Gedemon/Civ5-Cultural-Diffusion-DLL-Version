/*
	Cultural Diffusion (DLL version)
	by Gedemon (2014)
		
*/

--------------------------------------------------------------
-- 
-- Debug settings
INSERT INTO Defines (Name, Value) VALUES ('CULTURE_DEBUG',				0); -- if true will output debug text in the lua.log / firetuner console.
INSERT INTO Defines (Name, Value) VALUES ('CULTURE_DEBUG_SHOW_PLOT',	1); -- if true will show the culture value and coordinate of a plot
INSERT INTO Defines (Name, Value) VALUES ('CULTURE_DEBUG_PERFORMANCE',	0); -- if true will outpout time taken by some functions to the lua.log / firetuner console.
--------------------------------------------------------------
-- 
-- General settings
INSERT INTO Defines (Name, Value) VALUES ('CULTURE_DIFFUSION_ENABLED',		1);	-- Culture diffusion ON/OFF
INSERT INTO Defines (Name, Value) VALUES ('CULTURE_ALLOW_TILE_ACQUISITION', 1);	-- if true, allow civilizations to gain unowned tiles via culture
INSERT INTO Defines (Name, Value) VALUES ('CULTURE_ALLOW_TILE_FLIPPING',	1);	-- if true, allow flipping of tiles from one civ to another (check CULTURE_FLIPPING_RATIO)
INSERT INTO Defines (Name, Value) VALUES ('CULTURE_USE_POLICIES',			1); -- if true, policies will affect culture diffusion
INSERT INTO Defines (Name, Value) VALUES ('CULTURE_MAX_LINES_UI',			5); -- Maximum culture entries shown on tooltip
--------------------------------------------------------------
--
-- Initial culture value in cities
INSERT INTO Defines (Name, Value) VALUES ('CULTURE_CITY_BASE_PRODUCTION',  10); -- default',  10
-- Base culture production factor in cities
INSERT INTO Defines (Name, Value) VALUES ('CULTURE_CITY_FACTOR',	10000);	-- culture value fator used for logarithmic progression (log10)
INSERT INTO Defines (Name, Value) VALUES ('CULTURE_CITY_RATIO',		15);	-- percent of culture value used for sqrt progression
INSERT INTO Defines (Name, Value) VALUES ('CULTURE_OUTPUT_USE_LOG', 0);		-- if true use logarithmic progression (slower), else use sqrt (faster)
------------------------------------------------------------------------------------------------------------------------
--
INSERT INTO Defines (Name, Value) VALUES ('CULTURE_CITY_CAPED_FACTOR',		2000);	-- maxCulture on a city plot',  (population + cityCultureProduction) * CULTURE_CITY_CAPED_FACTOR
INSERT INTO Defines (Name, Value) VALUES ('CULTURE_CITY_CONVERSION_RATE',	50);	-- per10000 rate of foreign culture groups converted in your cities each turn
INSERT INTO Defines (Name, Value) VALUES ('CULTURE_LOST_CITY_CONQUEST',		55);	-- percentage of culture lost by each civs on a city plot on conquest
INSERT INTO Defines (Name, Value) VALUES ('CULTURE_GAIN_CITY_CONQUEST',		75);	-- percentage of the total lost culture gained by the conqueror
------------------------------------------------------------------------------------------------------------------------
--
-- Minimum culture value before a plot can have ownership, ratio applied to change ownership and max distance from city
INSERT INTO Defines (Name, Value) VALUES ('CULTURE_MINIMUM_FOR_ACQUISITION',	300);	-- higher value means more stability (less tile flipping)
INSERT INTO Defines (Name, Value) VALUES ('CULTURE_FLIPPING_RATIO',				65);	-- that percentage of the most important culture group value must be superior of the 2nd CG value for a tile to flip. 50 means the first CG must have more than twice the value of the second CG. 100 means the first CG get the tile immediatly.
INSERT INTO Defines (Name, Value) VALUES ('CULTURE_FLIPPING_RATIO_FEEBLE',		65);	-- not implemented, todo : add a ratio by total value ?
INSERT INTO Defines (Name, Value) VALUES ('CULTURE_FLIPPING_MAX_DISTANCE',		6);		-- max distance from a civ's city a plot may flip (0 means no limit)
INSERT INTO Defines (Name, Value) VALUES ('CULTURE_FLIPPING_ONLY_ADJACENT',		1);		-- flip tile only if adjacent to an already owned tile
INSERT INTO Defines (Name, Value) VALUES ('CULTURE_NO_FORTIFICATION_FLIPPING',	1);		-- fort won't flip from culture, and no flipping around citadelles
INSERT INTO Defines (Name, Value) VALUES ('CULTURE_MINIMAL_ON_OWNED_PLOT',		1);		-- owned plot will have at least that culture value of the owner
------------------------------------------------------------------------------------------------------------------------
--
-- Minimum culture value before a plot start diffusing to normal adjacents plots
INSERT INTO Defines (Name, Value) VALUES ('CULTURE_DIFFUSION_THRESHOLD',  100); -- higher value means slower diffusion
------------------------------------------------------------------------------------------------------------------------
--
-- Minimum culture value before a plot start diffusing to special adjacents plots
-- (percentage of CULTURE_THRESHOLD)
INSERT INTO Defines (Name, Value) VALUES ('CULTURE_CROSS_MOUNTAIN_THRESHOLD',	750);
INSERT INTO Defines (Name, Value) VALUES ('CULTURE_CROSS_MARSH_THRESHOLD',		500);
INSERT INTO Defines (Name, Value) VALUES ('CULTURE_CROSS_JUNGLE_THRESHOLD',		450);
INSERT INTO Defines (Name, Value) VALUES ('CULTURE_CROSS_SNOW_THRESHOLD',		400);
INSERT INTO Defines (Name, Value) VALUES ('CULTURE_CROSS_DESERT_THRESHOLD',		300);
INSERT INTO Defines (Name, Value) VALUES ('CULTURE_CROSS_TUNDRA_THRESHOLD',		250);
INSERT INTO Defines (Name, Value) VALUES ('CULTURE_CROSS_RIVER_THRESHOLD',		200);
INSERT INTO Defines (Name, Value) VALUES ('CULTURE_CROSS_HILLS_THRESHOLD',		150);
INSERT INTO Defines (Name, Value) VALUES ('CULTURE_CROSS_FOREST_THRESHOLD',		125);
------------------------------------------------------------------------------------------------------------------------
--
-- Rate of diffusion
INSERT INTO Defines (Name, Value) VALUES ('CULTURE_DIFFUSION_RATE',  55); --	percentage*10 : if CULTURE_DIFFUSION_RATE = 1000 then diffusion is 100% of diffusing plot value.
--							Defaut is 55',  5,5% diffusion
------------------------------------------------------------------------------------------------------------------------
--
-- Rate of decay
INSERT INTO Defines (Name, Value) VALUES ('CULTURE_DECAY_RATE',  5); -- percentage of culture lost on a plot each turn
------------------------------------------------------------------------------------------------------------------------
--
-- Maximum value of adjacent plot in percent of diffusing plot value
-- Those are factored, for example when following a road and a river from a plot with a culture value of 250
-- Max diffused culture = 250 * (CULTURE_NORMAL_MAX/100) * (CULTURE_FOLLOW_RIVER_MAX/100) * (CULTURE_FOLLOW_ROAD_MAX/100)
-- so bonus tile must be > 100 to act as bonus should, the total will always be capped by (CULTURE_MAX_ADJACENT_PERCENT/100) <- note: reading this 2 years later, I don't understand WTF I wanted to explain here
--
INSERT INTO Defines (Name, Value) VALUES ('CULTURE_MAX_ADJACENT_PERCENT',  75); -- percent
--
INSERT INTO Defines (Name, Value) VALUES ('CULTURE_NORMAL_MAX',  40); -- base percentage, always used
--
INSERT INTO Defines (Name, Value) VALUES ('CULTURE_FOLLOW_RIVER_MAX',	180);
INSERT INTO Defines (Name, Value) VALUES ('CULTURE_FOLLOW_ROAD_MAX',	250);
--
INSERT INTO Defines (Name, Value) VALUES ('CULTURE_CROSS_FOREST_MAX',	80);
INSERT INTO Defines (Name, Value) VALUES ('CULTURE_CROSS_HILLS_MAX',	60);
INSERT INTO Defines (Name, Value) VALUES ('CULTURE_CROSS_TUNDRA_MAX',	40);
INSERT INTO Defines (Name, Value) VALUES ('CULTURE_CROSS_RIVER_MAX',	35);
INSERT INTO Defines (Name, Value) VALUES ('CULTURE_CROSS_DESERT_MAX',	30);
INSERT INTO Defines (Name, Value) VALUES ('CULTURE_CROSS_SNOW_MAX',		25);
INSERT INTO Defines (Name, Value) VALUES ('CULTURE_CROSS_JUNGLE_MAX',	20);
INSERT INTO Defines (Name, Value) VALUES ('CULTURE_CROSS_MARSH_MAX',	20);
INSERT INTO Defines (Name, Value) VALUES ('CULTURE_CROSS_MOUNTAIN_MAX',	10);
------------------------------------------------------------------------------------------------------------------------
--
-- Rate of diffusion modifiers
-- Malus, 100',  halve the diffusion rate
INSERT INTO Defines (Name, Value) VALUES ('CULTURE_CROSS_FOREST_PENALTY',	10); -- percentage
INSERT INTO Defines (Name, Value) VALUES ('CULTURE_CROSS_HILLS_PENALTY',	15); -- percentage
INSERT INTO Defines (Name, Value) VALUES ('CULTURE_CROSS_TUNDRA_PENALTY',	25); -- percentage
INSERT INTO Defines (Name, Value) VALUES ('CULTURE_CROSS_RIVER_PENALTY',	50); -- percentage
INSERT INTO Defines (Name, Value) VALUES ('CULTURE_CROSS_DESERT_PENALTY',	55); -- percentage
INSERT INTO Defines (Name, Value) VALUES ('CULTURE_CROSS_SNOW_PENALTY',		55); -- percentage
INSERT INTO Defines (Name, Value) VALUES ('CULTURE_CROSS_JUNGLE_PENALTY',	60); -- percentage
INSERT INTO Defines (Name, Value) VALUES ('CULTURE_CROSS_MARSH_PENALTY',	65); -- percentage
INSERT INTO Defines (Name, Value) VALUES ('CULTURE_CROSS_MOUNTAIN_PENALTY',	75); -- percentage
--
-- Bonus, 100',  double the diffusion rate
INSERT INTO Defines (Name, Value) VALUES ('CULTURE_FOLLOW_RIVER_BONUS',  65); -- percentage
INSERT INTO Defines (Name, Value) VALUES ('CULTURE_FOLLOW_ROAD_BONUS',  100); -- percentage

------------------------------------------------------------------------------------------------------------------------
--
-- Culture on tile conquest (military unit entering a plot belonging to a civ it's at war with)
--
INSERT INTO Defines (Name, Value) VALUES ('CULTURE_CONQUEST_ENABLED',			1);		-- allow the use of military culture conquest
INSERT INTO Defines (Name, Value) VALUES ('CULTURE_MINIMAL_FOR_CONQUEST',		150);	-- minimum value of the unit culture on the plot to allow flipping. Overriden by CULTURE_CONQUEST_EVEN_NONE', 1);
INSERT INTO Defines (Name, Value) VALUES ('CULTURE_CONQUEST_EVEN_LOWER',		1);		-- conquest tile even without having more culture on it than it's current owner
INSERT INTO Defines (Name, Value) VALUES ('CULTURE_CONQUEST_EVEN_NONE',			1);		-- conquest tile even without having any culture on it. CULTURE_CONQUEST_EVEN_LOWER must be set to true if you want to activate this one
INSERT INTO Defines (Name, Value) VALUES ('CULTURE_LOCKED_TURN_ON_CONQUEST',	15);	-- number of turns the tile is locked when conquered
INSERT INTO Defines (Name, Value) VALUES ('CULTURE_CONQUEST_ONLY_ADJACENT',		1);		-- conquest tile only if adjacent to an already owned tile
INSERT INTO Defines (Name, Value) VALUES ('CULTURE_LOCK_FLIPPING_ON_WAR',		1);		-- prevent cultural tile flipping between 2 civilizations at war
INSERT INTO Defines (Name, Value) VALUES ('CULTURE_LOST_PLOT_CONQUEST',			10);	-- percentage of culture lost by each civs on a plot on conquest
INSERT INTO Defines (Name, Value) VALUES ('CULTURE_GAIN_PLOT_CONQUEST',			50);	-- percentage of the total lost culture gained by the conqueror

------------------------------------------------------------------------------------------------------------------------
--
-- Policies modifier
INSERT INTO Defines (Name, Value) VALUES ('CULTURE_TRADITION_OPENER_CONVERTION_RATE',	50);	-- per10000 rate of culture converted to plot owner each turn for tradition opener
INSERT INTO Defines (Name, Value) VALUES ('CULTURE_TRADITION_FINISHER_CONVERTION_RATE', 50);	-- per10000 rate of culture converted to plot owner each turn for tradition finisher
INSERT INTO Defines (Name, Value) VALUES ('CULTURE_SOCIALIST_REALISM_CONVERTION_RATE',  150);	-- per10000 rate of culture converted to plot owner each turn for socialist realism (BNW)
INSERT INTO Defines (Name, Value) VALUES ('CULTURE_MEDIA_CULTURE_CONVERTION_RATE',		175);	-- per10000 rate of culture converted to plot owner each turn for media culture (BNW)
INSERT INTO Defines (Name, Value) VALUES ('CULTURE_NATIONALISM_CONVERTION_RATE',		125);	-- per10000 rate of culture converted to plot owner each turn for nationalism (BNW)

INSERT INTO Defines (Name, Value) VALUES ('CULTURE_LIBRARY_CONVERTION_RATE',		25);	-- per10000 rate of culture converted to city owner each turn for library
INSERT INTO Defines (Name, Value) VALUES ('CULTURE_UNIVERSITY_CONVERTION_RATE',		50);	-- per10000 rate of culture converted to city owner each turn for university
INSERT INTO Defines (Name, Value) VALUES ('CULTURE_PUBLIC_SCHOOL_CONVERTION_RATE',  100);	-- per10000 rate of culture converted to city owner each turn for Public School

------------------------------------------------------------------------------------------------------------------------
--
-- Improvement and units modifier
INSERT INTO Defines (Name, Value) VALUES ('CULTURE_IMPROVEMENT_CONVERTION_RATE',	10);	-- per10000 rate of convertion to plot owner each turn for improvements yielding culture (multiplied by yield)
INSERT INTO Defines (Name, Value) VALUES ('CULTURE_UNIT_CONVERTION_RATE',			5);		-- per10000 rate of convertion to unit owner each turn for units providing culture (multiplied by BaseCultureTurnsToCount)

------------------------------------------------------------------------------------------------------------------------
--
-- Revolution Mod
--
INSERT INTO Defines (Name, Value) VALUES ('CULTURE_SEPARATIST_TYPE',  'SEPARATIST'); -- culture type used for separatist

INSERT OR REPLACE INTO Defines (Name, Value) VALUES ('THRESHOLD_JOYFUL', 200); -- Relation thresholds (max value, ex: 95 = Joyful, -60 = Unhappy)
INSERT OR REPLACE INTO Defines (Name, Value) VALUES ('THRESHOLD_HAPPY', 75);
INSERT OR REPLACE INTO Defines (Name, Value) VALUES ('THRESHOLD_CONTENT', 10);
INSERT OR REPLACE INTO Defines (Name, Value) VALUES ('THRESHOLD_UNHAPPY', -10);
INSERT OR REPLACE INTO Defines (Name, Value) VALUES ('THRESHOLD_WOEFUL', -125);
INSERT OR REPLACE INTO Defines (Name, Value) VALUES ('THRESHOLD_EXASPERATED', -300);