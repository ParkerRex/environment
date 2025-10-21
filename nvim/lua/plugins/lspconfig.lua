return {
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		config = function()
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

			vim.api.nvim_create_autocmd({ "BufWritePre" }, { pattern = { "*.templ" }, callback = vim.lsp.buf.format })

			local on_attach = function(_client, bufnr)
				local builtin = require("telescope.builtin")
				local opts = { buffer = bufnr }
				
				vim.keymap.set("n", "gr", builtin.lsp_references, opts)
				vim.keymap.set("n", "gd", builtin.lsp_definitions, opts)
				vim.keymap.set("n", "gi", builtin.lsp_implementations, opts)
				vim.keymap.set("n", "gt", builtin.lsp_type_definitions, opts)
			end

			vim.lsp.config.lua_ls = {
				cmd = { "lua-language-server" },
				root_markers = { ".luarc.json", ".luarc.jsonc", ".luacheckrc", ".stylua.toml", "stylua.toml", "selene.toml", "selene.yml" },
				on_attach = on_attach,
				capabilities = capabilities,
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
							disable = { "different-requires" },
						},
					},
				},
			}

			vim.lsp.config.rust_analyzer = {
				cmd = { "rust-analyzer" },
				root_markers = { "Cargo.toml", "rust-project.json" },
				on_attach = on_attach,
				capabilities = capabilities,
			}

			vim.lsp.config.gopls = {
				cmd = { "gopls" },
				root_markers = { "go.work", "go.mod", ".git" },
				on_attach = on_attach,
				capabilities = capabilities,
				filetypes = { "go", "gomod", "gowork", "gotmpl" },
				settings = {
					env = {
						GOEXPERIMENT = "rangefunc",
					},
					formatting = {
						gofumpt = true,
					},
				},
			}

			vim.lsp.config.tailwindcss = {
				cmd = { "tailwindcss-language-server", "--stdio" },
				root_markers = { "tailwind.config.js", "tailwind.config.cjs", "tailwind.config.mjs", "tailwind.config.ts" },
				on_attach = on_attach,
				capabilities = capabilities,
				filetypes = { "templ", "astro", "javascript", "typescript", "react" },
				settings = {
					tailwindCSS = {
						includeLanguages = {
							templ = "html",
						},
					},
				},
			}

			vim.lsp.config.templ = {
				cmd = { "templ", "lsp" },
				root_markers = { "go.mod", ".git" },
				on_attach = on_attach,
				capabilities = capabilities,
			}

			vim.lsp.config.nil_ls = {
				cmd = { "nil" },
				root_markers = { "flake.nix", "default.nix", "shell.nix", ".git" },
				on_attach = on_attach,
				capabilities = capabilities,
			}

			vim.lsp.config.ts_ls = {
				cmd = { "typescript-language-server", "--stdio" },
				root_markers = { "tsconfig.json", "jsconfig.json", "package.json", ".git" },
				on_attach = on_attach,
				capabilities = capabilities,
			}

			vim.lsp.config.html = {
				cmd = { "vscode-html-language-server", "--stdio" },
				root_markers = { "package.json", ".git" },
				on_attach = on_attach,
				capabilities = capabilities,
				filetypes = { "html", "templ" },
			}

			vim.lsp.config.htmx = {
				cmd = { "htmx-lsp" },
				root_markers = { ".git" },
				on_attach = on_attach,
				capabilities = capabilities,
				filetypes = { "html", "templ" },
			}

			-- Enable all configured LSP servers
			vim.lsp.enable("lua_ls")
			vim.lsp.enable("rust_analyzer")
			vim.lsp.enable("gopls")
			vim.lsp.enable("tailwindcss")
			vim.lsp.enable("templ")
			vim.lsp.enable("nil_ls")
			vim.lsp.enable("ts_ls")
			vim.lsp.enable("html")
			vim.lsp.enable("htmx")
		end,
	},
}
