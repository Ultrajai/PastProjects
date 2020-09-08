extends Node2D

onready var GameModeManager = get_node("../../GameManager/GameMode-Manager")
onready var gameMode = GameModeManager.gameMode

const DRAGTHRESHOLD = 25
var startPos = Vector2(0,0)
var dragPos = Vector2(0,0)
var dragRelative = Vector2(0,0)
var dragged = false
var touched = false

# Checks what direction the drag was based on the threshold
func GetDirection():
	dragRelative = startPos - dragPos
	if(abs(dragRelative.x) > DRAGTHRESHOLD and abs(dragRelative.x) > abs(dragRelative.y)):
		return "H"
	elif(abs(dragRelative.y) > DRAGTHRESHOLD and abs(dragRelative.x) < abs(dragRelative.y)):
		return "V"
	else:
		return "N"
		
# Checks if the touch input made was in the play area
func InPlayArea():
	if(touched and abs(startPos.x) < 432 and abs(startPos.y) < 432 and gameMode != 4):
		return true
	elif(touched and abs(startPos.x) < 688 and abs(startPos.y) < 688 and gameMode == 4):
		return true
	else:
		return false

# This handles any other input from the user
func _unhandled_input(event):
	#sets the startpos value
	if(event is InputEventScreenTouch):
		startPos = get_canvas_transform().xform_inv(event.get_position())
		touched = event.is_pressed()
		# when the touch has been released
		if(event.is_pressed() == false):
			dragged = false
	# Sets up dragPos and dragRelatuve values
	elif(event is InputEventScreenDrag):
		dragPos = get_canvas_transform().xform_inv(event.get_position())
		dragged = true
	pass
