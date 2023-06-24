return function ()
    vim.opt.showtabline=2
    local git_status = function(type, prefix)
        local status = vim.b.gitsigns_status_dict
        if not status then
          return nil
        end
        if not status[type] or status[type] == 0 then
          return nil
        end
        return prefix .. status[type]
    end
    require"staline".setup {
        sections = {
            left = {
                '  ', ' ', ' ',
                'file_name',
                 {
                    "GitSignsAdd",
                    function()
                       return git_status("added", " ") or ''
                    end
                },
                ' ',
                {
                    "GitSignsChange",
                    function()
                       return git_status("changed", " ") or ''
                    end
                },
                ' ',
                {
                    "GitSignsDelete",
                    function()
                       return git_status("removed", " ") or ''
                    end
                },
            },
            mid = { 'lsp_name', ' ', 'lsp' },
            right = {
                vim.bo.fileencoding:upper(), ' ',
                function ()
                    if vim.bo.fileformat == 'dos' then
                        return ' '
                    elseif vim.bo.fileformat == 'unix' then
                        return ' '
                    else
                        return ' '
                    end
                end, ' ', '%l:%c',
            },
        },
        defaults = {
            mod_synbol = ' ',
            branch_symbol = '',
            true_colors = true,
        },
        lsp_symbols = {
                Error=" ",
                Info=" ",
                Warn=" ",
                Hint=" ",
        },
    }
    require"stabline".setup {}
end

