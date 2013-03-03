-- 1. Pick GILDED as the unique identifier.
-- 2. Pick /apprentice and /app as slash commands
SLASH_GILDED1, SLASH_GILDED2 = '/gilded', '/gild'

function SlashCmdList.GILDED(msg, editbox)
  if msg == "" or msg == "info" then

  elseif msg == "online" then
    
  elseif msg == "experience" or msg == "xp" then
    PrintGuildExperience()
  else
    GildedPrint("Usage is /gilded [info||online||experience].")
  end
end

function PrintGuildExperience()
  local currentXP, remainingXP, dailyXP, maxDailyXP = UnitGetGuildXP("player")
  local guildLevel = GetGuildLevel()
  if guildLevel == MAX_GUILD_LEVEL then
    GildedPrint("Your guild is currently at max level.")
  else
    local nextLevelXP, percentToLevel = CalculateExperienceStatistics(currentXP, remainingXP)
    local questsToLevel = math.ceil(remainingXP / 60000)
    GildedPrint("Your guild is "..math.floor(percentToLevel * 100).."% to level "..(guildLevel + 1)..". ("..currentXP.."/"..nextLevelXP..")")
    GildedPrint("Your guild will reach level "..(guildLevel + 1).." after "..questsToLevel.." completed quests.")
  end
end

function CalculateExperienceStatistics(currentXP, remainingXP)
  local nextLevelXP = currentXP + remainingXP
  local percentToLevel = currentXP / nextLevelXP
  return nextLevelXP, percentToLevel
end

function GildedFrame_OnLoad(self)
  self:RegisterEvent("GUILD_XP_UPDATE")
  GildedPrint("has successfully loaded.")
end

function GildedFrame_OnEvent(self, event, ...)
  if event == "GUILD_XP_UPDATE" then
    PrintGuildExperience()
  end
end


function GildedPrint(msg)
  print("|cFFFFFF00Gilded|r "..msg)
end


