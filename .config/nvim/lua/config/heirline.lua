return function()
    local conditions = require('heirline.conditions')
    local utils = require('heirline.utils')

    local b = { provider = ' ' }
    local bb = { provider = '  ' }
    local spacer = { provider = '%=' }
    local function blend_colors(color1, color2_hl, alpha)
        -- color2_hl（ハイライトグループ名）から背景色（bg）を取得。無ければデフォルト値
        local hl = vim.api.nvim_get_hl(0, { name = color2_hl, link = false })
        local bg2_num = hl.bg or hl.background or 0x1e1e2e -- フォールバック用の暗い色

        -- color1 ("#404040") を数値に変換
        local bg1_num = tonumber(color1:gsub("#", ""), 16) or 0x404040

        -- RGB成分を分解
        local r1, g1, b1 = bit.rshift(bg1_num, 16), bit.band(bit.rshift(bg1_num, 8), 0xff), bit.band(bg1_num, 0xff)
        local r2, g2, b2 = bit.rshift(bg2_num, 16), bit.band(bit.rshift(bg2_num, 8), 0xff), bit.band(bg2_num, 0xff)

        -- ブレンド計算 (alpha は 0 から 1 の範囲にする)
        local a = alpha / 100
        local r = math.floor(r1 * a + r2 * (1 - a))
        local g = math.floor(g1 * a + g2 * (1 - a))
        local b = math.floor(b1 * a + b2 * (1 - a))

        -- 16進数カラー文字列 (#RRGGBB) に戻す
        return string.format("#%02x%02x%02x", r, g, b)
    end

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
        git_component('add', '  ', 'MiniDiffSignAdd'),
        git_component('change', '  ', 'MiniDiffSignChange'),
        git_component('delete', '  ', 'MiniDiffSignDelete'),
    }

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
        hl = { fg = 'lightgray', bold = true },
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
        provider = function()
            local icon = { dos = ' ', unix = ' ', mac = ' ' }
            return icon[vim.bo.fileformat] or ''
        end,
        hl = 'Number',
    }

    local Ruler = {
        provider = '󰳂 %03l:%02c',
        hl = 'Number',
    }

    local StatusLine = {
        init = function(self)
            self.filepath = vim.api.nvim_buf_get_name(0)
        end,
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
                local blended_bg = blend_colors("#404040", "TabLineFill", 1)
                return { bg = blended_bg }
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
        { bb, TablineFileName, TablineFileFlags, bb, }
    }

    local TablineBufferBlock = {
        {
            condition = function(self) return self.is_active end,
            utils.surround({ '▐', '▌' }, blend_colors("lightgray", "TabLineFill", 80), { TablineFileNameBlock }),
            -- utils.surround({ '▐', '▌' }, 'lightgray', { TablineFileNameBlock }),
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
