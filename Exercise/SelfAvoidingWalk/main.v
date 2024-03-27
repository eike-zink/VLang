module main

import math
import gg
import gx

struct App {
	width  int = 400
	height int = 400
	spacing int = 5
mut:
	gg   &gg.Context = unsafe { nil }
	walker Walker
	grid [][]bool
}

fn (app App) cols() int {
	return int(math.floor(app.width / app.spacing))
}


fn (app App) rows() int {
	return int(math.floor(app.height / app.spacing))
}

fn (app App) valid_directions() []Vector {
	mut valid_directions := []Vector{}
	position := app.walker.Vector
	if position.x > 0 {
		valid_directions << Vector{x: -1, y: 0} // left
	}
	if position.x < app.cols() {
		valid_directions << Vector{x: 1, y: 0}  // right
	}
	if position.y > 0 {
		valid_directions << Vector{x: 0, y: -1}  // down
	}
	if position.y < app.rows() {
		valid_directions << Vector{x: 0, y: 1} // up
	}
	return valid_directions
}

fn (app App) save_position() {
	app.grid[app.walker.x][app.walker.y] = true
}

fn main() {
	mut app := &App{
		grid: [][]bool{len: 80, init: []bool{len: 80, init: false}}
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
	app.walker.move(app.valid_directions())
	app.save_position()
	app.gg.begin()
	for row in 1 .. app.rows() {
		for col in 1 .. app.cols() {
			if app.grid[row][col] {
				app.gg.draw_circle_filled(row * app.spacing, col * app.spacing, 2, gx.rgba(255,255, 120, 180))
			} else {
				app.gg.draw_circle_filled(row * app.spacing, col * app.spacing, 2, gx.rgba(255,255, 120, 80))
			}
		}
	}
	app.gg.end()
}

