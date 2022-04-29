extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var oldTime
signal TimeMinHasChanged
signal TimeHourHasChanged
signal TimeDayHasChanged
signal TimeMonthHasChanged

# Called when the node enters the scene tree for the first time.
func _ready():
	oldTime = OS.get_datetime()
	emit_signal("TimeMinHasChanged",oldTime)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _physics_process(delta):
	var time = OS.get_datetime()
	if time.month != oldTime.month:
		emit_signal("TimeMonthHasChanged",time)
		print(time)
	if time.day != oldTime.day:
		emit_signal("TimeDayHasChanged",time)
		print(time)
	if time.hour != oldTime.hour:
		emit_signal("TimeHourHasChanged",time)
		print(time)
	if time.minute != oldTime.minute:
		emit_signal("TimeMinHasChanged",time)
		print(time)
		oldTime = time
