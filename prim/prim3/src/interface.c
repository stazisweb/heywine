#include "database.h"
#include <stdio.h>
#include "interface.h"
#include "core.h"
#include <stdlib.h>

void printMenu()
{
	printf("Please choose an action:\n");
	printf("[1] Append record to file.\n");
	printf("[2] Show all records.\n");
	printf("[3] Get oldest student.\n");
	printf("[4] Exit.\n");
}
void printStudent(student* student)
{
	printf("================================\n");

	printf("First name: %s\n", student->firstName);
	printf("Second name: %s\n", student->lastName);
	printf("Patronymic: %s\n", student->patronymic);
	printf("Year of birth: %d\n", student->birthYear);
	printf("Gender: %s\n", student->gender ? "Female" : "Male");
	printf("Marks: ");
	for (int i = 0; i < student->marksCount; i++)
		printf("%d ", student->marks[i]);

	printf("\n================================\n");
}

int main()
{
	char* databaseName = "db.txt";
	init(databaseName);

	while (1)
	{
		char c;
		printMenu();
		scanf("%c", &c);

		switch (c)
		{
			case '1':
			{
				student st;
				printf("Enter first name\n");
				scanf("%s", st.firstName);
				printf("Enter last name\n");
				scanf("%s", st.lastName);
				printf("Enter patronymic\n");
				scanf("%s", st.patronymic);

				printf("Enter year of birth\n");
				scanf("%d", &st.birthYear);
				printf("Enter gender (0 - male, 1 - female)\n");
				scanf("%d", &st.gender);
				printf("Enter the number of marks\n");
				scanf("%d", &st.marksCount);

				st.marks = malloc(st.marksCount * sizeof(int));
				for (int i = 0; i < st.marksCount; i++)
				{
					printf("Enter %d mark\n", i + 1);
					scanf("%d", &st.marks[i]);
				}

				append(&st);

				break;
			}
			case '2':
			{
				int recordsNumber;
				student* allStudents = getAll(&recordsNumber);

				for (int i = 0; i < recordsNumber; i++)
					printStudent(allStudents + i);

				freeStudents(allStudents);
				break;
			}
			case '3':
			{
				int recordsNumber;
				student* allStudents = getAll(&recordsNumber);
				student* oldest = getOldest(recordsNumber, allStudents);

				printf("Oldest student:\n");
				printStudent(oldest);

				freeStudents(allStudents);
				break;
			}
			case '4':
			{
				return 0;
			}
			default:
			{
				break;
			}
		}

		scanf("%c", &c);
	}


	return 0;
}