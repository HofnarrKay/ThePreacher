extends Node

signal sceneChange(scene)

export (PackedScene) var plaza
export (PackedScene) var beggar
export (PackedScene) var slaveMarket

var sceneWeighting = {"plaza" : 1,
					  "beggar" : 5,
					  "slaveMarket" : 1}


onready var scenes = {"plaza" : plaza,
					  "beggar" : beggar,
					  "slaveMarket" : slaveMarket}



func scenePicker():
	emit_signal("sceneChange", randomScenePicker())


func randomScenePicker():
	var concludedSceneWeight = 0
	for sceneWeight in sceneWeighting:
		concludedSceneWeight += sceneWeighting[sceneWeight]
	var chosenScene = pickScene(randi() % concludedSceneWeight)
	return chosenScene

func pickScene(number):
	var overallSceneWeight = 1
	for scene in scenes:
		overallSceneWeight += sceneWeighting[scene]
		if overallSceneWeight >= number:
			return scenes[scene]
