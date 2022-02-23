extends Control

signal playerMovement(character, position, events)

var waitingScenes = []

func queueScene(scene):
	waitingScenes.insert(waitingScenes.size(), scene)

func addWaitingScenes():
	for scene in waitingScenes:
		var sceneAsNode = scene.instance()
		$Scenes.addScene(sceneAsNode)
		waitingScenes.erase(scene)

func decisionCreation(decision):
	$Decision.decisionCreation(decision)


func _on_Decision_clearedDecision():
	$Character.finishedDecision()


func _on_Player_movement(character, position, events):
	emit_signal("playerMovement",character, position, events)
