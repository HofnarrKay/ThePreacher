extends Node


var canvasSize = Rect2()

func _physics_process(_delta):
	var rect = get_node("/root").get_visible_rect()
	if rect != canvasSize:
		canvasSize = rect
		for node in get_tree().get_nodes_in_group("canvasAdjusting"):
			if node.has_method("onCanvasChange"):
				node.onCanvasChange()
