extends "res://Scripts/Decisions/DecisionCore/StandardDecisionParameters.gd"

export (Texture) var texture

var possibleAttributeChange = true

func decisionCalculation(node, trueCalculation, player):
	possibleAttributeChange = true
	var testPlayer = player.duplicate()
	for attribute in attributes:
		testPlayer.attributeChange(attribute)

	for attribute in testPlayer.calculateChanges(trueCalculation):
		if attribute.has("possibility"):
			if !attribute["possibility"]:
				possibleAttributeChange = false
	testPlayer.queue_free()
	
	if possibleAttributeChange:
		var allChanges = []
		for attribute in attributes:
			if attribute["value"] != 0:
				allChanges.insert(allChanges.size(), player.attributeChange(attribute))
	else:
		return {value        = 0,
				attribute    = "impossible",
				opposition   = null,
				texture      = texture,
				node         = self}
