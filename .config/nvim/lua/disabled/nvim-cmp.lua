return {
  'hrsh7th/nvim-cmp',
  dependencies = {
    'L3MON4D3/LuaSnip',
    'saadparwaiz1/cmp_luasnip',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-path',
    'rafamadriz/friendly-snippets',
  },
  opts = {
    sources = {
      { name = 'nvim_lsp '},
      { name = 'luasnip' },
      { name = 'path' },
      { name = 'cmp_tabnine' }, 
    },
    -- ... other nvim-cmp configs
  }
}
