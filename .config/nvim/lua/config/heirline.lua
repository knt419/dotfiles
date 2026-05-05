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

    local TablineBufnr = {
        provider = function(self)
            return tostring(self.bufnr) .. ". "
        end,
        hl = "Comment",
    }

    -- we redefine the filename component, as we probably only want the tail and not the relative path
    local TablineFileName = {
        provider = function(self)
            -- self.filename will be defined later, just keep looking at the example!
            local filename = self.filename
            filename = filename == "" and "[No Name]" or vim.fn.fnamemodify(filename, ":t")
            return filename
        end,
        hl = function(self)
            return { bold = self.is_active or self.is_visible, italic = true }
        end,
    }

    -- this looks exactly like the FileFlags component that we saw in
    -- #crash-course-part-ii-filename-and-friends, but we are indexing the bufnr explicitly
    -- also, we are adding a nice icon for terminal buffers.
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

    -- Here the filename block finally comes together
    local TablineFileNameBlock = {
        init = function(self)
            self.filename = vim.api.nvim_buf_get_name(self.bufnr)
        end,
        hl = function(self)
            if self.is_active then
                return "TabLineSel"
                -- why not?
                -- elseif not vim.api.nvim_buf_is_loaded(self.bufnr) then
                --     return { fg = "gray" }
            else
                return "TabLine"
            end
        end,
        on_click = {
            callback = function(_, minwid, _, button)
                if (button == "m") then -- close on mouse middle click
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
        TablineBufnr,
        FileIcon, -- turns out the version defined in #crash-course-part-ii-filename-and-friends can be reutilized as is here!
        TablineFileName,
        TablineFileFlags,
    }

    -- The final touch!
    local TablineBufferBlock = utils.surround({ " ", "" }, function(self)
        if self.is_active then
            return utils.get_highlight("TabLineSel").bg
        else
            return utils.get_highlight("TabLine").bg
        end
    end, { TablineFileNameBlock })

    -- and here we go
    local BufferLine = utils.make_buflist(
        TablineBufferBlock,
        { provider = "", hl = { fg = "gray" } }, -- left truncation, optional (defaults to "<")
        { provider = "", hl = { fg = "gray" } } -- right trunctation, also optional (defaults to ...... yep, ">")
    -- by the way, open a lot of buffers and try clicking them ;)
    )

    require('heirline').setup({
        statusline = StatusLine,
        tabline = BufferLine,
    })
end
