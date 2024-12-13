-- java lsp support
local M = {
    "mfussenegger/nvim-jdtls",
    ft = { "java" },
}

M.config = function()
    -- https://github.com/mfussenegger/nvim-jdtls
    local lombok = os.getenv("NVIM_LOMBOK")
    local jar = os.getenv("NVIM_JDT_LANGUAGE_SERVER_JAR")
    local config_dir = os.getenv("NVIM_JAVA_CONFIG_DIR")
    local workspace_dir = os.getenv("NVIM_JAVA_WORKSPACE_DIR")

    local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
    local data_dir = workspace_dir .. project_name

    local xdg_data_home = os.getenv("XDG_DATA_HOME") .. "/java"
    -- check if environment variables are set
    local function isempty(s)
        return s == nil or s == ""
    end
    if isempty(lombok) or isempty(jar) or isempty(config_dir) or isempty(workspace_dir) then
        vim.notify(
            "One or more environment variables for java are not set correctly",
            vim.log.levels.ERROR,
            { title = "nvim-jdtls" }
        )
        return
    end

    local config = {
        cmd = {
            "java",
            "-Declipse.application=org.eclipse.jdt.ls.core.id1",
            "-Dosgi.bundles.defaultStartLevel=4",
            "-Declipse.product=org.eclipse.jdt.ls.core.product",
            "-Dlog.protocol=true",
            "-Dlog.level=ALL",
            "-Xmx2g",
            "-javaagent:" .. lombok,
            "-jar",
            jar,
            "-configuration",
            config_dir,
            "-data",
            data_dir,
            "-Djava.utils.prefs.userRoot=" .. xdg_data_home,
            "--add-modules=ALL-SYSTEM",
            "--add-opens",
            "java.base/java.lang=ALL-UNNAMED",
        },
        root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew" }),
        settings = {
            java = {},
        },

        init_options = {
            bundles = {},
        },
    }
    require("jdtls").start_or_attach(config)
end

return M
