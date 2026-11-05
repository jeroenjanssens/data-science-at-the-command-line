local M = {}

local function decode(output)
  local results = pandoc.json.decode(output)
  if type(results) ~= "table" then
    io.stderr:write("quarto-term: engine returned invalid output: " .. tostring(output):sub(1, 200) .. "\n")
    return nil
  end
  return results
end

local function has_error(results)
  if type(results) ~= "table" then
    return false
  end
  for _, result in ipairs(results) do
    local err = result.error
    if err and err ~= pandoc.json.null and err ~= "" then
      return true
    end
  end
  return false
end

-- sha1 of a file's contents, or nil if it can't be read
function M.file_hash(path)
  local f = io.open(path, "rb")
  if not f then return nil end
  local content = f:read("*a")
  f:close()
  return pandoc.utils.sha1(content)
end

local function is_directory(path)
  local ok, entries = pcall(pandoc.system.list_directory, path)
  return ok and type(entries) == "table"
end

-- Hashes of the files in `paths` (files or directories, walked recursively),
-- as sorted "path\0sha1" strings. Missing paths are recorded as missing, so
-- creating them later changes the key too.
function M.dependency_hashes(paths)
  local out = {}
  local function add(path)
    if is_directory(path) then
      local entries = pandoc.system.list_directory(path)
      table.sort(entries)
      for _, name in ipairs(entries) do
        add(path .. "/" .. name)
      end
    else
      table.insert(out, path .. "\0" .. (M.file_hash(path) or "missing"))
    end
  end
  for _, path in ipairs(paths or {}) do
    add(path)
  end
  table.sort(out)
  return out
end

-- Id of the local Docker image (changes when a tag points to a new image),
-- or "" if Docker or the image isn't available
function M.image_id(image)
  if not image then return "" end
  local p = io.popen("docker image inspect --format '{{.Id}}' '" .. image:gsub("'", "") .. "' 2>/dev/null")
  if not p then return "" end
  local id = p:read("*a") or ""
  p:close()
  return (id:gsub("%s+$", ""))
end

-- The cache key: everything that can change the results of a document
function M.key(parts)
  local lines = {
    "key-v2",
    "version " .. (parts.version or ""),
    "engine " .. (parts.engine_hash or ""),
    "image " .. (parts.image_id or ""),
  }
  for _, dep in ipairs(parts.dependencies or {}) do
    table.insert(lines, "dep " .. dep)
  end
  table.insert(lines, parts.input_json)
  return pandoc.utils.sha1(table.concat(lines, "\n"))
end

function M.run(input_json, opts)
  local use_cache = opts.cache ~= false
  local engine = opts.engine
  local verbose = opts.verbose
  local version = opts.version

  if use_cache then
    local engine_hash = M.file_hash(engine) or ""
    local image_id = opts.docker_image and M.image_id(opts.docker_image) or ""
    local dependencies = M.dependency_hashes(opts.dependencies)
    local cache_key = M.key({
      version = version,
      engine_hash = engine_hash,
      image_id = image_id,
      dependencies = dependencies,
      input_json = input_json,
    })
    if verbose then
      io.stderr:write(string.format(
        "quarto-term: cache key %s (engine %s, image %s, %d dependency files)\n",
        cache_key:sub(1, 8), engine_hash:sub(1, 8),
        image_id ~= "" and image_id:gsub("^sha256:", ""):sub(1, 12) or "none", #dependencies))
    end
    local cache_dir = pandoc.system.get_working_directory() .. "/.quarto-term-cache"
    local cache_file = cache_dir .. "/" .. cache_key .. ".json"
    local cf = io.open(cache_file, "r")
    if cf then
      local cached = cf:read("*a")
      cf:close()
      if verbose then
        io.stderr:write("quarto-term: cache hit (" .. cache_key:sub(1, 8) .. ")\n")
      end
      return decode(cached)
    else
      local ok, output = pcall(pandoc.pipe, engine, {}, input_json)
      if not ok then
        io.stderr:write("quarto-term: engine error: " .. tostring(output) .. "\n")
        return nil
      end
      local results = decode(output)
      if not results then return nil end
      -- Don't cache failed cells, so the next render retries them
      if has_error(results) then
        if verbose then
          io.stderr:write("quarto-term: cache miss, not stored due to errors (" .. cache_key:sub(1, 8) .. ")\n")
        end
        return results
      end
      os.execute('mkdir -p "' .. cache_dir .. '"')
      local wf = io.open(cache_file, "w")
      if wf then
        wf:write(output)
        wf:close()
      end
      if verbose then
        io.stderr:write("quarto-term: cache miss, stored (" .. cache_key:sub(1, 8) .. ")\n")
      end
      return results
    end
  else
    local ok, output = pcall(pandoc.pipe, engine, {}, input_json)
    if not ok then
      io.stderr:write("quarto-term: engine error: " .. tostring(output) .. "\n")
      return nil
    end
    return decode(output)
  end
end

return M
