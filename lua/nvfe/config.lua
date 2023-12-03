local config = {}

config.values = {
    oraclepath = "/home/jason/nvfe.nvim/oracles/",
    gamespace = "/home/jason/newiron/",
    logdir = "/home/jason/newiron/.nvfe/log/",
    logfile = "log.norg",
}

function config.set_opts(opts)
    opts = opts or {}

    for key, val in pairs(opts) do
        config.values[key] = val
    end

end

function config.print_vals()
    for k,v in pairs(config.values) do
        print(string.format("[%s] %s", k, v))
    end
end

return config
