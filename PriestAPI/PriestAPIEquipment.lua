PriestAPIEquipment = {}

function PriestAPIEquipment.EquipmentSlotNameToID(istrSlotName)
    local slotNames =
    {
        Head     = 1,
        Neck     = 2,
        Shoulder = 3,
        Shirt    = 4,
        Chest    = 5,
        Waist    = 6,
        Legs     = 7,
        Feet     = 8,
        Wrist    = 9,
        Hands    = 10,
        Finger1  = 11,
        Finger2  = 12,
        Trinket1 = 13,
        Trinket2 = 14,
        Back     = 15,
        MainHand = 16,
        OffHand  = 17,
        Ranged   = 18,
        Tabard   = 19
    }

    return slotNames[istrSlotName] or -1
end

function PriestAPIEquipment.EquipmentSlotIDtoString(iiID)
    local slotNames =
    {
        [1]  = "Head",
        [2]  = "Neck",
        [3]  = "Shoulder",
        [4]  = "Shirt",
        [5]  = "Chest",
        [6]  = "Waist",
        [7]  = "Legs",
        [8]  = "Feet",
        [9]  = "Wrist",
        [10] = "Hands",
        [11] = "Finger1",
        [12] = "Finger2",
        [13] = "Trinket1",
        [14] = "Trinket2",
        [15] = "Back",
        [16] = "MainHand",
        [17] = "OffHand",
        [18] = "Ranged",
        [19] = "Tabard"
    }

    return slotNames[iiID] or "Unknown"
end

function PriestAPIEquipment.GetEquipmentInfo(istrUnit, iIdentifier)
    local equipmentInfo = {}

    if (iIdentifier == nil or istrUnit == nil or istrUnit == "") then
        return nil
    end

    local iSLotID = 0
    if (type(iIdentifier) == "string") then
        iSLotID = PriestAPIEquipment.EquipmentSlotNameToID(iIdentifier)
    else
        iSLotID = iIdentifier
    end

    if (iSLotID == -1) then
        return nil
    end

    equipmentInfo["Link"]        = GetInventoryItemLink(istrUnit, iSLotID)
    if (equipmentInfo["Link"] == nil) then
        return nil
    end

    local id, _ = GetInventoryItemID(istrUnit, iSLotID);
    equipmentInfo["ID"]          = id

    equipmentInfo["Texture"]     = GetInventoryItemTexture(istrUnit, iSLotID)
    equipmentInfo["Quality"]     = GetInventoryItemQuality(istrUnit, iSLotID)
    equipmentInfo["Count"]       = GetInventoryItemCount(istrUnit, iSLotID)

    local currentDurability, maximumDurability = GetInventoryItemDurability(iSLotID)
    if (currentDurability ~= nil and maximumDurability ~= nil and maximumDurability > 0) then
        equipmentInfo["Durability"]  = currentDurability / maximumDurability * 100
    else
        equipmentInfo["Durability"]  = 100
    end

    equipmentInfo["Broken"]      = GetInventoryItemBroken(istrUnit, iSLotID)

    if (equipmentInfo["Link"]) then
        local itemName, _, _, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture, sellPrice, classID, subclassID, bindType, expacID, setID, isCraftingReagent = GetItemInfo(equipmentInfo["Link"])

        equipmentInfo["Name"]        = itemName

        local slotMixin = ItemLocation:CreateFromEquipmentSlot(iSLotID)
        if (slotMixin ~= nil) then
            equipmentInfo["ItemLevel"] = C_Item.GetCurrentItemLevel(slotMixin)
        else
            equipmentInfo["ItemLevel"] = itemLevel
        end

        equipmentInfo["MinLevel"]    = itemMinLevel
        equipmentInfo["Type"]        = itemType
        equipmentInfo["SubType"]     = itemSubType
        equipmentInfo["StackCount"]  = itemStackCount
        equipmentInfo["EquipLoc"]    = itemEquipLoc
        equipmentInfo["Texture"]     = itemTexture
        equipmentInfo["SellPrice"]   = sellPrice
        equipmentInfo["ClassID"]     = classID
        equipmentInfo["SubclassID"]  = subclassID
        equipmentInfo["BindType"]    = bindType
        equipmentInfo["ExpacID"]     = expacID
        equipmentInfo["SetID"]       = setID
        equipmentInfo["CraftingReagent"] = isCraftingReagent
    end

    return equipmentInfo
end