#ifndef HEADER
#define HEADER

/*
Ajai Gill
1015577
10/14/2018
Assignment 2
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct Info
{
  char *plateNumber;
  int mileage;
  int returnDate;
}Info;

typedef struct List
{
  Info data;
  struct List *next;
}List;

/*Main Functions*/
void addNewCar(List**, List*, List*);
void addReturnToAvailable(List**, List**, float*);
void addReturnToRepair(List**, List**, float*);
void transferRepairToAvailable(List**, List**);
void rent(List**, List**);
void printLists(List*, List*, List*);
void quit(float, List*, List*, List*);

/*Helper Funtions*/
void flushSTDIN();
void plateNumAndMileage(char*, int*, List*, List*, List*);
void orderByMileage(List**, List**);
void orderByReturnDate(List**, List**);
void moveFromList(List**, List**, int , char*, int);
void amountEarned(float*, List**);
void loadData(float*, List**, List**, List**);
void checkPlateNum(List**, List**, List**, char*);

#endif
