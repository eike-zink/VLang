import math

struct Cell {
	x int
	y int
}

struct Grid {
	dim_x int
	dim_y int
	grid  [][]Cell
mut:
	idx int
}

fn (grid Grid) len() int {
	return grid.dim_x * grid.dim_y
}

fn (mut iter Grid) next() ?Cell {
	if iter.idx >= iter.len() {
		return none
	}
	defer {
		iter.idx++
	}
	x := int(math.mod(iter.idx, iter.dim_x))
	y := int(iter.idx / iter.dim_x)
	return iter.grid[x][y]
}

fn Grid.new(dim_x int, dim_y int) Grid {
	mut grid := [][]Cell{len: dim_x, init: []Cell{len: dim_y}}
	for x in 0 .. dim_x {
		for y in 0 .. dim_y {
			grid[x][y] = Cell{x, y}
		}
	}
	return Grid{
		dim_x: dim_x
		dim_y: dim_y
		grid: grid
	}
}

fn main() {
	grid := Grid.new(5, 1)
	for cell in grid {
		println(cell)
	}
}
