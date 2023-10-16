extends Button

func _on_Remove_pressed():
	var root = get_parent().get_parent().get_parent().get_parent()
	if get_parent().get_node("Type").text == "Lab": root.lno-=1
	elif get_parent().get_node("Type").text == "Quiz": root.qno-=1
	elif get_parent().get_node("Type").text == "Assignment": root.ano-=1
	elif get_parent().get_node("Type").text == "Test": root.tno-=1
	if get_parent().name != "0":
#		var nume = float(get_parent().get_node("Score").text)
#		var deno = float(get_parent().get_node("Outof").text)
#		var calc = nume/deno
#		root.totcalc -= calc
		get_parent().queue_free()
	else: get_tree().reload_current_scene()
