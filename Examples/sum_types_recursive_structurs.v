// Beispiel aus der Dokumentation zu V
// V`s binary tree

struct Empty {}

struct Node {
	value int
	left  Tree
	right Tree
}

type Tree = Empty | Node

// sum up all node values

fn sum(tree Tree) int {
	return match tree {
		Empty { 0 }
		Node { tree.value + sum(tree.left) + sum(tree.right) }
	}
}

fn main() {
	left := Node{2, Empty{}, Empty{}}
	right := Node{3, Empty{}, Node{4, Empty{}, Empty{}}}
	tree := Node{5, left, right}
	println(sum(tree)) // ==> 2 + 3 + 4 + 5 = 14
}
