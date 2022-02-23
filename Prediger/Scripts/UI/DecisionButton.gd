extends TextureButton

signal buttonPressed(index)
signal onButtonHover(index, value)

export (Color) var highlightedColour
export (Color) var darkenedColour

export var borderSpace = {x = 0, y = 0}
export var heightPercentage = 0.50
export var buttonSpacing = 0
export var hoverHeightPercentage = 0.30
export var speedHoveringAnimationRising = 7.0
export var speedHoveringAnimationFalling = 2.0
export var textMarginSides = 20
export var textMarginBottom = 20
var pictureRect = Rect2()
var imageData = {}
var textData = {}

var totalButtonCount = 1
var decisionIndex = 0
var parent
var player
var rootDecision

var onHovered = false
var inModifiedProcess = false

var fadeSprite #Wird unter der setFade Funktion geändert, weil onready zu langsam

func _process(_delta):
	setText()

func modifiedProcess(delta):
	moveDecision(delta)

func _on_DecisionButton_pressed():
	emit_signal("buttonPressed", decisionIndex)


func _on_DecisionButton_mouse_entered():
	if !inModifiedProcess:
		Global.call("addToModifiedProcess", self)
		inModifiedProcess = true
	onHovered = true
	emit_signal("onButtonHover", decisionIndex, true)


func _on_DecisionButton_mouse_exited():
	onHovered = false
	emit_signal("onButtonHover", decisionIndex, false)



func buttonSetup(Decision, newDecisionIndex, newTotalButtonCount, newParent, newPlayer):
	rootDecision = Decision
	player = newPlayer
	parent = newParent
	imageData = Decision.imageInformation
	$Sprite.texture = imageData["image"]
	$Sprite.modulate = darkenedColour
	pictureRect = $Sprite.get_rect()
	decisionIndex = newDecisionIndex
	totalButtonCount = newTotalButtonCount
	onCanvasChange()
	getAttributeChange(Decision)


func onCanvasChange():
	setButton()
	setSprite()
	setFade()
	setText()
	setAttributeVisualizer()


func setButton():
	rect_size.x = (Global.getCanvasSize().size.x-borderSpace.x*2 )/(totalButtonCount) - buttonSpacing * (totalButtonCount-1)/totalButtonCount
	rect_size.y = Global.getCanvasSize().size.y - Global.getCanvasSize().size.y * hoverHeightPercentage
	rect_position.y = Global.getCanvasSize().size.y * heightPercentage
	rect_position.x = - (Global.getCanvasSize().size.x-borderSpace.x*2)/2  + (decisionIndex) * (rect_size.x + buttonSpacing)

func setSprite():
	$Sprite.set_region_rect(pictureRect)
	var spriteSize = $Sprite.get_rect().size
	if imageData.has("focusPoint"):
		var focusPoint = imageData["focusPoint"]
		var spriteRect = Rect2(spriteSize.x/2 + focusPoint.x - rect_size.x*imageData["focusPointExpand"].x, spriteSize.y/2 + focusPoint.y - rect_size.y*imageData["focusPointExpand"].y, rect_size.x, rect_size.y)
		$Sprite.region_enabled = true
		$Sprite.set_region_rect(spriteRect)
		$Sprite.position = Vector2(rect_size.x/2 ,rect_size.y/2)


func setFade():
	fadeSprite = $BlackFade
	if rect_size.x == 0:
		fadeSprite.scale = Vector2(0,0)
	else:
		fadeSprite.scale.x = rect_size.x/fadeSprite.get_rect().size.x
		fadeSprite.scale.y = rect_size.y/fadeSprite.get_rect().size.y
		fadeSprite.position = Vector2(rect_size.x/2 ,rect_size.y/2)


func setText():
	var text = $Text
	text.text = rootDecision.text[Global.language]
	text.rect_size = Vector2(rect_size.x - textMarginSides*2,0)
	text.rect_position = Vector2(textMarginSides, rect_size.y-text.rect_size.y-textMarginBottom)

func setAttributeVisualizer():
	var attributeVisualizer = $AttributeVisualizer
	attributeVisualizer.rect_position.x = -20
	attributeVisualizer.rect_position.y = 20
	if rect_size.y != 0:
		attributeVisualizer.rect_size.y = rect_size.y -40

func getAttributeChange(Decision):
	$AttributeVisualizer.visualizeImpact(Decision.decisionCalculationInitializer(parent, false, player, 0))
	
func moveDecision(delta):
	var maxHoverPosition = Global.getCanvasSize().size.y * hoverHeightPercentage
	if onHovered:
		if is_equal_approx(rect_position.y, maxHoverPosition) or rect_position.y <= maxHoverPosition:
			rect_position.y =  maxHoverPosition
		else:
			var speedMultiplier = 0.05 + 1/ ((Global.getCanvasSize().size.y * heightPercentage) / (rect_position.y - Global.getCanvasSize().size.y * hoverHeightPercentage +0.01))
			rect_position.y -= Global.getCanvasSize().size.y * (heightPercentage - hoverHeightPercentage) * delta * speedHoveringAnimationRising * speedMultiplier
	else:
		if rect_position.y < Global.getCanvasSize().size.y * heightPercentage:
			var speedMultiplier = 0.1 + ((Global.getCanvasSize().size.y * heightPercentage - rect_position.y) / (Global.getCanvasSize().size.y * heightPercentage - maxHoverPosition))
			rect_position.y += Global.getCanvasSize().size.y * (heightPercentage - hoverHeightPercentage) * delta * speedHoveringAnimationFalling * speedMultiplier
		else:
			rect_position.y = Global.getCanvasSize().size.y * heightPercentage
			Global.deleteFromModifiedProcess(self)
			inModifiedProcess = false
	changeModulateBasedOnHoverDistance()

func changeModulateBasedOnHoverDistance():
	if rect_position.y - Global.getCanvasSize().size.y * hoverHeightPercentage != 0:
		var remainingHoverPercentage = (rect_position.y - Global.getCanvasSize().size.y * hoverHeightPercentage)/ (Global.getCanvasSize().size.y * heightPercentage-Global.getCanvasSize().size.y * hoverHeightPercentage)
		if remainingHoverPercentage > 1:
			remainingHoverPercentage = 1
		if remainingHoverPercentage < 0:
			remainingHoverPercentage = 0
		for key in ["r", "g", "b"]:
			$Sprite.modulate[key] = darkenedColour[key] + (highlightedColour[key] - darkenedColour[key]) * (1-remainingHoverPercentage)

func _on_DecisionButton_tree_exiting():
	Global.deleteFromModifiedProcess(self)
