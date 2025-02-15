-- function to get paths of selected elements or current hovered file
-- of no elements are selected
local get_paths = ya.sync(function()
	local paths = {}
	-- get selected files
	for _, u in pairs(cx.active.selected) do
		paths[#paths + 1] = tostring(u)
	end
	-- if no files are selected, get current hovered file
	if #paths == 0 then
		if cx.active.current.cwd then
			paths[1] = tostring(cx.active.current.hovered.url)
		else
			ya.err("what-size would return nil paths")
		end
	end
	return paths
end)

-- Function to get total size from du output
local get_total_size = function(s)
	local lines = {}
	for line in s:gmatch("[^\n]+") do
		lines[#lines + 1] = line
	end
	local last_line = lines[#lines]
	local last_line_parts = {}
	for part in last_line:gmatch("%S+") do
		last_line_parts[#last_line_parts + 1] = part
	end
	local total_size = last_line_parts[1]
	return total_size
end

return {
	entry = function(self, job)
		-- defaults not to use clipboard, use it only if required by the user
		local clipboard = job.args.clipboard or job.args[1] == "-c"
		local cwd = job.args[1] == "cwd"

		local cmd = "du"
		local output, err

		if cwd then
			output, err = Command(cmd):arg("-sch"):output()
		else
			local items = get_paths()
			output, err = Command(cmd):arg("-sch"):args(items):output()
		end

		if not output then
			ya.err("Failed to run diff, error: " .. err)
		else
			local total_size = get_total_size(output.stdout)

			local notification_content = "Total size: " .. total_size
			if clipboard then
				ya.clipboard(total_size)
				notification_content = notification_content .. "\nCopied to clipboard."
			end

			ya.notify({
				title = "What size",
				content = notification_content,
				timeout = 5,
			})
		end
	end,
}
