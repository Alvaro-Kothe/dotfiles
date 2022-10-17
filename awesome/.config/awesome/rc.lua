-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")

-- Theme handling library
local beautiful = require("beautiful")

-- Miscellanous awesome library
local menubar = require("menubar")

RC = {} -- global namespace, on top before require any modules
RC.vars = require("main.user-variables")

-- {{{ Error handling -- }}}
require("main.error-handling")
require("awful.autofocus")

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
beautiful.init(gears.filesystem.get_themes_dir() .. "default/theme.lua")
beautiful.wallpaper = RC.vars.wallpaper
-- }}}

modkey = RC.vars.modkey
altkey = RC.vars.altkey

-- Custom Local Library
local main = {
  layouts = require("main.layouts"),
  tags    = require("main.tags"),
  menu    = require("main.menu"),
  rules   = require("main.rules"),
}

-- Custom Local Library: Keys and Mouse Binding
local binding = {
  globalbuttons = require("binding.globalbuttons"),
  clientbuttons = require("binding.clientbuttons"),
  globalkeys    = require("binding.globalkeys"),
  bindtotags    = require("binding.bindtotags"),
  clientkeys    = require("binding.clientkeys")
}

-- {{{ Layouts
-- Table of layouts to cover with awful.layout.inc, order matters.
-- a variable needed in main.tags, and statusbar
-- awful.layout.layouts = { ... }
-- RC.layouts = main.layouts

awful.layout.layouts = {

    awful.layout.suit.tile,             -- 2:
    awful.layout.suit.floating,           -- 1:
    awful.layout.suit.max,                -- 10:
    -- awful.layout.suit.tile.left,        -- 3:
    -- awful.layout.suit.tile.bottom,      -- 4:
    -- awful.layout.suit.tile.top,         -- 5:
    --
    -- awful.layout.suit.fair,             -- 6:
    -- awful.layout.suit.fair.horizontal,  -- 7:
    --
    -- awful.layout.suit.spiral,             -- 8:
    -- awful.layout.suit.spiral.dwindle,     -- 9:
    --
    -- awful.layout.suit.max.fullscreen,     -- 11:
    -- awful.layout.suit.magnifier,          -- 12:

    -- awful.layout.suit.corner.nw           -- 13:
--  awful.layout.suit.corner.ne,
--  awful.layout.suit.corner.sw,
--  awful.layout.suit.corner.se,
  }
-- }}}


-- {{{ Tags
-- Define a tag table which hold all screen tags.
-- a variable needed in rules, tasklist, and globalkeys
RC.tags = main.tags()
-- }}}

-- {{{ Menu
-- Create a laucher widget and a main menu
RC.mainmenu = awful.menu({ items = main.menu() }) -- in globalkeys

-- a variable needed in statusbar (helper)
RC.launcher = awful.widget.launcher(
  { image = beautiful.awesome_icon, menu = RC.mainmenu }
)

-- Menubar configuration
-- Set the terminal for applications that require it
menubar.utils.terminal = RC.vars.terminal

-- }}}

-- {{{ Mouse and Key bindings
RC.globalkeys = binding.globalkeys()
RC.globalkeys = binding.bindtotags(RC.globalkeys)

-- Set root
root.buttons(binding.globalbuttons())
root.keys(RC.globalkeys)
-- }}}

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

-- {{{ Statusbar: Wibar
require("deco.statusbar")
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = main.rules(
  binding.clientkeys(),
  binding.clientbuttons()
)
-- }}}

-- {{{ Signals
require("main.signals")
-- }}}

awful.spawn.with_shell("~/.config/awesome/autorun.sh")
