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

function M.run(input_json, opts)
  local use_cache = opts.cache ~= false
  local engine = opts.engine
  local verbose = opts.verbose
  local version = opts.version

  if use_cache then
    local engine_size = ""
    local ef = io.open(engine, "r")
    if ef then
      engine_size = tostring(ef:seek("end"))
      ef:close()
    end
    local cache_key = pandoc.utils.sha1(version .. "\n" .. engine_size .. "\n" .. input_json)
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
