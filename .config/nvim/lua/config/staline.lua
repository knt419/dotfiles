return function ()
    vim.opt.showtabline=2
    local git_status = function(type)
        local status = vim.b.minidiff_summary
        if status == nil then
          return ''
        end
        if status[type] == nil or status[type] == 0 then
          return ''
        end
        local prefix = { add = '', change = '', delete = ''}
        return prefix[type] .. ' ' .. status[type]
    end
    local ff = function ()
        local icon = { dos = '', unix = '', mac = ''}
        return icon[vim.bo.fileformat]
    end
    local fname = function ()
        local icon, highlightname = require('nvim-web-devicons').get_icon(vim.fn.expand('%:t'), vim.fn.expand("%:e"))
        if highlightname == nil then
            return '%t'
        end
        return '%#' .. highlightname .. '#' .. icon .. '  %t'
    end
    require('staline').setup {
        sections = {
            left = {
                '  ', 'mode', ' ', 'branch',
                fname,
                ' ', { 'MiniDiffSignAdd', function() return git_status('add') end },
                ' ', { 'MiniDiffSignChange', function() return git_status('change') end },
                ' ', { 'MiniDiffSignDelete', function() return git_status('delete') end },
            },
            mid = { { 'SpecialKey', 'lsp_name' }, ' ', 'lsp' },
            right = {
                { 'Number', vim.bo.fileencoding }, ' ',
                { 'Number', ff }, ' ',
                { 'Number', ' %03l:%02c'}, ' ',
            },
        },
        mode_icons = { n = ' ', i = ' ', c = ' ', v = '󰒉 ', V = ' ', [''] = '󰾂 '},
        defaults = {
            mod_synbol = ' ',
            branch_symbol = ' ',
            true_colors = true,
        },
        lsp_symbols = { Error=' ', Info=' ', Warn=' ', Hint=' ', },
    }
    require('stabline').setup {
        fg = '#ffffff',
        bg = '#404040',
        inactive_fg = '#404040',
    }
end
