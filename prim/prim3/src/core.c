#include "core.h"

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