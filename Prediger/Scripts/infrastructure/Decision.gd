extends Control

export (PackedScene) var buttonScene


export (Color) var highlightedColour
export (Color) var darkenedColour

var currentDecisionFoundations = []
var currentDecisionFoundationButtons = []
var buttonCount = 0
var activeButton = 0

func decisionCreation(decisions):
	currentDecisionFoundations.insert(currentDecisionFoundations.size(), decisions)
	resetButtons()
	createDecisionOverview()
	if currentDecisionFoundations.size() == 1:
		createDecision(decisions, 0)
		activeButton = 0
		

func createDecisionOverview():
	for decisions in range(currentDecisionFoundations.size() - buttonCount):
		buttonCreation(buttonCount, decisions)
	move_child($DecisionButtons, get_child_count())
	changeButtonModulate()

func resetButtons():
	for button in currentDecisionFoundationButtons:
		button.queue_free()
	currentDecisionFoundationButtons = []
	buttonCount = 0

func buttonCreation(index, _decision):
	var button = buttonScene.instance()
	currentDecisionFoundationButtons.insert(currentDecisionFoundationButtons.size() , button)
	
	button.buttonSetup(currentDecisionFoundations[index]["node"],index, currentDecisionFoundations.size()) 
	button.connect("buttonPressed", self, "buttonPressed")
	add_child(button)
	buttonCount += 1


func _on_DecisionButtons_clearedDecision(decisionIndex):
	resetButtons()
	currentDecisionFoundations.erase(currentDecisionFoundations[decisionIndex])
	activeButton = 0
	if currentDecisionFoundations.size() == 0:
		Global.nextTurn()
	else:
		createDecisionOverview()
		createDecision(currentDecisionFoundations[0], 0)

func createDecision(decisions, decisionIndex):
	$DecisionButtons.decisionCreation(decisions, decisionIndex)


func buttonPressed(index):
	$DecisionButtons.clearButtons()
	activeButton = index
	changeButtonModulate()
	createDecision(currentDecisionFoundations[index], index)

func changeButtonModulate():
	for i in currentDecisionFoundationButtons.size():
		if i == activeButton:
			currentDecisionFoundationButtons[i].modulate = highlightedColour
		else:
			currentDecisionFoundationButtons[i].modulate = darkenedColour

func getBaseCharacterValue(attribute):
	return get_parent().getBaseCharacterValue(attribute)

func getCharacterValue(attribute):
	return get_parent().getCharacterValue(attribute)
