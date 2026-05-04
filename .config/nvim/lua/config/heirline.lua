return function()
  local conditions = require("heirline.conditions")
  local utils = require("heirline.utils")

  -- =========================
  -- 共通関数（staline互換）
  -- =========================

  local git_status = function(type)
    local status = vim.b.minidiff_summary
    if not status or not status[type] or status[type] == 0 then
      return ""
    end
    local prefix = { add = "", change = "", delete = "" }
    return prefix[type] .. " " .. status[type]
  end

  local ff = function()
    local icon = { dos = "", unix = "", mac = "" }
    return icon[vim.bo.fileformat] or ""
  end

  local fname = function()
    local devicons = require("nvim-web-devicons")
    local filename = vim.fn.expand("%:t")
    local ext = vim.fn.expand("%:e")
    local icon, hl = devicons.get_icon(filename, ext)

    if not icon then
      return filename
    end

    return icon .. " " .. filename
  end

  -- =========================
  -- コンポーネント
  -- =========================

  -- モード
  local ViMode = {
    init = function(self)
      self.mode = vim.fn.mode(1)
    end,
    static = {
      mode_icons = {
        n = " ",
        i = " ",
        c = " ",
        v = "󰒉 ",
        V = " ",
        ["\22"] = "󰾂 ",
      },
    },
    provider = function(self)
      return self.mode_icons[self.mode] or self.mode
    end,
  }

  -- Git branch
  local GitBranch = {
    condition = conditions.is_git_repo,
    provider = function()
      local head = vim.b.gitsigns_head
      if head then
        return " " .. head
      end
      return ""
    end,
  }

  -- ファイル名
  local FileName = {
    provider = fname,
  }

  -- Git diff
  local GitAdd = {
    provider = function() return git_status("add") end,
    hl = { fg = "green" },
  }

  local GitChange = {
    provider = function() return git_status("change") end,
    hl = { fg = "yellow" },
  }

  local GitDelete = {
    provider = function() return git_status("delete") end,
    hl = { fg = "red" },
  }

  -- LSP name
  local LSPName = {
    provider = function()
      local clients = vim.lsp.get_clients({ bufnr = 0 })
      if #clients == 0 then return "" end
      return clients[1].name
    end,
    hl = { fg = "cyan" },
  }

  -- Diagnostics
  local Diagnostics = {
    provider = function()
      local e = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
      local w = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })

      local out = ""
      if e > 0 then out = out .. " " .. e .. " " end
      if w > 0 then out = out .. " " .. w end
      return out
    end,
  }

  -- Encoding
  local Encoding = {
    provider = function()
      return vim.bo.fileencoding ~= "" and vim.bo.fileencoding or vim.o.encoding
    end,
  }

  -- Fileformat
  local FileFormat = {
    provider = ff,
  }

  -- Position
  local Ruler = {
    provider = " %03l:%02c",
  }

  -- =========================
  -- ステータスライン構築
  -- =========================

  local StatusLine = {
    hl = { fg = "white", bg = "black" },

    -- 左
    ViMode,
    { provider = " " },
    GitBranch,
    { provider = " " },
    FileName,
    { provider = " " },
    GitAdd,
    { provider = " " },
    GitChange,
    { provider = " " },
    GitDelete,

    -- 中央寄せ
    { provider = "%=" },

    -- 中央（staline mid）
    LSPName,
    { provider = " " },
    Diagnostics,

    -- 右寄せ
    { provider = "%=" },

    Encoding,
    { provider = " " },
    FileFormat,
    { provider = " " },
    Ruler,
    { provider = " " },
  }

  require("heirline").setup({
    statusline = StatusLine,
  })
end
