extends TextureButton


signal buttonPressed(index)
signal onButtonHover(index, value)

var totalButtonCount = 1
var decisionIndex = 0

func _on_DecisionOverviewButton_pressed():
	emit_signal("buttonPressed", decisionIndex)


func _on_DecisionOverviewButton_mouse_entered():
	emit_signal("onButtonHover", decisionIndex, true)


func _on_DecisionOverviewButton_mouse_exited():
	emit_signal("onButtonHover", decisionIndex, false)


export var borderSpace = {x = 0, y = 0}
export var heightPercentage = 0.40
var pictureRect = Rect2()
var imageData = {}

func buttonSetup(newImageData, newDecisionIndex, newTotalButtonCount):
	imageData = newImageData
	#$Sprite.texture = imageData["image"]
	$Sprite.flip_v = true
	viewportTextureAsSpriteTexture()
	pictureRect = $Sprite.get_rect()
	decisionIndex = newDecisionIndex
	totalButtonCount = newTotalButtonCount
	onCanvasChange()

func viewportTextureAsSpriteTexture():
	var viewportContent = imageData["viewportScene"].instance()
	$Viewport.add_child(viewportContent)
	$Viewport.size = viewportContent.get_rect().size

func onCanvasChange():
	setButton()
	setSprite()
	setFade()

func setButton():
	rect_size.x = (Global.getCanvasSize().size.x-borderSpace.x*2)/(totalButtonCount)
	rect_size.y = Global.getCanvasSize().size.y * heightPercentage - borderSpace.y
	rect_position.y = borderSpace.y
	rect_position.x = - (Global.getCanvasSize().size.x-borderSpace.x*2)/2  + (decisionIndex) * rect_size.x


func setSprite():
	$Sprite.set_region_rect(pictureRect)
	var spriteSize = $Sprite.get_rect().size
	var focusPoint = imageData["focusPoint"]
	print(imageData["focusPointExpand"].y)
	var spriteRect = Rect2(spriteSize.x/2 + focusPoint.x - rect_size.x*imageData["focusPointExpand"].x,(spriteSize.y/2 +  focusPoint.y*-1 + rect_size.y*(1-imageData["focusPointExpand"].y)*-1), rect_size.x, rect_size.y)
	$Sprite.region_enabled = true
	$Sprite.set_region_rect(spriteRect)
	$Sprite.position = Vector2(rect_size.x/2 ,rect_size.y/2)
	
func setFade():
	var fadeSprite = $BlackFade
	if rect_size.x == 0:
		fadeSprite.scale = Vector2(0,0)
	else:
		fadeSprite.scale.x = rect_size.x/fadeSprite.get_rect().size.x
		fadeSprite.scale.y = rect_size.y/fadeSprite.get_rect().size.y
		fadeSprite.position = Vector2(rect_size.x/2 ,rect_size.y/2)
