local keymap = vim.keymap
local fn = vim.fn

keymap.set("n", "<Esc>", "<Esc><Cmd>nohlsearch<CR><Esc>", {silent = true})
keymap.set("n", "<Esc><Esc>", "<Cmd>bdelete<CR>", {silent = true})
keymap.set("n", "Y", "y$", {silent = true})
keymap.set("x", "Y", '"+y', {silent = true})
keymap.set("n", "x", '"_x', {silent = true})
keymap.set("n", "X", '"_X', {silent = true})
keymap.set("n", "cd", "<Cmd>cd %:h<CR>", {silent = true})
keymap.set("n", "rr", ":<C-u>%s///g<Left><Left>", {silent = true})
keymap.set("x", "p", '"_xP', {silent = true})
keymap.set("x", ".", ":normal .<CR>", {silent = true})
keymap.set("n", "U", "<C-r>", {silent = true})
keymap.set("n", "<BS>", "<C-^>", {silent = true})
keymap.set("n", "+", "<C-a>", {silent = true})
keymap.set("n", "-", "<C-x>", {silent = true})
keymap.set("n", "os", "<Cmd>e ++enc=cp932<CR>", {silent = true})
keymap.set("n", "oe", "<Cmd>e ++enc=euc-jp<CR>", {silent = true})
keymap.set("n", "ou", "<Cmd>e ++enc=utf-8<CR>", {silent = true})
keymap.set("n", "q;", ":q")

keymap.set("v", "<", "<gv")
keymap.set("v", ">", ">gv")

keymap.set("n", ";", ":")
keymap.set("n", "<CR><CR>", "o<Esc>", {silent = true})
keymap.set("n", "<Leader>n", "<Cmd>enew<CR>", {silent = true})
keymap.set("n", "<C-n>", "*", {silent = true})
keymap.set("n", "<C-p>", "#", {silent = true})
keymap.set("c", "<C-v>", "<C-r>+")
keymap.set("c", "<C-c>", "<C-r><C-w>")
keymap.set("i", "<Esc>", "<Esc><Cmd>set iminsert=0<CR>", {silent = true})
keymap.set("i", "jj", "<Esc><Cmd>set iminsert=0<CR>", {silent = true})

keymap.set("n", "<S-Left>", "<C-w><")
keymap.set("n", "<S-Right>", "<C-w>>")
keymap.set("n", "<S-Up>", "<C-w>-")
keymap.set("n", "<S-Down>", "<C-w>+")

keymap.set("n", "<Tab>", function()
                            if fn.winlayout()[1] == "leaf" then
                                if fn.tabpagenr("$") <= 1
                                    and fn.len(fn.getbufinfo({buflisted = 1})) <= 1 then
                                        return "<Cmd>echo 'no buffer to switch.'<CR>"
                                else
                                    return "<Cmd>bn<CR>"
                                end
                            else
                                return "<C-w>w"
                            end
                        end, {expr = true})
keymap.set("n", "<S-Tab>", function()
                            if fn.winlayout()[1] == "leaf" then
                                if fn.tabpagenr("$") <= 1
                                    and fn.len(fn.getbufinfo({buflisted = 1})) <= 1 then
                                        return "<Cmd>echo 'no buffer to switch.'<CR>"
                                else
                                    return "<Cmd>bp<CR>"
                                end
                            else
                                return "<C-w>W"
                            end
                        end, {expr = true})
