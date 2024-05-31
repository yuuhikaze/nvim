local installed, numb = pcall(require, "numb")
if not installed then
	return
end

numb.setup()
