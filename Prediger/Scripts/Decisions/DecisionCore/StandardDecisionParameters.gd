extends Node

export(StreamTexture) var image = StreamTexture
export var focusPoint = {x = 0, y = 0}
export var focusPointExpand = {x = 0.5, y = 0.5}
export (PackedScene) var viewportScene

export var text = {german  = "",
				   english = ""}


onready var imageInformation = {image = image,
								viewportScene = viewportScene,
								focusPoint = focusPoint,
								focusPointExpand = focusPointExpand}

var totalDecisionOutcomes = []
var attributes = []

func _ready():
	for child in get_children():
		if child.get("attribute") != null:
			attributes.insert(attributes.size(), child.constructInformation())


func getDecisionRootNode():
	if self.has_method("getDecisionRootNodeExtra"):
		return call("getDecisionRootNodeExtra")
	else:
		return {node = self}

func decisionCalculationInitializer(node, trueCalculation, player, depth):
	var childDecisionOutcomes = []
	totalDecisionOutcomes = []
	
	if has_method("decisionCalculation"):
		decisionOutcome(call("decisionCalculation", node, trueCalculation, player))
		trueCalculation = trueCalculationRecalculation(trueCalculation)
	
	for decisionChild in get_children():
		if decisionChild.has_method("decisionCalculationInitializer"):
			decisionOutcome(decisionChild.decisionCalculationInitializer(node, trueCalculation, player, depth+1))
		
	if depth == 0:
		decisionOutcome(node.clearDecisions(trueCalculation))
	return totalDecisionOutcomes
	
func trueCalculationRecalculation(trueCalculation):
	#Ich könnte auch einfach am Ende trueCalculation return statt den 1. if Teil, aber somit
	#muss ich nicht bei Anzeigekalkulationen die untere for-Schleife durchgehen.
	if !trueCalculation:
		return trueCalculation
	for decisionOutcome in totalDecisionOutcomes:
		if decisionOutcome.has("attribute"):
			if decisionOutcome["attribute"] == "impossible":
				return false
	return true

func decisionOutcome(decisionOutcome):
	match typeof(decisionOutcome):
		TYPE_ARRAY:
			for singleOutcome in decisionOutcome:
				totalDecisionOutcomes.insert(totalDecisionOutcomes.size(), singleOutcome)
		TYPE_DICTIONARY:
			totalDecisionOutcomes.insert(totalDecisionOutcomes.size(), decisionOutcome)
