extends "res://Scripts/Decisions/DecisionCore/StandardDecisionParameters.gd"

signal timeIncrease(time)

export (Texture) var texture
export var time = 0

func decisionCalculation(node, trueCalculation, player):
	if trueCalculation:
		emit_signal("timeIncrease", time)
