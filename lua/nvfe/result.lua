-- generic class to use with nvfe.log
Result = {
    title = "",
    body = "",
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

return Result
