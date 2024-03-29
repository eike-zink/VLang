module main

import math
import gg
import gx

struct App {
	width   int = 400
	height  int = 400
	spacing int = 15
mut:
	gg        &gg.Context = unsafe { nil }
	walker    Walker
	positions []Vector
}

fn (app App) cols() int {
	return int(math.floor(app.width / app.spacing))
}

fn (app App) rows() int {
	return int(math.floor(app.height / app.spacing))
}

fn (app App) valid_directions() []Vector {
	position := app.walker.Vector
	mut options := []Vector{}
	if position.x > 0 {
		options << Vector{
			x: -1
			y: 0
		} // left
	}
	if position.x < (app.cols() - 1) {
		options << Vector{
			x: 1
			y: 0
		} // right
	}
	if position.y > 0 {
		options << Vector{
			x: 0
			y: -1
		} // down
	}
	if position.y < (app.rows() - 1) {
		options << Vector{
			x: 0
			y: 1
		} // up
	}
	mut valid_directions := []Vector{}
	for option in options {
		new_position := position + option
		if new_position !in app.positions {
			valid_directions << option
		}
	}
	return valid_directions
}

fn (mut app App) frame() {
	app.walker.move(app.valid_directions())
	app.save_position()
	app.gg.begin()
	// Draw the previous positions
	for i in 0 .. app.positions.len {
		position := app.positions[i]
		app.draw_position(position, gx.orange)
		if i > 0 {
			last_position := app.positions[i-1]
			app.draw_line(last_position, position, gx.orange)
		}
	}
	// Draw current position
	app.draw_position(app.walker.Vector, gx.red)
	app.gg.end()
}

fn (mut app App) save_position() {
	app.positions << app.walker.Vector
}

fn (app App) draw_position(v Vector, color gx.Color) {
	x := (app.spacing / 2) + (v.x * app.spacing)
	y := (app.spacing / 2) + (v.y * app.spacing)
	app.gg.draw_circle_filled(x, y, 5, color)
}

fn (app App) draw_line(a Vector, b Vector, color gx.Color) {
	x := (app.spacing / 2) + (a.x * app.spacing)
	y := (app.spacing / 2) + (a.y * app.spacing)
	x2 := (app.spacing / 2) + (b.x * app.spacing)
	y2 := (app.spacing / 2) + (b.y * app.spacing)
	app.gg.draw_line(x, y, x2, y2, color)
}
