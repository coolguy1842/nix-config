function HasValue(table, a)
    for _, b in ipairs(table) do
        if a == b then
            return true
        end
    end

    return false
end

function HasValueMatchingPattern(table, val)
    for _, pattern in ipairs(table) do
        if string.match(val, pattern) ~= nil then
            return true
        end
    end

    return false
end

-- https://stackoverflow.com/a/77170992
Enum = function(keys)
    local Enum = {}
    local max = 0

    for i, value in ipairs(keys) do
        Enum[value] = i
        max = max + 1
    end

    Enum.next = function(val)
        val = val + 1
        if val > max then
            val = 1
        end

        return val
    end

    return Enum
end

-- https://stackoverflow.com/a/65047878
function switch(element)
    local Table = {
        ["Value"] = element,
        ["DefaultFunction"] = nil,
        ["Functions"] = {}
    }

    Table.case = function(testElement, callback)
        Table.Functions[testElement] = callback
        return Table
    end

    Table.default = function(callback)
        Table.DefaultFunction = callback
        return Table
    end

    Table.process = function()
        local Case = Table.Functions[Table.Value]
        if Case then
            Case()
        elseif Table.DefaultFunction then
            Table.DefaultFunction()
        end
    end

    return Table
end

