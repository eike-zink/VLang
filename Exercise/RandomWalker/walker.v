import rand
import gg
import gx

const directions :=[
  Vector{x: -2, y: 0},  // left
  Vector{x: 2, y: 0},   // right
  Vector{x: 0, y: 2},	// up
  Vector{x: 0, y: -2}   // down
]

const speed := Vector{x: 2, y: 2}

struct Walker {
	Vector
}

fn (walker Walker) str() string {
	return '{x:${walker.x}, y:${walker.y}}'
}

fn (mut walker Walker) move() {
	new_direction := rand.element(directions) or { panic('no direction')}
	walker.Vector = walker.Vector + (new_direction * speed)
}


struct App {
mut:
	gg     &gg.Context = unsafe { nil }
	walker Walker
}

fn main() {
	mut app := &App{}
	app.gg = gg.new_context(
		width: 600
		height: 600
		window_title: 'Random Walker'
		frame_fn: frame
		user_data: app
	)
	app.walker = Walker{
		x: 300
		y: 300
	}
	app.gg.run()
}

fn frame(mut app App) {
	app.gg.begin()
	app.walker.move()
	app.draw()
	// Option verhindert, dass der Context neu gezeichnet
	// wird, aber jetzt wird der Background rot dargestellt
	app.gg.end(how: .passthru)
}

fn (app &App) draw() {
	app.gg.draw_circle_filled(app.walker.x, app.walker.y, 4, gx.rgba(255, 255, 120, 60))
}
