extends Node

export (PackedScene) var follower
export (int) var bonusMarginForRandomizedFollower
signal leavingFollower(value, trueCalculation)

var followerCount = 0
func followerChange(_type, _attribute, value):
	followerCount += value
	if value > 0:
		addFollower(value)
	else:
		loseFollower(value)

func beliefExtremism(_type, attribute, value):
	if value > 0:
		$FollowerUI.addUpgradePoints(attribute, value)
		var information = $unspecificFollowers/attributeSocket.getAttributeInformation($unspecificFollowers/attributeSocket.getAttributeInformation(attribute).opposition).node.addValue(-value, true)
		emit_signal("leavingFollower", information.endValue -information.startValue, true)

func addFollower(value):
	var playerStats = []
	for attributeNode in $unspecificFollowers/attributeSocket.get_children():
		playerStats.insert(playerStats.size(), {attribute = attributeNode.attribute, value = Global.player.getAttributeValue(attributeNode.attribute) + bonusMarginForRandomizedFollower})
	
	var statRange = 0
	for i in range(playerStats.size()):
		statRange += playerStats[i].value
	
	for i in range(value):
		var chosenNumber = randi() % statRange
		for playerStat in playerStats:
			if chosenNumber > playerStat.value:
				chosenNumber -= playerStat.value
			else:
				$unspecificFollowers/attributeSocket.getAttributeInformation(playerStat.attribute).node.addValue(1, true)
				break


func loseFollower(value):
	pass


func onFollowerUpgrade(): 
	print("Test3")



class sortUpwards:
	static func sortUpwards(x, y):
		return x < y

