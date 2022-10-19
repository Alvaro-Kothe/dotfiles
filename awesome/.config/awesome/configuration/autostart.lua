awful = require("awful")


local apps = {
  "nm-applet --indicator",
  "blueman-applet",
  "picom",
  "volumeicon",
  "redshift-gtk",
  "flatpak run org.flameshot.Flameshot",
  "flatpak run org.mozilla.Thunderbird",
  "xfce4-power-manager",
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
