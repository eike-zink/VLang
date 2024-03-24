import rand
import gg
import gx

enum Directions {
	left
	right
	up
	down
}

fn Directions.rand() Directions {
	direction := rand.int_in_range(0, 4) or { 0 }
	match direction {
		0 { return .left }
		1 { return .right }
		2 { return .up }
		else { return .down }
	}
}

struct Walker {
mut:
	x int
	y int
}

fn (walker Walker) str() string {
	return '{x:${walker.x}, y:${walker.y}}'
}

fn (mut walker Walker) move() {
	direction := Directions.rand()
	match direction {
		.left { walker.x-- }
		.right { walker.x++ }
		.up { walker.y++ }
		.down { walker.y-- }
	}
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
		window_title: 'Polygons'
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
	app.gg.end(how: .passthru)
}

fn (app &App) draw() {
	app.gg.draw_circle_filled(app.walker.x, app.walker.y, 5, gx.white)
}
