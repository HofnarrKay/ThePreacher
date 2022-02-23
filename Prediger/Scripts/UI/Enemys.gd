extends Control

signal initiateDecision(decision)

func addEnemy(enemy):
	$Enemykeeper.add_child(enemy)
	enemy.connect("confrontation", self, "confrontation")
	if enemy.has_method("getInformation"):
		$EnemyVisualizer.addEnemyVisualizer(enemy.getInformation())

func confrontation(enemy):
	emit_signal("initiateDecision", enemy.getDecisions())
