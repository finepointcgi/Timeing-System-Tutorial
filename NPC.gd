extends MeshInstance


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var minTasks = {
	"moveLeft":{
		"time": {"hour":2, "minute":6, "month":1, "day":14, "year":2022},
		"task": "moveLeft"
	},"moveRight":{
		"time": {"hour":2, "minute":7, "month":1, "day":14, "year":2022},
		"task": "moveRight"
	}
}

var hourTasks = {
	"moveLeft":{
		"time": {"hour":15, "minute":61, "month":1, "day":14, "year":2022},
		"task": "moveLeft"
	},"moveRight":{
		"time": {"hour":16, "minute":0, "month":1, "day":14, "year":2022},
		"task": "moveRight"
	}
} 

var DayTasks = {
	"moveLeft":{
		"time": {"hour":15, "minute":61, "month":1, "day":15, "year":2022},
		"task": "moveLeft"
	},"moveRight":{
		"time": {"hour":16, "minute":0, "month":1, "day":17, "year":2022},
		"task": "moveRight"
	}
} 

# Called when the node enters the scene tree for the first time.
func _ready():
	var timeManager = get_tree().get_nodes_in_group("TimeManager")[0]
	timeManager.connect("TimeMinHasChanged", self, "_on_TimeMinHasChanged")
	timeManager.connect("TimeHourHasChanged", self, "_on_TimeHourHasChanged")
	timeManager.connect("TimeDayHasChanged", self, "_on_TimeDayHasChanged")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_TimeMinHasChanged(time):
	for mintask in minTasks.values():
		if(mintask.time.minute == time.minute or mintask.time.minute == 61):
			call(mintask.task)
	#print("NPC caught signal")
	pass
	
func _on_TimeHourHasChanged(time):
	var newMinTasks = {}
	for hourtask in hourTasks.keys():
		if hourTasks[hourtask].time.hour == time.hour:
			newMinTasks[hourtask] = hourTasks[hourtask]
		if hourTasks[hourtask].time.hour == 25:
			newMinTasks[hourtask] = hourTasks[hourtask]
	minTasks = newMinTasks
	pass

func _on_TimeDayHasChanged(time):
	var newDayTasks = {}
	for Daytask in DayTasks.keys():
		if DayTasks[Daytask].time.day == time.day:
			newDayTasks[Daytask] = DayTasks[Daytask]
		if DayTasks[Daytask].time.day == 35:
			newDayTasks[Daytask] = DayTasks[Daytask]
	hourTasks = newDayTasks
	
func moveLeft():
	$Tween.interpolate_property(self,"transform", transform, get_tree().get_nodes_in_group("LeftPos")[0].transform, 1, Tween.TRANS_LINEAR, Tween.TRANS_LINEAR)
	$Tween.start()
	
func moveRight():
	$Tween.interpolate_property(self,"transform", transform, get_tree().get_nodes_in_group("RightPos")[0].transform, 1, Tween.TRANS_LINEAR, Tween.TRANS_LINEAR)
	$Tween.start()
