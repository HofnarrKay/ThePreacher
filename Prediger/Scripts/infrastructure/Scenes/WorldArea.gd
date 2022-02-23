extends Node

export var position = ""

func getSceneMovement(events):
	var hitEvents = []
	for i in range(get_child_count()):
		var child = get_child(i)
		hitEvents.insert(hitEvents.size(), [child, 0])
		for event in events:
			for childEvent in child.eventKeys:
				if childEvent == event:
					hitEvents[i][1] += 1
	hitEvents.sort_custom(hitEventNumberSorter, "sort_ascending")
	return hitEvents[0][0].pickScene()
	
class hitEventNumberSorter:
	static func sort_ascending(objectA, objectB):
		if objectA[1] > objectB[1]:
			return true
		return false
