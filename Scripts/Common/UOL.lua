--[[
  _    _       _  __ _          _    ____       _                  _ _               _ _ _
 | |  | |     (_)/ _(_)        | |  / __ \     | |                | | |             | (_) |
 | |  | |_ __  _| |_ _  ___  __| | | |  | |_ __| |____      ____ _| | | _____ _ __  | |_| |__  _ __ __ _ _ __ _   _ 
 | |  | | '_ \| |  _| |/ _ \/ _` | | |  | | '__| '_ \ \ /\ / / _` | | |/ / _ \ '__| | | | '_ \| '__/ _` | '__| | | |
 | |__| | | | | | | | |  __/ (_| | | |__| | |  | |_) \ V  V / (_| | |   <  __/ |    | | | |_) | | | (_| | |  | |_| |
  \____/|_| |_|_|_| |_|\___|\__,_|  \____/|_|  |_.__/ \_/\_/ \__,_|_|_|\_\___|_|    |_|_|_.__/|_|  \__,_|_|   \__, |
                                                                                                               __/ |
                                                                                                              |___/
  By Nebelwolfi

]]--

class "UOL"

--Scriptstatus tracker (usercounter)
assert(load(Base64Decode("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"), nil, "bt", _ENV))()
TrackerLoad("Oa2u5AWkbJkT7ecr")
--Scriptstatus tracker (usercounter)

UOLautoupdate = true
UOLversion = 1.10

function UOL:__init()
  if not _G.UOLloaded then
    self:Update()
    self:Loaded()
    return self
  end
end

function crequire(x)
  if FileExist(LIB_PATH..x..".lua") then
    require(x)
    return true
  else
    print("Missing library: "..x..". Downloading.....")
    return false
  end
end

function UOL:Msg(msg)
  print("<font color=\"#ff0000\">[</font><font color=\"#ff1900\">U</font><font color=\"#ff3300\">n</font><font color=\"#ff4c00\">i</font><font color=\"#ff6600\">f</font><font color=\"#ff7f00\">i</font><font color=\"#ff9f00\">e</font><font color=\"#ffbf00\">d</font><font color=\"#ffdf00\"> </font><font color=\"#ffff00\">O</font><font color=\"#ccff00\">r</font><font color=\"#99ff00\">b</font><font color=\"#66ff00\">w</font><font color=\"#33ff00\">a</font><font color=\"#00ff00\">l</font><font color=\"#00ff40\">k</font><font color=\"#00ff80\">e</font><font color=\"#00ffbf\">r</font><font color=\"#00ffff\"> </font><font color=\"#00ccff\">L</font><font color=\"#0099ff\">i</font><font color=\"#0066ff\">b</font><font color=\"#0033ff\">r</font><font color=\"#0000ff\">a</font><font color=\"#2300ff\">r</font><font color=\"#4600ff\">y</font><font color=\"#6800ff\">]</font><font color=\"#8b00ff\">:</font> <font color=\"#FFFFFF\">"..msg.."</font>") 
end

function UOL:Update()
  local UOL_UPDATE_HOST = "raw.githubusercontent.com"
  local UOL_UPDATE_PATH = "/nebelwolfi/BoL/master/Common/UOL.lua"
  local UOL_UPDATE_FILE_PATH = LIB_PATH.."UOL.lua"
  local UOL_UPDATE_URL = "https://"..UOL_UPDATE_HOST..UOL_UPDATE_PATH
  if UOLautoupdate then
    local UOLServerData = GetWebResult(UOL_UPDATE_HOST, "/nebelwolfi/BoL/master/Common/UOL.version")
    if UOLServerData then
      UOLServerVersion = type(tonumber(UOLServerData)) == "number" and tonumber(UOLServerData) or nil
      if UOLServerVersion then
        if tonumber(UOLversion) < UOLServerVersion then
          self:Msg("New version available v"..UOLServerVersion)
          self:Msg("Updating, please don't press F9")
          DelayAction(function() DownloadFile(UOL_UPDATE_URL, UOL_UPDATE_FILE_PATH, function () self:Msg("Successfully updated. ("..UOLversion.." => "..UOLServerVersion.."), press F9 twice to load the updated version") end) end, 3)
          return true
        end
      end
    else
      self:Msg("Error downloading version info")
    end
  end
  return false
end

function UOL:Loaded()
  self:Msg("Loaded!")
  UOLloaded = true
end

function UOL:AddToMenu(scI)
  DelayAction(function()
    if _G.Reborn_Loaded or _G.AutoCarry then
      local function IsSACLoadedNow()
        if _G.AutoCarry then
          isSAC = true
        else
          DelayAction(IsSACLoadedNow, 1)
        end
      end
      IsSACLoadedNow()
      scI:addParam("d", "SAC Detected", SCRIPT_PARAM_INFO, "")
    elseif _Pewalk then
      isPEW = true
      scI:addParam("d", "Pewalk Detected", SCRIPT_PARAM_INFO, "")
    elseif _G.MMA_Loaded or _G.MMA_Version then
      isMMA = true
      scI:addParam("d", "MMA Detected", SCRIPT_PARAM_INFO, "")
    elseif _G.NebelwolfisOrbWalkerInit or _G.NebelwolfisOrbWalkerLoaded then
      isNOW = true
      scI:addParam("d", "NOW Detected", SCRIPT_PARAM_INFO, "")
    else
      scI:addParam("o", "Choose Orbwalker", SCRIPT_PARAM_LIST, 1, {"Nebelwolfi's Orb Walker", "SxOrbWalk", "Simple OrbWalker", "Big Fat OrbWalker"})
      scI:addParam("e", "Enable Orbwalker", SCRIPT_PARAM_ONOFF, false)
      scI:setCallback("e", function(var) if var and not (isNOW or isSOW or isBFW or isSxOrb) then self:LoadOrb(scI.o) else self:UnloadOrb() end end)
      self.scI = scI
      if scI.e then self:LoadOrb(scI.o) end
    end
  end, 0.25)
end

function UOL:LoadOrb(i)
  if i == 1 then
    if not crequire "Nebelwolfi's Orb Walker" then 
      DownloadFile("https://raw.githubusercontent.com/nebelwolfi/BoL/master/Common/Nebelwolfi%27s%20Orb%20Walker.lua", LIB_PATH.."Nebelwolfi's Orb Walker.lua", function()
        self:LoadOrb(i)
      end)
      return 
    end
    isNOW = true
    NebelwolfisOrbWalkerClass(self.scI)
  elseif i == 2 then
    if not crequire "SxOrbwalk" then 
      DownloadFile("https://raw.githubusercontent.com/Superx321/BoL/master/common/SxOrbWalk.lua", LIB_PATH.."SxOrbwalk.lua", function()
        self:LoadOrb(i)
      end)
      return 
    end
    isSxOrb = true
    SxOrb:LoadToMenu(self.scI)
  elseif i == 3 then
    if not crequire "SOW" then
      DownloadFile("https://raw.githubusercontent.com/Hellsing/BoL/master/common/SOW.lua", LIB_PATH.."SOW.lua", function()
        self:LoadOrb(i)
      end)
      return
    end
    if not crequire "VPrediction" then 
      DownloadFile("https://raw.githubusercontent.com/SidaBoL/Scripts/master/Common/VPrediction.lua", LIB_PATH.."VPrediction.lua", function()
        self:LoadOrb(i)
      end)
      return
    end
    isSOW = true
    _G.VP = VPrediction()
    SOWVP = SOW(VP)
    SOWVP:LoadToMenu(self.scI)
  elseif i == 4 then
    if not crequire "Big Fat Orbwalker" then 
      DownloadFile("https://raw.githubusercontent.com/BigFatNidalee/BoL-Releases/master/LimitedAccess/Big%20Fat%20Orbwalker.lua", LIB_PATH.."Big%20Fat%20Orbwalker.lua", function()
        self:LoadOrb(i)
      end)
      return 
    end
    _G["BigFatOrb_DisableAttacks"] = false
    _G["BigFatOrb_DisableMove"] = false
    isBFW = true
  end
end

function UOL:GetActiveOrb()
    return isPEW and "Pewalk" or isSAC and "SAC" or isMMA and "MMA" or isNOW and "NOW" or isSxOrb and "SxOrb" or isSOW and "SOW" or isBFW and "BFW" or ""
end

function UOL:UnloadOrb()
  if not (isNOW or isSOW or isBFW or isSxOrb) then return end
  self:Msg("OrbWalker un-ticked. Press 2x F9 to unload.")
end

function UOL:SetOrb(bool)
  if isSAC then
    _G.AutoCarry.MyHero:MovementEnabled(bool)
    _G.AutoCarry.MyHero:AttacksEnabled(bool)
  elseif isNOW then
    _G.NebelwolfisOrbWalker:SetOrb(bool)
  elseif isPEW then
    _Pewalk.AllowAttack(bool)
    _Pewalk.AllowMove(bool)
  elseif isSxOrb then
    if bool then
      SxOrb:EnableMove()
      SxOrb:EnableAttacks()
    else
      SxOrb:DisableAttacks()
      SxOrb:DisableMove()
    end
  elseif isSOW then
    SOWVP.Attacks = bool
    SOWVP.Move = bool
  elseif isBFW then
    _G["BigFatOrb_DisableMove"] = not bool
    _G["BigFatOrb_DisableAttacks"] = not bool
  elseif isMMA then
    _G.MMA_AvoidMovement(not bool)
    _G.MMA_StopAttacks(not bool)
  end
end

function UOL:SetMovement(bool)
  if isSAC then
    _G.AutoCarry.MyHero:MovementEnabled(bool)
  elseif isNOW then
    _G.NebelwolfisOrbWalker:SetMove(bool)
  elseif isPEW then
    _Pewalk.AllowMove(bool)
  elseif isSxOrb then
    if bool then
      SxOrb:EnableMove()
    else
      SxOrb:DisableMove()
    end
  elseif isSOW then
    SOWVP.Move = bool
  elseif isBFW then
    _G["BigFatOrb_DisableMove"] = not bool
  elseif isMMA then
    _G.MMA_AvoidMovement(not bool)
  end
end

function UOL:SetAttacks(bool)
  if isSAC then
    _G.AutoCarry.MyHero:AttacksEnabled(bool)
  elseif isNOW then
    _G.NebelwolfisOrbWalker:SetAA(bool)
  elseif isPEW then
    _Pewalk.AllowAttack(bool)
  elseif isSxOrb then
    if bool then
      SxOrb:EnableAttacks()
    else
      SxOrb:DisableAttacks()
    end
  elseif isSOW then
    SOWVP.Attacks = bool
  elseif isBFW then
    _G["BigFatOrb_DisableAttacks"] = not bool
  elseif isMMA then
    _G.MMA_StopAttacks(not bool)
  end
end

function UOL:ForceTarget(thing)
  if isSAC then
    _G.AutoCarry.Crosshair:ForceTarget(thing)
  elseif isNOW then
    _G.NebelwolfisOrbWalker:SetTarget(thing)
  elseif isPEW then
    _Pewalk.ForceTarget(thing)
  elseif isSxOrb then
    SxOrb:ForceTarget(thing)
  elseif isSOW then
    SOWVP.forcetarget = thing
  elseif isBFW then
    _G["BigFatOrb_ForcedTarget"] = thing
  elseif isMMA then
    _G.MMA_ForceTarget(thing)
  end
end

function UOL:ForcePosition(pos)
  if isSAC then
    _G.AutoCarry.Orbwalker:OverrideOrbwalkLocation(pos)
  elseif isNOW then
    _G.NebelwolfisOrbWalker:ForcePos(pos)
  elseif isPEW then
    _Pewalk.ForcePoint(pos)
  elseif isSxOrb then
    SxOrb:ForcePoint(pos and pos.x, pos and pos.z)
  elseif isSOW then
    
  elseif isBFW then
    
  elseif isMMA then
    _G.MMA_MoveTo(pos and pos.x, pos and pos.z)
  end
end

function UOL:GetTarget()
  if isSAC then
    return _G.AutoCarry.SkillsCrosshair.target
  elseif isNOW then
    return _G.NebelwolfisOrbWalker:GetTarget()
  elseif isPEW then
    return _Pewalk.GetTarget()
  elseif isSxOrb then
    return SxOrb:EnableAttacks()
  elseif isSOW then
    return SOWVP:GetTarget(true)
  elseif isBFW then
    return Orbwalk_GetTarget()
  elseif isMMA then
    return _G.MMA_Target()
  end
end

function UOL:CanOrb(target)
  if isSAC then
    return _G.AutoCarry.MyHero:CanOrbwalkTarget(target)
  elseif isNOW then
    return _G.NebelwolfisOrbWalker:CanOrbTarget(target)
  elseif isPEW then
    return _Pewalk.ValidTarget(target)
  elseif isSxOrb then
    return SxOrb:EnableAttacks()
  elseif isSOW then
    return SOWVP:ValidTarget(target)
  elseif isBFW then
    return CanMove() and not IsEvading() and ValidTarget(target)
  elseif isMMA then
    return _G.MMA_StopAttacks(not bool)
  end
end

function UOL:CanMove()
  if isSAC then
    return _G.AutoCarry.Orbwalker:CanMove()
  elseif isNOW then
    return _G.NebelwolfisOrbWalker:TimeToMove()
  elseif isPEW then
    return _Pewalk.CanMove()
  elseif isSxOrb then
    return SxOrb:CanMove()
  elseif isSOW then
    return SOWVP:CanMove()
  elseif isBFW then
    return CanMove()
  elseif isMMA then
    return _G.MMA_CanMove
  end
end

function UOL:CanAttack()
  if isSAC then
    return _G.AutoCarry.Orbwalker:CanShoot()
  elseif isNOW then
    return _G.NebelwolfisOrbWalker:TimeToAttack()
  elseif isPEW then
    return _Pewalk.CanAttack()
  elseif isSxOrb then
    return SxOrb:CanAttack()
  elseif isSOW then
    return SOWVP:CanAttack()
  elseif isBFW then
    return CanAttack()
  elseif isMMA then
    return _G.MMA_CanAttack
  end
end

function UOL:ResetAA()
  if isSAC then
    _G.AutoCarry.Orbwalker:ResetAttackTimer()
  elseif isNOW then
    _G.NebelwolfisOrbWalker:ResetAA()
  elseif isPEW then
  elseif isSxOrb then
    _G.SxOrb:ResetAA()
  elseif isSOW then
    SOWVP:resetAA()
  elseif isBFW then
    BigFatOrb_ResetAA()
  elseif isMMA then
    _G.MMA_ResetAutoAttack()
  end
end

function UOL:GetOrbWalkMode()
  if (isPEW and _Pewalk.GetActiveMode().Carry) or (isSAC and _G.AutoCarry.Keys.AutoCarry) or (isNOW and _G.NebelwolfisOrbWalker.Config.k.Combo) or (isSOW and SOWVP.Menu.Mode0) or (isMMA and _G.MMA_IsOrbwalking()) or (isBFW and _G["BigFatOrb_Mode"] == "Combo") or (isSxOrb and _G.SxOrb.isFight) then
    return "Combo"
  end
  if (isPEW and _Pewalk.GetActiveMode().Mixed) or (isSAC and _G.AutoCarry.Keys.MixedMode) or (isNOW and _G.NebelwolfisOrbWalker.Config.k.Harass) or (isSOW and SOWVP.Menu.Mode1) or (isMMA and _G.MMA_IsDualCarrying()) or (isBFW and _G["BigFatOrb_Mode"] == "Harass") or (isSxOrb and _G.SxOrb.isHarass) then
    return "Harass"
  end
  if (isPEW and _Pewalk.GetActiveMode().LaneClear) or (isSAC and _G.AutoCarry.Keys.LaneClear) or (isNOW and _G.NebelwolfisOrbWalker.Config.k.LaneClear) or (isSOW and SOWVP.Menu.Mode2) or (isMMA and _G.MMA_IsLaneClearing()) or (isBFW and _G["BigFatOrb_Mode"] == "LaneClear") or (isSxOrb and _G.SxOrb.isLaneClear) then
    return "LaneClear"
  end
  if (isPEW and _Pewalk.GetActiveMode().Farm) or (isSAC and _G.AutoCarry.Keys.LastHit) or (isNOW and _G.NebelwolfisOrbWalker.Config.k.LastHit) or (isSOW and SOWVP.Menu.Mode3) or (isMMA and _G.MMA_IsLastHitting()) or (isBFW and _G["BigFatOrb_Mode"] == "LastHit") or (isSxOrb and _G.SxOrb.isLastHit) then
    return "LastHit"
  end
  return ""
end

UOL = UOL()
