-- adapted from: https://github.com/jakobwesthoff/nvim-from-scratch/blob/session/04/lua/plugins/lsp.lua
return {
    -- Main LSP Configuration
    'neovim/nvim-lspconfig',
    dependencies = {
        -- Automatically install LSPs and related tools to stdpath for Neovim
        -- Mason must be loaded before its dependents so we need to set it up here.
        -- NOTE: `opts = {}` is the same as calling `require('mason').setup({})`
        { 'williamboman/mason.nvim', opts = {} },
        'williamboman/mason-lspconfig.nvim',
        'WhoIsSethDaniel/mason-tool-installer.nvim',

        -- Useful status updates for LSP.
        { 'j-hui/fidget.nvim', opts = {} },
    },
    config = function()
        -- Brief aside: **What is LSP?**
        --
        -- LSP is an initialism you've probably heard, but might not understand what it is.
        --
        -- LSP stands for Language Server Protocol. It's a protocol that helps editors
        -- and language tooling communicate in a standardized fashion.
        --
        -- In general, you have a "server" which is some tool built to understand a particular
        -- language (such as `gopls`, `lua_ls`, `rust_analyzer`, etc.). These Language Servers
        -- (sometimes called LSP servers, but that's kind of like ATM Machine) are standalone
        -- processes that communicate with some "client" - in this case, Neovim!
        --
        -- LSP provides Neovim with features like:
        --  - Go to definition
        --  - Find references
        --  - Autocompletion
        --  - Symbol Search
        --  - and more!
        --
        -- Thus, Language Servers are external tools that must be installed separately from
        -- Neovim. This is where `mason` and related plugins come into play.
        --
        -- If you're wondering about lsp vs treesitter, you can check out the wonderfully
        -- and elegantly composed help section, `:help lsp-vs-treesitter`

        --  This function gets run when an LSP attaches to a particular buffer.
        --    That is to say, every time a new file is opened that is associated with
        --    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
        --    function will be executed to configure the current buffer
        vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
            callback = function(event)
                -- NOTE: Remember that Lua is a real programming language, and as such it is possible
                -- to define small helper and utility functions so you don't have to repeat yourself.
                --
                -- In this case, we create a function that lets us more easily define mappings specific
                -- for LSP related items. It sets the mode, buffer and description for us each time.
                local map = function(keys, func, desc, mode)
                    mode = mode or 'n'
                    vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
                end

                -- Jump to the definition of the word under your cursor.
                --  This is where a variable was first declared, or where a function is defined, etc.
                --  To jump back, press <C-t>.
                map('gd', require('fzf-lua').lsp_definitions, '[G]oto [D]efinition')

                -- Find references for the word under your cursor.
                map('gr', require('fzf-lua').lsp_references, '[G]oto [R]eferences')

                -- Jump to the implementation of the word under your cursor.
                --  Useful when your language has ways of declaring types without an actual implementation.
                map('gI', require('fzf-lua').lsp_implementations, '[G]oto [I]mplementation')

                -- Jump to the type of the word under your cursor.
                --  Useful when you're not sure what type a variable is and you want to see
                --  the definition of its *type*, not where it was *defined*.
                map('<leader>D', require('fzf-lua').lsp_typedefs, 'Type [D]efinition')

                -- Fuzzy find all the symbols in your current document.
                --  Symbols are things like variables, functions, types, etc.
                map('<leader>ds', require('fzf-lua').lsp_document_symbols, '[D]ocument [S]ymbols')

                -- Fuzzy find all the symbols in your current workspace.
                --  Similar to document symbols, except searches over your entire project.
                map('<leader>ws', require('fzf-lua').lsp_live_workspace_symbols, '[W]orkspace [S]ymbols')

                -- Rename the variable under your cursor.
                --  Most Language Servers support renaming across files, etc.
                map('gR', vim.lsp.buf.rename, '[R]e[n]ame')

                -- Execute a code action, usually your cursor needs to be on top of an error
                -- or a suggestion from your LSP for this to activate.
                --map('ga', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })

                -- WARN: This is not Goto Definition, this is Goto Declaration.
                --  For example, in C this would take you to the header.
                map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

                -- This function resolves a difference between neovim nightly (version 0.11) and stable (version 0.10)
                ---@param client vim.lsp.Client
                ---@param method vim.lsp.protocol.Method
                ---@param bufnr? integer some lsp support methods only in specific files
                ---@return boolean
                local function client_supports_method(client, method, bufnr)
                    if vim.fn.has('nvim-0.11') == 1 then
                        return client:supports_method(method, bufnr)
                    else
                        return client.supports_method(method, { bufnr = bufnr })
                    end
                end

                -- The following two autocommands are used to highlight references of the
                -- word under your cursor when your cursor rests there for a little while.
                --    See `:help CursorHold` for information about when this is executed
                --
                -- When you move your cursor, the highlights will be cleared (the second autocommand).
                local client = vim.lsp.get_client_by_id(event.data.client_id)
                if
                    client
                    and client_supports_method(
                        client,
                        vim.lsp.protocol.Methods.textDocument_documentHighlight,
                        event.buf
                    )
                then
                    local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
                    vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                        buffer = event.buf,
                        group = highlight_augroup,
                        callback = vim.lsp.buf.document_highlight,
                    })

                    vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
                        buffer = event.buf,
                        group = highlight_augroup,
                        callback = vim.lsp.buf.clear_references,
                    })

                    vim.api.nvim_create_autocmd('LspDetach', {
                        group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
                        callback = function(event2)
                            vim.lsp.buf.clear_references()
                            vim.api.nvim_clear_autocmds({ group = 'kickstart-lsp-highlight', buffer = event2.buf })
                        end,
                    })
                end

                -- The following code creates a keymap to toggle inlay hints in your
                -- code, if the language server you are using supports them
                --
                -- This may be unwanted, since they displace some of your code
                if
                    client
                    and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf)
                then
                    map('<leader>th', function()
                        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
                    end, '[T]oggle Inlay [H]ints')
                end
            end,
        })

        -- Diagnostic Config
        -- See :help vim.diagnostic.Opts
        vim.diagnostic.config({
            severity_sort = true,
            float = { border = 'rounded', source = 'if_many' },
            underline = { severity = vim.diagnostic.severity.ERROR },
            signs = {
                text = {
                    [vim.diagnostic.severity.ERROR] = '󰅚 ',
                    [vim.diagnostic.severity.WARN] = '󰀪 ',
                    [vim.diagnostic.severity.INFO] = '󰋽 ',
                    [vim.diagnostic.severity.HINT] = '󰌶 ',
                },
            },
            virtual_text = {
                source = 'if_many',
                spacing = 2,
                format = function(diagnostic)
                    local diagnostic_message = {
                        [vim.diagnostic.severity.ERROR] = diagnostic.message,
                        [vim.diagnostic.severity.WARN] = diagnostic.message,
                        [vim.diagnostic.severity.INFO] = diagnostic.message,
                        [vim.diagnostic.severity.HINT] = diagnostic.message,
                    }
                    return diagnostic_message[diagnostic.severity]
                end,
            },
        })

        -- LSP servers and clients are able to communicate to each other what features they support.
        --  By default, Neovim doesn't support everything that is in the LSP specification.
        --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
        --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
        local original_capabilities = vim.lsp.protocol.make_client_capabilities()
        local capabilities = require('blink.cmp').get_lsp_capabilities(original_capabilities)

        -- adapted from: https://stackoverflow.com/a/4991602
        function file_exists(path)
            local f = io.open(path, 'r')
            if f ~= nil then
                io.close(f)
                return true
            else
                return false
            end
        end

        local ltex_opts = {
            filetypes = { 'latex', 'tex', 'bib', 'markdown', 'gitcommit', 'text' },
            settings = {
                ltex = {
                    enabled = { 'latex', 'tex', 'bib', 'markdown' },
                    language = 'en-US',
                    diagnosticSeverity = 'information',
                    sentenceCacheSize = 2000,
                    languageToolHttpServerUri = 'https://api.languagetoolplus.com/v2',
                    -- languageToolOrg = {
                    --     username = LanguageTool_username,
                    --     apiKey = LanguageTool_ApiKey,
                    -- },
                },
            },
        }

        t = {}

        local current_dir_path = string.sub(debug.getinfo(1).source, 2, string.len('/lsp.lua') * -1)
        local language_tool_credentials_path = current_dir_path .. '../config/language-tool-credentials.lua'

        if file_exists(language_tool_credentials_path) then
            require('config.language-tool-credentials')
            ltex_opts['settings']['ltex']['languageToolOrg'] = {
                username = LanguageTool_username,
                apiKey = LanguageTool_ApiKey,
            }
        end

        -- capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

        local function find_python_venv(root_dir)
            local dir = root_dir or vim.uv.cwd()

            while dir and dir ~= '' do
                for _, name in ipairs({ '.venv', 'venv' }) do
                    local python = table.concat({ dir, name, 'bin', 'python' }, '/')

                    if vim.fn.executable(python) == 1 then
                        return {
                            root = dir,
                            name = name,
                            path = table.concat({ dir, name }, '/'),
                            python = python,
                        }
                    end
                end

                local parent = vim.fs.dirname(dir)

                if parent == dir then
                    break
                end

                dir = parent
            end

            return nil
        end

        local function pyright_settings_for_venv(venv)
            return {
                python = {
                    pythonPath = venv.python,
                    venvPath = venv.root,
                    venv = venv.name,
                },
            }
        end

        local function configure_pyright_project_env(config, root_dir)
            local venv = find_python_venv(root_dir or config.root_dir)

            if not venv then
                return
            end

            config.settings = vim.tbl_deep_extend('force', config.settings or {}, pyright_settings_for_venv(venv))
        end

        local function pyright_on_init(client)
            configure_pyright_project_env(client.config, client.config.root_dir)

            client.settings = vim.tbl_deep_extend('force', client.settings or {}, client.config.settings or {})
            client:notify('workspace/didChangeConfiguration', { settings = client.config.settings })
        end

        vim.api.nvim_create_user_command('PyrightProjectEnv', function()
            local buffer_name = vim.api.nvim_buf_get_name(0)
            local start_dir = buffer_name ~= '' and vim.fs.dirname(buffer_name) or vim.uv.cwd()
            local venv = find_python_venv(start_dir)

            if not venv then
                vim.notify('No .venv or venv with bin/python found for this project.', vim.log.levels.WARN)
                return
            end

            vim.notify(
                table.concat({
                    'Pyright project environment:',
                    'pythonPath: ' .. venv.python,
                    'venvPath: ' .. venv.root,
                    'venv: ' .. venv.name,
                }, '\n'),
                vim.log.levels.INFO
            )
        end, {
            desc = 'Show the Python virtual environment detected for Pyright',
        })

        vim.api.nvim_create_user_command('PyrightUseProjectEnv', function()
            local buffer = vim.api.nvim_get_current_buf()
            local buffer_name = vim.api.nvim_buf_get_name(buffer)
            local start_dir = buffer_name ~= '' and vim.fs.dirname(buffer_name) or vim.uv.cwd()
            local venv = find_python_venv(start_dir)

            if not venv then
                vim.notify('No .venv or venv with bin/python found for this project.', vim.log.levels.WARN)
                return
            end

            local clients = vim.lsp.get_clients({ bufnr = buffer, name = 'pyright' })

            if vim.tbl_isempty(clients) then
                vim.notify('No running Pyright client for this buffer. Open a Python file or run :LspRestart pyright.', vim.log.levels.WARN)
                return
            end

            local settings = pyright_settings_for_venv(venv)

            for _, client in ipairs(clients) do
                client.config.settings = vim.tbl_deep_extend('force', client.config.settings or {}, settings)
                client.settings = vim.tbl_deep_extend('force', client.settings or {}, settings)
                client:notify('workspace/didChangeConfiguration', { settings = client.config.settings })
            end

            vim.notify('Pyright now uses ' .. venv.python, vim.log.levels.INFO)
        end, {
            desc = 'Reconfigure the running Pyright client to use the project virtual environment',
        })

        -- Enable the following language servers
        --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
        --
        --  Add any additional override configuration in the following tables. Available keys are:
        --  - cmd (table): Override the default command used to start the server
        --  - filetypes (table): Override the default list of associated filetypes for the server
        --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
        --  - settings (table): Override the default settings passed when initializing the server.
        --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
        local servers = {
            bashls = {},
            marksman = {},
            checkmake = {},
            clangd = {},
            pyright = {
                before_init = function(_, config)
                    configure_pyright_project_env(config, config.root_dir)
                end,
                on_init = pyright_on_init,
                settings = {
                    python = {
                        analysis = {
                            autoSearchPaths = true,
                            useLibraryCodeForTypes = true,
                        },
                    },
                },
            },
            verible = {
                cmd = { 'verible-verilog-ls' },
                filetypes = { 'verilog', 'systemverilog' },
            },
            vhdl_ls = {},
            ltex = ltex_opts,
            lua_ls = {
                -- cmd = { ... },
                -- filetypes = { ... },
                -- capabilities = {},
                -- settings = {
                --   Lua = {
                --     completion = {
                --       callSnippet = 'Replace',
                --     },
                --     -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
                --     -- diagnostics = { disable = { 'missing-fields' } },
                --   },
                -- },
            },
        }

        -- Ensure the servers and tools above are installed
        --
        -- To check the current status of installed tools and/or manually install
        -- other tools, you can run
        --    :Mason
        --
        -- You can press `g?` for help in this menu.
        --
        -- `mason` had to be setup earlier: to configure its options see the
        -- `dependencies` table for `nvim-lspconfig` above.
        --
        -- You can add other tools here that you want Mason to install
        -- for you, so that they are available from within Neovim.
        local ensure_installed = vim.tbl_keys(servers or {})
        vim.list_extend(ensure_installed, {
            'stylua', -- Used to format Lua code
        })
        require('mason-tool-installer').setup({ ensure_installed = ensure_installed })

        for server_name, server in pairs(servers) do
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            vim.lsp.config(server_name, server)
        end

        require('mason-lspconfig').setup({
            ensure_installed = {}, -- Kickstart populates installs via mason-tool-installer.
            automatic_enable = vim.tbl_keys(servers or {}),
        })
    end,
}
