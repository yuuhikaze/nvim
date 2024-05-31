local installed_jdtls_dap, jdtls_dap = pcall(require, "jdtls.dap")
if not installed_jdtls_dap then
    return
end

jdtls_dap.setup_dap_main_class_configs()
