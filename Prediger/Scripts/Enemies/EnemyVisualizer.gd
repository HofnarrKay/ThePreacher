extends Control


func addEnemyVisualizer(enemyInformation):
	if enemyInformation.has("enemyType"):
		if enemyInformation.enemyType == "bishop":
			$BishopSlot.createVisualizer(enemyInformation)
		else:
			$UpcomingEvents.createVisualizer(enemyInformation)

func newTurn():
	$BishopSlot.updateVisualizer()
	$UpcomingEvents.updateVisualizer()
