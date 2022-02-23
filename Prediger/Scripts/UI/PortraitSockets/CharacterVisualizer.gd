extends TextureButton

signal queueFreed(node)
signal informationGotUpdatedInTurn()

var information

func portraitSetup(newInformation):
	information = newInformation
	information.node.addConnection(self)
	$Sprite.texture = information.texture
	$Timer.text = str(newInformation.remainingTime)

func imagePositioningUpdate(imageInformation):
	var textureScaling = int($Sprite.texture.get_size().x / imageInformation.size.x)
	$Sprite.scale = Vector2(1.0 / textureScaling, 1.0 / textureScaling)
	$Sprite.region_rect = Rect2((($Sprite.texture.get_size().x-imageInformation.size.x*textureScaling)/2), (($Sprite.texture.get_size().y-imageInformation.size.y*textureScaling)/2), imageInformation.size.x *textureScaling, imageInformation.size.y*textureScaling)
	rect_position = imageInformation.position
	$Sprite.position = Vector2($Sprite.get_rect().size.x / 2 * $Sprite.scale.x, $Sprite.get_rect().size.y/2 * $Sprite.scale.y)

func updatePortraitInformation():
	$Timer.text = str(information.node.remainingTime)

func connectionGotUpdated(node):
	updatePortraitInformation()
	emit_signal("informationGotUpdatedInTurn")

func connectionGetsFreed():
	emit_signal("queueFreed", self)
	queue_free()
