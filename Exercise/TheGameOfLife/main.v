module main

import gg

fn main() {
	mut app := &App{
		grid: [][]bool{len: 80, init: []bool{len: 80, init: false}}
	}
	app.gg = gg.new_context(
		width: app.width
		height: app.height
		window_title: 'Game of Life'
		init_fn: init
		frame_fn: frame
		user_data: app
	)
	app.gg.run()
}

fn init(mut app App) {
	app.init_game()
}

fn frame(mut app App) {
	app.frame()
}
