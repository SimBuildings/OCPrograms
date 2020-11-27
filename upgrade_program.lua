local program = "labor_control.lua"
local prefix = "<Upgrade Program> "
local github_address = "https://raw.githubusercontent.com/SimBuildings/OCPrograms/master/"

os.execute("rm /home/" .. program)
print(prefix .. program .. "deleted ...")

os.execute("wget " .. github_address .. program .. " " .. program)
print(prefix .. "Neue Datei geladen!")
