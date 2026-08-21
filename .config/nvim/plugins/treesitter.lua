return {
    {
        'nvim-treesitter/nvim-treesitter',
        lazy = false,
        build = ':TSUpdate',
        config = function(_, opts)
            require('nvim-treesitter').install {
                'go',
                'gosum',
                'gomod',
                'gotmpl'
            }

            vim.api.nvim_create_autocmd('FileType', {
                pattern = {
                    'go',
                    'gosum',
                    'gomod',
                    'gotmpl'
                },
                callback = function() vim.treesitter.start() end,
            })
        end
    }
}
