Ajai Gill
1015577

Compilation Notes:
- q1.c needs q1.h in order to compile properly
- If you want to compile for question 1 type 'make q1' in the command prompt
- If you want to compile for question 2 type 'make q2' in the command prompt
- if you wan to compile both questions type 'make all' or just 'make'
- to delete q1 or q2 type 'make clean'

Question 1
++++++++++

Notes:
- The program only takes in plate numbers that has a '-' in the middle of the number like '???-???'
- The program only receives plate numbers 7 characters long
- The program will protect against duplicate plate numbers
- The program will protect for searching for non-existent cars
- The program will protect against some bad inputs (see below)
	- The program will not be able to protect for bad input for plate numbers like '*()-!@#'
	- The program will not be able to protect for bad input for return date like '999999' but will stop
	  numbers with not enough or too many digits
- The program takes kilometers as integers 
- to run type './q1' then hit enter.

Examples of use
---------------

Case 1: If you type 1 you will be prompted for the plate number and milage of the car you want to add then you will
		return to the main menu for your next order.

Example
-------
Please choose a number between 1-7:
1: Add a new car to the available-for-rent list
2: Add a returned car to the available-for-rent list
3: Add a returned car to the repair list
4: Transfer a car from the repair list to the available-for-rent list
5: Rent the first Available car
6: print all lists
7: quit
1
please provide the plate number and mileage:
plate number(ex. 'XXX-XXX'):999-999
Mileage:99
Please choose a number between 1-7:
1: Add a new car to the available-for-rent list
2: Add a returned car to the available-for-rent list
3: Add a returned car to the repair list
4: Transfer a car from the repair list to the available-for-rent list
5: Rent the first Available car
6: print all lists
7: quit

Case 2: If you type 2 you will be prompted for the plate number and milage of the car you want to move from the return list
	    back to the available-for-rent list. It will also prompt for the distance the car has driven.
	   
Example
-------
Please choose a number between 1-7:
1: Add a new car to the available-for-rent list
2: Add a returned car to the available-for-rent list
3: Add a returned car to the repair list
4: Transfer a car from the repair list to the available-for-rent list
5: Rent the first Available car
6: print all lists
7: quit
2
please provide the plate number and mileage:
plate number(ex. 'XXX-XXX'):999-999
Mileage:99
How many kilometers was the car driven: 123
Please choose a number between 1-7:
1: Add a new car to the available-for-rent list
2: Add a returned car to the available-for-rent list
3: Add a returned car to the repair list
4: Transfer a car from the repair list to the available-for-rent list
5: Rent the first Available car
6: print all lists
7: quit

Case 3: If you type 3 you will be prompted for the plate number and milage of the car you want to move from the return list
	    into the in-repair list. It will also prompt for the distance the car has driven.

Example
-------
Please choose a number between 1-7:
1: Add a new car to the available-for-rent list
2: Add a returned car to the available-for-rent list
3: Add a returned car to the repair list
4: Transfer a car from the repair list to the available-for-rent list
5: Rent the first Available car
6: print all lists
7: quit
3
please provide the plate number and mileage:
plate number(ex. 'XXX-XXX'):999-999
Mileage:99
How many kilometers was the car driven: 80
Please choose a number between 1-7:
1: Add a new car to the available-for-rent list
2: Add a returned car to the available-for-rent list
3: Add a returned car to the repair list
4: Transfer a car from the repair list to the available-for-rent list
5: Rent the first Available car
6: print all lists
7: quit

Case 4: If you type 4 you will be prompted for the plate number of the car you want to move from the in-repair list
	    back to the available-for-rent list.
		
Example
-------
Please choose a number between 1-7:
1: Add a new car to the available-for-rent list
2: Add a returned car to the available-for-rent list
3: Add a returned car to the repair list
4: Transfer a car from the repair list to the available-for-rent list
5: Rent the first Available car
6: print all lists
7: quit
4
please provide the plate number and mileage:
plate number(ex. 'XXX-XXX'):999-999
Please choose a number between 1-7:
1: Add a new car to the available-for-rent list
2: Add a returned car to the available-for-rent list
3: Add a returned car to the repair list
4: Transfer a car from the repair list to the available-for-rent list
5: Rent the first Available car
6: print all lists
7: quit

Case 5: If you type 5 you will be prompted for the return date of the car you want to move from the available-for-rent list
	    to the rented list.

Example
-------
Please choose a number between 1-7:
1: Add a new car to the available-for-rent list
2: Add a returned car to the available-for-rent list
3: Add a returned car to the repair list
4: Transfer a car from the repair list to the available-for-rent list
5: Rent the first Available car
6: print all lists
7: quit
5
What is the expected return date (yymmdd):120916
Please choose a number between 1-7:
1: Add a new car to the available-for-rent list
2: Add a returned car to the available-for-rent list
3: Add a returned car to the repair list
4: Transfer a car from the repair list to the available-for-rent list
5: Rent the first Available car
6: print all lists
7: quit

Case 6: If you type 6 all list items from each list will be printed. It first prints the plate number then mileage
		then return date if it was rented. Car means an available-for-rent car, Rent means a rented car, and Repair
		means a car that is in repair.

Example
-------
Please choose a number between 1-7:
1: Add a new car to the available-for-rent list
2: Add a returned car to the available-for-rent list
3: Add a returned car to the repair list
4: Transfer a car from the repair list to the available-for-rent list
5: Rent the first Available car
6: print all lists
7: quit
6
Car 1: 999-999, 99
Car 2: 186-607, 123
Rent 1: 123-456, 23, 160815
Rent 2: 125-456, 56, 170918
Repair 1: 427-586, 137
Repair 2: 456-678, 134
Please choose a number between 1-7:
1: Add a new car to the available-for-rent list
2: Add a returned car to the available-for-rent list
3: Add a returned car to the repair list
4: Transfer a car from the repair list to the available-for-rent list
5: Rent the first Available car
6: print all lists
7: quit


Case 7: If you type 7 the program will print the total revenue earned and save all data into a data.txt file.

Example
-------
Please choose a number between 1-7:
1: Add a new car to the available-for-rent list
2: Add a returned car to the available-for-rent list
3: Add a returned car to the repair list
4: Transfer a car from the repair list to the available-for-rent list
5: Rent the first Available car
6: print all lists
7: quit
7
Revenue: 43.75

data.txt Example
----------------
43.75
1 999-999 99 0
2 186-607 123 0
1 123-456 23 160815
2 125-456 56 170918
1 427-586 137 0
2 456-678 134 0


Question 2
++++++++++

Notes:
- When you don't give enough arguments it won't run
- This program requires 2 command line argument values
- The program will not compute if a math error has occured
- The stack can only contain 100 different operands

To run type './q2' then type your equation in postfix orientation. Then hit enter:
Example
-------
$ ./q2 12+
result: 3.00

If only 2 numbers are provided nothing will return:
Example
-------
$ ./q2 12

If only 1 number is provided it will return that number:
Example
-------
$ ./q2 1
result: 1.00

If at least 2 calculations are done and their results are left in the stack with out any manipulation it will return nothing:
Example
-------
$ ./q2 12+53-

If too many operations are given an error is returned:
Example
-------
$ ./q2 12//
Math error: there is not enough operands to do calculation!!!

