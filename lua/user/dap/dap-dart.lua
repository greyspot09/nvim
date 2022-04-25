local dap = require('dap')

dap.adapters.dart = {
  type = "executable",
  command = "node",
  args = { "/Users/liucien/.local/share/nvim/dapinstall/dart/Dart-Code/out/dist/debug.js", "flutter" }
}
dap.configurations.dart = {
  {
    type = "dart",
    request = "launch",
    name = "Launch flutter",
    dartSdkPath = os.getenv('HOME') .. "/flutter/flutter/bin/cache/dart-sdk/",
    flutterSdkPath = os.getenv('HOME') .. "/flutter/flutter",
    program = "${workspaceFolder}/lib/main.dart",
    cwd = "${workspaceFolder}",
  }
}
