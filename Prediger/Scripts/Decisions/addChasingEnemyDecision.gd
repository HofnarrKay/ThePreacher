extends "res://Scripts/Decisions/DecisionCore/StandardDecisionParameters.gd"

export (Texture) var texture
export (PackedScene) var enemyScene
export (int) var chaseTime

func decisionCalculation(node, trueCalculation, player):
	if trueCalculation:
		var enemy = enemyScene.instance()
		enemy.addChaseTime(chaseTime)
		player.addEnemy(enemy)
	return {value        = 0,
			attribute    = "addEnemy",
			opposition   = null,
			texture      = texture,
			node         = self}
