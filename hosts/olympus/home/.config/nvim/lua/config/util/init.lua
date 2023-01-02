local M = {}

---
---loads a lua file with pcall and logs the path if it fails to load
---@param module_path string path to the lua file
---@param func_name? string name of the function to call on the required module
---@returns fun
M.safe_load = function(module_path, func_name, ...)
	local params = { ... }

	local ok, result = pcall(require, module_path)

	if not ok then
		print(string.format('Error loading "%s". Error:\n%s', module_path, result))
		return
	end

	if not func_name then
		return
	end

	result[func_name](unpack(params))
end

M.bind = function(func, ...)
	local params = { ... }
	return function()
		return func(unpack(params))
	end
end

function M.require(module_path)
	local ok, ret = M.try(require, module_path)
	return ok and ret
end

function M.try(fn, ...)
	local args = { ... }

	return xpcall(function()
		return fn(unpack(args))
	end, function(err)
		local lines = {}
		table.insert(lines, err)
		table.insert(lines, debug.traceback("", 3))

		M.error(table.concat(lines, "\n"))
		return err
	end)
end

function M.error(msg, name)
	vim.notify(msg, vim.log.levels.ERROR, { title = name or "init.lua" })
end

return M
