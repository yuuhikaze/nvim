local installed, hop = pcall(require, "hop")
if not installed then
	return
end

hop.setup()
