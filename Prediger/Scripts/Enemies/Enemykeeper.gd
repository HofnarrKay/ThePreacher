extends Node

func newTurn():
	for enemy in get_children():
		if enemy.has_method("closeGab"):
			enemy.closeGab(0)
