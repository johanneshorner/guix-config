local M = {}

function M.format()
    if vim.lsp.buf.format then
        vim.lsp.buf.format()
    else
        vim.lsp.buf.formatting_sync()
    end
end

function M.setup(client, bufnr)
    local ft = vim.api.nvim_buf_get_option(bufnr, "filetype")
    local nls = require("config.plugins.null-ls")

    local enable = false
    if nls.has_formatter(ft) then
        enable = client.name == "null-ls"
    else
        enable = not (client.name == "null-ls")
    end

    client.server_capabilities.documentFormattingProvider = enable
    -- format on save
    if client.server_capabilities.documentFormattingProvider then
        vim.cmd([[
      augroup LspFormat
        autocmd! * <buffer>
        autocmd BufWritePre <buffer> lua require("config.plugins.lsp.formatting").format()
      augroup END
    ]]   )
    end
end

return M
