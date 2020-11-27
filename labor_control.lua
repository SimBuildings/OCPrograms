local GUI = require("GUI")
local component = require("component")
local sides = require("sides")
local colors = require("colors")

--- farm colors
farm_colors = {colors.white, colors.yellow, colors.magenta, colors.blue, colors.green}

for key,value in ipairs(farm_colors)
do
    component.redstone.setBundledOutput(sides.left, value, 255)
end

--- CONSTANTS ------------------------------------------------------------------

local LEFT_MARGIN = 3
local PANEL_HEIGHT = 10

local PANEL_COL = 0x858585
local BACKGROUND_COL = 0x484848

--------------------------------------------------------------------------------

local application = GUI.application()
application:addChild(GUI.panel(1, 1, application.width, application.height, 0x484848))

---

local menu = application:addChild(GUI.menu(1, 1, application.width, 0xFFFFFF, 0x666666, 0x858585, 0xFFFFFF))
menu:addItem("Labor Control", 0x0).onTouch = function()
  application:stop()
end

local contextMenu = menu:addContextMenu("Fenster")
contextMenu:addItem("Anzeige")
contextMenu:addItem("Schließen").onTouch = function()
  application:stop()
end



application:addChild(GUI.label(3, 3, application.width, application.height, 0x378a43, "Labor Control Panel - made by Simon Techology Group")).onTouch = function()
  application:stop()
end

--- PANELS --------------------------------------------------------------------

local farmSwitch = {}
local farmPanel = {}
local farmText = {}

--- COLUMN 1 ---
for i = 1, 3, 1
do
  farmPanel[i * 2 - 1] = application:addChild(GUI.panel(LEFT_MARGIN, 5 + (PANEL_HEIGHT + 1) * i - PANEL_HEIGHT - 1, application.width / 2 - 3 - 1, PANEL_HEIGHT, PANEL_COL))
  farmText[i * 2 - 1] = application:addChild(GUI.text(LEFT_MARGIN + 2, 6 + (PANEL_HEIGHT + 1) * i - PANEL_HEIGHT - 1, 0x0, "Feld " .. i * 2 - 1))

  farmSwitch[i * 2 - 1] = application:addChild(GUI.switch(application.width / 2 - 3 - 8, 6 + (PANEL_HEIGHT + 1) * i - PANEL_HEIGHT - 1, 8, 0x66DB80, 0x1D1D1D, 0xEEEEEE, true))

end

--- COLUMN 2 ---

for i = 1, 3, 1
do
  farmPanel[i * 2] = application:addChild(GUI.panel(application.width / 2 + 1, 5 + (PANEL_HEIGHT + 1) * i - PANEL_HEIGHT - 1, application.width / 2 - 2, PANEL_HEIGHT, PANEL_COL))
  farmText[i * 2] = application:addChild(GUI.text(application.width / 2 + 2, 6 + (PANEL_HEIGHT + 1) * i - PANEL_HEIGHT - 1, 0x0, "Feld " .. i * 2))
  
  farmSwitch[i * 2] = application:addChild(GUI.switch(application.width / 2 + 2 + application.width / 2 - 5 - 8, 6 + (PANEL_HEIGHT + 1) * i - PANEL_HEIGHT - 1, 8, 0x66DB80, 0x1D1D1D, 0xEEEEEE, true))
end

-- dashboard
farmPanel[6] = application:addChild(GUI.panel(application.width / 2 + 1, 5 + (PANEL_HEIGHT + 1) * 3 - PANEL_HEIGHT - 1, application.width / 2 - 2, PANEL_HEIGHT, 0x54b3af))
farmText[6] = application:addChild(GUI.text(application.width / 2 + 2, 6 + (PANEL_HEIGHT + 1) * 3 - PANEL_HEIGHT - 1, 0xFFFFFF, "Dashboard"))
farmSwitch[6] = nil


--- REDSTONE -------------------------------------------------------------------


-- farmSwitch1.onStateChanged = function(state)
--     if(state)
--     then
--         component.redstone.setBundledOutput(sides.left, farm_colors[1], 0)
--         GUI.alert("Redstone = 0")
--     else
--         component.redstone.setBundledOutput(sides.left, farm_colors[1], 255)
--         GUI.alert("Redstone = 255")
--     end
-- end

for key,value in ipairs(farmSwitch)
do
  farmSwitch[key].onStateChanged = function(state)
    if(farmSwitch[key].state == true)
    then
      component.redstone.setBundledOutput(sides.left, farm_colors[key], 255)
    else
      component.redstone.setBundledOutput(sides.left, farm_colors[key], 0)
    end
  end
end

---component.redstone.setBundledOutput(sides.left, farmcolors[value], 0)
--------------------------------------------------------------------------------

application:draw(true)
application:start()local GUI = require("GUI")