return function()
    local conditions = require('heirline.conditions')
    local utils = require('heirline.utils')

    local b = { provider = ' ' }
    local bb = { provider = '  ' }
    local spacer = { provider = '%=' }

    local function git_component(key, icon, hl)
        return {
            provider = function(self)
                local n = self.summary[key]
                return (n and n > 0) and (icon .. n) or ''
            end,
            hl = hl,
        }
    end

    local Git = {
        condition = function()
            return vim.b.minidiff_summary ~= nil
        end,
        init = function(self)
            self.summary = vim.b.minidiff_summary
        end,
        git_component('add', ' ', 'MiniDiffSignAdd'), b,
        git_component('change', ' ', 'MiniDiffSignChange'), b,
        git_component('delete', ' ', 'MiniDiffSignDelete'),
    }

    local ff = function()
        local icon = { dos = ' ', unix = ' ', mac = ' ' }
        return icon[vim.bo.fileformat] or ''
    end

    local ViMode = {
        init = function(self)
            self.mode = vim.fn.mode(1)
        end,
        static = {
            mode_icons = {
                n = ' ',
                i = ' ',
                c = ' ',
                v = '󰒉 ',
                V = ' ',
                ['\22'] = '󰾂 ',
            },
            mode_colors = {
                n = '#4799eb',
                i = '#2bbb4f',
                c = '#e27d60',
                v = '#986fec',
                V = '#986fec',
                ['\22'] = '#986fec',
            },
        },
        provider = function(self)
            return self.mode_icons[self.mode] or self.mode
        end,
        hl = function(self)
            return { fg = self.mode_colors[self.mode] or '#4799eb' }
        end
    }

    local Branch = {
        provider = function()
            local result = vim.system({
                'git',
                'rev-parse',
                '--abbrev-ref',
                'HEAD',
            }, { text = true }):wait()
            if result.code ~= 0 then
                return ''
            end
            return ' ' .. vim.trim(result.stdout)
        end,
        hl = { fg = 'lightgray', bold = true },
    }

    local FileName = {
        init = function(self)
            self.filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ':t')
            local extension = vim.fn.fnamemodify(self.filename, ':e')
            self.icon, self.icon_color = require('nvim-web-devicons').get_icon_color(self.filename, extension,
                { default = true })
        end,
        provider = function(self)
            return self.icon and (self.icon .. ' ' .. self.filename) or self.filename
        end,
        hl = function(self)
            return { fg = self.icon_color }
        end
    }

    local LSPName = {
        provider = function()
            local clients = vim.lsp.get_clients({ bufnr = 0 })
            if #clients == 0 then return '' end
            return '󱐋 ' .. clients[1].name
        end,
        hl = { fg = 'NvimLightYellow' },
    }

    local function diag(sev, icon, hl)
        return {
            provider = function()
                local n = vim.diagnostic.count(0)[sev] or 0
                return n > 0 and (icon .. n .. ' ') or ''
            end,
            hl = hl,
        }
    end

    local Diagnostics = {
        diag(vim.diagnostic.severity.ERROR, ' ', 'DiagnosticError'),
        diag(vim.diagnostic.severity.WARN, ' ', 'DiagnosticWarn'),
        diag(vim.diagnostic.severity.INFO, ' ', 'DiagnosticInfo'),
        diag(vim.diagnostic.severity.HINT, '󰛨 ', 'DiagnosticHint'),
    }

    local Encoding = {
        provider = function()
            return vim.bo.fileencoding ~= '' and vim.bo.fileencoding or vim.o.encoding
        end,
        hl = 'Number',
    }

    local FileFormat = {
        provider = ff,
        hl = 'Number',
    }

    local Ruler = {
        provider = '󰳂 %03l:%02c',
        hl = 'Number',
    }

    local StatusLine = {
        bb, ViMode, b, Branch, b, FileName, bb, Git,
        spacer,
        LSPName, b, Diagnostics,
        spacer,
        Encoding, b, FileFormat, b, Ruler,
    }

    local TablineFileName = {
        init = function(self)
            local filename = self.filename
            self.filename = filename == '' and '[No Name]' or vim.fn.fnamemodify(self.filename, ':t')
            local extension = vim.fn.fnamemodify(filename, ':e')
            self.icon, self.fg = require('nvim-web-devicons').get_icon_color(filename, extension, { default = true })
        end,
        provider = function(self)
            return self.icon .. ' ' .. self.filename
        end,
        hl = function(self)
            if self.is_active then
                return { fg = self.fg, bold = true }
            end
            return { bold = self.is_visible }
        end,
    }

    local TablineFileFlags = {
        {
            condition = function(self)
                return vim.api.nvim_get_option_value('modified', { buf = self.bufnr })
            end,
            provider = ' 󰷫',
        },
        {
            condition = function(self)
                return not vim.api.nvim_get_option_value('modifiable', { buf = self.bufnr })
                    or vim.api.nvim_get_option_value('readonly', { buf = self.bufnr })
            end,
            provider = function(self)
                if vim.api.nvim_get_option_value('buftype', { buf = self.bufnr }) == 'terminal' then
                    return '  '
                else
                    return ' '
                end
            end,
            hl = { fg = 'orange' },
        },
    }

    local TablineFileNameBlock = {
        init = function(self)
            self.filename = vim.api.nvim_buf_get_name(self.bufnr)
        end,
        hl = function(self)
            if self.is_active then
                return { bg = '#404040' }
            else
                return 'TabLine'
            end
        end,
        on_click = {
            callback = function(_, minwid, _, button)
                vim.api.nvim_win_set_buf(0, minwid)
            end,
            minwid = function(self)
                return self.bufnr
            end,
            name = 'heirline_tabline_buffer_callback',
        },
        bb,
        TablineFileName,
        TablineFileFlags,
        bb,
    }

    local TablineBufferBlock = {
        {
            condition = function(self) return self.is_active end,
            utils.surround({ '▐', '▌' }, 'lightgray', { TablineFileNameBlock }),
        },
        {
            condition = function(self) return not self.is_active end,
            utils.surround({ ' ', ' ' }, 'NONE', { TablineFileNameBlock }),
        },
    }

    local BufferLine = utils.make_buflist(
        TablineBufferBlock,
        { provider = '  ', hl = { fg = 'gray' } },
        { provider = ' ', hl = { fg = 'gray' } }
    )

    require('heirline').setup({
        statusline = StatusLine,
        tabline = BufferLine,
    })
end
