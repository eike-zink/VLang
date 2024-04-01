module main

import math
import rand
import gg
import gx

struct App {
	width   int = 800
	height  int = 800
	spacing int = 10
mut:
	gg   &gg.Context = unsafe { nil }
	grid [][]bool
}

fn (app App) cols() int {
	return int(math.floor(app.width / app.spacing))
}

fn (app App) rows() int {
	return int(math.floor(app.height / app.spacing))
}

fn (mut app App) init_game() {
	for row in 0 .. app.rows() {
		for col in 0 .. app.cols() {
			// The status of 20 percent of the cells is changed
			random_value := rand.int_in_range(1, 100) or { panic('No random value') }
			if random_value >= 80 {
				app.grid[row][col] = true
			}
		}
	}
}

fn (mut app App) frame() {
	// Draw the grid
	app.gg.begin()
	for row in 0 .. app.rows() {
		for col in 0 .. app.cols() {
			if app.grid[row][col] == true {
				app.draw_cell(row, col)
			}
		}
	}
	app.gg.end()
	// Compute next based on grid
	mut next := [][]bool{len: 80, init: []bool{len: 80, init: false}}
	for row in 0 .. app.rows() {
		for col in 0 .. app.cols() {
			state := app.grid[row][col]
			neighbors := app.count_neighbors(row, col)
			if neighbors == 3 {
				next[row][col] = true
			} else if neighbors < 2 || neighbors > 3 {
				next[row][col] = false
			} else {
				next[row][col] = state
			}
		}
	}
	app.grid = next
}

fn (app App) draw_cell(row int, col int) {
	x := row * app.spacing
	y := col * app.spacing
	app.gg.draw_rect(x: x + 1, y: y + 1, w: 8, h: 8, color: gx.orange, style: .fill)
	app.gg.draw_rect(x: x, y: y, w: 10, h: 10, color: gx.black, style: .stroke)
}

fn (app App) count_neighbors(row int, col int) int {
	mut neighbors := 0
	for i := -1; i < 2; i++ {
		for j := -1; j < 2; j++ {
			if i == 0 && j == 0 {
				continue
			}
			next_row := int(math.mod(row + i + app.rows(), app.rows()))
			next_col := int(math.mod(col + j + app.cols(), app.cols()))
			if app.grid[next_row][next_col] {
				neighbors += 1
			}
		}
	}
	return neighbors
}
