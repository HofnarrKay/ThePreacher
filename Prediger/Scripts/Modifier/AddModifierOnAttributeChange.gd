extends "res://Scripts/Modifier/ModifierInfrastructure/StandardModifierInfrastructure.gd"

export var addValue = 0
export var pairedAttributeList = [[]]

var modifierPriority = 1

func modifier(i, node):
	return node.attributeList[keyAttributes[i]] + addValue
