extends Area2D

signal picked

@export var minWaitTime = 5.0
@export var maxWaitTime = 10.0

# images of the different stages of the carot

const textures = [
	null,
	preload("res://assets/carot/stage-1.png"),
	preload("res://assets/carot/stage-2.png"),
	preload("res://assets/carot/stage-3.png")
]

# carot state

var state

# percents of the Timer value to wait to reach each new state

const grow1 = 0.2
const grow2 = 0.4
const grow3 = 0.4

func _ready() -> void:
	reset( true )


func _process( _delta: float ) -> void:
	# check if the timer is passed the time when the carot changes state, and if so changes state
	if ( state == 0 && $GrowTimer.time_left / $GrowTimer.wait_time <= 1.0 - grow1 ):
		setState( 1 )
	if ( state == 1 && $GrowTimer.time_left / $GrowTimer.wait_time <= 1.0 - grow2 ):
		setState( 2 )
	if ( state == 2 && $GrowTimer.time_left / $GrowTimer.wait_time <= 1.0 - grow3 ):
		setState( 3 )


func reset( random_progress: bool = false ):
	# reset the timer with a new wait_time value, so that this Carot grows at a different pace.
	var waitTime = minWaitTime + ( ( maxWaitTime - minWaitTime ) * randf_range( 0, 1 ) )
	$GrowTimer.wait_time = waitTime
	$GrowTimer.start()
	if ( random_progress ):
		setState( randi_range( 0, 3 ) )
	else:
		setState( 0 )


func setState( newState ):
	state = newState
	$Sprite2D.texture = textures[ newState ]
	$GrowTimer.stop()
	$GrowTimer.start()

func _on_area_entered( _area: Area2D ) -> void:
	if ( state == 3 ):
		picked.emit()
		$AudioPicked.play()
	else:
		$AudioDestroyed.play()
	reset()
