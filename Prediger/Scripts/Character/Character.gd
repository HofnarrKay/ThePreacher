extends Control

signal movement(character, position, events)
signal addEnemy(enemy)

export (Array, String) var events
export (String) var position
var attributeChanges = []

func playerSetup():
	visualizePlayerStats()

func visualizePlayerStats():
	var labelText = ""
	for attributeInformation in $attributeSocket.getAllPositiveAttributeInformations():
		labelText += attributeInformation["attribute"] + ": " + str(attributeInformation["value"]) + "\n"
	$CharacterStatsUI.text = labelText

func attributeChange(attributeChange):
	var newAttributeChange = attributeChange.duplicate()
	attributeChanges.insert(attributeChanges.size(), newAttributeChange)
	
func calculateChanges(trueCalculation):
	
	var allChanges = []
	for attributeChange in attributeChanges:
		var attributeInformation = $attributeSocket.getAttributeInformation(attributeChange["attribute"])
		var addedValue = attributeInformation["node"].addValue(attributeChange["value"], trueCalculation)
		allChanges.insert(allChanges.size(), addedValue)
		if trueCalculation:
			#wirkt nicht auf modifier im OppositeValue, sehr einseitige Einwirkung. Sollte vlt gelöst werden?
			var oppositionAttributeInformation = $attributeSocket.getAttributeInformation(attributeInformation["opposition"])
			match typeof(oppositionAttributeInformation):
				TYPE_DICTIONARY:
					oppositionAttributeInformation["node"].value = -attributeInformation["node"].value
	
	attributeChanges = []
	if trueCalculation:
		visualizePlayerStats()
	return allChanges

func newTurn():
	$TurnCount.text = "Turn: " + str(Global.turn)
	for modifier in $Modifiers.get_children():
		for attribute in modifier.keyAttributes:
			if attribute == "newTurn":
				modifier.modify(Global.turn)
	calculateMovement(position, events)
	events = []
	
func calculateMovement(playerPosition, playerEvents):
	emit_signal("movement", self, playerPosition, playerEvents)
	
func move(scene):
	Global.getSceneRoot().addScene(scene)

func dieing():
	Global.restartGame()

func attributeModifiers(attribute):
	$Modifiers.attributeModifiers(attribute)

func getBaseAttributeValue(attribute):
	return $attributeSocket.getAttributeValue(attribute)

func getAttributeValue(attribute):
	return $attributeSocket.getAttributeValue(attribute)
	
func addEnemy(enemy):
	emit_signal("addEnemy", enemy)
