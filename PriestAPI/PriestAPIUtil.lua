PriestAPIUtil = {}

function PriestAPIUtil.DumpTable(iTbl, iPadding)
    if not iPadding then
        iPadding = 0
    end

    if (iTbl == nil) then
        return
    end

    for k,v in pairs(iTbl) do
        if type(v) == "table" then
            print(string.rep("    ", iPadding) .. k .. " = {")
            PriestAPIUtil.DumpTable(v, iPadding + 1)
            print(string.rep("    ", iPadding) .. "}")
        else
            print(string.rep("    ", iPadding) .. k .. " = " .. tostring(v))
        end
    end
end