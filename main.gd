extends Node2D

signal update_counter

var carot_counter

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var children = get_children()
	for child in children:
		if child.has_signal( "picked" ):
			child.connect( "picked", on_carot_picked )
	start_game()

func start_game():
	carot_counter = 0
	$Music.play()

func on_carot_picked() :
	carot_counter += 1
	update_counter.emit( carot_counter )
