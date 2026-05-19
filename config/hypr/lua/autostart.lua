hl.on("hyprland.start", function()
	hl.exec_cmd("uwsm app -- waybar")
	hl.exec_cmd("uwsm app -- wlsunset -t 3500 -l 42.6 -L -73.7") -- albany coordinates
	hl.exec_cmd("uwsm app -- steam -silent")

end)
