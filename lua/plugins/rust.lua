return {
    'mrcjkb/rustaceanvim',
    version = '^5', -- Recommended
    lazy = false, -- This plugin is already lazy
    config = function()
        local mason_registry = require("mason-registry")

        -- Update this path
        local codelldb = mason_registry.get_package("codelldb")
        local extension_path = codelldb:get_install_path() .. "/extension/"
        local codelldb_path = extension_path .. "adapter/codelldb"
        local liblldb_path = extension_path .. "lldb/lib/liblldb.dylib"

        local cfg = require('rustaceanvim.config')

        vim.g.rustaceanvim = {
            server = {
                cmd = function()
                    if mason_registry.is_installed('rust-analyzer') then
                        -- This may need to be tweaked depending on the operating system.
                        local ra = mason_registry.get_package('rust-analyzer')
                        local ra_filename = ra:get_receipt():get().links.bin['rust-analyzer']
                        return { ('%s/%s'):format(ra:get_install_path(), ra_filename or 'rust-analyzer') }
                    else
                        -- global installation
                        return { 'rust-analyzer' }
                    end
                end,
            },
            dap = {
                adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path),
            },

        }
    end
}

