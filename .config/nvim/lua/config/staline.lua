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
    local ff = function ()
        local icon = { dos = '', unix = '', mac = ''}
        return icon[vim.bo.fileformat]
    end
    require"staline".setup {
        sections = {
            left = {
                '  ', ' ', ' ', 'branch',
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
                ff , ' ',
                ' ', '%03l:%02c ',
            },
        },
        defaults = {
            mod_synbol = ' ',
            branch_symbol = ' ',
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

