extends Node


func getAllPositiveAttributeInformations():
	var currentAttribute = []
	var returnedAttributeInformation = []
	for child in get_children():
		if currentAttribute.has(child.opposition):
			continue
		if child.value >= 0:
			currentAttribute.insert(currentAttribute.size(), child.attribute)
			returnedAttributeInformation.insert(returnedAttributeInformation.size(), child.constructInformation())
	return returnedAttributeInformation
	
func getAttributeValue(attribute):
	for child in get_children():
		if child.attribute == attribute:
			return child.value
	return "no child with attribute"

func getAttributeInformation(attribute):
	for child in get_children():
		if child.attribute == attribute:
			return child.constructInformation()
	return "no child with attribute"



