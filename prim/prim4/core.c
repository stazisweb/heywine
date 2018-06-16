#include "core.h"
#include <string.h>

student* getOldest(int recordNumber, student* allStudents)
{
	student* oldestStudent = allStudents;
	int earliestBirthYear = oldestStudent->birthYear;
	for (int i = 0; i < recordNumber; i++)
		if (allStudents[i].birthYear <= earliestBirthYear)
		{
			earliestBirthYear = allStudents[i].birthYear;
			oldestStudent = allStudents + i;
		}
	return oldestStudent;
}

int marksSum(int marksCount, int* marks)
{
	int sum = 0;
	for (int i = 0; i < marksCount; i++)
		sum += marks[i];
	return sum;
}

student * getWorst(int recordNumber, student * allStudents)
{
	student* worstStudent = allStudents;
	int worstMarksSum = marksSum(worstStudent->marksCount, worstStudent->marks);
	int currentMarksSum;

	for (int i = 0; i < recordNumber; i++)
	{
		currentMarksSum = marksSum(allStudents[i].marksCount, allStudents[i].marks);
		if (currentMarksSum <= worstMarksSum)
		{
			worstMarksSum = currentMarksSum;
			worstStudent = allStudents + i;
		}
	}
	return worstStudent;
}

student* getByFullName(char * firstName, char * lastName, int recordNumber, student * allStudents, int* searchResult)
{
	for (int i = 0; i < recordNumber; i++)
		if (!strcmp(firstName, allStudents[i].firstName) && !strcmp(lastName, allStudents[i].lastName))
		{
			*searchResult = 1;
			return allStudents + i;
		}
	*searchResult = 0;
	return 0;
}
