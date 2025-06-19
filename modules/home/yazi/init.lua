require("gvfs"):setup({
  -- (Optional) Allowed keys to select device.
  which_keys = "1234567890qwertyuiopasdfghjklzxcvbnm-=[]\\;',./!@#$%^&*()_+{}|:\"<>?",

  -- (Optional) Save file.
  -- Default: ~/.config/yazi/gvfs.private
  save_path = os.getenv("HOME") .. "/.config/yazi/gvfs.private"

  -- (Optional) Select where to save passwords. Default: nil
  -- Available options: "keyring", "pass", or nil
  password_vault = "keyring",

  -- (Optional) Only need if you set password_vault = "pass"
  -- Read the guide at SECURE_SAVED_PASSWORD.md for more information
  key_grip = "BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB",

  -- (Optional) save password automatically after mounting. Default: false
  save_password_autoconfirm = true,
})