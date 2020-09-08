extends "res://Source/PuzzlePiece.gd"


var value = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	value = randi() % 34 + 1
	
	self.get_child(0).get_child(0).text = var2str(value)
	self.get_child(1).get_child(0).text = var2str(value)
	self.get_child(2).get_child(0).text = var2str(value)
	
	pass
	
func _process(_delta):
	InfiniteScrolling()
	pass
