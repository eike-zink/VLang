import rand
import math
import gg
import gx

const width = 400
const height = 400

const spacing = 5

struct Walker {
	Vector
}

fn (walker Walker) str() string {
	return '{x:${walker.x}, y:${walker.y}}'
}

fn (mut walker Walker) move(directions []Vector) {
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

fn (app &App) valid_directions() []Vector {
	mut valid_directions := []Vector{}
	position := app.walker.Vector
	if position.x > 0 {
		valid_directions << Vector{x: -1, y: 0} // left
	}
	if position.x < app.cols {
		valid_directions << Vector{x: 1, y: 0}  // right
	}
	if position.y > 0 {
		valid_directions << Vector{x: 0, y: -1}  // down
	}
	if position.y < app.rows {
		valid_directions << Vector{x: 0, y: 1} // up
	}
	return valid_directions
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

	app.cols = int(math.floor(app.gg.window.width / spacing))
	app.rows = int(math.floor(app.gg.window.height / spacing))

	app.walker = Walker{
		x: app.cols / 2
		y: app.rows / 2
	}
	app.gg.run()
}


fn frame(mut app App) {
	app.walker.move(app.valid_directions())
	app.walker.save_position(mut app.positions)
	app.draw()
}

fn (app &App) draw() {
	app.gg.begin()
	app.gg.end()

	app.gg.begin()
	for position in app.positions {
		app.gg.draw_circle_filled(position.x * spacing, position.y * spacing, 4, gx.rgba(255,255, 120, 120))
	}
	app.gg.end(how: .passthru)
	
	app.gg.begin()
	app.gg.show_fps()
	app.gg.end(how: .passthru)
}