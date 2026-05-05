return function()
    local conditions = require('heirline.conditions')
    local utils = require('heirline.utils')

    local git_status = function(type)
        local status = vim.b.minidiff_summary
        if not status or not status[type] or status[type] == 0 then
            return ''
        end
        local prefix = { add = '', change = '', delete = '' }
        return prefix[type] .. ' ' .. status[type]
    end

    local ff = function()
        local icon = { dos = '', unix = '', mac = '' }
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
    local GitBranch = {
        provider = function()
            local file = vim.api.nvim_buf_get_name(0)
            if file == "" then return "" end

            local dir = vim.fn.fnamemodify(file, ":p:h")
            local git_dir = vim.fn.finddir(".git", dir .. ";")
            if git_dir == "" then return "" end

            local root = vim.fn.fnamemodify(git_dir, ":h")

            local branch_name = vim.fn.systemlist({
                "git",
                "-C",
                root,
                "branch",
                "--show-current",
            })

            if not branch_name or branch_name[1] == "" then
                return ""
            end

            return ' ' .. branch_name[1]
        end,

        hl = { fg = "purple", bold = true },
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
            return ' :' .. clients[1].name
        end,
        hl = 'Normal',
    }

    -- Diagnostics
    local Diagnostics = {
        {
            provider = function()
                local e = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
                local out = ''
                if e > 0 then out = out .. ' ' .. e .. ' ' end
                return out
            end,
            hl = 'DiagnosticError'
        },
        {
            provider = function()
                local i = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
                local out = ''
                if i > 0 then out = out .. ' ' .. i .. ' ' end
                return out
            end,
            hl = 'DiagnosticInfo'
        },
        {
            provider = function()
                local w = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
                local out = ''
                if w > 0 then out = out .. ' ' .. w .. ' ' end
                return out
            end,
            hl = 'DiagnosticWarn'
        },
        {
            provider = function()
                local h = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
                local out = ''
                if h > 0 then out = out .. ' ' .. h .. ' ' end
                return out
            end,
            hl = 'DiagnosticHint'
        },
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
        provider = '%03l%02c',
        hi = 'Number',
    }

    local StatusLine = {

        { provider = '　' },
        ViMode,
        { provider = ' ' },
        GitBranch,
        { provider = ' ' },
        FileName,
        { provider = ' ' },
        GitAdd,
        { provider = ' ' },
        GitChange,
        { provider = ' ' },
        GitDelete,

        { provider = '%=' },

        LSPName,
        { provider = ' ' },
        Diagnostics,

        { provider = '%=' },

        Encoding,
        { provider = ' ' },
        FileFormat,
        { provider = ' ' },
        Ruler,
        { provider = ' ' },
    }

    require('heirline').setup({
        statusline = StatusLine,
    })
end
