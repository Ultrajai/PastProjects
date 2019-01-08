#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <ctype.h>

/*
Ajai Gill
1015577
10/14/2018
Assignment 2
*/

#define MAX 100

typedef struct stack{
	float array[MAX];
	int top;
}Stack;

/*function declarations*/
void push(Stack*, float, int*);
float pop(Stack*, int*);

int main(int argc, char **argv)
  {
	float operand1 = 0;
	float operand2 = 0;
	int error = 0;
	Stack stack;
	
	stack.top = -1;
	
	if(argc != 2)
	{
		return -1;
	}
	
	
	/*reads argument values and performs the appropriate function call and/or initializations*/
	for(int i = 0; i < strlen(argv[1]); i++)
	  {
		if(isdigit(argv[1][i]))
		{
			push(&stack, (float)(argv[1][i] - '0'), &error);
		}
		else if(argv[1][i] == '-')
		{
			operand2 = pop(&stack, &error);
			operand1 = pop(&stack, &error);
			
			push(&stack, operand1 - operand2, &error);
		}
		else if(argv[1][i] == '+')
		{
			operand2 = pop(&stack, &error);
			operand1 = pop(&stack, &error);
			
			push(&stack, operand1 + operand2, &error);
		}
		else if(argv[1][i] == '*')
		{
			operand2 = pop(&stack, &error);
			operand1 = pop(&stack, &error);
			
			push(&stack, operand1 * operand2, &error);
		}
		else if(argv[1][i] == '/')
		{
			operand2 = pop(&stack, &error);
			operand1 = pop(&stack, &error);
			
			push(&stack, operand1 / operand2, &error);
		}
		
	  }
	
	if(error != 1 && stack.top == 0)
	  {
		printf("result: %.2f\n", pop(&stack, &error));
	  }
	
	
	return 0;
  }

/*pushes the value onto the stack*/
void push(Stack *stack, float num, int *error)
  {
	if(stack->top >= MAX - 1)
	{
	  printf("Stack is full\n");
	  *error = 1;
	  return;
	}
	
	stack->top++;
	stack->array[stack->top] = num;
		
	
  }

/*removes the item on the top of the list and returns the number*/
float pop(Stack *stack, int *error)
  {
	  float val = 0;
	  
	  if(stack->top < 0)
	  {
		  printf("Math error: there is not enough operands to do calculation!!!\n");
		  *error = 1;
		  return 0;
	  }
	  
	  val = stack->array[stack->top];
	  stack->top--;
	  
	  return val;
  }