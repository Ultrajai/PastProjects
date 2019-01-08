#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

/*
Ajai Gill
1015577
10/14/2018
Assignment 4
*/

typedef struct node{
	int bFactor;
	char *key;
	int frequency;
	struct node *left, *right;
}AVL_Node;

void BuildTree(AVL_Node **root, FILE *file);
AVL_Node *SearchTree(AVL_Node *root, char *key);
AVL_Node *CreateNode(char *key);
void InsertNode(char *key, AVL_Node **root);
void DeleteNode(char *key, AVL_Node **root);
void UpdateBFactors(AVL_Node *root);
int CalculateHeight(AVL_Node *root);
void InsertionAnalysis(AVL_Node **root, char *keyEntered);
void DeletionAnalysis(AVL_Node **root, char *keyDeleted);
void Restructure(AVL_Node *x, AVL_Node *y, AVL_Node *z, AVL_Node **prevNode, int changeRoot);
void SizeAndCount(unsigned long long *size, unsigned long long *count, AVL_Node *root);
unsigned long long KeyToInt(char *key);
void FindAllAbove(AVL_Node *root, int threshold);
AVL_Node *FindMax(AVL_Node *root);
AVL_Node *FindMin(AVL_Node *root);
void SetXYZ(AVL_Node **x, AVL_Node **y, AVL_Node **z);

void PrintTree(AVL_Node *tree);

int main()
{
	AVL_Node *tree = NULL;
	FILE *file = NULL;
	int userChoice = 0;
	int avlBool = 0;
	AVL_Node *nodeFound = NULL;
	char key[10];
	unsigned long height = 0;
	unsigned long long size = 0;
	unsigned long long count = 0;
    long threshold = -1;

	while(userChoice != 7)
	{
		printf("1. Initialization\n2. Find\n3. Insert\n4. Remove\n5. Check Height, Size, and Total Count\n6. Find All (above a given frequency)\n7. Exit\n");
		printf("avl/> ");
		scanf("%d", &userChoice);

		switch(userChoice)
		{
			case 1:
				file = fopen("A4_data_f18.txt", "r");
				BuildTree(&tree, file);
				avlBool = 1;
				fclose(file);

				PrintTree(tree);
				break;
			case 2:
				if(avlBool)
				{
                    printf("Please provide the key you want to find: ");
                    scanf("%s", key);
                    nodeFound = SearchTree(tree, key);

                    if(KeyToInt(nodeFound->key) == KeyToInt(key))
                    {
                        printf("Key: %s Frequency: %d\n", nodeFound->key, nodeFound->frequency);
                    }
                    else
                    {
                        printf("No_such_key\n");
                    }
				}
				else
				{
					printf("AVL tree not initialized!!!\n");
				}
				break;
			case 3:
				if(avlBool)
				{
                    printf("Please provide the key you want to insert: ");
                    scanf("%s", key);
                    InsertNode(key, &tree);
                    UpdateBFactors(tree);

                    nodeFound = SearchTree(tree, key);

                    printf("Key: %s Frequency: %d\n", nodeFound->key, nodeFound->frequency);
				}
				else
				{
					printf("AVL tree not initialized!!!\n");
				}
				break;
			case 4:
				if(avlBool)
				{
                    printf("Please provide the key you want to delete: ");
                    scanf("%s", key);

                    DeleteNode(key, &tree);
                    DeletionAnalysis(&tree, key);
                    UpdateBFactors(tree);

                    PrintTree(tree);
				}
				else
				{
					printf("AVL tree not initialized!!!\n");
				}
				break;
			case 5:
				if(avlBool)
				{
                    height = CalculateHeight(tree);
                    SizeAndCount(&size, &count, tree);
                    printf("Height: %ld Size: %llu Count: %llu\n", height, size, count);
				}
				else
				{
					printf("AVL tree not initialized!!!\n");
				}
				break;
			case 6:
				if(avlBool)
				{
				    while(threshold < 0)
                    {
                        printf("Please provide the threshold you want: ");
                        scanf("%ld", &threshold);
                    }

                    FindAllAbove(tree, threshold);
				}
				else
				{
					printf("AVL tree not initialized!!!\n");
				}
				break;
		}
        height = 0;
	    size = 0;
	    count = 0;
	    threshold = -1;
	}

}

void Restructure(AVL_Node *x, AVL_Node *y, AVL_Node *z, AVL_Node **prevNode, int changeRoot)
{
    if(x->left == y && y->right == z)
        {
            y->right = z->left;
            z->left = y;
            x->left = z->right;
            z->right = x;

            if(!changeRoot && KeyToInt((*prevNode)->key) > KeyToInt(z->key))
            {
                (*prevNode)->left = z;
            }
            else if(!changeRoot && KeyToInt((*prevNode)->key) < KeyToInt(z->key))
            {
                (*prevNode)->right = z;
            }
            else if(changeRoot)
            {
                *prevNode = z;
            }
        }
        else if(x->right == y && y->left == z)
        {
            y->left = z->right;
            z->right = y;
            x->right = z->left;
            z->left = x;

            if(!changeRoot && KeyToInt((*prevNode)->key) > KeyToInt(z->key))
            {
                (*prevNode)->left = z;
            }
            else if(!changeRoot && KeyToInt((*prevNode)->key) < KeyToInt(z->key))
            {
                (*prevNode)->right = z;
            }
            else if(changeRoot)
            {
                *prevNode = z;
            }
        }
        else if(x->right == y && y->right == z)
        {
            x->right = y->left;
            y->left = x;

            if(!changeRoot && KeyToInt((*prevNode)->key) > KeyToInt(y->key))
            {
                (*prevNode)->left = y;
            }
            else if(!changeRoot && KeyToInt((*prevNode)->key) < KeyToInt(y->key))
            {
                (*prevNode)->right = y;
            }
            else if(changeRoot)
            {
                *prevNode = y;
            }
        }
        else if(x->left == y && y->left == z)
        {
            x->left = y->right;
            y->right = x;

            if(!changeRoot && KeyToInt((*prevNode)->key) > KeyToInt(y->key))
            {
                (*prevNode)->left = y;
            }
            else if(!changeRoot && KeyToInt((*prevNode)->key) < KeyToInt(y->key))
            {
                (*prevNode)->right = y;
            }
            else if(changeRoot)
            {
                *prevNode = y;
            }
        }
}

void DeletionAnalysis(AVL_Node **root, char *keyDeleted)
{
    AVL_Node *temp = NULL;
	AVL_Node *x = NULL;
	AVL_Node *y = NULL;
	AVL_Node *z = NULL;
	AVL_Node **nodeArray = NULL;
	int i = 0;
	int arraySize = 0;
	int bFactorError = 0;

	temp = *root;

	while(KeyToInt(temp->key) != KeyToInt(keyDeleted))
	{
		arraySize += 1;
		nodeArray =  realloc(nodeArray, sizeof(struct node*) * (arraySize));
		nodeArray[arraySize - 1] = temp;

		if(KeyToInt(temp->key) > KeyToInt(keyDeleted))
		{
		    if(temp->left != NULL)
            {
                temp = temp->left;
            }
            else
            {
                break;
            }

		}
		else if(KeyToInt(temp->key) < KeyToInt(keyDeleted))
		{
			if(temp->right != NULL)
            {
                temp = temp->right;
            }
            else
            {
                break;
            }
		}
	}

	for(i = arraySize - 1; i >= 0; i--)
	{

		if(nodeArray[i]->bFactor >= 2 || nodeArray[i]->bFactor <= -2)
		{
		    bFactorError = 1;
		    x = nodeArray[i];
			break;
		}
	}

	if(bFactorError)
    {
        SetXYZ(&x, &y, &z);

        if((i - 1) < 0)
        {
            Restructure(x, y, z, root, 1);
        }
        else
        {
            Restructure(x, y, z, &(nodeArray[i - 1]), 0);
        }

    }
}

void SetXYZ(AVL_Node **x, AVL_Node **y, AVL_Node **z)
{
    if(CalculateHeight((*x)->left) > CalculateHeight((*x)->right))
    {
        *y = (*x)->left;
    }
    else
    {
        *y = (*x)->right;
    }

    if(CalculateHeight((*y)->left) > CalculateHeight((*y)->right))
    {
        *z = (*y)->left;
    }
    else
    {
        *z = (*y)->right;
    }
}

void DeleteNode(char *key, AVL_Node **root)
{
    AVL_Node *toDelete = NULL;
    AVL_Node *toSwap = NULL;
    AVL_Node *prevNode = NULL;
    char *keyToCopy = NULL;
    char *keyToDelete = NULL;

    toDelete = *root;

    while(KeyToInt(toDelete->key) != KeyToInt(key))
	{
	    prevNode = toDelete;

		if(KeyToInt(toDelete->key) > KeyToInt(key))
		{
			toDelete = toDelete->left;
		}
		else if(KeyToInt(toDelete->key) < KeyToInt(key))
		{
			toDelete = toDelete->right;
		}

		if(toDelete == NULL)
        {
            printf("No_such_key\n");
            return;
        }
	}

	if(toDelete->frequency > 1)
    {
        toDelete->frequency -= 1;
    }
    else if(toDelete->right == NULL && toDelete->left == NULL)
    {
        if(prevNode->left == toDelete)
        {
            prevNode->left = NULL;
        }
        else
        {
            prevNode->right = NULL;
        }

        keyToDelete = toDelete->key;
        free(keyToDelete);
        toDelete->key = NULL;
        free(toDelete);
    }
    else if(toDelete->right != NULL && toDelete->left == NULL)
    {
        toSwap = FindMin(toDelete->right);

        keyToCopy = strcpy(malloc(strlen(toSwap->key) + 1), toSwap->key);
        toDelete->frequency = toSwap->frequency;

        DeleteNode(toSwap->key, &(toDelete));

        keyToDelete = toDelete->key;
        free(keyToDelete);
        toDelete->key = keyToCopy;
    }
    else if(toDelete->left != NULL)
    {
        toSwap = FindMax(toDelete->left);

        keyToCopy = strcpy(malloc(strlen(toSwap->key) + 1), toSwap->key);
        toDelete->frequency = toSwap->frequency;

        DeleteNode(toSwap->key, &(toDelete));

        keyToDelete = toDelete->key;
        free(keyToDelete);
        toDelete->key = keyToCopy;
    }

    UpdateBFactors(*root);

}

AVL_Node *FindMax(AVL_Node *root)
{
    if(root->right != NULL)
    {
        return FindMin(root->right);
    }
    else
    {
        return root;
    }
}

AVL_Node *FindMin(AVL_Node *root)
{
    if(root->left != NULL)
    {
        return FindMin(root->left);
    }
    else
    {
        return root;
    }
}

void FindAllAbove(AVL_Node *root, int threshold)
{
    if(root->frequency >= threshold)
    {
        printf("Key: %s Frequency: %d\n", root->key, root->frequency);
    }

    if(root->left != NULL)
	{
		FindAllAbove(root->left, threshold);
	}

	if(root->right != NULL)
	{
		FindAllAbove(root->right, threshold);
	}
}

void PrintTree(AVL_Node *tree)
{
    printf("Key: %s Frequency: %d\n", tree->key, tree->frequency);

    if(tree->left != NULL)
	{
        PrintTree(tree->left);
	}

	if(tree->right != NULL)
	{
		PrintTree(tree->right);
	}
}

void SizeAndCount(unsigned long long *size, unsigned long long *count, AVL_Node *root)
{
    *size += 1;
    *count += root->frequency;

    if(root->left != NULL)
	{
		SizeAndCount(size, count, root->left);
	}

	if(root->right != NULL)
	{
		SizeAndCount(size, count, root->right);
	}
}

void BuildTree(AVL_Node **root, FILE *file)
{
	char *keyToCopy = NULL;

	keyToCopy = malloc(15);

	while(!feof(file))
	{
		fscanf(file, "%s", keyToCopy);

		InsertNode(keyToCopy, root);
	}

    UpdateBFactors(*root);
}

void InsertionAnalysis(AVL_Node **root, char *keyEntered)
{
	AVL_Node *temp = *root;
	AVL_Node *x = NULL;
	AVL_Node *y = NULL;
	AVL_Node *z = NULL;
	AVL_Node **nodeArray = NULL;
	int arraySize = 0;
	int i = 0;
	int bFactorError = 0;

	while(KeyToInt(temp->key) != KeyToInt(keyEntered))
	{
		arraySize += 1;
		nodeArray =  realloc(nodeArray, sizeof(struct node*) * (arraySize));
		nodeArray[arraySize - 1] = temp;

		if(KeyToInt(temp->key) > KeyToInt(keyEntered))
		{
			temp = temp->left;
		}
		else if(KeyToInt(temp->key) < KeyToInt(keyEntered))
		{
			temp = temp->right;
		}
	}

	arraySize += 1;
	nodeArray =  realloc(nodeArray, sizeof(struct node*) * (arraySize));
	nodeArray[arraySize - 1] = temp;

	for(i = arraySize - 1; i >= 0; i--)
	{
		z = y;
		y = x;
		x = nodeArray[i];

		if(nodeArray[i]->bFactor >= 2 || nodeArray[i]->bFactor <= -2)
		{
		    bFactorError = 1;
			break;
		}
	}


    if(bFactorError)
    {
        if((i - 1) < 0)
        {
            Restructure(x, y, z, root, 1);
        }
        else
        {
            Restructure(x, y, z, &(nodeArray[i - 1]), 0);
        }
    }

    free(nodeArray);

}

void UpdateBFactors(AVL_Node *root)
{
	int left = 0;
	int right = 0;

	if(root->left != NULL)
	{
		left = CalculateHeight(root->left);
	}

	if(root->right != NULL)
	{
		right = CalculateHeight(root->right);
	}

	root->bFactor = left - right;

	if(root->left != NULL)
	{
		UpdateBFactors(root->left);
	}

	if(root->right != NULL)
	{
		UpdateBFactors(root->right);
	}
}

int CalculateHeight(AVL_Node *root)
{
	int heightL = 0;
	int heightR = 0;

	if(root == NULL)
    {
        return 0;
    }

	if(root->left != NULL)
	{
		heightL = CalculateHeight(root->left);
	}

	if(root->right != NULL)
	{
		heightR = CalculateHeight(root->right);
	}

	if(heightR > heightL)
	{
		return heightR + 1;
	}
	else
	{
		return heightL + 1;
	}
}

void InsertNode(char *key, AVL_Node **root)
{
	AVL_Node *node;
	AVL_Node *toInsertTo;

	toInsertTo = SearchTree(*root, key);

	if(toInsertTo == NULL)
	{
		node = CreateNode(key);
		*root = node;
	}
	else if(KeyToInt(toInsertTo->key) > KeyToInt(key))
	{
		node = CreateNode(key);
		toInsertTo->left = node;
	}
	else if(KeyToInt(toInsertTo->key) < KeyToInt(key))
	{
		node = CreateNode(key);
		toInsertTo->right = node;
	}
	else if(KeyToInt(toInsertTo->key) == KeyToInt(key))
	{
		toInsertTo->frequency += 1;
	}

	UpdateBFactors(*root);
    InsertionAnalysis(root, key);
}

AVL_Node *CreateNode(char *key)
{
	AVL_Node *node;
	node = malloc(sizeof(struct node));

	node->key = malloc(strlen(key) + 1);
    node->key[0] = '\0';
    strcat(node->key, key);

	node->bFactor = 0;
	node->frequency = 1;
	node->left = NULL;
	node->right = NULL;

	return node;
}

AVL_Node *SearchTree(AVL_Node *root, char *key)
{
	if(root == NULL)
	{
		return NULL;
	}
	else if(KeyToInt(root->key) == KeyToInt(key))
	{
		return root;
	}
	else
	{
		if(KeyToInt(root->key) > KeyToInt(key) && root->left != NULL)
		{
			return SearchTree(root->left, key);
		}
		else if(KeyToInt(root->key) < KeyToInt(key) && root->right != NULL)
		{
			return SearchTree(root->right, key);
		}
		else
        {
            return root;
        }
	}
}

unsigned long long KeyToInt(char *key)
{
    return strtoull(key, NULL, 36);
}
