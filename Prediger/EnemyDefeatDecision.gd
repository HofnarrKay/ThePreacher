extends "res://Scripts/Decisions/DecisionCore/StandardDecisionParameters.gd"

signal defeated()

export (Texture) var texture

func decisionCalculation(node, trueCalculation, player):
	if trueCalculation:
		emit_signal("defeated")
	return {value        = 0,
			attribute    = "kill",
			opposition   = null,
			texture      = texture,
			node         = self}
