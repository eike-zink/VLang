module main

struct Vector {
mut:
	x int
	y int
}

fn (a Vector) + (b Vector) Vector {
    return Vector {
        a.x + b.x , 
        a.y + b.y 
    }
}

fn (a Vector) - (b Vector) Vector {
    return Vector {
        a.x - b.x , 
        a.y - b.y 
    }
}

fn (a Vector) * (b Vector) Vector {
    return Vector {
        a.x * b.x, 
        a.y * b.y
    }
}

fn (a Vector) / (b Vector) Vector {
    return Vector {
        a.x / b.x, 
        a.y / b.y
    }
}