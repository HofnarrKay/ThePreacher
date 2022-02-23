extends Node


func _on_playerMovement(character, position, events):
	var scene
	for children in get_children():
		if children.position == position:
			scene = children.getSceneMovement(events)
			break
	character.move(scene)
	#playerEvent(events)
