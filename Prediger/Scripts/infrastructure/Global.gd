extends Node

var language = "german"

var bishopCount = 3
var bishopChaseTime = 10
var turn = 0

var beliefJoinTurningPoint = 3

var modifiedProcessUsers = []
var player

func _process(delta):
	for node in modifiedProcessUsers:
		if node.has_method("modifiedProcess"):
			node.modifiedProcess(delta)

func addToModifiedProcess(node):
	modifiedProcessUsers.insert(modifiedProcessUsers.size(), node)
	
func deleteFromModifiedProcess(node):
	modifiedProcessUsers.erase(node)

func _ready():
	randomize()

func nextTurn():
	turn += 1
	var nodesTurnChange = get_tree().get_nodes_in_group("newTurn")
	for node in nodesTurnChange:
		if node.has_method("newTurn"):
			node.newTurn()


func endGame():
	turn = 0
	restartGame()

func restartGame():
	get_tree().reload_current_scene()
	turn = -1


func getCanvasSize():
	return $CanvasResizer.canvasSize


func getSceneRoot():
	return get_tree().get_nodes_in_group("sceneRoot")[0]
