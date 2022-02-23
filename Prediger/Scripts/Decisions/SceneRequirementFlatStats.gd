extends "res://Scripts/Decisions/DecisionCore/StandardDecisionParameters.gd"

func getDecisionRootNodeExtra():
	var possibleDecisionInstance = true
	for attribute in attributes:
		var playerAttributeValue = Global.player.getAttributeValue(attribute["attribute"])
		if playerAttributeValue < attribute["value"] and playerAttributeValue * attribute["value"] <= 0:
			possibleDecisionInstance = false 
	if get_child_count() > 0 and possibleDecisionInstance:
		return get_child(get_child_count()-1).getDecisionRootNode()
	return null
