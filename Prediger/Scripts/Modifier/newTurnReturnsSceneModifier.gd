extends "res://Scripts/Modifier/ModifierInfrastructure/StandardModifierInfrastructure.gd"

export var remainingTurnCount = 0
export (PackedScene) var scene

func modify(value):
	Global.getSceneRoot().addScene(scene.instance())
	remainingTurnCount -= 1
	if remainingTurnCount == 0:
		queue_free()
