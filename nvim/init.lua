-- init.lua
require('plugins')     -- Plugin manager
require('settings')    -- General settings
require('mappings')    -- Key mappings
require('autocmds')    -- Autocommands
require('colors')      -- Colors and UI settings

-- Load plugin-specific configurations
require('plugin-config.fern')
require('plugin-config.airline')

-- Mason Setup
require("mason").setup({
    ui = {
        icons = {
            package_installed = "",
            package_pending = "",
            package_uninstalled = "",
        },
    }
})
require("mason-lspconfig").setup()

