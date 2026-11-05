local M = {}

local function detect_platform()
  local os_name = pandoc.system.os
  local arch = pandoc.system.arch

  if os_name == "darwin" then
    if arch == "aarch64" or arch == "arm64" then
      return "aarch64-apple-darwin"
    else
      return "x86_64-apple-darwin"
    end
  elseif os_name == "linux" then
    if arch == "aarch64" or arch == "arm64" then
      return "aarch64-unknown-linux-gnu"
    else
      return "x86_64-unknown-linux-gnu"
    end
  elseif os_name == "windows" or os_name == "mingw32" then
    return "x86_64-pc-windows-msvc"
  end
  return nil
end

function M.find(filter_dir)
  local override = os.getenv("QUARTO_TERM_BINARY")
  if override and override ~= "" then
    return override
  end

  local project_root = filter_dir:match("(.*/?)_extensions/term/") or "./"

  local platform = detect_platform()
  if platform then
    local ext = platform:match("windows") and ".exe" or ""
    local bundled = filter_dir .. "bin/quarto-term-" .. platform .. ext
    local f = io.open(bundled, "r")
    if f then
      f:close()
      return bundled
    end
  end

  local dev_candidates = {
    project_root .. "target/release/quarto-term",
    project_root .. "target/debug/quarto-term",
    project_root .. "../target/release/quarto-term",
    project_root .. "../target/debug/quarto-term",
    "./target/release/quarto-term",
    "./target/debug/quarto-term",
  }
  for _, path in ipairs(dev_candidates) do
    local f = io.open(path, "r")
    if f then
      f:close()
      return path
    end
  end

  return "quarto-term"
end

return M
