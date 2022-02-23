extends TextureRect

export (PackedScene) var icon
var impact

func visualizeImpact(newImpact):
	impact = newImpact.duplicate()
	for singleImpact in impact:
		if singleImpact.has("texture"):
			addIcon(singleImpact["texture"])


func addIcon(iconTexture):
	var iconNode = icon.instance()
	iconNode.texture = iconTexture
	iconNode.position.y = iconNode.get_rect().size.y * get_child_count()
	add_child(iconNode)

