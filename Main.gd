extends Control

onready var lists = get_node("Table/Lists")
var chk = 1

export var lno = 0
export var qno = 0
export var ano = 0
export var tno = 0

export var totcalc = 0.0

func _ready():
	pass

func _process(_delta):
#	if $Data/Lab/ScoreReceived.text == "": $Data/Lab/ScoreReceived.text = "0"
#	if $Data/Lab/ScoreTotal.text == "": $Data/Lab/ScoreTotal.text = "100"
#	if $Data/Quiz/ScoreReceived.text == "": $Data/Quiz/ScoreReceived.text = "0"
#	if $Data/Quiz/ScoreTotal.text == "": $Data/Quiz/ScoreTotal.text = "100"
#	if $Data/Assignment/ScoreReceived.text == "": $Data/Assignment/ScoreReceived.text = "0"
#	if $Data/Assignment/ScoreTotal.text == "": $Data/Assignment/ScoreTotal.text = "100"
#	if $Data/Test/ScoreReceived.text == "": $Data/Test/ScoreReceived.text = "0"
#	if $Data/Test/ScoreTotal.text == "": $Data/Test/ScoreTotal.text = "100"
	
	get_node("Table/Lists/0/Outof").text = "Out of"
	get_node("Table/Lists/0/Score").text = "Score"
	
	$Data/LNO.text = str(lno)
	$Data/QNO.text = str(qno)
	$Data/ANO.text = str(ano)
	$Data/TNO.text = str(tno)

func _copy_list(_numb):
	var temp = get_node("Table/Lists/0").duplicate()
	temp.name = str(_numb)
	lists.add_child(temp)


func _on_LabButton_pressed():
	if lists.get_child_count()<=100:
		chk = int($Table/Lists.get_children()[-1].name)+1
		_copy_list(chk)
		get_node("Table/Lists/"+str(chk)+"/Type").text = "Lab"
		get_node("Table/Lists/"+str(chk)+"/Score").text = $Data/Lab/ScoreReceived.text
		get_node("Table/Lists/"+str(chk)+"/Outof").text = $Data/Lab/ScoreTotal.text
#		$Data/Lab/ScoreReceived.text = "0"
#		$Data/Lab/ScoreTotal.text = "100"
		lno+=1


func _on_QuizButton_pressed():
	if lists.get_child_count()<=100:
		chk = int($Table/Lists.get_children()[-1].name)+1
		_copy_list(chk)
		get_node("Table/Lists/"+str(chk)+"/Type").text = "Quiz"
		get_node("Table/Lists/"+str(chk)+"/Score").text = $Data/Quiz/ScoreReceived.text
		get_node("Table/Lists/"+str(chk)+"/Outof").text = $Data/Quiz/ScoreTotal.text
#		$Data/Quiz/ScoreReceived.text = "0"
#		$Data/Quiz/ScoreTotal.text = "100"
		qno+=1


func _on_AssignmentButton_pressed():
	if lists.get_child_count()<=100:
		chk = int($Table/Lists.get_children()[-1].name)+1
		_copy_list(chk)
		get_node("Table/Lists/"+str(chk)+"/Type").text = "Assignment"
		get_node("Table/Lists/"+str(chk)+"/Score").text = $Data/Assignment/ScoreReceived.text
		get_node("Table/Lists/"+str(chk)+"/Outof").text = $Data/Assignment/ScoreTotal.text
#		$Data/Assignment/ScoreReceived.text = "0"
#		$Data/Assignment/ScoreTotal.text = "100"
		ano+=1


func _on_TestButton_pressed():
	if lists.get_child_count()<=100:
		chk = int($Table/Lists.get_children()[-1].name)+1
		_copy_list(chk)
		get_node("Table/Lists/"+str(chk)+"/Type").text = "Test"
		get_node("Table/Lists/"+str(chk)+"/Score").text = $Data/Test/ScoreReceived.text
		get_node("Table/Lists/"+str(chk)+"/Outof").text = $Data/Test/ScoreTotal.text
#		$Data/Test/ScoreReceived.text = "0"
#		$Data/Test/ScoreTotal.text = "100"
		tno+=1


func _on_Calculate_pressed():
	totcalc = 0.0
	var totw = 1.0
	if lists.get_child_count()!=1: 
		totw = 0.0
		for c in range(lists.get_child_count()):
			if lists.get_children()[c].name!="0":
				var nume = float(get_node("Table/Lists/"+lists.get_children()[c].name+"/Score").text)
				var deno = float(get_node("Table/Lists/"+lists.get_children()[c].name+"/Outof").text)
				var typ = 0.0
				if get_node("Table/Lists/"+lists.get_children()[c].name+"/Type").text=="Lab": typ = float(get_node("Data/Weights/LabW").text)
				elif get_node("Table/Lists/"+lists.get_children()[c].name+"/Type").text=="Quiz": typ = float(get_node("Data/Weights/QuizW").text)
				elif get_node("Table/Lists/"+lists.get_children()[c].name+"/Type").text=="Assignment": typ = float(get_node("Data/Weights/AssignmentW").text)
				elif get_node("Table/Lists/"+lists.get_children()[c].name+"/Type").text=="Test": typ = float(get_node("Data/Weights/TestW").text)
				var calc = (nume/deno)*typ
				totcalc += calc
				totw += typ
	#var totw = float(get_node("Data/Weights/LabW").text)+float(get_node("Data/Weights/QuizW").text)+float(get_node("Data/Weights/AssignmentW").text)+float(get_node("Data/Weights/TestW").text)
	$Stats/Percentage/Numbers.text = str(stepify(totcalc/totw,0.0001)*100)+"%"
	$Stats/GPA/Numbers.text = str(stepify(totcalc/totw,0.001)*4)


func _on_Cross_pressed():
		$Data/Lab/ScoreReceived.text = "0"
		$Data/Lab/ScoreTotal.text = "10"
		$Data/Quiz/ScoreReceived.text = "0"
		$Data/Quiz/ScoreTotal.text = "10"
		$Data/Assignment/ScoreReceived.text = "0"
		$Data/Assignment/ScoreTotal.text = "36"
		$Data/Test/ScoreReceived.text = "0"
		$Data/Test/ScoreTotal.text = "30"


func _on_Clear_pressed():
	for c in range(get_node("Table/Lists").get_child_count()):
		if get_node("Table/Lists/"+lists.get_children()[c].name).name!="0":
			get_node("Table/Lists/"+lists.get_children()[c].name).queue_free()
	lno = 0
	qno = 0
	ano = 0
	tno = 0


func _on_Clear_Score_pressed():
	$Data/Lab/ScoreReceived.text = ""
	$Data/Lab/ScoreTotal.text = ""
	$Data/Quiz/ScoreReceived.text = ""
	$Data/Quiz/ScoreTotal.text = ""
	$Data/Assignment/ScoreReceived.text = ""
	$Data/Assignment/ScoreTotal.text = ""
	$Data/Test/ScoreReceived.text = ""
	$Data/Test/ScoreTotal.text = ""


func _on_Clear_Weight_pressed():
	$Data/Weights/LabW.text = ""
	$Data/Weights/QuizW.text = ""
	$Data/Weights/AssignmentW.text = ""
	$Data/Weights/TestW.text = ""


func _on_Reset_pressed():
	$Data/Weights/LabW.text = "10"
	$Data/Weights/QuizW.text = "10"
	$Data/Weights/AssignmentW.text = "5"
	$Data/Weights/TestW.text = "20"
