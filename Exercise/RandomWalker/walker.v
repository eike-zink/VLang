import rand
import math
import gg
import gx

const directions = [
	Vector{
		x: -1
		y: 0
	}, // left
	Vector{
		x: 1
		y: 0
	}, // right
	Vector{
		x: 0
		y: 1
	}, // up
	Vector{
		x: 0
		y: -1
	}, // down
]

const width = 400
const height = 400

const spacing = 5

struct Walker {
	Vector
}

fn (walker Walker) str() string {
	return '{x:${walker.x}, y:${walker.y}}'
}

fn (mut walker Walker) move() {
	new_direction := rand.element(directions) or { panic('no direction') }
	walker.Vector = walker.Vector + new_direction
}

fn (walker Walker) save_position(mut pos []Vector) {
	pos << walker.Vector
}

struct App {
mut:
	gg        &gg.Context = unsafe { nil }
	walker    Walker
	cols      int
	rows      int
	positions []Vector
}

fn main() {
	mut app := &App{}
	app.gg = gg.new_context(
		width: width
		height: height
		window_title: 'Random Walker'
		frame_fn: frame
		user_data: app
	)

	app.cols = int(math.floor(width / spacing))
	app.rows = int(math.floor(height / spacing))

	app.walker = Walker{
		x: app.cols / 2
		y: app.rows / 2
	}
	app.gg.run()
}

fn frame(mut app App) {
	app.gg.begin()
	app.walker.move()
	app.walker.save_position(mut app.positions)
	app.draw()
	app.gg.end()
}

fn (app &App) draw() {
	for position in app.positions {
		app.gg.draw_circle_filled(position.x * spacing, position.y * spacing, 4, gx.rgba(255,
			255, 120, 120))
	}
}
