local dap = require('dap')

dap.adapters.lldb = {
  id = 'ccppr_lldb',
  type = "executable",
  -- command = os.getenv('HOME') .. '/.config/nvim/lua/user/dap/debugger/ms-vscode.cpptools-1.7.1/debugAdapters/bin/OpenDebugAD7',
  command = "/opt/homebrew/opt/llvm/bin/lldb-vscode",
}
dap.configurations.cpp = {
-- launch exe
{
    name = "Launch file",
    type = "lldb",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = true,
    postRunCommands = {'process handle -p true -s false -n false SIGWINCH'},
    setupCommands = {
    {
        description =  'enable pretty printing',
        text = '-enable-pretty-printing',
        ignoreFailures = false
      },
    },
},
-- attach process
{
    name = "Attach process",
    type = "cppdbg",
    request = "attach",
    processId = require('dap.utils').pick_process,
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = "${workspaceFolder}",
    setupCommands = {
    {
        description =  'enable pretty printing',
        text = '-enable-pretty-printing',
        ignoreFailures = false
      },
    },
},
-- attach server
{
    name = 'Attach to gdbserver :1234',
    type = 'cppdbg',
    request = 'launch',
    MIMode = 'gdb',
    miDebuggerServerAddress = 'localhost:1234',
    miDebuggerPath = '/usr/bin/gdb', cwd = '${workspaceFolder}',
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    setupCommands = {
      {
        text = '-enable-pretty-printing',
        description =  'enable pretty printing',
        ignoreFailures = false
      },
    },
  },
}

-- setup other language
dap.configurations.c = dap.configurations.cpp



