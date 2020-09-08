extends Node2D

onready var TouchInputManager = get_node("../../GameManager/TouchInput-Manager")
onready var GameModeManager = get_node("../../GameManager/GameMode-Manager")
onready var afterSprite = get_node("AfterSprite")
onready var beforeSprite = get_node("BeforeSprite")
onready var gameMode = GameModeManager.gameMode

var xPos = self.get_position().x
var yPos = self.get_position().y
var direction = "N"
var debug = false

func SmallestDistantRestPos():
	var smallestDistantVector
	
	if(gameMode != 4):
		smallestDistantVector = GameModeManager.STARTPOS[0]
	else:
		smallestDistantVector = GameModeManager.STARTPOS5X5[0]
	
	if(gameMode != 4):
		for i in range(0,9):
			if(self.get_position().distance_to(GameModeManager.STARTPOS[i]) < self.get_position().distance_to(smallestDistantVector)):
				smallestDistantVector = GameModeManager.STARTPOS[i]
	else:
		for i in range(0,25):
			if(self.get_position().distance_to(GameModeManager.STARTPOS5X5[i]) < self.get_position().distance_to(smallestDistantVector)):
				smallestDistantVector = GameModeManager.STARTPOS5X5[i]
				
	return smallestDistantVector
	
func InfiniteScrolling():
	if(TouchInputManager.InPlayArea() == true and TouchInputManager.touched == true and TouchInputManager.dragged == true):
		if(direction == "N"):
			direction = TouchInputManager.GetDirection()
		
		if(TouchInputManager.dragged == true):
			if(direction == "H" and abs(self.get_position().y - TouchInputManager.startPos.y) <= 115):
				self.set_position(Vector2(xPos - (TouchInputManager.startPos.x - TouchInputManager.dragPos.x), self.get_position().y))
			elif(direction == "V" and abs(self.get_position().x - TouchInputManager.startPos.x) <= 115):
				self.set_position(Vector2(self.get_position().x, yPos - (TouchInputManager.startPos.y - TouchInputManager.dragPos.y)))
	else:
		self.set_position(self.get_position().move_toward(SmallestDistantRestPos(), 25.0))
		xPos = self.get_position().x
		yPos = self.get_position().y
		direction = "N"
		
	if(direction == "H" and gameMode != 4):
		afterSprite.set_position(Vector2(888, 0))
		beforeSprite.set_position(Vector2(-888, 0))
		if(self.get_position().x < -444):
			self.set_position(Vector2(afterSprite.get_global_position().x, self.get_position().y))
			xPos =  xPos + 888
		elif(self.get_position().x > 444):
			self.set_position(Vector2(beforeSprite.get_global_position().x, self.get_position().y))
			xPos = xPos - 888
	elif(direction == "V" and gameMode != 4):
		afterSprite.set_position(Vector2(0, 888))
		beforeSprite.set_position(Vector2(0, -888))
		if(self.get_position().y < -444):
			self.set_position(Vector2(self.get_position().x, afterSprite.get_global_position().y))
			yPos = yPos + 888
		elif(self.get_position().y > 444):
			self.set_position(Vector2(self.get_position().x, beforeSprite.get_global_position().y))
			yPos = yPos - 888
	elif(direction == "H" and gameMode == 4):
		afterSprite.set_position(Vector2(1376.4, 0))
		beforeSprite.set_position(Vector2(-1376.4, 0))
		if(self.get_position().x < -700):
			self.set_position(Vector2(afterSprite.get_global_position().x, self.get_position().y))
			xPos =  xPos + 1376.4
		elif(self.get_position().x > 700):
			self.set_position(Vector2(beforeSprite.get_global_position().x, self.get_position().y))
			xPos = xPos - 1376.4
	elif(direction == "V" and gameMode == 4):
		afterSprite.set_position(Vector2(0, 1376.4))
		beforeSprite.set_position(Vector2(0, -1376.4))
		if(self.get_position().y < -700):
			self.set_position(Vector2(self.get_position().x, afterSprite.get_global_position().y))
			xPos =  xPos + 1376.4
		elif(self.get_position().y > 700):
			self.set_position(Vector2(self.get_position().x, beforeSprite.get_global_position().y))
			yPos = yPos - 1376.4
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
		
	InfiniteScrolling()
		
	pass
