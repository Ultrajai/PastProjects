#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <ctype.h>
#include <math.h>

typedef struct node{
	char *name;
	float value;
	struct node *leftChild, *rightChild;
}node;

/*building tree functions*/
void buildTree(node*, char*, int*);

/*traversal functions*/
void inOrderTraversal(node*);
void preOrderTraversal(node*);
void postOrderTraversal(node*);

/*displaying tree functions*/
char*** insertItemsToArray(node*, int, char***);
void displayTree(char***, int);

/*calculation functions*/
void searchAndReplace(node*, char*, float);
float calculate(node*);

/*initilaization functions*/
node* createNode();
char*** initializeLevelTreeArray(int);

/*input error checking functions*/
int enoughBraces(char*);
int incompleteTree(node*);
int incorrectElements(node*);

/*helper functions*/
void flushSTDIN();

int main(int argc, char **argv)
{
	char ***levelTreeArray;
	int userInput = 0;
	char searchString[10];
	float valueToReplace = 0.0;
	int numItems = 0;
	
	node *root = createNode();
	
	if(argc != 2)
	{
		printf("no equation given!!!\n");
		return -1;
	}
	
	buildTree(root, argv[1], &numItems);
	
	/*checking for errors in equation*/
	if(!enoughBraces(argv[1]) || incompleteTree(root) || incorrectElements(root))
	{
		printf("your equation is invalid!!!\n");
		return -1;
	}
	
	/*main loop for user input*/
	while(userInput != 7)
	{
		printf("1. Display\n2. Preorder\n3. Inorder\n4. Postorder\n5. Update\n6. Calculate\n7. Exit\n");
		printf("please make your selection: ");
		scanf("%d", &userInput);
		
		switch(userInput)
		{
			case 1:
				levelTreeArray = initializeLevelTreeArray((int)floor(log10((double)numItems)/log10(2.0)));
				levelTreeArray = insertItemsToArray(root, 0, levelTreeArray);
				displayTree(levelTreeArray, (int)floor(log10((double)numItems)/log10(2.0)));
				free(levelTreeArray);
				break;
			case 2:
				preOrderTraversal(root);
				printf("\n");
				break;
			case 3:
				inOrderTraversal(root);
				printf("\n");
				break;
			case 4:
				postOrderTraversal(root);
				printf("\n");
				break;
			case 5:
				printf("Variable to change: ");
				scanf("%s", searchString);
				flushSTDIN();
				
				printf("Value: ");
				scanf("%4f", &valueToReplace);
				flushSTDIN();
				
				searchAndReplace(root, searchString, valueToReplace);
				break;
			case 6:
				printf("result: %.2f\n", calculate(root));
				break;
		}
	}
	
	return 0;
}

/*helper function to clean stdin of any left over input*/
void flushSTDIN()
{
	while(getc(stdin) != '\n' && !feof(stdin));
}

/*checks if any element has any errors when it was inputted to the tree*/
int incorrectElements(node *root)
{
	int incorrectBool = 0;
	
	/*checks the integrity of the nodes that contain values*/
	if(isdigit(root->name[0]))
	{
		if(root->name[1] != '.' || !isdigit(root->name[2]) || !isdigit(root->name[3]))
		{
			return 1;
		}
	}
	/*checks the integrity of nodes that are varibles*/
	else if(root->name[0] == 'x')
	{
		if(!isdigit(root->name[1]))
		{
			return 1;
		}
	}
	/*checks the integrity of nodes that are binary operators*/
	else if(root->name[0] != '*' && root->name[0] != '-' && root->name[0] != '+' && root->name[0] != '/')
	{
		return 1;
	}
	
	/*checks the left and right nodes if they exist*/
	if(root->leftChild != NULL)
	{
		incorrectBool = incorrectElements(root->leftChild);
	}
	
	if(incorrectBool == 0 && root->rightChild != NULL)
	{
		incorrectBool = incorrectElements(root->rightChild);
	}	
	
	return incorrectBool;
}

/*checks if the tree is missing any needed children for the binary operators*/
int incompleteTree(node *root)
{
	int incompleteBool = 0;
	if(root->name == NULL)
	{
		return 1;
	}
	else if(!isdigit(root->name[0]) && root->name[0] != 'x')
	{
		if(root->leftChild == NULL || root->rightChild == NULL)
		{
			return 1;
		}
		else
		{
			incompleteBool = incompleteTree(root->leftChild);

			if(incompleteBool == 0)
			{
				incompleteBool = incompleteTree(root->rightChild);
			}			
		}
	}

	return incompleteBool;
}

/*checks if too many braces or too little braces are given*/
int enoughBraces(char *equation)
{
	int numOpenBrace = 0;
	int numCloseBrace = 0;
	
	for(int i = 0; i < strlen(equation); i++)
	{
		if(equation[i] == '(')
		{
			numOpenBrace++;
		}
		else if(equation[i] == ')')
		{
			numCloseBrace++;
		}
	}
	
	if(numCloseBrace != numOpenBrace)
	{
		return 0;
	}
	else
	{
		return 1;
	}
}

/*calculates the equation from the tree*/
float calculate(node *root)
{
	if(strcmp(root->name, "/") == 0)
	{
		if(calculate(root->rightChild) != 0.0)
		{
			return calculate(root->leftChild) / calculate(root->rightChild);
		}
		else
		{
			printf("cannot divide by zero!!!\n");
			return 0.0;
		}
	}
	else if(strcmp(root->name, "+") == 0)
	{
		return calculate(root->leftChild) + calculate(root->rightChild);
	}
	else if(strcmp(root->name, "-") == 0)
	{
		return calculate(root->leftChild) - calculate(root->rightChild);
	}
	else if(strcmp(root->name, "*") == 0)
	{
		return calculate(root->leftChild) * calculate(root->rightChild);
	}
	else
	{
		return root->value;
	}	
	
}

/*inserts the tree items to a triple pointer array for the display function*/
char*** insertItemsToArray(node *root, int height, char*** levelTreeArray)
{
	char value[50];
	for(int i = 0; i < (int)pow(2.0, (float)height); i++)
	{
		/*inserts the name of the node to the array based on height and location*/
		if(levelTreeArray[height][i] == NULL)
		{
			if(root->name[0] == 'x')
			{
				levelTreeArray[height][i] = strcat(malloc(strlen(root->name) + 6), root->name);
				strcat(levelTreeArray[height][i], ":");
				sprintf(value, "%.2f", root->value);
				strcat(levelTreeArray[height][i], value);
			}
			else
			{
				levelTreeArray[height][i] = strcat(malloc(strlen(root->name)), root->name);
			}
			
			break;
		}
	}
	/*goes through the other nodes and adds them to the array*/
	if(root->leftChild != NULL)
	{
		levelTreeArray = insertItemsToArray(root->leftChild, height + 1, levelTreeArray);
	}
	
	if(root->rightChild != NULL)
	{
		levelTreeArray = insertItemsToArray(root->rightChild, height + 1, levelTreeArray);
	}
	
	return levelTreeArray;
}

/*initializes the triple pointer array*/
char*** initializeLevelTreeArray(int height)
{
	char ***levelTreeArray;
	
	levelTreeArray = malloc(sizeof(char ***) * (height + 1));
	
	for(int i = 0; i < height + 1; i++)
	{
		levelTreeArray[i] = malloc(sizeof(char **) * (int)pow(2.0, (float)i));
		
		for(int j = 0; j < (int)pow(2.0, (float)i); j++)
		{
			levelTreeArray[i][j] = NULL;
		}
	}
	
	return levelTreeArray;
	
}

/*displays tree based on the triple pointer array*/
void displayTree(char ***levelTreeArray, int height)
{
	for(int i = 0; i <= height; i++)
	{
		printf("level %2d: ", i + 1);
		for(int j = 0; j < (int)pow(2.0, (float)i); j++)
		{
			if(levelTreeArray[i][j] != NULL)
			{
				printf("%s ", levelTreeArray[i][j]);
			}
		}
		printf("\n");
	}
	
	
}

/*searches the tree for a node with a specific name and replaces the value with the value given*/
void searchAndReplace(node *root, char *stringToFind, float replaceVal)
{
	if(strcmp(root->name, stringToFind) == 0)
	{
		root->value = replaceVal;
	}
	else
	{
		if(root->leftChild != NULL)
		{
			searchAndReplace(root->leftChild, stringToFind, replaceVal);
		}
		
		if(root->rightChild != NULL)
		{
			searchAndReplace(root->rightChild, stringToFind, replaceVal);
		}
	}
}

/*creates space for a new node in the tree*/
node* createNode()
{
	node *item = malloc(sizeof(node));
	item->name = NULL;
	item->value = 0.0;
	item->leftChild = NULL;
	item->rightChild = NULL;
	
	return item;
}

/*travels and prints the tree in a post-order manner*/
void postOrderTraversal(node *root)
{
	if(root->leftChild != NULL)
	{
		postOrderTraversal(root->leftChild);
	}
	
	if(root->rightChild != NULL)
	{
		postOrderTraversal(root->rightChild);
	}
	
	printf("%s", root->name);
}

/*travels and prints the tree in a pre-order manner*/
void preOrderTraversal(node *root)
{
	printf("%s", root->name);
	
	if(root->leftChild != NULL)
	{
		preOrderTraversal(root->leftChild);
	}
	
	if(root->rightChild != NULL)
	{
		preOrderTraversal(root->rightChild);
	}
}

/*travels and prints the tree in a in-order manner with brackets*/
void inOrderTraversal(node *root)
{
	if(root->leftChild != NULL)
	{
		printf("(");
		inOrderTraversal(root->leftChild);
	}
	
	printf("%s", root->name);
	
	if(root->rightChild != NULL)
	{
		inOrderTraversal(root->rightChild);
		printf(")");
	}
}

/*build the tree from the expression given and updates the amount of items there are*/
void buildTree(node *root, char *expression, int *numItems)
{
	int numOpenBrace;
	int numCloseBrace;
	char *toCopy;
	
	/*loops through the expression excluding the outer brackets*/
	for(int i = 1; i < strlen(expression) - 1; i++)
	{
		numOpenBrace = 0;
		numCloseBrace = 0;
		
		/*
		  checks if we are at a brace and recursively calls the function modifying the expression to only
		  only include the expression in the brackets
		*/
		if(expression[i] == '(')
		{
			for(int j = i; j < strlen(expression) - 1; j++)
			{
				if(expression[j] == '(')
				{
					numOpenBrace++;
				}
				else if(expression[j] == ')')
				{
					numCloseBrace++;
				}
				
				
				if((numOpenBrace - numCloseBrace) == 0)
				{
					if(root->leftChild == NULL)
					{
						root->leftChild = createNode();
						toCopy = strncat(malloc(j - i + 2), (expression + i), (j - i + 1));
						toCopy[strlen(toCopy)] = '\0';
						buildTree(root->leftChild, toCopy, numItems);
						i = j;
					}
					else
					{
						root->rightChild = createNode();
						toCopy = strncat(malloc(j - i + 2), (expression + i), (j - i + 1));
						toCopy[strlen(toCopy)] = '\0';
						buildTree(root->rightChild, toCopy, numItems);
						i = j;
					}						
					break;
				}
			}
		}
		/*checks if the item we are looking at is a digit and creates a new digit node*/
		else if(isdigit(expression[i]))
		{
			toCopy = malloc(5);
			toCopy[0] = '\0';
			toCopy = strncat(toCopy, expression + i, 4);
			
			
			if(root->leftChild == NULL)
			{
				root->leftChild = createNode();
				root->leftChild->name = toCopy;	
				root->leftChild->value = atof(toCopy);
			}
			else
			{
				root->rightChild = createNode();
				root->rightChild->name = toCopy;
				root->rightChild->value = atof(toCopy);
			}
			
			*numItems += 1;

			i = i + 3;
		}
		/*checks if the item we are looking at is a variable and creates a new variable node*/
		else if(expression[i] == 'x')
		{
			toCopy = malloc(3);
			toCopy[0] = '\0';
			toCopy = strncat(toCopy, expression + i, 2);
			if(root->leftChild == NULL)
			{
				root->leftChild = createNode();
				root->leftChild->name = toCopy;
			}
			else
			{
				root->rightChild = createNode();
				root->rightChild->name = toCopy;
			}

			*numItems += 1;
			
			i = i + 1;
		}
		/*checks if the item we are looking at is a binary operator and creates a new operator node*/
		else
		{
			toCopy = malloc(2);
			toCopy[0] = '\0';
			toCopy = strncat(toCopy, expression + i, 1);
			*numItems += 1;
			
			root->name = toCopy;
		}
	}
}