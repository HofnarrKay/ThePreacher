extends Node



func getDecisions():
	if get_child(0).has_method("getDecisions"):
		return get_child(0).getDecisions()
	return null

