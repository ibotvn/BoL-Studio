local LocalVersion = "1.31"
local autoupdate = true -- Change to false if you don't want autoupdates.
local RangeSmite = 560

	if myHero:GetSpellData(SUMMONER_1).name:find("SummonerSmite") then Smite = SUMMONER_1 elseif myHero:GetSpellData(SUMMONER_2).name:find("SummonerSmite") then Smite = SUMMONER_2 end

	PrintChat("<font color=\"#415cf6\"><b>[HR Smite] </b></font>".."<font color=\"#01cc9c\"><b>Loaded.</b></font>")	
	if Smite ~= nil then
	PrintChat("<font color=\"#415cf6\"><b>[HR Smite] </b></font>".."<font color=\"#01cc9c\"><b>Smite found.</b></font>")
	else
	PrintChat("<font color=\"#415cf6\"><b>[HR Smite] </b></font>".."<font color=\"#01cc9c\"><b>Smite not found.</b></font>")	
	return
	end

-- START: BOL TOOLS.
assert(load(Base64Decode("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"), nil, "bt", _ENV))()
TrackerLoad("Lq4Urk4cSpXgYgzv")
-- END: BOL TOOLS.

function OnLoad()

	jungleMinions = minionManager(MINION_JUNGLE, RangeSmite, myHero, MINION_SORT_MAXHEALTH_DEC)
	MenuInit()
	FindUpdates()
end

function MenuInit()
	Menu = scriptConfig("HR Smite", "HRSmite")
	
	Menu:addParam("SmiteActive", "Smite Active", SCRIPT_PARAM_ONKEYTOGGLE, true, 76)

	Menu:addSubMenu("Smite Monsters:", "smitethat")
    Menu.smitethat:addParam("Dragon", "Use Smite on: Dragon", SCRIPT_PARAM_ONOFF, true)
    Menu.smitethat:addParam("SRUBaron", "Use Smite on: Baron", SCRIPT_PARAM_ONOFF, true)
    Menu.smitethat:addParam("SRURazorbeak", "Use Smite on: Wraith", SCRIPT_PARAM_ONOFF, false)
    Menu.smitethat:addParam("SRUMurkwolf", "Use Smite on: Wolf", SCRIPT_PARAM_ONOFF, false)
    Menu.smitethat:addParam("SRUKrug", "Use Smite on: Krug", SCRIPT_PARAM_ONOFF, false)
    Menu.smitethat:addParam("SRUGromp", "Use Smite on: Gromp", SCRIPT_PARAM_ONOFF, false)
    Menu.smitethat:addParam("SRURed", "Use Smite on: Red", SCRIPT_PARAM_ONOFF, true)
    Menu.smitethat:addParam("SRUBlue", "Use Smite on: Blue", SCRIPT_PARAM_ONOFF, true)

	Menu:addSubMenu("Draw Options:", "drawing")
    Menu.drawing:addParam("rangeSmite", "Range Smite", SCRIPT_PARAM_ONOFF, true)
    Menu.drawing:addParam("SRUDragon", "Draw Smite damage in: Dragon", SCRIPT_PARAM_ONOFF, true)
    Menu.drawing:addParam("SRUBaron", "Draw Smite damage in: Baron", SCRIPT_PARAM_ONOFF, true)
    Menu.drawing:addParam("SRURazorbeak", "Draw Smite damage in: Wraith", SCRIPT_PARAM_ONOFF, true)
    Menu.drawing:addParam("SRUMurkwolf", "Draw Smite damage in: Wolf", SCRIPT_PARAM_ONOFF, true)
    Menu.drawing:addParam("SRUKrug", "Draw Smite damage in: Krug", SCRIPT_PARAM_ONOFF, true)
    Menu.drawing:addParam("SRUGromp", "Draw Smite damage in: Gromp", SCRIPT_PARAM_ONOFF, true)
    Menu.drawing:addParam("SRURed", "Draw Smite damage in: Red", SCRIPT_PARAM_ONOFF, true)
    Menu.drawing:addParam("SRUBlue", "Draw Smite damage in: Blue", SCRIPT_PARAM_ONOFF, true)

    DelayAction(function() Menu:permaShow("SmiteActive") end, 5.0)
end

function GetSmiteDamage()
	local SmiteDamage
	if myHero.level <= 4 then
		SmiteDamage = 370 + (myHero.level*20)
	end
	if myHero.level > 4 and myHero.level <= 9 then
		SmiteDamage = 330 + (myHero.level*30)
	end
	if myHero.level > 9 and myHero.level <= 14 then
		SmiteDamage = 240 + (myHero.level*40)
	end
	if myHero.level > 14 then
		SmiteDamage = 100 + (myHero.level*50)
	end
	return SmiteDamage
end

function GetDamageSpell()
	local SpellDamage

	if myHero.charName == "Chogath" then
	SpellDamage = 1000 + (0.7*myHero.ap)
	end

	if myHero.charName == "Nunu" then
	QLevel = myHero:GetSpellData(_Q).level
	if QLevel == 1 then
		SpellDamage = 400
	elseif QLevel == 2 then
		SpellDamage = 550
	elseif QLevel == 3 then
		SpellDamage = 700
	elseif QLevel == 4 then
		SpellDamage = 850
	elseif QLevel == 5 then
		SpellDamage = 1000
	end
	end



	return SpellDamage
end

function Spell()
	local Spell
	if myHero.charName == "Chogath" then Spell = _R
	elseif myHero.charName == "Nunu" then Spell = _Q
	else Spell = nil end
	return Spell
end

function OnTick()
	if myHero.dead then return end
	jungleMinions:update()
	CheckJungle()
end

function CheckJungle()
	if Menu.SmiteActive then
	for i, jungle in pairs(jungleMinions.objects) do
	if jungle ~= nil then
	if jungle.charName:find("Dragon") and Menu.smitethat.Dragon then
	if myHero.charName == "Chogath" or myHero.charName == "Nunu" then
	ComboMonster(jungle)
	else
	SmiteMonster(jungle)
	end
	end
	if Menu.smitethat[jungle.charName:gsub("_", "")] then
	if myHero.charName == "Chogath" or myHero.charName == "Nunu" then
	ComboMonster(jungle)
	else
	SmiteMonster(jungle)
end
end
end
end   
end
end

function SmiteMonster(obj)
    local DistanceMonster = GetDistance(obj)
    if myHero:CanUseSpell(Smite) == READY and DistanceMonster <= RangeSmite and obj.health <= GetSmiteDamage() then
    CastSpell(Smite, obj)
    end
end

function ComboMonster(obj)
    local DistanceMonster = GetDistance(obj)
    if myHero:CanUseSpell(Smite) == READY and myHero:CanUseSpell(Spell()) == READY then
    if DistanceMonster <= RangeSmite and obj.health <= GetSmiteDamage() + GetDamageSpell() then
	CastSpell(Spell(), obj)
	end
	return
	end

	if myHero:CanUseSpell(Smite) == READY then
    if DistanceMonster <= RangeSmite and obj.health <= GetSmiteDamage() then
    CastSpell(Smite, obj)
    end

	elseif myHero:CanUseSpell(Spell()) == READY then
    if DistanceMonster <= RangeSmite and obj.health <= GetDamageSpell() then
	CastSpell(Spell(), obj)
	end
	end
end

function OnDraw()
	if myHero.dead then return end
	for i, jungle in pairs(jungleMinions.objects) do
	if jungle ~= nil then
    if Menu.drawing[jungle.charName:gsub("_", "")] then
    MonsterDraw(jungle)
    end
	end
	end

	if Menu.drawing.rangeSmite and myHero:CanUseSpell(Smite) == READY and Menu.SmiteActive then
	DrawCircle(myHero.x, myHero.y, myHero.z, RangeSmite,ARGB(100,0,252,255))
	end

end

function MonsterDraw(minion)
        local barPos = GetUnitHPBarPos(minion)
        barPos.x = math.floor(barPos.x - 32)
        barPos.y = math.floor(barPos.y - 3)
        local maxDistance = 62
        if minion.charName:find("Dragon") then
        barPos.x = barPos.x - 31
        barPos.y = barPos.y - 7
        maxDistance = 124
        elseif minion.charName == "SRU_Baron" then
        barPos.x = barPos.x - 31
        maxDistance = 124
        end
        local SmiteDistance = GetSmiteDamage() / minion.maxHealth * maxDistance
        local alphaSmite = (myHero:CanUseSpell(Smite) == READY and Menu.SmiteActive and GetDistance(minion) <= RangeSmite) and 255 or 100

        DrawRectangle(barPos.x + SmiteDistance - 8, barPos.y - 10, 20, 10, ARGB(alphaSmite,0,0,0))
        DrawText(tostring(GetSmiteDamage()), 11, barPos.x + SmiteDistance - 6, barPos.y - 11, ARGB(alphaSmite,0,252,255))

        if Spell() ~= nil then 
		if myHero:CanUseSpell(Spell()) == READY and myHero:CanUseSpell(Smite) == READY and minion.health <= GetSmiteDamage() + GetDamageSpell() then
        DrawText("Use "..Spell().." + Smite", 15, barPos.x - 50 , barPos.y - 30, ARGB(alphaSmite,0,252,255))
    	elseif myHero:CanUseSpell(Spell()) == READY and minion.health <= GetDamageSpell() then
        DrawText("Use "..Spell(), 15, barPos.x - 35 , barPos.y - 30, ARGB(alphaSmite,0,252,255))
    	elseif myHero:CanUseSpell(Smite) == READY and minion.health <= GetSmiteDamage() then
        DrawText("Use Smite", 15, barPos.x - 35 , barPos.y - 30, ARGB(alphaSmite,0,252,255))
    	end
    	
   	    else
   	    if minion.health <= GetSmiteDamage() then
        DrawText("Use Smite", 15, barPos.x - 35 , barPos.y - 30, ARGB(255,0,252,255))
        end
    end
end

local serveradress = "raw.githubusercontent.com"
local scriptadress = "/HiranN/BoL/master"
	function FindUpdates()
	if not autoupdate then return end
	local ServerVersionDATA = GetWebResult(serveradress , scriptadress.."/HR Smite.version")
	if ServerVersionDATA then
		local ServerVersion = tonumber(ServerVersionDATA)
		if ServerVersion then
			if ServerVersion > tonumber(LocalVersion) then
			PrintChat("<font color=\"#415cf6\"><b>[HR Smite] </b></font>".."<font color=\"#01cc9c\"><b>Updating, don't press F9.</b></font>")
			Update()
			else
			PrintChat("<font color=\"#415cf6\"><b>[HR Smite] </b></font>".."<font color=\"#01cc9c\"><b>You have the latest version.</b></font>")
			end
		else
		PrintChat("<font color=\"#415cf6\"><b>[HR Smite] </b></font>".."<font color=\"#01cc9c\"><b>An error occured, while updating, please reload.</b></font>")
		end
	else
	PrintChat("<font color=\"#415cf6\"><b>[HR Smite] </b></font>".."<font color=\"#01cc9c\"><b>Could not connect to update Server.</b></font>")
	end
end

function Update()
	DownloadFile("http://"..serveradress..scriptadress.."/HR Smite.lua",SCRIPT_PATH.."HR Smite.lua", function ()
	PrintChat("<font color=\"#415cf6\"><b>[HR Smite] </b></font>".."<font color=\"#01cc9c\"><b>Updated, press 2xF9.</b></font>")
	end)
end

--[[TITLE|HR Smite.lua|TITLE]]--
--[[USER|HiranN|USER]]--
--[[TYPE|Free|TYPE]]--
--[[LINKS|https://raw.githubusercontent.com/HiranN/BoL/master/HR Smite.lua|LINKS]]--
