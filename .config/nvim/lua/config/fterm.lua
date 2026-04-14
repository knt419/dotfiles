return  function()
            local shcmd = vim.env.SHELL or 'nu'
            local visual
            if not vim.env.NVIM then
                visual = 'nvim --remote'
            else
                visual = 'nvim --server ' .. vim.env.NVIM .. ' --remote'
            end
            require('FTerm').setup {
                cmd = shcmd,
                blend = 10,
                dimensions = {
                    height = 0.9,
                    width = 0.9,
                },
                env = {
                    VISUAL = visual,
                },
            }
            vim.api.nvim_create_user_command('FtermGituiOpen', function()
                local fterm = require('FTerm')
                local gitui = fterm:new({
                    ft = 'fterm_gitui',
                    cmd = 'gitui',
                    blend = 10,
                    dimensions = {
                        height = 0.9,
                        width = 0.9,
                    },
                })
                gitui:open()
            end, {})
        end
