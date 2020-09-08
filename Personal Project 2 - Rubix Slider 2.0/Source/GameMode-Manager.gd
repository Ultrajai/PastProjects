extends Node2D

const STARTPOS = [Vector2(-296,-296), Vector2(0,-296), Vector2(296,-296), 
				  Vector2(-296,0), Vector2(0,0), Vector2(296,0), 
				  Vector2(-296,296), Vector2(0,296), Vector2(296,296)]
const STARTPOS5X5 = [Vector2(-550.56,-550.56),Vector2(-275.28,-550.56),Vector2(0,-550.56),Vector2(275.28,-550.56),Vector2(550.56,-550.56),
					 Vector2(-550.56,-275.28),Vector2(-275.28,-275.28),Vector2(0,-275.28),Vector2(275.28,-275.28),Vector2(550.56,-275.28),
					 Vector2(-550.56,0),Vector2(-275.28,0),Vector2(0,0),Vector2(275.28,0),Vector2(550.56,0),
					 Vector2(-550.56,275.28),Vector2(-275.28,275.28),Vector2(0,275.28),Vector2(275.28,275.28),Vector2(550.56,275.28),
					 Vector2(-550.56,550.56),Vector2(-275.28,550.56),Vector2(0,550.56),Vector2(275.28,550.56),Vector2(550.56,550.56)]
const COLOURMULTCONSTS = [[4.0/4, 0.0/4 ,0.0/4, 0.0/4], [3.0/4, 1.0/4, 0.0/4, 0.0/4], [2.0/4, 2.0/4, 0.0/4, 0.0/4], [1.0/4, 3.0/4, 0.0/4, 0.0/4], [0.0/4, 4.0/4, 0.0/4, 0.0/4], 
						  [3.0/4, 0.0/4, 1.0/4, 0.0/4], [2.25/4, 0.75/4, 0.75/4, 0.25/4], [1.5/4, 1.5/4, 0.5/4, 0.5/4], [0.75/4, 2.25/4, 0.25/4, 0.75/4], [0.0/4, 3.0/4, 0.0/4, 1.0/4],
						  [2.0/4, 0.0/4, 2.0/4, 0.0/4], [1.5/4, 0.5/4, 1.5/4, 0.5/4], [1.0/4, 1.0/4, 1.0/4, 1.0/4], [0.5/4, 1.5/4, 0.5/4, 1.5/4], [0.0/4, 2.0/4, 0.0/4, 2.0/4],
						  [1.0/4, 0.0/4, 3.0/4, 0.0/4], [0.75/4, 0.25/4, 2.25/4, 0.75/4], [0.5/4, 0.5/4, 1.5/4, 1.5/4], [0.25/4, 0.75/4, 0.75/4, 2.25/4], [0.0/4, 1.0/4, 0.0/4, 3.0/4],
						  [0.0/4, 0.0/4, 4.0/4, 0.0/4], [0.0/4, 0.0/4, 3.0/4, 1.0/4], [0.0/4, 0.0/4, 2.0/4, 2.0/4], [0.0/4, 0.0/4, 1.0/4, 3.0/4], [0.0/4, 0.0/4, 0.0/4, 4.0/4]]
const RED = Color(float(255) / 255, float(66) / 255, float(66) / 255)
const YELLOW = Color(float(255) / 255, float(255) / 255, float(102) / 255)
const BLUE = Color(float(51) / 255, float(161) / 255, float(255) / 255)
const GRID = [{"Adjacent":[1,3], "Size": 2},{"Adjacent":[0,2,4], "Size": 3},
			  {"Adjacent":[1,5], "Size": 2},{"Adjacent":[0,4,6], "Size": 3},
			  {"Adjacent":[3,1,5,7], "Size": 4},{"Adjacent":[2,4,8], "Size": 3},
			  {"Adjacent":[3,7], "Size": 2},{"Adjacent":[6,4,8], "Size": 3},{"Adjacent":[5,7], "Size": 2}]

onready var normalModePieces = [load("res://Scenes/Objects/Square.tscn"), 
								load("res://Scenes/Objects/Triangle.tscn"), 
								load("res://Scenes/Objects/Circle.tscn")]
onready var alphaNumericPieces = load("res://Scenes/Objects/AlphaNumericPuzzlePiece.tscn")
onready var DirectionalPieces = [load("res://Scenes/Objects/DownRight.tscn"),
								 load("res://Scenes/Objects/DownLeft.tscn"), 
								 load("res://Scenes/Objects/UpRight.tscn"),
								 load("res://Scenes/Objects/UpLeft.tscn"), 
								 load("res://Scenes/Objects/Vertical.tscn"), 
								 load("res://Scenes/Objects/Horizontal.tscn"),
								 load("res://Scenes/Objects/DirectionalDownLeft.tscn"),
								 load("res://Scenes/Objects/DirectionalDownRight.tscn"),
								 load("res://Scenes/Objects/DirectionalDownVertical.tscn"),
								 load("res://Scenes/Objects/DirectionalLeftDown.tscn"),
								 load("res://Scenes/Objects/DirectionalLeftHorizontal.tscn"),
								 load("res://Scenes/Objects/DirectionalLeftUp.tscn"),
								 load("res://Scenes/Objects/DirectionalRightDown.tscn"),
								 load("res://Scenes/Objects/DirectionalRightHorizontal.tscn"),
								 load("res://Scenes/Objects/DirectionalRightUp.tscn"),
								 load("res://Scenes/Objects/DirectionalUpLeft.tscn"),
								 load("res://Scenes/Objects/DirectionalUpRight.tscn"),
								 load("res://Scenes/Objects/DirectionalUpVertical.tscn")]
onready var ColourPieces = load("res://Scenes/Objects/ColourPiece.tscn")
onready var gamePiecesContainer = get_node("../../GamePiecesContainer")
onready var background = get_node("../../BackGround")
onready var label = get_node("../../Label")

var gameMode = 4
var currentGamePieces = []
var paths = []
var startColumn = true # does the start of the path start on a column?
var endColumn = true # does the end of the path end on a column?
var starts = 0 # start position of path
var ends = 0 # end position of path 
var pathNum = 0

var topRowVal = 0
var middleRowVal = 0
var bottomRowVal = 0
var leftColVal = 0
var middleColVal = 0
var rightColVal = 0

func RandomizeLocations():
	var pieces = [[0,1,2],[3,4,5],[6,7,8]]
	var temp
	var column = 0
	var row = 0
	var axis = 0
	var direction = 0
	var iterations = randi() % 60 + 50
	
	for _i in range(0, iterations):
		# warning-ignore:integer_division
		column = (randi() % 75) / 25
		# warning-ignore:integer_division
		row = (randi() % 75) / 25
		# warning-ignore:integer_division
		axis = (randi() % 100) / 50
		# warning-ignore:integer_division
		direction = (randi() % 100) / 50
		
		if(axis == 0):
			if(direction == 0):
				temp = pieces[row][2]
				pieces[row][2] = pieces[row][1]
				pieces[row][1] = pieces[row][0]
				pieces[row][0] = temp
			elif(direction == 1):
				temp = pieces[row][0]
				pieces[row][0] = pieces[row][1]
				pieces[row][1] = pieces[row][2]
				pieces[row][2] = temp
		elif(axis == 1):
			if(direction == 0):
				temp = pieces[2][column]
				pieces[2][column] = pieces[1][column]
				pieces[1][column] = pieces[0][column]
				pieces[0][column] = temp
			elif(direction == 1):
				temp = pieces[0][column]
				pieces[0][column] = pieces[1][column]
				pieces[1][column] = pieces[2][column]
				pieces[2][column] = temp
	
	return pieces

func PuzzelSolved():
	if(gameMode == 0):
		for i in range(0,9):
			if(currentGamePieces[i].position != STARTPOS[i]):
				return false
	elif(gameMode == 1):
		var topRow = 0
		var middleRow = 0
		var bottomRow = 0
		
		for obj in currentGamePieces:
			if(obj.position.y == -296):
				topRow += obj.value
			elif(obj.position.y == 0):
				middleRow += obj.value
			elif(obj.position.y == 296):
				bottomRow += obj.value
				
		if(topRow != topRowVal or middleRow != middleRowVal or bottomRow != bottomRowVal):
			return false
		else:
			for i in range(0,9):
				if(currentGamePieces[i].position.x != STARTPOS[i].x):
					return false
	elif(gameMode == 2):
		var topRow = 0
		var middleRow = 0
		var bottomRow = 0
		var leftCol = 0
		var middleCol = 0
		var rightCol = 0
		
		for obj in currentGamePieces:
			if(obj.position.y == -296):
				topRow += obj.value
			elif(obj.position.y == 0):
				middleRow += obj.value
			elif(obj.position.y == 296):
				bottomRow += obj.value
				
			if(obj.position.x == -296):
				leftCol += obj.value
			elif(obj.position.x == 0):
				middleCol += obj.value
			elif(obj.position.x == 296):
				rightCol += obj.value
				
		if(topRow != topRowVal or middleRow != middleRowVal or bottomRow != bottomRowVal 
		   or leftCol != leftColVal or middleCol != middleColVal or rightCol != rightColVal):
			return false
	elif(gameMode == 3):
# warning-ignore:unused_variable
		var direction = "None"
		var currentPosition = starts
		var pathLength = 0
		
		#relized this is a ton of work so I will do it later along with other game modes
		
		while(currentPosition != ends):
			if(startColumn == true and starts < 3 and pathLength == 0):
				direction = "Down"
			elif(startColumn == true and starts > 5 and pathLength == 0):
				direction = "Up"
			elif(startColumn == false and starts % 3 == 1 and pathLength == 0):
				direction = "Right"
			else:
				direction = "Left"
			
			
			pathLength += 1
	elif(gameMode == 4):
		var wrong = 0 # this is a count of the valid answers that are not in the solution
		
		# solution normal position
		for i in range(0, 25):
			if(currentGamePieces[i].position != STARTPOS5X5[i]):
				wrong += 1
				break
		# solution normal position flipped horizontally
		for i in range(0, 25):
			# warning-ignore:integer_division
			var row = i / 5
			if(currentGamePieces[i].position != STARTPOS5X5[i + (4 - (2 * i)) + (10 * row)]):
				wrong += 1
				break
		# solution rotated right once
		for i in range(0, 25):
			# warning-ignore:integer_division
			var row = i / 5
			if(currentGamePieces[i].position != STARTPOS5X5[((((i * 5) + 5) - 1) - (row * 25)) - row]):
				wrong += 1
				break
		# solution rotated right once flipped vertically
		for i in range(0, 25):
			# warning-ignore:integer_division
			var row = i / 5
			if(currentGamePieces[i].position != STARTPOS5X5[(((((i + (4 - (2 * i)) + (10 * row)) * 5) + 5) - 1) - (row * 25)) - row]):
				wrong += 1
				break
		# solution rotated right twice
		for i in range(0, 25):
			if(currentGamePieces[i].position != STARTPOS5X5[24 - i]):
				wrong += 1
				break
		# solution rotated right twice flipped horizontally
		for i in range(0, 25):
			# warning-ignore:integer_division
			var row = i / 5
			if(currentGamePieces[i].position != STARTPOS5X5[24 - (i + (4 - (2 * i)) + (10 * row))]):
				wrong += 1
				break
		# solution rotated right thrice
		for i in range(0, 25):
			# warning-ignore:integer_division
			var row = i / 5
			if(currentGamePieces[i].position != STARTPOS5X5[20 - i * 5 + row * 25 + row]):
				wrong += 1
				break
		# solution rotated right thrice flipped vertically
		for i in range(0, 25):
			# warning-ignore:integer_division
			var row = i / 5
			if(currentGamePieces[i].position != STARTPOS5X5[20 - (i + (4 - (2 * i)) + (10 * row)) * 5 + row * 25 + row]):
				wrong += 1
				break
				
		if(wrong == 8):
			return false
		
	return true

func PathFinder(start, end, visited = [false, false, false, false, false ,false, false, false, false], path = [0,0,0,0,0,0,0,0,0], pathIndex = 0):
	visited[start] = true
	path[pathIndex] = start
	pathIndex += 1
	
	if(start == end):
		paths.append(path.slice(0,pathIndex - 1))
		pathNum += 1
	else:
		for i in range(0,GRID[start].get("Size")):
			if(visited[GRID[start].get("Adjacent")[i]] == false):
				PathFinder(GRID[start].get("Adjacent")[i], end, visited, path, pathIndex)
	
	visited[start] = false
	pass

func IsEqualApprox(colour1, colour2, e):
	var rMean = (colour1.r + colour2.r) / 2.0
	if(rMean < 0.502 and sqrt((2 * pow(colour1.r - colour2.r, 2.0)) + (4 * pow(colour1.g - colour2.g, 2.0)) + (3 * pow(colour1.b - colour2.b, 2.0))) < e):
		return true
	elif(rMean > 0.502 and sqrt((3 * pow(colour1.r - colour2.r, 2.0)) + (4 * pow(colour1.g - colour2.g, 2.0)) + (2 * pow(colour1.b - colour2.b, 2.0))) < e):
		return true
	else:
		return false

func RegenerateColours(colour1, colour2, colour3, colour4, colour1Comp, colour2Comp, colour3Comp, colour4Comp):
	
	if(IsEqualApprox(colour1, colour2, 1.0)):
		return true
	elif(IsEqualApprox(colour1, colour3, 1.0)):
		return true
	elif(IsEqualApprox(colour1, colour4, 1.0)):
		return true
	elif(IsEqualApprox(colour2, colour3, 1.0)):
		return true
	elif(IsEqualApprox(colour2, colour4, 1.0)):
		return true
	elif(IsEqualApprox(colour3, colour4, 1.0)):
		return true
	elif(IsEqualApprox(colour1Comp, colour2, 0.8) or IsEqualApprox(colour1Comp, colour3, 0.8) or IsEqualApprox(colour1Comp, colour4, 0.8)):
		return true
	elif(IsEqualApprox(colour2Comp, colour1, 0.8) or IsEqualApprox(colour2Comp, colour3, 0.8) or IsEqualApprox(colour2Comp, colour4, 0.8)):
		return true
	elif(IsEqualApprox(colour3Comp, colour1, 0.8) or IsEqualApprox(colour3Comp, colour2, 0.8) or IsEqualApprox(colour3Comp, colour4, 0.8)):
		return true
	elif(IsEqualApprox(colour4Comp, colour1, 0.8) or IsEqualApprox(colour4Comp, colour2, 0.8) or IsEqualApprox(colour4Comp, colour3, 0.8)):
		return true
	else:
		return false
		
# Called when the node enters the scene tree for the first time.
func _ready():
	randomize() # random seed creation
	var randomLocation = RandomizeLocations() # provides the random locations to place the puzzle pieces
	currentGamePieces.resize(9) # initializing array
	
	if(gameMode == 0):
		background.texture = load("res://Sprites/BackGround1.png")
		for i in range(0,9):
			# warning-ignore:integer_division
			currentGamePieces[i] = normalModePieces[i / 3].instance()
			currentGamePieces[i].set_name("PuzzlePiece")
			# warning-ignore:integer_division
			currentGamePieces[i].position = STARTPOS[randomLocation[i / 3][i % 3]]
			
			if(i % 3 == 0):
				currentGamePieces[i].modulate = RED
			elif(i % 3 == 1):
				currentGamePieces[i].modulate = YELLOW
			else:
				currentGamePieces[i].modulate = BLUE
				
			gamePiecesContainer.add_child(currentGamePieces[i])
	elif(gameMode == 1):
		background.texture = load("res://Sprites/BackGround2.png")
		for i in range(0,9):
			currentGamePieces[i] = alphaNumericPieces.instance()
			currentGamePieces[i].set_name("PuzzlePiece")
			# warning-ignore:integer_division
			currentGamePieces[i].position = STARTPOS[randomLocation[i / 3][i % 3]]
			
			if(i % 3 == 0):
				currentGamePieces[i].modulate = RED
			elif(i % 3 == 1):
				currentGamePieces[i].modulate = YELLOW
			else:
				currentGamePieces[i].modulate = BLUE
				
			gamePiecesContainer.add_child(currentGamePieces[i])
	elif(gameMode == 2):
		background.texture = load("res://Sprites/BackGround3.png")
		for i in range(0,9):
			currentGamePieces[i] = alphaNumericPieces.instance()
			currentGamePieces[i].set_name("PuzzlePiece")
			# warning-ignore:integer_division
			currentGamePieces[i].position = STARTPOS[randomLocation[i / 3][i % 3]]
				
			gamePiecesContainer.add_child(currentGamePieces[i])
	elif(gameMode == 3):
		var selectedPath = 0
		var selectedPathLength = 0
		var startOBJ = normalModePieces[2].instance()
		var endOBJ = normalModePieces[2].instance()
		background.texture = load("res://Sprites/BackGround3.png")
		
		startOBJ.modulate = RED
		endOBJ.modulate = BLUE
		
		while (starts == ends or starts == 4 or ends == 4):
			starts = randi() % 9
			ends = randi() % 9
		
		if(starts == 0 or starts == 2 or starts == 6 or starts == 8):
			startColumn = (randi() % 2 == 0)
		elif(starts == 1 or starts == 7):
			startColumn = true
		else:
			startColumn = false
		
		if(ends == 0 or ends == 2 or ends == 6 or ends == 8):
			endColumn = (randi() % 2 == 0)
		elif(ends == 1 or ends == 7):
			endColumn = true
		else:
			endColumn = false
		
		startOBJ.position = STARTPOS[starts]
		endOBJ.position = STARTPOS[ends]
		
		if(startColumn == true and starts < 3):
			startOBJ.position.y -= 272
		elif(startColumn == true and starts > 5):
			startOBJ.position.y += 272
		elif(startColumn == false and (starts == 2 or starts == 5 or starts == 8)):
			startOBJ.position.x += 272
		else:
			startOBJ.position.x -= 272
		
		if(endColumn == true and ends < 3):
			endOBJ.position.y -= 272
		elif(endColumn == true and ends > 5):
			endOBJ.position.y += 272
		elif(endColumn == false and (ends == 2 or ends == 5 or ends == 8)):
			endOBJ.position.x += 272
		else:
			endOBJ.position.x -= 272
		
		PathFinder(starts, ends)
		paths.sort()
		
		selectedPath = randi() % paths.size()
		
		selectedPathLength = paths[selectedPath].size()
		
		for i in range(0, selectedPathLength):
			
			var randint = randi() % 2
			
			if(i == 0 and startColumn == false):
				if(paths[selectedPath][i] + 3 == paths[selectedPath][i + 1]):
					if(paths[selectedPath][i] % 3 == 0):
						
						if(randint == 0):
							currentGamePieces[paths[selectedPath][i]] = DirectionalPieces[3].instance()
						else:
							currentGamePieces[paths[selectedPath][i]] = DirectionalPieces[12].instance()
					else:
						
						if(randint == 0):
							currentGamePieces[paths[selectedPath][i]] = DirectionalPieces[2].instance()
						else:
							currentGamePieces[paths[selectedPath][i]] = DirectionalPieces[9].instance()
				elif(paths[selectedPath][i] - 3 == paths[selectedPath][i + 1]):
					if(paths[selectedPath][i] % 3 == 0):
						if(randint == 0):
							currentGamePieces[paths[selectedPath][i]] = DirectionalPieces[0].instance()
						else:
							currentGamePieces[paths[selectedPath][i]] = DirectionalPieces[14].instance()
					else:
						if(randint == 0):
							currentGamePieces[paths[selectedPath][i]] = DirectionalPieces[1].instance()
						else:
							currentGamePieces[paths[selectedPath][i]] = DirectionalPieces[11].instance()
				else:
					if(randint == 0):
						currentGamePieces[paths[selectedPath][i]] = DirectionalPieces[5].instance()
					else:
						if(paths[selectedPath][i] < paths[selectedPath][i + 1]):
							currentGamePieces[paths[selectedPath][i]] = DirectionalPieces[13].instance()
						else:
							currentGamePieces[paths[selectedPath][i]] = DirectionalPieces[10].instance()
			elif(i == 0 and startColumn == true):
				if(paths[selectedPath][i] + 3 == paths[selectedPath][i + 1] or 
				   paths[selectedPath][i] - 3 == paths[selectedPath][i + 1]):
					
					if(randint == 0):
						currentGamePieces[paths[selectedPath][i]] = DirectionalPieces[4].instance()
					else:
						if(paths[selectedPath][i] + 3 == paths[selectedPath][i + 1]):
							currentGamePieces[paths[selectedPath][i]] = DirectionalPieces[8].instance()
						else:
							currentGamePieces[paths[selectedPath][i]] = DirectionalPieces[17].instance()
				elif(paths[selectedPath][i] < paths[selectedPath][i + 1]):
					if(paths[selectedPath][i] < 3):
						if(randint == 0):
							currentGamePieces[paths[selectedPath][i]] = DirectionalPieces[1].instance()
						else:
							currentGamePieces[paths[selectedPath][i]] = DirectionalPieces[7].instance()
					elif(paths[selectedPath][i] > 5):
						if(randint == 0):
							currentGamePieces[paths[selectedPath][i]] = DirectionalPieces[2].instance()
						else:
							currentGamePieces[paths[selectedPath][i]] = DirectionalPieces[16].instance()
				elif(paths[selectedPath][i] > paths[selectedPath][i + 1]):
					if(paths[selectedPath][i] < 3):
						if(randint == 0):
							currentGamePieces[paths[selectedPath][i]] = DirectionalPieces[0].instance()
						else:
							currentGamePieces[paths[selectedPath][i]] = DirectionalPieces[6].instance()
					elif(paths[selectedPath][i] > 5):
						if(randint == 0):
							currentGamePieces[paths[selectedPath][i]] = DirectionalPieces[3].instance()
						else:
							currentGamePieces[paths[selectedPath][i]] = DirectionalPieces[15].instance()
			elif(i == paths[selectedPath].size() - 1 and endColumn == false):
				if(paths[selectedPath][i] - 3 == paths[selectedPath][i - 1]):
					if(paths[selectedPath][i] % 3 == 0):
						if(randint == 0):
							currentGamePieces[paths[selectedPath][i]] = DirectionalPieces[0].instance()
						else:
							currentGamePieces[paths[selectedPath][i]] = DirectionalPieces[6].instance()
					else:
						if(randint == 0):
							currentGamePieces[paths[selectedPath][i]] = DirectionalPieces[1].instance()
						else:
							currentGamePieces[paths[selectedPath][i]] = DirectionalPieces[7].instance()
				elif(paths[selectedPath][i] + 3 == paths[selectedPath][i - 1]):
					if(paths[selectedPath][i] % 3 == 0):
						if(randint == 0):
							currentGamePieces[paths[selectedPath][i]] = DirectionalPieces[3].instance()
						else:
							currentGamePieces[paths[selectedPath][i]] = DirectionalPieces[15].instance()
					else:
						if(randint == 0):
							currentGamePieces[paths[selectedPath][i]] = DirectionalPieces[1].instance()
						else:
							currentGamePieces[paths[selectedPath][i]] = DirectionalPieces[16].instance()
				else:
					if(randint == 0):
						currentGamePieces[paths[selectedPath][i]] = DirectionalPieces[5].instance()
					else:
						if(paths[selectedPath][i - 1] < paths[selectedPath][i]):
							currentGamePieces[paths[selectedPath][i]] = DirectionalPieces[13].instance()
						else:
							currentGamePieces[paths[selectedPath][i]] = DirectionalPieces[10].instance()
			elif(i == paths[selectedPath].size() - 1 and endColumn == true):
				if(paths[selectedPath][i - 1] + 3 == paths[selectedPath][i] or 
				   paths[selectedPath][i - 1] - 3 == paths[selectedPath][i]):
					if(randint == 0):
						currentGamePieces[paths[selectedPath][i]] = DirectionalPieces[4].instance()
					else:
						if(paths[selectedPath][i - 1] + 3 == paths[selectedPath][i]):
							currentGamePieces[paths[selectedPath][i]] = DirectionalPieces[8].instance()
						else:
							currentGamePieces[paths[selectedPath][i]] = DirectionalPieces[17].instance()
				elif(paths[selectedPath][i] < paths[selectedPath][i - 1]):
					if(paths[selectedPath][i] < 3):
						if(randint == 0):
							currentGamePieces[paths[selectedPath][i]] = DirectionalPieces[1].instance()
						else:
							currentGamePieces[paths[selectedPath][i]] = DirectionalPieces[11].instance()
					elif(paths[selectedPath][i] > 5):
						if(randint == 0):
							currentGamePieces[paths[selectedPath][i]] = DirectionalPieces[2].instance()
						else:
							currentGamePieces[paths[selectedPath][i]] = DirectionalPieces[9].instance()
				elif(paths[selectedPath][i] > paths[selectedPath][i - 1]):
					if(paths[selectedPath][i] < 3):
						if(randint == 0):
							currentGamePieces[paths[selectedPath][i]] = DirectionalPieces[0].instance()
						else:
							currentGamePieces[paths[selectedPath][i]] = DirectionalPieces[14].instance()
					elif(paths[selectedPath][i] > 5):
						if(randint == 0):
							currentGamePieces[paths[selectedPath][i]] = DirectionalPieces[3].instance()
						else:
							currentGamePieces[paths[selectedPath][i]] = DirectionalPieces[12].instance()
			else:
				if(paths[selectedPath][i - 1] + 3 == paths[selectedPath][i]):
					if(paths[selectedPath][i] + 3 == paths[selectedPath][i + 1]):
						if(randint == 0):
							currentGamePieces[paths[selectedPath][i]] = DirectionalPieces[4].instance()
						else:
							currentGamePieces[paths[selectedPath][i]] = DirectionalPieces[8].instance()
					elif(paths[selectedPath][i] < paths[selectedPath][i + 1]):
						if(randint == 0):
							currentGamePieces[paths[selectedPath][i]] = DirectionalPieces[1].instance()
						else:
							currentGamePieces[paths[selectedPath][i]] = DirectionalPieces[7].instance()
					elif(paths[selectedPath][i] > paths[selectedPath][i + 1]):
						if(randint == 0):
							currentGamePieces[paths[selectedPath][i]] = DirectionalPieces[0].instance()
						else:
							currentGamePieces[paths[selectedPath][i]] = DirectionalPieces[6].instance()
				elif(paths[selectedPath][i - 1] - 3 == paths[selectedPath][i]):
					if(paths[selectedPath][i] - 3 == paths[selectedPath][i + 1]):
						if(randint == 0):
							currentGamePieces[paths[selectedPath][i]] = DirectionalPieces[4].instance()
						else:
							currentGamePieces[paths[selectedPath][i]] = DirectionalPieces[17].instance()
					elif(paths[selectedPath][i] < paths[selectedPath][i + 1]):
						if(randint == 0):
							currentGamePieces[paths[selectedPath][i]] = DirectionalPieces[2].instance()
						else:
							currentGamePieces[paths[selectedPath][i]] = DirectionalPieces[16].instance()
					elif(paths[selectedPath][i] > paths[selectedPath][i + 1]):
						if(randint == 0):
							currentGamePieces[paths[selectedPath][i]] = DirectionalPieces[3].instance()
						else:
							currentGamePieces[paths[selectedPath][i]] = DirectionalPieces[15].instance()
				elif(paths[selectedPath][i] < paths[selectedPath][i - 1]):
					if(paths[selectedPath][i] + 3 == paths[selectedPath][i + 1]):
						if(randint == 0):
							currentGamePieces[paths[selectedPath][i]] = DirectionalPieces[2].instance()
						else:
							currentGamePieces[paths[selectedPath][i]] = DirectionalPieces[9].instance()
					elif(paths[selectedPath][i] - 3 == paths[selectedPath][i + 1]):
						if(randint == 0):
							currentGamePieces[paths[selectedPath][i]] = DirectionalPieces[1].instance()
						else:
							currentGamePieces[paths[selectedPath][i]] = DirectionalPieces[11].instance()
					else:
						if(randint == 0):
							currentGamePieces[paths[selectedPath][i]] = DirectionalPieces[5].instance()
						else:
							currentGamePieces[paths[selectedPath][i]] = DirectionalPieces[10].instance()
				elif(paths[selectedPath][i] > paths[selectedPath][i - 1]):
					if(paths[selectedPath][i] + 3 == paths[selectedPath][i + 1]):
						if(randint == 0):
							currentGamePieces[paths[selectedPath][i]] = DirectionalPieces[3].instance()
						else:
							currentGamePieces[paths[selectedPath][i]] = DirectionalPieces[12].instance()
					elif(paths[selectedPath][i] - 3 == paths[selectedPath][i + 1]):
						if(randint == 0):
							currentGamePieces[paths[selectedPath][i]] = DirectionalPieces[0].instance()
						else:
							currentGamePieces[paths[selectedPath][i]] = DirectionalPieces[14].instance()
					else:
						if(randint == 0):
							currentGamePieces[paths[selectedPath][i]] = DirectionalPieces[5].instance()
						else:
							currentGamePieces[paths[selectedPath][i]] = DirectionalPieces[13].instance()
		
		for i in range(0,9):
			if(currentGamePieces[i] != null):
				# warning-ignore:integer_division
				currentGamePieces[i].position = STARTPOS[randomLocation[i / 3][i % 3]]
			else:
				currentGamePieces[i] = DirectionalPieces[randi() % 18].instance()
				# warning-ignore:integer_division
				currentGamePieces[i].position = STARTPOS[randomLocation[i / 3][i % 3]]
			gamePiecesContainer.add_child(currentGamePieces[i])
		
		startOBJ.script = null
		endOBJ.script = null
		
		self.add_child(startOBJ)
		self.add_child(endOBJ)
		
		label.text = var2str(selectedPathLength)
	elif(gameMode == 4):
		currentGamePieces.resize(25)
		background.texture = load("res://Sprites/BackGround4.png")
		
		var colour1 = Color(randf(), randf(), randf())
		var colour2 = Color(randf(), randf(), randf())
		var colour3 = Color(randf(), randf(), randf())
		var colour4 = Color(randf(), randf(), randf())
		var colour1Comp = Color(1 - colour1.r, 1 - colour1.g, 1 - colour1.b)
		var colour2Comp = Color(1 - colour2.r, 1 - colour2.g, 1 - colour2.b)
		var colour3Comp = Color(1 - colour3.r, 1 - colour3.g, 1 - colour3.b)
		var colour4Comp = Color(1 - colour4.r, 1 - colour4.g, 1 - colour4.b)
		
		while(RegenerateColours(colour1, colour2, colour3, colour4, colour1Comp, colour2Comp, colour3Comp, colour4Comp)):
			colour1 = Color(randf(), randf(), randf())
			colour2 = Color(randf(), randf(), randf())
			colour3 = Color(randf(), randf(), randf())
			colour4 = Color(randf(), randf(), randf())
			colour1Comp = Color(1 - colour1.r, 1 - colour1.g, 1 - colour1.b)
			colour2Comp = Color(1 - colour2.r, 1 - colour2.g, 1 - colour2.b)
			colour3Comp = Color(1 - colour3.r, 1 - colour3.g, 1 - colour3.b)
			colour4Comp = Color(1 - colour4.r, 1 - colour4.g, 1 - colour4.b)
		
		for i in range(0, 25):
			currentGamePieces[i] = ColourPieces.instance()
			currentGamePieces[i].modulate = Color((colour1.r * COLOURMULTCONSTS[i][0]) + (colour2.r * COLOURMULTCONSTS[i][1]) + (colour3.r * COLOURMULTCONSTS[i][2]) + (colour4.r * COLOURMULTCONSTS[i][3]),
												  (colour1.g * COLOURMULTCONSTS[i][0]) + (colour2.g * COLOURMULTCONSTS[i][1]) + (colour3.g * COLOURMULTCONSTS[i][2]) + (colour4.g * COLOURMULTCONSTS[i][3]),
												  (colour1.b * COLOURMULTCONSTS[i][0]) + (colour2.b * COLOURMULTCONSTS[i][1]) + (colour3.b * COLOURMULTCONSTS[i][2]) + (colour4.b * COLOURMULTCONSTS[i][3]))
			currentGamePieces[i].position = STARTPOS5X5[i]
			gamePiecesContainer.add_child(currentGamePieces[i])
	else:
		print("some other gamemode")
		

func _input(event):
	if(Input.is_key_pressed(KEY_R)):
		get_tree().reload_current_scene()
	pass

	pass
