// Beispiel aus der Dokumentation zu V
struct Vec {
	x int
	y int
}

fn (a Vec) str() string {
	return '{${a.x}, ${a.y}}'
}

fn (a Vec) + (b Vec) Vec {
	return Vec{a.x + b.x, a.y + b.y}
}

fn (a Vec) - (b Vec) Vec {
	return Vec{a.x - b.x, a.y - b.y}
}

fn (a Vec) * (b Vec) Vec {
	return Vec{a.x * b.x, a.y * b.y}
}

fn (a Vec) / (b Vec) Vec {
	return Vec{a.x / b.x, a.y / b.y}
}

type Faktor = Vec | int

// ACHTUNG ein Operator-Overloading ist hier leider
// nicht möglich, da dies nur bei Structs und Type alias
// zulässig ist (???)

fn (a Vec) multiply(f Faktor) Vec {
	return match f {
		Vec { a * f }
		int { Vec{a.x * f, a.y * f} }
	}
}

fn (a Vec) divide(f Faktor) Vec {
	return match f {
		Vec { a / f }
		int { Vec{a.x / f, a.y / f} }
	}
}

fn main() {
	a := Vec{
		x: 4
		y: 4
	}
	b := Vec{
		x: 2
		y: 2
	}

	println(a + b)         // ==> {6, 6}
	println(a - b)         // ==> {2, 2}
	println(a * b)         // ==> {8, 8}
	println(a / b)         // ==> {2, 2}
	println(a.multiply(3)) // ==> {12, 12}
	println(a.divide(2))   // ==> {2, 2}
}
