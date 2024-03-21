struct Vec {
	x int
	y int
}

fn (a Vec) str() string {
	return '{${a.x}, ${a.y}}'
}

fn (a Vec) + (b Vec) Vec {
	return Vec{
		a.x + b.x,
		a.y + b.y
	}
}

fn (a Vec) - (b Vec) Vec {
	return Vec{
		a.x - b.x,
		a.y - b.y
	}
}

fn (a Vec) * (b Vec) Vec {
	return Vec{
		a.x * b.x,
		a.y * b.y
	}
}

fn (a Vec) / (b Vec) Vec {
	return Vec{
		a.x / b.x,
		a.y / b.y
	}
}

fn main() {
 	a := Vec{x: 4, y: 4}
 	b := Vec{x: 2, y: 2}

 	println(a + b) // ==> {6, 6}
 	println(a - b) // ==> {2, 2}
 	println(a * b) // ==> {8, 8}
 	println(a / b) // ==> {2, 2}
}
