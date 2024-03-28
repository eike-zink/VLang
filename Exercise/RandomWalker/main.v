module main

import gg

fn main() {
	mut app := &App{
		positions: [][]int{len: 80, init: []int{len: 80, init: 0}}
	}
	app.gg = gg.new_context(
		width: app.width
		height: app.height
		window_title: 'Random Walker'
		frame_fn: frame
		user_data: app
	)

	app.walker = Walker{
		x: app.cols() / 2
		y: app.rows() / 2
	}
	app.gg.run()
}

fn frame(mut app App) {
	app.frame()
}
