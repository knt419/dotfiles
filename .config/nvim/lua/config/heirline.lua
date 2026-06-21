return function()
    local conditions = require('heirline.conditions')
    local utils = require('heirline.utils')

    -- Aquarium color palette (dark)
    -- https://github.com/FrenzyExists/aquarium-vim
    local C = {
        bg       = '#20202A',  -- gui00: Default Background
        bg_light = '#2C2E3E',  -- gui01: Lighter Background (status bars)
        bg_sel   = '#A7B7D6',  -- gui02: Selection Background
        comments = '#3D4059',  -- gui03: Comments, Line Highlighting
        fg_dark  = '#C6D0E9',  -- gui04: Dark Foreground (status bars text)
        fg       = '#63718B',  -- gui05: Default Foreground
        fg_light = '#313449',  -- gui06: Light Foreground
        bg_dark  = '#1A1A24',  -- gui07: Light Background
        red      = '#EBB9B9',  -- gui08: Variables, Deleted
        orange   = '#E8CCA7',  -- gui09: Integers, Boolean
        yellow   = '#E6DFB8',  -- gui0A: Classes, Search
        green    = '#B1DBA4',  -- gui0B: Strings, Inserted
        cyan     = '#B8DCEB',  -- gui0C: Support, Regex
        blue     = '#A3B8EF',  -- gui0D: Functions, Methods, Headings
        magenta  = '#F6BBE7',  -- gui0E: Keywords, Changed
        pink     = '#EAC1C1',  -- gui0F: Deprecated
    }

    local mode_accent = {
        n     = C.blue,
        i     = C.green,
        c     = C.cyan,
        v     = C.magenta,
        V     = C.magenta,
        ['\22'] = C.magenta,
        R     = C.orange,
    }

    local b = { provider = ' ' }
    local bb = { provider = '  ' }
    local spacer = { provider = '%=' }

    local function git_component(key, icon, hl)
        return {
            provider = function(self)
                local n = self.summary[key] or 0
                return n > 0 and (icon .. n) or ''
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
        git_component('add',    '  ', 'MiniDiffSignAdd'),
        git_component('change', '  ', 'MiniDiffSignChange'),
        git_component('delete', '  ', 'MiniDiffSignDelete'),
    }

    local ViMode = {
        init = function(self)
            self.mode = vim.fn.mode(1)
        end,
        static = {
            mode_icons = {
                n     = ' ',
                i     = ' ',
                c     = ' ',
                v     = '󰒉 ',
                V     = ' ',
                ['\22'] = '󰾂 ',
                R     = '󰬲 ',
            },
        },
        provider = function(self)
            return self.mode_icons[self.mode] or self.mode
        end,
        hl = function(self)
            return { fg = mode_accent[self.mode] or C.blue, bold = true }
        end,
    }

    local git_branch_cache = {}

    local Branch = {
        provider = function(self)
            local cache = git_branch_cache[self.filepath]
            if cache then
                return cache == '' and '' or ' ' .. cache
            end
            local result = vim.system({
                'git',
                'rev-parse',
                '--abbrev-ref',
                'HEAD',
            }, { text = true }):wait()
            if result.code ~= 0 then
                git_branch_cache[self.filepath] = ''
                return ''
            end
            git_branch_cache[self.filepath] = vim.trim(result.stdout)
            return ' ' .. vim.trim(result.stdout)
        end,
        hl = { fg = C.fg_dark, bold = true },
    }

    local FileName = {
        init = function(self)
            self.filename = vim.fn.fnamemodify(self.filepath, ':t')
            local extension = vim.fn.fnamemodify(self.filename, ':e')
            self.icon, self.icon_hl = require('nvim-web-devicons').get_icon(self.filename, extension,
                { default = true })
        end,
        provider = function(self)
            return self.icon and (self.icon .. ' ' .. self.filename) or self.filename
        end,
        hl = function(self)
            return self.icon_hl
        end,
    }

    local LSPName = {
        provider = function()
            local clients = vim.lsp.get_clients({ bufnr = 0 })
            if #clients == 0 then return '' end
            return '󱐋 ' .. clients[1].name
        end,
        hl = { fg = C.yellow },
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
        diag(vim.diagnostic.severity.WARN,  ' ', 'DiagnosticWarn'),
        diag(vim.diagnostic.severity.INFO,  ' ', 'DiagnosticInfo'),
        diag(vim.diagnostic.severity.HINT,  '󰛨 ', 'DiagnosticHint'),
    }

    local Encoding = {
        provider = function()
            return vim.bo.fileencoding ~= '' and vim.bo.fileencoding or vim.o.encoding
        end,
        hl = { fg = C.fg },
    }

    local FileFormat = {
        provider = function()
            local icon = { dos = ' ', unix = ' ', mac = ' ' }
            return icon[vim.bo.fileformat] or ''
        end,
        hl = { fg = C.fg },
    }

    local Ruler = {
        provider = '󰳂 %03l:%02c',
        hl = { fg = C.fg },
    }

    local StatusLine = {
        init = function(self)
            self.filepath = vim.api.nvim_buf_get_name(0)
        end,
        hl = { fg = C.fg_dark, bg = C.bg_light },
        { bb,      ViMode, b,           Branch, b, FileName, b, Git, },
        spacer,
        { LSPName, b,      Diagnostics, },
        spacer,
        { Encoding, b, FileFormat, b, Ruler, },
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
                end
                return ' '
            end,
            hl = { fg = C.orange },
        },
    }

    local TablineFileNameBlock = {
        init = function(self)
            self.filename = vim.api.nvim_buf_get_name(self.bufnr)
        end,
        hl = function(self)
            if self.is_active then
                return { fg = C.fg_dark, bg = C.bg_light, bold = true }
            end
            return { fg = C.fg, bg = C.bg }
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
        { bb, TablineFileName, TablineFileFlags, bb, },
    }

    local TablineBufferBlock = {
        {
            condition = function(self) return self.is_active end,
            utils.surround({ '▐', '▌' }, C.bg_light, { TablineFileNameBlock }),
        },
        {
            condition = function(self) return not self.is_active end,
            utils.surround({ ' ', ' ' }, C.bg, { TablineFileNameBlock }),
        },
    }

    local BufferLine = utils.make_buflist(
        TablineBufferBlock,
        { provider = '  ', hl = { fg = C.comments } },
        { provider = ' ', hl = { fg = C.comments } }
    )

    require('heirline').setup({
        statusline = StatusLine,
        tabline = BufferLine,
    })
end
