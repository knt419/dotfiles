return function()
    local conditions = require('heirline.conditions')
    local utils = require('heirline.utils')

    local b = { provider = ' ' }
    local spacer = { provider = '%=' }

    local git_status = function(type)
        local status = vim.b.minidiff_summary
        if not status or not status[type] or status[type] == 0 then
            return ''
        end
        local prefix = { add = ' ', change = ' ', delete = ' ' }
        return prefix[type] .. status[type]
    end

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

    -- Git branch
    local Branch = {
        provider = function()
            local root = vim.fs.root(0, { ".git" })
            if not root then
                return ''
            end

            local branch_name = vim.fn.systemlist({
                'git',
                '-C',
                root,
                'branch',
                '--show-current',
            })

            if not branch_name or branch_name[1] == '' then
                return ''
            end

            return ' ' .. branch_name[1]
        end,

        hl = { fg = 'purple', bold = true },
    }

    local FileName = {
        init = function(self)
            self.filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ':t')
            local extension = vim.fn.fnamemodify(self.filename, ':e')
            self.icon, self.icon_color = require('nvim-web-devicons').get_icon_color(self.filename, extension,
                { default = true })
        end,
        provider = function(self)
            return self.icon and (self.icon .. " " .. self.filename) or self.filename
        end,
        hl = function(self)
            return { fg = self.icon_color }
        end
    }
    -- Git diff
    local GitAdd = {
        provider = function() return git_status('add') end,
        hl = 'MiniDiffSignAdd',
    }

    local GitChange = {
        provider = function() return git_status('change') end,
        hl = 'MiniDiffSignChange',
    }

    local GitDelete = {
        provider = function() return git_status('delete') end,
        hl = 'MiniDiffSignDelete',
    }

    -- LSP name
    local LSPName = {
        provider = function()
            local clients = vim.lsp.get_clients({ bufnr = 0 })
            if #clients == 0 then return '' end
            return '󱐋 ' .. clients[1].name
        end,
        hl = { fg = 'NvimLightYellow' },
    }

    -- Diagnostics
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
    -- Encoding
    local Encoding = {
        provider = function()
            return vim.bo.fileencoding ~= '' and vim.bo.fileencoding or vim.o.encoding
        end,
        hi = 'Number',
    }

    -- Fileformat
    local FileFormat = {
        provider = ff,
        hi = 'Number',
    }

    -- Position
    local Ruler = {
        provider = '󰳂 %03l:%02c',
        hi = 'Number',
    }

    local StatusLine = {
        b, b, ViMode, b, Branch, b, FileName, b, GitAdd, b, GitChange, b, GitDelete,
        spacer,
        LSPName, b, Diagnostics,
        spacer,
        Encoding, b, FileFormat, b, Ruler,
    }

    local TablineFileName = {
        provider = function(self)
            local filename = self.filename
            filename = filename == "" and "[No Name]" or vim.fn.fnamemodify(filename, ":t")
            return filename
        end,
        hl = function(self)
            return { bold = self.is_active or self.is_visible }
        end,
    }

    local TablineFileFlags = {
        {
            condition = function(self)
                return vim.api.nvim_get_option_value("modified", { buf = self.bufnr })
            end,
            provider = "[+]",
            hl = { fg = "green" },
        },
        {
            condition = function(self)
                return not vim.api.nvim_get_option_value("modifiable", { buf = self.bufnr })
                    or vim.api.nvim_get_option_value("readonly", { buf = self.bufnr })
            end,
            provider = function(self)
                if vim.api.nvim_get_option_value("buftype", { buf = self.bufnr }) == "terminal" then
                    return "  "
                else
                    return ""
                end
            end,
            hl = { fg = "orange" },
        },
    }

    local TablineFileNameBlock = {
        init = function(self)
            self.filename = vim.api.nvim_buf_get_name(self.bufnr)
        end,
        hl = function(self)
            if self.is_active then
                return "TabLineSel"
            else
                return "TabLine"
            end
        end,
        on_click = {
            callback = function(_, minwid, _, button)
                if (button == "m") then
                    vim.schedule(function()
                        vim.api.nvim_buf_delete(minwid, { force = false })
                    end)
                else
                    vim.api.nvim_win_set_buf(0, minwid)
                end
            end,
            minwid = function(self)
                return self.bufnr
            end,
            name = "heirline_tabline_buffer_callback",
        },
        TablineFileName,
        TablineFileFlags,
    }

    local TablineBufferBlock = utils.surround({ "", "" }, function(self)
        if self.is_active then
            return utils.get_highlight("TabLineSel").bg
        else
            return utils.get_highlight("TabLine").bg
        end
    end, { TablineFileNameBlock })

    local BufferLine = utils.make_buflist(
        TablineBufferBlock,
        { provider = "", hl = { fg = "gray" } },
        { provider = "", hl = { fg = "gray" } }
    )

    require('heirline').setup({
        statusline = StatusLine,
        tabline = BufferLine,
    })
end
