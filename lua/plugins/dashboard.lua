local asciiArt = {
[[                                                                                           ]],
[[                                                                                           ]],
[[         ______               _   ______                  _   _  __      __  _             ]],
[[        |____  |             | | |____  |                | \ | | \ \    / / (_)            ]],
[[   ___      / /   _ __     __| |     / /   _ __          |  \| |  \ \  / /   _   _ __ ___  ]],
[[  / _ \    / /   | '_ \   / _` |    / /   | '__|         | . ` |   \ \/ /   | | | '_ ` _ \ ]],
[[ |  __/   / /    | | | | | (_| |   / /    | |       _    | |\  |    \  /    | | | | | | | |]],
[[  \___|  /_/     |_| |_|  \__,_|  /_/     |_|      (_)   |_| \_|     \/     |_| |_| |_| |_|]],
[[                                                                                           ]],
[[                                                                                           ]],
}

return {
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    dependencies = {
        { 'nvim-tree/nvim-web-devicons' },
        { 'MaximilianLloyd/ascii.nvim' },
    },
    config = function()
        require('dashboard').setup {
            theme = 'doom',
            config = {
                vertical_center = true,
                header = asciiArt,
                center = {
                    {
                        icon = '󰈞 ',
                        icon_hl = 'Title',
                        desc = 'Find File',
                        desc_hl = 'String',
                        key = 'f',
                        key_hl = 'Number',
                        action = 'Telescope find_files'
                    },
                    {
                        icon = '󰋚 ',
                        icon_hl = 'Title',
                        desc = 'Recent Files',
                        desc_hl = 'String',
                        key = 'r',
                        key_hl = 'Number',
                        action = 'Telescope oldfiles'
                    },
                    {
                        icon = '󰈭 ',
                        icon_hl = 'Title',
                        desc = 'Find Word',
                        desc_hl = 'String',
                        key = 'w',
                        key_hl = 'Number',
                        action = 'Telescope live_grep'
                    },
                    {
                        icon = '󰈔 ',
                        icon_hl = 'Title',
                        desc = 'New File',
                        desc_hl = 'String',
                        key = 'n',
                        key_hl = 'Number',
                        action = 'enew'
                    },
                    {
                        icon = '󰒓 ',
                        icon_hl = 'Title',
                        desc = 'Config',
                        desc_hl = 'String',
                        key = 'c',
                        key_hl = 'Number',
                        action = 'e ~/.config/nvim/init.lua'
                    },
                    {
                        icon = '󰒲 ',
                        icon_hl = 'Title',
                        desc = 'Lazy',
                        desc_hl = 'String',
                        key = 'l',
                        key_hl = 'Number',
                        action = 'Lazy'
                    },
                    {
                        icon = '󰗼 ',
                        icon_hl = 'Title',
                        desc = 'Quit',
                        desc_hl = 'String',
                        key = 'q',
                        key_hl = 'Number',
                        action = 'qa'
                    },
                },
                footer = function()
                    local stats = require('lazy').stats()
                    local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
                    return { '⚡ Neovim loaded ' .. stats.count .. ' plugins in ' .. ms .. 'ms' }
                end,
            },
        }
    end,
}

