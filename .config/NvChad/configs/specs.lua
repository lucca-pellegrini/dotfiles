local specs = require("specs")

specs.setup({
  show_jumps = true,
  min_jump = 10,
  popup = {
    delay_ms = 0, -- delay before popup displays
    inc_ms = 15, -- time increments used for fade/resize effects
    blend = 50, -- starting blend, between 0-100 (fully transparent), see :h winblend
    width = 20,
    winhl = "PMenu",
    fader = specs.pulse_fader,
    resizer = specs.slide_resizer,
  },
  ignore_filetypes = {},
  ignore_buftypes = {
    nofile = true,
  },
})
