#include "database.h"
#include <string.h>
#include <stdio.h>
#include <stdlib.h>

char database[256];

int init(char databaseName[256])
{
	strcpy(database, databaseName);
	return 0;
}

int append(student* student)
{
	FILE *db = fopen(database, "at");
	if (db == NULL)
		return 1;

	fprintf(db, "%s %s %s %d %d %d ", student->firstName, student->lastName, student->patronymic, student->birthYear, student->gender, student->marksCount);

	int count = student->marksCount;
	int* marks = student->marks;

	for (int i = 0; i < count; i++)
		fprintf(db, "%d ", marks[i]);

	fprintf(db, "\n");
	fclose(db);
	return 0;
}

student* getAll(int* recordsNumber)
{
	FILE *db = fopen(database, "rt");
	if (db == NULL || feof(db))
		return 0;

	int records = 0;
	char c;
	for (c = getc(db); c != EOF; c = getc(db))
		if (c == '\n')
			++records;
	rewind(db);
	*recordsNumber = records;

	student* students = malloc(records * sizeof(student));
	int count;
	char line[256];

	for (int i = 0; i < records; i++)
	{
		fscanf(db, "%s %s %s %d %d %d ", students[i].firstName, students[i].lastName,
			students[i].patronymic, &students[i].birthYear, &students[i].gender, &students[i].marksCount);

		int count = students[i].marksCount;
		students[i].marks = malloc(count * sizeof(int));
		for (int j = 0; j < count; j++)
			fscanf(db, "%d ", students[i].marks + j);

	}

	return students;
}

int freeStudents(student* allStudents)
{
	int length = sizeof(allStudents) / sizeof(student);

	for (int i = 0; i < length; i++)
		free(allStudents[i].marks);

	free(allStudents);
	return 0;
}
