extends Node

signal addedValue(type, attribute, value)
signal pointOverload(type, attribute, value)

export var type = "attribute"
export var attribute = "holy"
export var opposition = ""
export (Texture) var texture
export var value = 0
export var feedbackImportance = 0
export var lowestPossibleValue = 0
export var highestPossibleValue = 0
export var alwaysAdd = true

func constructInformation():
	return {type        = type,
			value       = value,
			attribute   = attribute,
			opposition  = opposition,
			texture     = texture,
			node        = self}

func constructReturnInformation(startValue, endValue, possibility):
	return {type        = type,
			attribute   = attribute,
			opposition  = opposition,
			startValue  = startValue,
			endValue    = endValue,
			possibility = possibility,
			texture     = texture}

func addValue(addedValue, trueCalculation):
	var saveValue = value
	value += addedValue
	
	if !alwaysAdd:
		if value < lowestPossibleValue or value > highestPossibleValue:
			value = saveValue
			return constructReturnInformation(saveValue, value+addedValue, false)
	else:
		if value > highestPossibleValue:
			if trueCalculation:
				emit_signal("pointOverload", type, attribute, value-highestPossibleValue)
			value = highestPossibleValue
		elif value < lowestPossibleValue:
			if trueCalculation:
				emit_signal("pointOverload", type, attribute, value+highestPossibleValue)
			value = lowestPossibleValue
		
	if !trueCalculation:
		value = saveValue
		return constructReturnInformation(saveValue, value+addedValue, true)
	emit_signal("addedValue", type, attribute, addedValue)
	return constructReturnInformation(saveValue, value, true)
