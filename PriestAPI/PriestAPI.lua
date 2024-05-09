-- Define your addon
local PriestAutoLFG = CreateFrame("Frame", "MyLFGAddonFrame")
PriestAutoLFG:RegisterEvent("ADDON_LOADED")

-- Function to create and show the secure button
local function CreateSecureButton()
    local MySecureButton = CreateFrame("Button", "MySecureButton", UIParent, "SecureActionButtonTemplate, SecureHandlerStateTemplate")
    MySecureButton:SetSize(100, 30)
    MySecureButton:SetPoint("CENTER", 0, 0)
    MySecureButton:SetText("Click Me")
    MySecureButton:SetNormalFontObject("GameFontNormal")
    MySecureButton:SetAttribute("type", "macro")
    MySecureButton:SetAttribute("macrotext", "/run C_LFGList.CreateListing(16, 0, 0, false, true)")
    MySecureButton:SetMovable(true)
    MySecureButton:EnableMouse(true)
    MySecureButton:RegisterForDrag("LeftButton")
    
    -- Dragging functionality
    MySecureButton:SetScript("OnDragStart", function(self)
        self:StartMoving()
    end)
    MySecureButton:SetScript("OnDragStop", function(self)
        self:StopMovingOrSizing()
    end)

    MySecureButton:Show()
end

-- Event handler for addon loaded
PriestAutoLFG:SetScript("OnEvent", function(self, event, addonName)
    if addonName == "PriestAutoLFG" then
        CreateSecureButton()
    end
end)

-- Register for events
PriestAutoLFG:Show()
