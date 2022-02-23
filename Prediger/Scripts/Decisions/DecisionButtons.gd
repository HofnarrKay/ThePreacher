extends Control

export (PackedScene) var buttonScene


signal clearedDecision(decisionIndex)


export var buttonDistance = 20
export var maxButtonsWithWiderGap = 6

var currentDecisions = []
var buttonCount = 0
var decisionIndex = 0
onready var player = Global.player

func decisionCreation(decisions, index):
	decisionIndex = index
	currentDecisions = decisions["decisions"]
	for decision in decisions["decisions"]:
		buttonCreation(buttonCount, decision)

func clearDecisions(isSceneChange):
	var calculatedValues = Global.player.calculateChanges(isSceneChange)
	if isSceneChange:
		clearButtons()
		emit_signal("clearedDecision", decisionIndex)
	return calculatedValues

func clearButtons():
	buttonCount = 0
	for button in get_children():
		button.queue_free()

func buttonCreation(index, decision):
	var button = buttonScene.instance()
	button.decisionIndex = index
	 
	button.buttonSetup(decision["node"], buttonCount, currentDecisions.size(), self, Global.player)
	button.connect("onButtonHover", self, "onButtonHover")
	button.connect("buttonPressed", self, "buttonPressed")
	add_child(button)
	buttonCount += 1


func buttonPressed(index):
	currentDecisions[index]["node"].call("decisionCalculationInitializer", self, true, Global.player, 0)

func getBaseCharacterValue(attribute):
	return get_parent().getBaseCharacterValue(attribute)

func getCharacterValue(attribute):
	return get_parent().getCharacterValue(attribute)

#Wird durch die Decision aufgerufen, die diese Node aus buttonPressed kennt
func attributeChange(attribute):
	Global.player.attributeChange(attribute)

func onButtonHover(index, value):
	if value:
		pass
