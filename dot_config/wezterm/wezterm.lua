-- Import the wezterm module
local wezterm = require 'wezterm'
local appearance = require 'appearance'

-- Creates a config object which we will be adding our config to
local config = wezterm.config_builder()

if appearance.is_dark() then
  config.color_scheme = 'Gruvbox Dark (Gogh)'
else
  config.color_scheme = 'GruvboxLight'
end
-- (This is where our config will go)

wezterm.on('update-status', function(window)
  -- Grab the utf8 character for the "powerline" left facing
  -- solid arrow.
  local SOLID_LEFT_ARROW = utf8.char(0xe0b2)

  -- Grab the current window's configuration, and from it the
  -- palette (this is the combination of your chosen colour scheme
  -- including any overrides).
  local color_scheme = window:effective_config().resolved_palette
  local bg = color_scheme.background
  local fg = color_scheme.foreground

  window:set_right_status(wezterm.format({
    -- First, we draw the arrow...
    { Background = { Color = 'none' } },
    { Foreground = { Color = bg } },
    { Text = SOLID_LEFT_ARROW },
    -- Then we draw our text
    { Background = { Color = bg } },
    { Foreground = { Color = fg } },
    { Text = ' ' .. wezterm.hostname() .. ' ' },
  }))
end)

-- Returns our config to be evaluated. We must always do this at the bottom of this file
return config
