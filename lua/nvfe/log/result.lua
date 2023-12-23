-- generic class to use with nvfe.log
Result = {
    title = "title",
    body = "body",
    formatter = {
        fmt = "-- %s --\n%s\n-----",
        fields = { "title", "body", }
    }
}

-- copied from *Programming in Lua*
function Result:new (o)
    o = o or {}     -- create object if the user does not provide one
    setmetatable(o,self)
    self.__index = self
    return o
end

function Result:get_string ()
    return table.concat({self.title, self.title, self.body}, '\n')
end

function Result:get_formatted ()
    local formatter = self.formatter

    if type(formatter.fmt) == "string" then
        local vals = {}
        for _,field in ipairs(formatter.fields) do
            table.insert(vals,self[field])
        end
        return string.format(formatter.fmt, unpack(vals))
    elseif type(formatter.fmt) == "function" then
        return formatter.fmt(self, formatter.fields)
    end

end

return Result
