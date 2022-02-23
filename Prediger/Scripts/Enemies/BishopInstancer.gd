extends Node

signal startEnemyChase(enemy)

export (PackedScene) var bishop1
export (PackedScene) var bishop2
export (PackedScene) var bishop3
export (PackedScene) var bishop4

var nonActiveBishops = []

onready var bishops = [bishop1, bishop2, bishop3, bishop4]

func bishopChaseSetup():
	startingBishops()

func startingBishops():
	nonActiveBishops = bishops
	for i in range(Global.bishopCount):
		startBishopChase(Global.bishopChaseTime * (i + 1), i)

func startBishopChase(time, difficulty):
	var bishop = nonActiveBishops[randi() % nonActiveBishops.size()]
	var bishopNode = bishop.instance()
	bishopNode.addChaseTime(time)
	emit_signal("startEnemyChase", bishopNode)
	nonActiveBishops.erase(bishop)



