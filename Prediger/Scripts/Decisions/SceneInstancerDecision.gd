extends "res://Scripts/Decisions/DecisionCore/StandardDecisionParameters.gd"

export (PackedScene) var scene

func decisionCalculation(node, trueCalculation, player):
	if trueCalculation:
		Global.getSceneRoot().addScene(scene.instance())
