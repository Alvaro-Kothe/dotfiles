local dap = require('dap')

local M = {}

function M.set_launch_args(lang, args)
  if dap.configurations[lang] == nil then
    error(("Configuration for %s is not defined!"):format(lang))
  end

  if type(args) ~= "table" and args ~= nil then
    error(("Invalid arguments %s of type %s specified! Must be a table or nil"):format(args, type(args)))
  end

  for _, config in ipairs(dap.configurations[lang]) do
    if config.request == "launch" then
      config.args = args
    end
  end
end

return M
