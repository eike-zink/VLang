module main

import math
import gg
import gx

struct App {
	width   int = 400
	height  int = 400
	spacing int = 20
mut:
	gg        &gg.Context = unsafe { nil }
	walker    Walker
	positions [][]int
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
		valid_directions << Vector{
			x: -1
			y: 0
		} // left
	}
	if position.x < (app.cols() - 1) {
		valid_directions << Vector{
			x: 1
			y: 0
		} // right
	}
	if position.y > 0 {
		valid_directions << Vector{
			x: 0
			y: -1
		} // down
	}
	if position.y < (app.rows() - 1) {
		valid_directions << Vector{
			x: 0
			y: 1
		} // up
	}
	return valid_directions
}

fn (mut app App) frame() {	
	app.walker.move(app.valid_directions())
	app.save_position()
	app.gg.begin()
	// Draw the previous positions
	for row in 0 .. app.rows() {
		for col in 0 .. app.cols() {
			color := gx.rgba(255, 165, 0, u8(app.positions[row][col] + 100))
			if app.positions[row][col] > 0 {
				app.draw_position(row, col, color)
			}
		}
	}
	// Draw current position
	app.draw_position(app.walker.x, app.walker.y, gx.red)
	app.gg.end()
}

fn (mut app App) save_position() {
	app.positions[app.walker.x][app.walker.y] += 10
}

fn (app App) draw_position(row int, col int, color gx.Color) {
	x := (app.spacing / 2) + (row * app.spacing)
	y := (app.spacing / 2) + (col * app.spacing)
	app.gg.draw_circle_filled(x, y, 7, color)
}
