extends Node

func initiateDecision(decisionsData):
	$ActiveWorld.decisionCreation(decisionsData)

func _ready():
	Global.player = $ActiveWorld/Player
	$ActiveWorld/Player.playerSetup()
	$BishopPicker.bishopChaseSetup()
	Global.nextTurn()

func _on_BishopPicker_startEnemyChase(enemy):
	$ActiveWorld/ChasingEnemies.addEnemy(enemy)
