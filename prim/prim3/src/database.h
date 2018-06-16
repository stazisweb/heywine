#pragma once
#include "student.h"

int init(char databaseName[256]);
int append(student* student);
student* getAll(int* recordsNumber);
int freeStudents(student* allStudents);