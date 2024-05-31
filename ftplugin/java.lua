local installed_jdtls, jdtls = pcall(require, "jdtls")
if not installed_jdtls then
    return
end

local handlers = require("core.lsp.handlers")
local config = {
    cmd = {'/usr/bin/jdtls'},
    root_dir = vim.fs.dirname(vim.fs.find({'gradlew', '.git', 'mvnw'}, { upward = true })[1]),
    init_options = {
        bundles = {
            vim.fn.glob("/usr/share/java-debug/com.microsoft.java.debug.plugin.jar", true)
        }
    },
    on_attach = handlers.on_attach,
    capabilities = handlers.capabilities,
}

jdtls.start_or_attach(config)
