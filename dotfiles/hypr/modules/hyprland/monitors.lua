
hl.monitor({
	output = "",
	mode = "preferred",
	position = "auto",
	scale = "1.25",
})

hl.config({
	general = {
		allow_tearing = true
	}
})

hl.config({
  xwayland = {
    force_zero_scaling = true
  }
})
