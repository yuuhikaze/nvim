local installed, impatient = pcall(require, "impatient")
if not installed then
  return
end

impatient.enable_profile()
