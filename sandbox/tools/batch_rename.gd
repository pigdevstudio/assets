tool
extends Node

export (String) var new_name = ""
export (bool) var apply = false setget set_apply

func set_apply(value):
	if not value:
		return
	
	for c in get_children():
		if c.get_index() < 9:
			c.name = new_name + str(c.get_index() + 1)
		else:
			var actual_name = new_name
			actual_name.erase(actual_name.length() -1, 1)
			c.name = actual_name + str(c.get_index() + 1)
			