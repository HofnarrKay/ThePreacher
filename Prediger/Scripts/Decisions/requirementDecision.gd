extends "res://Scripts/Decisions/DecisionCore/StandardDecisionParameters.gd"

export (Texture) var texture

func decisionCalculation(node, trueCalculation, player):
	var requirementIsMet = true
	
	var testPlayer = player.duplicate()
	for attribute in attributes:
		testPlayer.attributeChange(getInformationOnly(attribute))
	
	for playerAttribute in testPlayer.calculateChanges(trueCalculation):
		for attribute in attributes:
			if attribute["attribute"] == playerAttribute["attribute"]:
				if playerAttribute["endValue"] * attribute["value"] <= 0 or abs(playerAttribute["endValue"]) < abs(attribute["value"]):
					requirementIsMet = false
	
	testPlayer.queue_free()
	if requirementIsMet:
		if get_child_count() == 1:
			if get_child(0).has_method("decisionCalculation"):
				get_child(0).decisionCalculation(node, trueCalculation, player)
	else:
		return {value        = 0,
				attribute    = "impossible",
				opposition   = null,
				texture      = texture,
				node         = self}

func getInformationOnly(attribute):
	var testAttribute = attribute.duplicate()
	testAttribute["value"] = 0
	return testAttribute
