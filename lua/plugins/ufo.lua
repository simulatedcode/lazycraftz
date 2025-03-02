return {
  "kevinhwang91/nvim-ufo",
  dependencies = { "kevinhwang91/promise-async" },
  event = "BufReadPost",
  opts = {
    provider_selector = function(_, _, _)
      return { "treesitter", "indent" }
    end,
    fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
      local newVirtText = {}
      local suffix = (" 󰅀 %d "):format(endLnum - lnum) -- VSCode-style fold indicator
      local sufWidth = vim.fn.strdisplaywidth(suffix)
      local targetWidth = width - sufWidth
      local curWidth = 0

      for _, chunk in ipairs(virtText) do
        local chunkText = chunk[1]
        local chunkWidth = vim.fn.strdisplaywidth(chunkText)

        if targetWidth > curWidth + chunkWidth then
          table.insert(newVirtText, chunk)
        else
          chunkText = truncate(chunkText, targetWidth - curWidth)
          table.insert(newVirtText, { chunkText, chunk[2] })
          break
        end
        curWidth = curWidth + chunkWidth
      end
      table.insert(newVirtText, { suffix, "MoreMsg" }) -- Highlight color
      return newVirtText
    end,
  },
  config = function(_, opts)
    require("ufo").setup(opts)

    -- Set fold column icons like VSCode
    vim.fn.sign_define("FoldClosed", { text = "", texthl = "FoldColumn" }) -- Arrow Right
    vim.fn.sign_define("FoldOpened", { text = "", texthl = "FoldColumn" }) -- Arrow Down
    vim.fn.sign_define("FoldSeparator", { text = " ", texthl = "FoldColumn" })

    -- Folding keymaps
    vim.keymap.set("n", "zR", require("ufo").openAllFolds, { desc = "Open all folds" })
    vim.keymap.set("n", "zM", require("ufo").closeAllFolds, { desc = "Close all folds" })
    vim.keymap.set("n", "zr", require("ufo").openFoldsExceptKinds, { desc = "Reduce folding level" })
    vim.keymap.set("n", "zm", require("ufo").closeFoldsWith, { desc = "Increase folding level" })
  end,
}
