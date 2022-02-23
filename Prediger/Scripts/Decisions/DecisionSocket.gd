extends Node

export (PackedScene) var viewportScene
export(StreamTexture) var image = StreamTexture
export var focusPoint = {x = 0, y = 0}
export var focusPointExpand = {x = 0.5, y = 0.5}

export var mainText = {german  = "",
					   english = ""}

var allDecisions = []

onready var imageInformation = {image = image,
								viewportScene = viewportScene,
								focusPoint = focusPoint,
								focusPointExpand = focusPointExpand}

func getDecisions():
	for i in range(get_child_count()):
		if  get_child(i).has_method("appearanceCondition"):
			if !get_child(i).appearanceCondition():
				continue
		if get_child(i).getDecisionRootNode() != null:
			allDecisions.insert(allDecisions.size(), get_child(i).getDecisionRootNode())
	var decisionDict = {node      = self,
						decisions = allDecisions}
	allDecisions = []
	return decisionDict
