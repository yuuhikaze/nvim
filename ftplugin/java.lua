local installed_jdtls, jdtls = pcall(require, "jdtls")
if not installed_jdtls then
    return
end

local handlers = require("core.lsp.handlers")
local config = {
    cmd = { vim.fn.stdpath("data") .. '/mason/bin/jdtls' },
    root_dir = vim.fs.dirname(vim.fs.find({ 'gradlew', '.git', 'mvnw' }, { upward = true })[1]),
    init_options = {
        bundles = {
            vim.fn.glob(vim.fn.stdpath("data") .. "/mason/packages/java-test/extension/server/*.jar", true ),
            vim.fn.glob(vim.fn.stdpath("data") .. "mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar", true)
        }
    },
    on_attach = handlers.on_attach,
    capabilities = handlers.capabilities,
}

jdtls.start_or_attach(config)
