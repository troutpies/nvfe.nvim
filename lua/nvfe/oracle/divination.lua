local result = require("nvfe.log.result")

local Divination = result:new{
    formatter = {
        fmt = function (t, fields)
            local vals = {}
            for _,f in ipairs(fields) do
                vals[f] = t[f]
            end

            local lines = {}

            table.insert(lines, vals.title)
            table.insert(lines, string.format("Roll: %s", vals.roll))

            local rstr
            if vals.range.m == vals.range.n then rstr = vals.range.m
            else rstr = string.format("%s-%s", vals.range.m, vals.range.n)
            end
            table.insert(lines, string.format("[%s] %s", rstr,vals.value))

            return table.concat(lines, "\n")
        end,
        fields = { "title", "roll", "range", "value", }
    }
}

function Divination:get_string ()
    local rstr
    if self.range.m == self.range.n then
        rstr = self.range.m
    else
        rstr = string.format("%s-%s",self.range.m, self.range.n)
    end
    local fields = {
        self.title,
        string.format("Roll: %s [%s]", self.roll, rstr),
        self.value,
    }
    print(table.concat(fields, "\n"))
end

return Divination
