extends Node

signal initiateDecision(decisions)

var currentScenes = []


func addScene(scene):
	add_child(scene)
	if scene.has_method("getDecisions"):
		emit_signal("initiateDecision", scene.getDecisions())
	currentScenes.insert(currentScenes.size(), scene)

func resetScene():
	if currentScenes != null:
		for currentScene in currentScenes:
			currentScene.queue_free()
		currentScenes = []

func _on_ScenePicker_sceneChange(scene):
	addScene(scene)
