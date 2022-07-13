local configs = {}

function configs.load(name)
    local ok, _ = pcall(require, name)
    if not ok then
        local msg = string.format(
            'Failed loading package: %s',
            name
        )
        vim.api.nvim_echo(
            {{'init.lua', 'ErrMsg'}, {'' .. msg }},
            true,
            {}
        )
    end
end

return configs
