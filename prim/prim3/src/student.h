#pragma once
//
//enum gender {
//	MALE,
//	FEMALE
//};

typedef struct student
{
	char firstName[256];
	char lastName[256];
	char patronymic[256];
	int birthYear;
	int gender;
	int marksCount;
	int* marks;
} student;