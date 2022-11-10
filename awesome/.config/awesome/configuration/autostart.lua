local awful = require("awful")


local apps = {
  "lxpolkit",
  "touchegg",
  "nm-applet --indicator",
  "blueman-applet",
  "volumeicon",
  "picom",
  "redshift-gtk",
  "flatpak run org.flameshot.Flameshot",
  "xfce4-power-manager",
  -- "mate-power-manager",
  "xss-lock --transfer-sleep-lock -- i3lock --nofork",
  -- "xautolock -detectsleep"
  --   .. " -time 10 -locker 'i3lock -c 3b423d'",
  "feh --bg-fill --randomize ~/.local/share/backgrounds",
}

local function run_once(cmd)
  local findme = cmd
  local firstspace = cmd:find(' ')
  if firstspace then
    findme = cmd:sub(0, firstspace - 1)
  end
  awful.spawn.with_shell(string.format('pgrep -u $USER -x %s > /dev/null || (%s)', findme, cmd))
end

for _, i in pairs(apps) do
  run_once(i)
end

awful.spawn.with_shell("flatpak run org.mozilla.Thunderbird")
