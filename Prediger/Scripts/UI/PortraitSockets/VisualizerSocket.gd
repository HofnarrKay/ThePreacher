extends Control

export (PackedScene) var characterVisualizer
export var standardImageInformation = {size = Vector2(300, 400),
									   position = Vector2(0, 0)}

export var nonPrimarySize = Vector2(300, 200)
var childListWithPosition = []

func createVisualizer(eventInformation):
	var visualizedCharacter = characterVisualizer.instance()
	var positionNumber = get_child_count()
	childListWithPosition.insert(childListWithPosition.size(), {node = visualizedCharacter, oldPosition = childListWithPosition.size()})
	updateImagePosition(visualizedCharacter, positionNumber)
	visualizedCharacter.portraitSetup(eventInformation)
	visualizedCharacter.connect("queueFreed", self, "erasedChildInList")
	updateVisualizer()
	add_child(visualizedCharacter)
	
func updateVisualizer():
	for child in get_children():
		child.updatePortraitInformation()

	childListWithPosition.sort_custom(EventSorterByRemainingTime, "sort_ascending")
	for i in childListWithPosition.size():
		if i != childListWithPosition[i].oldPosition:
			updateImagePosition(childListWithPosition[i].node, i)

func updateImagePosition(node, positionNumber):
	var imageInformation = standardImageInformation.duplicate()
	if positionNumber > 0:
		imageInformation.size = nonPrimarySize
		imageInformation.position.y -= imageInformation.size.y * positionNumber
	node.imagePositioningUpdate(imageInformation)

func erasedChildInList(node):
	for i in range(childListWithPosition.size()):
		if childListWithPosition[i].node == node:
			childListWithPosition.erase(childListWithPosition[i])
			break
	updateVisualizer()

class EventSorterByRemainingTime:
	static func sort_ascending(eventA, eventB):
		if eventA.node.information.remainingTime < eventB.node.information.remainingTime:
			return true
		elif eventA.node.information.remainingTime == eventB.node.information.remainingTime:
			pass
		return false
