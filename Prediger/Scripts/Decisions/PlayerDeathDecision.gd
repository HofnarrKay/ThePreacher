extends "res://Scripts/Decisions/DecisionCore/StandardDecisionParameters.gd"

export (Texture) var texture


func decisionCalculation(node, trueCalculation, player):
	if trueCalculation:
		player.dieing()
	return {value        = 0,
			attribute    = "death",
			opposition   = null,
			texture      = texture,
			node         = self}
