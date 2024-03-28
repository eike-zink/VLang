module main

import math
import gg
import gx

const spacing = 5

struct App {
	width  int = 400
	height int = 400
mut:
	gg        &gg.Context = unsafe { nil }
	walker    Walker
	positions [][]int
}

fn (app App) cols() int {
	return int(math.floor(app.width / spacing))
}

fn (app App) rows() int {
	return int(math.floor(app.height / spacing))
}

fn (app App) valid_directions() []Vector {
	mut valid_directions := []Vector{}
	position := app.walker.Vector
	if position.x > 0 {
		valid_directions << Vector{x: -1, y: 0} // left
	}
	if position.x < (app.cols() - 1) {
		valid_directions << Vector{x: 1, y: 0}  // right
	}
	if position.y > 0 {
		valid_directions << Vector{x: 0, y: -1}  // down
	}
	if position.y < (app.rows() - 1) {
		valid_directions << Vector{x: 0, y: 1} // up
	}
	return valid_directions
}

fn (mut app App) save_position() {
	app.positions[app.walker.x][app.walker.y] += 10
}

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
	app.walker.move(app.valid_directions())
	app.save_position()
	app.gg.begin()
	// Draw the previous positions
	for row in 0 .. app.rows() {
		for col in 0 .. app.cols() {
			color := gx.rgba(255, 165, 0, u8(app.positions[row][col] + 100))
			if app.positions[row][col] > 0 {
				draw_position(app, row, col, color)
			} 
		}
	}
	// Draw current position
	draw_position(app, app.walker.x, app.walker.y, gx.red)
	app.gg.end()
}

fn draw_position(app App, row int, col int, color gx.Color) {
	x := (spacing / 2) + (row * spacing)
	y := (spacing / 2) + (col * spacing)
	app.gg.draw_circle_filled(x, y, 2, color)
}