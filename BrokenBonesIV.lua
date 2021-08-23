-- Getting the UI Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("LuaHub - Broken Bones IV", "BloodTheme")

-- Adding tabs
local MoneyTab = Window:NewTab("Autofarm")

-- Adding sections
local MoneySection = MoneyTab:NewSection("Give money")

-- MoneyFunction
function GetScript()
    for i,v in pairs(game:GetService("ReplicatedFirst"):GetChildren()) do
        if (v.Name):match("^%-?%d+$") then
            return v    
        end
    end
end

local FireServer = getupvalue(getsenv(GetScript()).Respawn,5)
local Remotes = getupvalue(getsenv(GetScript()).Respawn,6)

function GiveMoney(Money)
    u5 = getupvalue(getconnections(Remotes["19574636"].OnClientEvent)[1].Function,1)
    u6 = getupvalue(getconnections(Remotes["38593640"].OnClientEvent)[1].Function,1)
    u7 = getupvalue(getconnections(Remotes["75924856"].OnClientEvent)[1].Function,1)
    Code = ("money"):byte() * Money + u5 * -21 + u6 * -45 + u7 * -63
    Remotes.UpdateStat:InvokeServer('money',Money,nil,Code)
    getsenv(GetScript()).pstats.money = getsenv(GetScript()).pstats.money + Money
    getsenv(GetScript()).gui.Data.Money.Text = getsenv(GetScript()).Comma(getsenv(GetScript()).pstats.money)
end

-- Buttons

MoneySection:NewButton("Give 1 money", "Gives the player 1 money.", function()
    GiveMoney(1)
end)

MoneySection:NewButton("Give 10 money", "Gives the player 10 money.", function()
    GiveMoney(10)
end)

MoneySection:NewButton("Give 100 money", "Gives the player 100 money.", function()
    GiveMoney(100)
end)

MoneySection:NewButton("Give 1K money", "Gives the player 1000", function()
    GiveMoney(1000)
end)

MoneySection:NewButton("Give 10K money", "Gives the player 10,000 money.", function()
    GiveMoney(10000)
end)

MoneySection:NewButton("Give 100K money", "Gives the player 100,000 money.", function()
    GiveMoney(100000)
end)

MoneySection:NewButton("Give 1M money", "Gives the player 1,000,000 money.", function()
    GiveMoney(1000000)
end)

MoneySection:NewButton("Give 10M money", "Gives the player 10,000,000 money.", function()
    GiveMoney(10000000)
end)

MoneySection:NewButton("Give 100M money", "Gives the player 100,000,000 money.", function()
    GiveMoney(100000000)
end)

MoneySection:NewButton("Give 1B money", "Gives the player 1,000,000,000 money.", function()
    GiveMoney(1000000000)
end)