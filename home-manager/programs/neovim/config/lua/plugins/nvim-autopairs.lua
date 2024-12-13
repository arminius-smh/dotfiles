-- autopairs
local M = {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
}

M.config = function()
    local Rule = require("nvim-autopairs.rule")
    local npairs = require("nvim-autopairs")
    local cond = require("nvim-autopairs.conds")

    npairs.setup({
        check_ts = true,
    })

    npairs.add_rules({
        Rule("*", "*", "norg")
            -- this is a start, but can definitely be improved
            :with_pair(cond.not_after_regex("*")),
    })
end

return M
