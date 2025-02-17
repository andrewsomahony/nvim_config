require("dapui").setup()

local dap, dapui = require("dap"), require("dapui")
dap.listeners.before.attach.dapui_config = function()
  dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
  dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
  dapui.close()
  -- Keep the console open so we can examine the results of the execution
  dapui.float_element("console")
end
dap.listeners.before.event_exited.dapui_config = function()
  dapui.close()
  -- Keep the console open so we can examine the results of the execution
  dapui.float_element("console")
end
