#include "q1.h"

/*
Ajai Gill
1015577
10/14/2018
Assignment 2
*/

int main()
  {

    int userChoice = -1;
    float revenue = 0.0;

    List *available = NULL;
    List *rented = NULL;
    List *inRepair = NULL;

    loadData(&revenue, &available, &rented, &inRepair);
	
	/*Calls appropriate functions depending on user input*/
    while(userChoice != 7)
      {
        printf("Please choose a number between 1-7:\n");
        printf("1: Add a new car to the available-for-rent list\n2: Add a returned car to the available-for-rent list\n3: Add a returned car to the repair list\n4: Transfer a car from the repair list to the available-for-rent list\n5: Rent the first Available car\n6: print all lists\n7: quit\n");

        scanf("%d", &userChoice);
        switch(userChoice)
          {
            case 1:
              addNewCar(&available, rented, inRepair);
              break;
            case 2:
              addReturnToAvailable(&available, &rented, &revenue);
              break;
            case 3:
              addReturnToRepair(&rented, &inRepair, &revenue);
              break;
            case 4:
              transferRepairToAvailable(&inRepair, &available);
              break;
            case 5:
              rent(&available, &rented);
              break;
            case 6:
              printLists(available, rented, inRepair);
              break;
            case 7:
              quit(revenue, available, rented, inRepair);
              break;
          }
      }
    return 0;
  }

/*
Adds a new car to the available-to-rent list. Prompts for plate number and mileage and
orders the list by mileage.
*/
void addNewCar(List **available, List *rented, List *inRepair)
  {
    List *newCar = NULL;

    newCar = malloc(sizeof(List));
    newCar->data.plateNumber = malloc(8);
    newCar->data.mileage = 0;
    newCar->data.returnDate = 0;
    newCar->next = NULL;
	
	printf("\n");

    plateNumAndMileage(newCar->data.plateNumber, &(newCar->data.mileage), *available, rented, inRepair);

    orderByMileage(available, &newCar);
	
	printf("\n");

  }

/*
Moves a rented car from the rented list to the available-to-rent list. Prompts for the plate number
and mileage and locates the list item the user wanted and prompts for the distance the car was driven,
adds the appropriate amount of revenue, updates the milage of the car, and moves it to the available-to-rent list.
*/
void addReturnToAvailable(List **available, List **rented, float *revenue)
  {
    char plate[8];
    int mile = 0;

    List *itemToMove = NULL;
	
	printf("\n");

    plateNumAndMileage(plate, &mile, NULL, NULL, NULL);

    moveFromList(rented, &itemToMove, mile, plate, 1);

    if(itemToMove)
      {
        amountEarned(revenue, &itemToMove);
        orderByMileage(available, &itemToMove);
      }
    else
      {
        printf("there isn't a rented car with that plate number or mileage!\n");
      }

	  
	printf("\n");
  }

/*
Moves a rented car from the rented list to the in-repair list. Prompts for the plate number
and mileage and locates the list item the user wanted and prompts for the distance the car was driven,
adds the appropriate amount of revenue, updates the milage of the car, and moves it to the in-repair list.
*/
void addReturnToRepair(List **rented, List **inRepair, float *revenue)
  {
    char plate[8];
    int mile = 0;

    List *itemToMove = NULL;
	
	printf("\n");

    plateNumAndMileage(plate, &mile, NULL, NULL, NULL);

    moveFromList(rented, &itemToMove, mile, plate, 1);

    if(itemToMove)
      {
        itemToMove->next = *inRepair;
        amountEarned(revenue, &itemToMove);
        *inRepair = itemToMove;
      }
    else
      {
        printf("there isn't a rented car with that plate number or mileage!\n");
      }
	  
	printf("\n");

  }

/*
Moves a in-repair car to the available-to-rent list. Just prompts for the plate number then finds
the correct car and moves it back into the available-to-rent list.
*/
void transferRepairToAvailable(List **inRepair, List **available)
  {
    char plate[8];

    List *itemToMove = NULL;
	
	printf("\n");

    plateNumAndMileage(plate, NULL, NULL, NULL, NULL);

    moveFromList(inRepair, &itemToMove, 0, plate, 2);

    if(itemToMove)
      {
        orderByMileage(available, &itemToMove);
      }
    else
      {
        printf("there isn't a car in repair with that plate number!\n");
      }
	  
	printf("\n");

  }

  
/*
Rents the first available-to-rent car in the available-to-rent list. Prompts for
the return date then places the car in the rented list by return date.
*/
void rent(List **cars, List **rented)
  {
    int returnTime = 0;
    List *temp = NULL;
	
	printf("\n");
	
	/*
	error checks if the value of your return dat is too large or too small.
	*/
    do
      {
        flushSTDIN();
        printf("What is the expected return date (yymmdd):");
        scanf("%d", &returnTime);
      }while(returnTime > 999999 || returnTime <= 99999);

    temp = *cars;
    *cars = (**cars).next;
    temp->next = NULL;
    temp->data.returnDate = returnTime;

    orderByReturnDate(rented, &temp);
	
	printf("\n");

  }

  
/*
Prints all the elements of each list.
*/
void printLists(List *available, List *rented, List *inRepair)
  {
    int i = 1;

	printf("\n");
	
    while(available)
      {
        printf("Available %d: %s, %d\n", i, available->data.plateNumber, available->data.mileage);
        available = available->next;
        i++;
      }

    i = 1;

    while(rented)
      {
        printf("Rent %d: %s, %d, %d\n", i, rented->data.plateNumber, rented->data.mileage, rented->data.returnDate);
        rented = rented->next;
        i++;
      }

    i = 1;

    while(inRepair)
      {
        printf("Repair %d: %s, %d\n", i, inRepair->data.plateNumber, inRepair->data.mileage);
        inRepair = inRepair->next;
        i++;
      }
	  
	printf("\n");
  }

  
/*
Prints total revenue, then creates a file, then places the revenue and lists' elements' data
into the file.
*/
void quit(float revenue, List *available, List *rented, List *inRepair)
  {
    FILE *file = fopen("data.txt", "w");

    printf("Revenue: %.2f\n", revenue);

    fprintf(file, "%.2f\n", revenue);

    int i = 1;

    while(available)
      {
        fprintf(file, "%d %s %d %d\n", i, available->data.plateNumber, available->data.mileage, 0);
        available = available->next;
        i++;
      }

    i = 1;

    while(rented)
      {
        fprintf(file, "%d %s %d %d\n", i, rented->data.plateNumber, rented->data.mileage, rented->data.returnDate);
        rented = rented->next;
        i++;
      }

    i = 1;

    while(inRepair)
      {
        fprintf(file, "%d %s %d %d\n", i, inRepair->data.plateNumber, inRepair->data.mileage, 0);
        inRepair = inRepair->next;
        i++;
      }

    fclose(file);
  }

  
/*
A helper function that cleans any left over input inside of stdin.
*/
void flushSTDIN()
  {
    while(getc(stdin) != '\n' && !feof(stdin));
  }

/*
A helper function that prompts for the plate number and optionally mileage if the pointer isn't NULL.
*/
void plateNumAndMileage(char *plateNumber, int *mileage, List *available, List *rented, List *inRepair)
  {

    do
      {
        flushSTDIN();
        printf("plate number(ex. 'XXX-XXX'):");
        fgets(plateNumber, 8, stdin);
      }while(plateNumber[3] != '-');

	  
	if(available && rented && inRepair)
	  {
		checkPlateNum(&available, &rented, &inRepair, plateNumber);
	  }
	
    if(mileage)
      {
        flushSTDIN();
        printf("Mileage:");
        scanf("%d", mileage);
      }

  }

/*
A helper function that places a car into a list by mileage.
*/
void orderByMileage(List **list, List **car)
  {
    List dummy;
    List *p = NULL;

    dummy.next = *list;
    p = &dummy;

    while(p->next && (**car).data.mileage > p->next->data.mileage)
      {
        p = p->next;
      }

    (**car).next = p->next;
    p->next = *car;
    *list = dummy.next;
  }

/*
A helper function that places a car into a list by return date.
*/
void orderByReturnDate(List **list, List **car)
  {
    List dummy;
    List *p = NULL;

    dummy.next = *list;
    p = &dummy;

    while(p->next && (**car).data.returnDate > p->next->data.returnDate)
      {
        p = p->next;
      }

    (**car).next = p->next;
    p->next = *car;
    *list = dummy.next;
  }

/*
A helper function that removes a car from a list based on the plate number and mileage or just plate number
based on the version of the function is passed.
*/
void moveFromList(List **list, List **toMove, int mile, char *plate, int version)
  {
    List dummy;
    List *p = NULL;

    dummy.next = *list;
    p = &dummy;

    if(version == 1)
      {
        while(p->next && strcmp(p->next->data.plateNumber, plate) != 0 && p->next->data.mileage !=  mile)
          {
            p = p->next;
          }
      }
    else
      {
        while(p->next && strcmp(p->next->data.plateNumber, plate) != 0)
          {
            p = p->next;
          }
      }

    if(p->next)
      {
        *toMove = p->next;
        p->next = (**toMove).next;
        *list = dummy.next;
      }
    else
      {
        *toMove = NULL;
      }

  }

/*
A helper function that prompts for the amount of kilometers a car was driven for
then calculates the revenue earned for the return and then adds the distance 
traveled to the mileage of the car driven.
*/
void amountEarned(float *revenue, List **car)
  {
    int kilometers = 0;

    printf("How many kilometers was the car driven: ");
	
	do{
		
		scanf("%d", &kilometers);
		
	}while(kilometers < 0);
    

    if(kilometers < 100)
      {
        *revenue += 40.00;
      }
    else
      {
        *revenue = ((float)(kilometers - 100) * 0.15) + 40.00;
      }

    (**car).data.mileage += kilometers;

  }

/*
Opens the data.txt file and gathers that data and places the items into the appropriate lists.
*/
void loadData(float *revenue, List **available, List **rented, List **inRepair)
  {
    int largestIndex = 1;
    int listNo = 1;
    int i = 0;
    int mile = 0;
    int returnTime;

    char plate[8];

    List *car = NULL;
    FILE *file = fopen("data.txt", "r");

    if(file)
	  {
	    fscanf(file, "%f", revenue);

		while(fscanf(file, "%d %s %d %d", &i, plate, &mile, &returnTime) && !feof(file))
		  {
			/*checks if we are looking at a different list of cars based on the index number read*/
			if(i != largestIndex)
              {
				largestIndex = i + 1;
				listNo += 1;
			  }
			else
			  {
				largestIndex += 1;
			  }

			car = malloc(sizeof(List));
			car->data.plateNumber = malloc(8);
			car->data.mileage = 0;
			car->data.returnDate = 0;
			car->next = NULL;

			strcpy(car->data.plateNumber, plate);
			car->data.mileage = mile;
			car->data.returnDate = returnTime;

			if(listNo == 1)
			  {
				orderByMileage(available, &car);
			  }
			else if(listNo == 2)
			  {
				orderByReturnDate(rented, &car);
			  }
			else if(listNo == 3)
			  {
			    car->next = *inRepair;
				*inRepair = car;
			  }

		  }
	  }
  }

/*
A helper function that checks if the plate number already exists and then prompts for a new one.
*/
void checkPlateNum(List **available, List **rented, List **inRepair, char *plateNum)
  {
	List *list;
	
	list = *available;
	
    while(list)
      {
        if(strcmp(plateNum, list->data.plateNumber) == 0)
		  {
			printf("Already have a plate number like that! Please provide a new one.\n");
			while(strcmp(plateNum, list->data.plateNumber) == 0)
			  {
				plateNumAndMileage(plateNum, NULL, *available, *rented, *inRepair);
			  }	
		  }
		list = list->next;
      }
	  
	list = *rented;

    while(list)
      {
          if(strcmp(plateNum, list->data.plateNumber) == 0)
		  {
			printf("Already have a plate number like that! Please provide a new one.\n");
			while(strcmp(plateNum, list->data.plateNumber) == 0)
			  {
				plateNumAndMileage(plateNum, NULL, *available, *rented, *inRepair);
			  }	
		  }
		list = list->next;
      }

	list = *inRepair;
	  
    while(list)
      {
          if(strcmp(plateNum, list->data.plateNumber) == 0)
		  {
			printf("Already have a plate number like that! Please provide a new one.\n");
			while(strcmp(plateNum, list->data.plateNumber) == 0)
			  {
				plateNumAndMileage(plateNum, NULL, *available, *rented, *inRepair);
			  }	
		  }
		list = list->next;
      }
  }