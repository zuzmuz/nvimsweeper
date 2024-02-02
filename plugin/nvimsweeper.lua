vim.api.nvim_create_user_command('NvimSweeper', function (opts)
    require('nvimsweeper.game').launch()
end, {})
