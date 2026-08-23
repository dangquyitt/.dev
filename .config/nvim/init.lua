-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Indentation
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep sign column visible
vim.opt.signcolumn = "yes"

-- Persistent undo
vim.opt.undofile = true

vim.pack.add({ { src = "https://github.com/catppuccin/nvim", name = "catppuccin" } })
require("catppuccin").setup({
	flavour = "macchiato", -- latte, frappe, macchiato, mocha
})
vim.cmd.colorscheme("catppuccin-nvim")

vim.pack.add({
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/nvim-telescope/telescope.nvim",
	"https://github.com/nvim-telescope/telescope-fzf-native.nvim",
})
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })

vim.pack.add({ "https://github.com/lewis6991/gitsigns.nvim" })
require("gitsigns").setup({
	signs = {
		add = { text = "┃" },
		change = { text = "┃" },
		delete = { text = "_" },
		topdelete = { text = "‾" },
		changedelete = { text = "~" },
		untracked = { text = "┆" },
	},
})

vim.pack.add({ "https://github.com/nvim-treesitter/nvim-treesitter" })
require("nvim-treesitter").install({ "rust", "javascript", "go" })
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "go" },
	callback = function()
		vim.treesitter.start()
	end,
})

vim.pack.add({ { src = "https://github.com/neovim/nvim-lspconfig" } })
vim.pack.add({ "https://github.com/mason-org/mason.nvim" })
require("mason").setup()
local servers = {
	gopls = {},
}
for name, opts in pairs(servers) do
	vim.lsp.config(name, opts)
	vim.lsp.enable(name)
end

vim.pack.add({ "https://github.com/stevearc/conform.nvim" })
require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		go = { "gofmt" },
	},

	format_on_save = {
		timeout_ms = 500,
		lsp_format = "fallback",
	},
})

vim.pack.add({
	"https://github.com/saghen/blink.cmp",
	"https://github.com/rafamadriz/friendly-snippets",
})
require("blink.cmp").setup()

vim.pack.add({
	"https://github.com/stevearc/oil.nvim",
})
require("oil").setup()
