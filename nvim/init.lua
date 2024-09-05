-- init.lua
require('settings')    -- General settings
require('mappings')    -- Key mappings
require('autocmds')    -- Autocommands
require('colors')      -- Colors and UI settings
require('plugins')     -- Plugin manager

-- Load plugin-specific configurations
require('plugin-config.fern')
require('plugin-config.airline')
