local script_path = vim.fn.expand("<sfile>:p:h") -- ~/.config/nvim/plugin

require("competitest").setup {
    testcases_use_single_file = true,
    template_file = string.format("%s/../lua/plugins/config/competitest/template.$(FEXT)", script_path),
    evaluate_template_modifiers = true,
    compile_command = {
        c = { exec = "gcc", args = { "-Wall", "$(FNAME)", "-o", "$(FNOEXT).out" } },
        cpp = { exec = "g++", args = { "-Wall", "$(FNAME)", "-o", "$(FNOEXT).out" } },
        rust = { exec = "rustc", args = { "$(FNAME)" } },
        java = { exec = "javac", args = { "$(FNAME)" } },
    },
    run_command = {
        c = { exec = "./$(FNOEXT).out" },
        cpp = { exec = "./$(FNOEXT).out" },
        rust = { exec = "./$(FNOEXT)" },
        python = { exec = "python", args = { "$(FNAME)" } },
        java = { exec = "java", args = { "$(FNOEXT)" } },
    },
}
