module main

pub struct Vector {
pub mut:
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