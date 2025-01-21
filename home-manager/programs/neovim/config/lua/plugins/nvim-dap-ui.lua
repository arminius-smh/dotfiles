-- dap ui
local M = {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    enabled = false,
}

M.config = function()
    require("dapui").setup()
end

return M
