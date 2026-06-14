-- loader.lua
local repo = "https://raw.githubusercontent.com/tracemason1088-hash/ROBLOX-SCRIPT/main/"

loadstring(game:HttpGet(repo .. "menu.lua"))()
loadstring(game:HttpGet(repo .. "esp.lua"))()
loadstring(game:HttpGet(repo .. "fly.lua"))()
loadstring(game:HttpGet(repo .. "movement.lua"))()

getgenv().Notify("All modules loaded! Use :help", Color3.fromRGB(255,200,100))
