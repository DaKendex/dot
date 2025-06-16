return {
  "yetone/avante.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'stevearc/dressing.nvim',
    'nvim-lua/plenary.nvim',
    'MunifTanjim/nui.nvim',
    { 'echasnovski/mini.icons', opts = {}, version = false },
    'zbirenbaum/copilot.lua',
    'ravitemer/mcphub.nvim',
    {
      'HakonHarnes/img-clip.nvim',
      event = 'BufWinEnter',
      opts = {
        default = {
          embed_image_as_base64 = true,
          prompt_for_file_name = true,
          drag_and_drop = {
            insert_mode = true,
          },
          use_absolute_path = false,
        },
      },
    },
  },
  -- enabled = false,
  version = false, -- Never set this value to "*"! Never!
  config = function()
    require('avante').setup {
      windows = {
        postion = 'right',
        width = 40,
        sidebar_header = {
          enabled = true,
          align = 'left',
          rounded = true,
        },
        input = {
          prefix = ' ',
          height = 12, -- Height of the input window in vertical layout
        },
      },

      file_selector = {
        provider = 'telescope',
      },
      selector = {
        provider = 'telescope',
      },

      -- cursor_applying_provider = nil,
      behaviour = {
        enable_cursor_planning_mode = true,
        enable_claude_text_editor_tool_mode = true,
      },

      -- provider = "ollama",
      -- ollama = { model = 'devstral:latest' },
      provider = 'copilot', -- The default provider to use for LLM interactions
      providers = {
        copilot = {
          model = 'claude-3.7-sonnet',
        },
        ollama = {
          model = 'devstral:latest', -- The model to use for Ollama
        },
      },

      -- TODO: research what value this provides and setup correctly
      -- rag_service = {
      --   enabled = true, -- Enables the RAG service
      --   host_mount = os.getenv 'HOME' .. '/github', -- Host mount path for the rag service (subfolder under home)
      --   provider = 'ollama', -- The provider to use for RAG service (e.g. openai or ollama)
      --   llm_model = 'devstral:latest',
      --   embed_model = '', -- default: nomic-embed-text
      --   endpoint = 'http://localhost:11434', -- The API endpoint for RAG service
      -- },

      system_prompt = function()
        local hub = require('mcphub').get_hub_instance()
        if hub then
          return hub:get_active_servers_prompt()
        else
          return nil
        end
      end,
      custom_tools = function()
        return {
          require('mcphub.extensions.avante').mcp_tool(),
        }
      end,

      -- If you are using the builtin Neovim server, you might have to disable the following tools in your avante config to avoid any conflicts.
      -- disabled_tools = {
      --   'list_files',
      --   'search_files',
      --   'read_file',
      --   'create_file',
      --   'rename_file',
      --   'delete_file',
      --   'create_dir',
      --   'rename_dir',
      --   'delete_dir',
      --   'bash',
      -- },
    }
  end,
}
