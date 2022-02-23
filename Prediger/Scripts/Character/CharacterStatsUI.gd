extends Label


func updateValues(baseAttributeList):
	var textEdit = ""
	for attribute in baseAttributeList:
		textEdit += str(attribute) + ": " + str(baseAttributeList[attribute]) + "\n"
	text = textEdit
