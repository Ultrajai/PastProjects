#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

/*
Ajai Gill
1015577
11/4/2018
Assignment 3
*/

int** initializeHeap();
void populateHeap(int**, FILE*);
int** downHeap(int**, int);
void printHeap(int**);
int getKey(int*);

int main()
{
	int **heap = initializeHeap();;
	FILE *file = fopen("f.dat", "r");
	
	populateHeap(heap, file);
	
	printf("Before:\n");
	printHeap(heap);
	
	for(int i = (20 / 2); i > 0; i--)
	{
		
		heap = downHeap(heap, i);
	}

	printf("\n");
	
	printf("After:\n");
	printHeap(heap);
	
	printf("\n");
}

/*prints the heap with the key of each object before every object*/
void printHeap(int **heap)
{
	for(int i = 1; i < 21; i++)
	{
		printf("%3d: ", getKey(heap[i]));
		
		for(int j = 0; j < 10; j++)
		{
			printf("%02d ", heap[i][j]);
		}
		
		printf("\n");
	}
}

/*performs the down heap algorithm*/
int** downHeap(int **heap, int index)
{
	int *temp;
	
	/*checks if the index we are going to reference exists*/
	if((index * 2) <= 20 && (2 * index + 1) <= 20)
	{
		/*finds out which child is larger and swaps that node and if that child is larger than the orignal node then swap them*/
		if(getKey(heap[2 * index]) > getKey(heap[2 * index + 1]) && getKey(heap[index]) < getKey(heap[2 * index]))
		{
			temp = heap[index];
			heap[index] = heap[2 * index];
			heap[2 * index] = temp;
		
			if((2 * index) <= 10)
			{
				heap = downHeap(heap, 2 * index);
			}
		}
		else if(getKey(heap[2 * index]) < getKey(heap[2 * index + 1]) && getKey(heap[index]) < getKey(heap[2 * index + 1]))
		{
			temp = heap[index];
			heap[index] = heap[2 * index + 1];
			heap[2 * index + 1] = temp;
		
			if((2 * index + 1) <= 10)
			{
				heap = downHeap(heap, 2 * index + 1);
			}
		}
	}
	/*if not then check if one of the nodes exists*/
	else if((2 * index + 1) <= 20)
	{
		/*checks if the node to be swapped is greater than the original node then swaps*/
		if(getKey(heap[index]) < getKey(heap[2 * index + 1]))
		{
			temp = heap[index];
			heap[index] = heap[2 * index + 1];
			heap[2 * index + 1] = temp;
		}
	}
	else if((index * 2) <= 20)
	{
		/*checks if the node to be swapped is greater than the original node then swaps*/
		if(getKey(heap[index]) < getKey(heap[2 * index]))
		{
			temp = heap[index];
			heap[index] = heap[2 * index];
			heap[2 * index] = temp;
		}
	}

	return heap;
}

int getKey(int *object)
{
	return object[0] + object[1] + object[2];
}

/*inserts the heap array with the data from the file*/
void populateHeap(int **heap, FILE *file)
{
	for(int i = 1; !feof(file); i++)
	{
		for(int j = 0; j < 10; j++)
		{
			fscanf(file, "%d", &heap[i][j]);
		}
	}
}

/*creates space for the heap array*/
int** initializeHeap()
{
	int **heap;
	
	heap = malloc(sizeof(int *) * 21);
	
	for(int i = 1; i < 21; i++)
	{
		heap[i] = malloc(sizeof(int) * 10);
	}
	
	return heap;
}