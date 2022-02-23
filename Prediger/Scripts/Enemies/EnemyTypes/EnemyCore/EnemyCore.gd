extends Control

signal confrontation(confrontingCharacter)

export (String) var enemyType
export (Texture) var texture

var chaseSpeed = 1
var remainingTime = 0
var visibility = true
export var visibilityTurnpoint = 0
#Existiert aus einem weirden Bug, "confrontation" kam, obwohl der parent gelöscht war? Habe mich
#2 Tage lang damit beschäftigt, habs nicht gefunden, und konnte es nicht lösen. fml
var canConfront = true
var connectedNodes = []

func addChaseTime(value):
	remainingTime += value 
	updateInformationForConnections()

func getDecisions():
	if get_child(0).has_method("getDecisions"):
		return get_child(0).getDecisions()
	return null

func closeGab(overallSpeedBonus):
	remainingTime -= chaseSpeed - overallSpeedBonus
	checkState()
	
func checkState():
	visibility = visibilityTurnpoint >= remainingTime
	if remainingTime <= 0 and canConfront:
		canConfront = false
		emit_signal("confrontation", self)
	else:
		canConfront = true

func defeated():
	for node in connectedNodes:
		node.connectionGetsFreed()
	queue_free()

func addConnection(node):
	connectedNodes.insert(connectedNodes.size(), node)

func eraseConnection(node):
	connectedNodes.erase(node)

func updateInformationForConnections():
	for connectedNode in connectedNodes:
		if connectedNode.has_method("connectionGotUpdated"):
			connectedNode.connectionGotUpdated(self)

func getInformation():
	return {texture = texture,
			node = self,
			enemyType = enemyType,
			visibility = visibility,
			remainingTime = remainingTime}
