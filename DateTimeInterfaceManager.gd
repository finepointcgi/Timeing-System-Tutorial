extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().get_nodes_in_group("TimeManager")[0].connect("TimeMinHasChanged",self,"_on_TimeMinChanged")
	_on_TimeMinChanged(OS.get_datetime())
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_TimeMinChanged(time):
	$DateTimeValue.text = str(time.hour) +" : " + str(time.minute) 
