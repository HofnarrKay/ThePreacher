extends Node

export (Array, String) var eventKeys = []
export var importance = 0

func pickScene():
	return randomScenePicker()

func randomScenePicker():
	var concludedSceneWeight = 0
	for scene in get_children():
		concludedSceneWeight += scene.weight
	var chosenScene = searchScene(randi() % concludedSceneWeight)
	return chosenScene.instance()


func searchScene(number):
	var overallSceneWeight = 0
	for scene in get_children():
		overallSceneWeight += scene.weight
		if overallSceneWeight > number:
			return scene.scene
