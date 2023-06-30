return function ()
    require('lualine').setup {
        options = {
            component_separators = { left = '', right = '' },
            section_separators = { left = '', right = '' },
            always_divide_middle = false,
            globalstatus = true,
            colored = true,
        },
        sections = {
            lualine_a = {},
            lualine_b = {
                {
                    function() return ' ' end,
                    padding = 2
                },
            },
            lualine_c = {
                {
                    'filetype',
                    icon_only = true,
                    padding = 0
                },
                {
                    'filename',
                    symbols = { modified = '', readonly = '' },
                },
                {
                    'diff',
                    symbols = { added = ' ', modified = ' ', removed = ' ' },
                },
                {
                    function () return '%=' end
                },
                {
                    function()
                        local msg = 'No Active Lsp'
                        local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
                        local clients = vim.lsp.get_active_clients()
                        if next(clients) == nil then
                            return msg
                        end
                        for _, client in ipairs(clients) do
                            local filetypes = client.config.filetypes
                            if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                                return client.name
                            end
                        end
                        return msg
                    end,
                    icon = ' ',
                    color = { fg = '#d08f70' },
                },
                {
                    'diagnostics',
                    symbols ={ error = ' ', warn = ' ', info = ' ', hint = ' ' }
                },
            },
            lualine_x = {
                {
                    'encoding',
                    fmt = function (string)
                        return string:upper()
                    end,
                    padding = 0,
                },
                {
                    'fileformat',
                },
                {
                    '%l:%c',
                    icon = '',
                },
            },
            lualine_y = {},
            lualine_z = {}
        },
        tabline = {
            lualine_a = {
            },
            lualine_b = {
            },
            lualine_c = {
                {
                    function () return '▊' end,
                    padding = 0
                },
                {
                    'buffers',
                    buffers_color = { active = 'lualine_a_normal', inactive = 'lualine_b_inactive' },
                    symbols = { modified = ' ', alternate_file = '', directory =  '' }
                }
            },
            lualine_x = {
                {
                    function ()
                        return vim.fn.fnamemodify(vim.fn.finddir(".git", ".;"), ":h:t")
                    end,
                    cond = function ()
                        return vim.fn.finddir(".git", ".;") ~= ""
                    end,
                    icon = '',
                    padding = { left = 2, right = 1 }
                },
                {
                    'branch',
                    icon = '',
                },
            },
            lualine_y = {'tabs' },
            lualine_z = {}
        }
    }
    vim.cmd.doautocmd"BufEnter"
end

