return {
  "robitx/gp.nvim",
  enabled = false,
  lazy = false,
  config = function()
    require("gp").setup({
      providers = {
        -- openai = {
        --   endpoint = "https://api.openai.com/v1/chat/completions",
        --   secret = os.getenv("OPENAI_API_KEY"),
        -- },
        ollama = {
          endpoint = "http://localhost:11434/v1/chat/completions",
        },
      },
      agents = {
        {
          name = "Llama3.1",
          chat = true,
          command = true,
          provider = "ollama",
          model = { model = "llama3.1" },
          system_prompt = "I am an AI meticulously crafted to provide programming guidance and code assistance. "
              .. "To best serve you as a computer programmer, please provide detailed inquiries and code snippets when necessary, "
              .. "and expect precise, technical responses tailored to your development needs.\n",
        },
      },
      hooks = {
        -- example of usig enew as a function specifying type for the new buffer
        CodeReview = function(gp, params)
          local template = "I have the following code from {{filename}}:\n\n"
              .. "```{{filetype}}\n{{selection}}\n```\n\n"
              .. "Please analyze for code smells and suggest improvements."
          local agent = gp.get_chat_agent()
          gp.Prompt(params, gp.Target.enew("markdown"), nil, agent.model, template, agent.system_prompt)
        end,
        -- example of making :%GpChatNew a dedicated command which
        -- opens new chat with the entire current buffer as a context
        BufferChatNew = function(gp, _)
          -- call GpChatNew command in range mode on whole buffer
          vim.api.nvim_command("%" .. gp.config.cmd_prefix .. "ChatNew")
        end,
      },
    })
    require("gen").prompts["Elaborate_Text"] = {
      prompt =
      "Elaborate the following text. If there are code snippets, leave them in place, but you can add comments:\n$text",
      replace = true,
    }
    require("gen").prompts["Fix_Code"] = {
      prompt =
      "Fix the following code. Only output the result in format ```$filetype\n...\n```:\n```$filetype\n$text\n```",
      replace = true,
      extract = "```$filetype\n(.-)```",
    }
    vim.keymap.set({ "n", "v" }, "<leader>ai", ":Gen<CR>")
  end,
}
