local curl = require 'plenary.curl'

local M = {
  -- Where to fetch CRD JSON files
  schemas_catalog = 'datreeio/CRDs-catalog',
  schema_catalog_branch = 'main',
  -- GitHub API info
  github_base_api_url = 'https://api.github.com/repos',
  github_headers = {
    Accept = 'application/vnd.github+json',
    ['X-GitHub-Api-Version'] = '2022-11-28',
  },
}

-- Base URL for raw JSON schemas in that repo
M.schema_url = 'https://raw.githubusercontent.com/' .. M.schemas_catalog .. '/' .. M.schema_catalog_branch

-- List all JSON files from the GitHub repo tree
M.list_github_tree = function()
  local url = M.github_base_api_url .. '/' .. M.schemas_catalog .. '/git/trees/' .. M.schema_catalog_branch
  local response = curl.get(url, { headers = M.github_headers, query = { recursive = 1 } })
  local body = vim.fn.json_decode(response.body)
  local trees = {}
  for _, tree in ipairs(body.tree) do
    -- Only pick up .json files
    if tree.type == 'blob' and tree.path:match '%.json$' then
      table.insert(trees, tree.path)
    end
  end
  return trees
end

-- The main function to pick & insert a schema
M.init = function()
  local all_crds = M.list_github_tree()
  vim.ui.select(all_crds, { prompt = 'Select schema: ' }, function(selection)
    if not selection then
      vim.notify('No schema selected.', vim.log.levels.INFO)
      return
    end
    local schema_url = M.schema_url .. '/' .. selection
    local schema_modeline = '# yaml-language-server: $schema=' .. schema_url

    -- Insert at the top of current buffer
    vim.api.nvim_buf_set_lines(0, 0, 0, false, { schema_modeline })
    vim.notify('Added schema modeline: ' .. schema_modeline)
  end)
end

return M

