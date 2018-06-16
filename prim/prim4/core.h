#pragma once
#include "student.h"

student* getOldest(int recordNumber, student* allStudents);

student* getWorst(int recordNumber, student* allStudents);

student* getByFullName(char *firstName, char* lastName, int recordNumber, student* allStudents, int* searchResult);