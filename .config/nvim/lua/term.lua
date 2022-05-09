-- start inserting in :term automatically
vim.api.nvim_create_autocmd("TermOpen", {
    pattern = "*",
    callback = function(args)
        vim.cmd("startinsert")
    end,
    desc = "Tell me when I enter a buffer",
})
