Ajai Gill
1015577
Assignment 3

Question 1:
+++++++++++

notes:
- it will check for errors in your equation and won't run if the equation does have errors
	- However, it won't explain what is wrong with your equation
	- if you create an equation with wrong number format, variable format, or some character meant to be one of the binary operators 
	  the program won't run (ie. '{' )
	- if you are missing variables or numbers in an equation the program will not run (ex. (1.22+) )
	- if you create an equation like this: ((equation...)). the program will not run because it will treat the inner brackets as a child to an
	  outer equation, if you want to do that you create the equation like this: ((equation...)+0.00)
	- You can only input vaiables from x0 to x9 nothing else can be excepted as a variable
	
- it will not work well or even at all if you don't provide braces around the equation initially like this: (equation....)

- the tree is displayed by height, so read left to right and match up two nodes with the previous nodes to get a visualization
	- ex. level  1: /
		  level  2: * x2:0.00
		  level  3: + -
		  level  4: 1.56 4.26 x1:0.00 2.23
		  
	  Means this:
					 -----------/-----------
					|						|
			--------*-------				x2
		   |				|
	    ---+---			----(-)----
	   |	   |	   |		   |
	 1.56     4.26     x1        2.23

Example of use
--------------

Case 1: if you type 1 it will display the tree by height.

$ ./q1 \(\(\(1.56+4.26\)*\(x1-2.23\)\)/x2\)
1. Display
2. Preorder
3. Inorder
4. Postorder
5. Update
6. Calculate
7. Exit
please make your selection: 1
level  1: /
level  2: * x2:0.00
level  3: + -
level  4: 1.56 4.26 x1:0.00 2.23

Case 2: if you type 2 it will print the equation in a pre-order way.

$ ./q1 \(\(\(1.56+4.26\)*\(x1-2.23\)\)/x2\)
1. Display
2. Preorder
3. Inorder
4. Postorder
5. Update
6. Calculate
7. Exit
please make your selection: 2
/*+1.564.26-x12.23x2

Case 3: if you type 3 it will print the equation in an in-order way.

$ ./q1 \(\(\(1.56+4.26\)*\(x1-2.23\)\)/x2\)
1. Display
2. Preorder
3. Inorder
4. Postorder
5. Update
6. Calculate
7. Exit
please make your selection: 3
(((1.56+4.26)*(x1-2.23))/x2)

Case 4: if you type 4 it will print the equation in a post-order way.

$ ./q1 \(\(\(1.56+4.26\)*\(x1-2.23\)\)/x2\)
1. Display
2. Preorder
3. Inorder
4. Postorder
5. Update
6. Calculate
7. Exit
please make your selection: 4
1.564.26+x12.23-*x2/

Case 5: if you type 5 it will prompt you to provide the variable you wish to change and the value you wish to change it to.

$ ./q1 \(\(\(1.56+4.26\)*\(x1-2.23\)\)/x2\)
1. Display
2. Preorder
3. Inorder
4. Postorder
5. Update
6. Calculate
7. Exit
please make your selection: 5
Variable to change: x1
Value: 2.33

Case 6: if you type 6 it will calculate the equation unless an error occurs when performing the calculation.

$ ./q1 \(\(\(1.56+4.26\)*\(x1-2.23\)\)/x2\)
//I provided varible changes before to prevent divide by zero error
1. Display
2. Preorder
3. Inorder
4. Postorder
5. Update
6. Calculate
7. Exit
please make your selection: 6
result: 0.29

Case 7: exits the program.

$ ./q1 \(\(\(1.56+4.26\)*\(x1-2.23\)\)/x2\)
1. Display
2. Preorder
3. Inorder
4. Postorder
5. Update
6. Calculate
7. Exit
please make your selection: 7

Question 2
++++++++++

Notes:
- in order for the program to work you have to have a correctly formatted file with the right amount elements only consisiting of 2-digit numbers
	- the file shouldn't have empty lines anywhere even at the endotherwise the program will contain a bad object
- the program will show you a before and after imiage of the heap before and after downheap was performed

Example
-------
$ ./q2
Before:
 54: 25 12 17 82 52 53 05 03 68 64
 90: 43 27 20 59 04 84 10 42 43 02
137: 81 14 42 21 09 69 05 30 20 91
260: 96 89 75 00 63 24 54 20 20 24
185: 41 62 82 46 69 42 74 68 79 28
 65: 50 09 06 44 59 87 32 36 36 46
208: 83 82 43 11 21 04 08 97 93 14
139: 03 60 76 23 14 81 82 00 38 04
114: 09 83 22 90 74 56 64 75 67 55
176: 41 82 53 40 29 84 24 61 87 20
186: 99 37 50 93 57 06 29 91 92 39
 77: 25 41 11 88 15 39 88 69 31 49
137: 03 37 97 53 36 54 69 68 38 43
139: 44 27 68 96 70 98 85 13 25 47
178: 51 90 37 86 42 44 48 64 41 01
 57: 16 14 27 99 29 99 79 45 59 19
203: 88 56 59 88 39 30 44 59 49 72
110: 49 17 44 32 33 54 60 33 51 87
 80: 12 00 68 68 49 68 74 32 09 30
127: 81 30 16 65 40 39 44 49 32 60

After:
260: 96 89 75 00 63 24 54 20 20 24
203: 88 56 59 88 39 30 44 59 49 72
208: 83 82 43 11 21 04 08 97 93 14
139: 03 60 76 23 14 81 82 00 38 04
186: 99 37 50 93 57 06 29 91 92 39
137: 03 37 97 53 36 54 69 68 38 43
178: 51 90 37 86 42 44 48 64 41 01
 90: 43 27 20 59 04 84 10 42 43 02
114: 09 83 22 90 74 56 64 75 67 55
176: 41 82 53 40 29 84 24 61 87 20
185: 41 62 82 46 69 42 74 68 79 28
 77: 25 41 11 88 15 39 88 69 31 49
 65: 50 09 06 44 59 87 32 36 36 46
139: 44 27 68 96 70 98 85 13 25 47
137: 81 14 42 21 09 69 05 30 20 91
 57: 16 14 27 99 29 99 79 45 59 19
 54: 25 12 17 82 52 53 05 03 68 64
110: 49 17 44 32 33 54 60 33 51 87
 80: 12 00 68 68 49 68 74 32 09 30
127: 81 30 16 65 40 39 44 49 32 60

- THIS IS VERY IMPORTANT: this program only results in a max heap if you would like it to result in a min heap change these lines in the
  downheap function to:
  
  line 61: if(getKey(heap[2 * index]) < getKey(heap[2 * index + 1]) && getKey(heap[index]) > getKey(heap[2 * index]))
  line 72: else if(getKey(heap[2 * index]) > getKey(heap[2 * index + 1]) && getKey(heap[index]) < getKey(heap[2 * index + 1]))
  line 88: if(getKey(heap[index]) > getKey(heap[2 * index + 1]))
  line 98: if(getKey(heap[index]) > getKey(heap[2 * index]))