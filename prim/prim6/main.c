//
//  main.c
//  task6
//
//  Created by Яна Лис on 15.06.2018.
//  Copyright © 2018 Яна Лис. All rights reserved.
//

#include <stdio.h>
#include <sqlite3.h>

void printMenu() {
    printf("[1] - Show the oldest students on the 1st and 2nd year\n");
    printf("[2] - Show for each course the student with the maximum number of marks and the total number of marks for all students of the course\n");
    printf("[3] - Show the average score for each group and course\n");
    printf("[0] - Exit\n");
}

int callbackPrintAll(void *NotUsed, int argc, char **argv, char **azColName) {
    NotUsed = 0;
    for (int i = 0; i < argc; i++) {
        printf("%s = %s\n", azColName[i], argv[i] ? argv[i] : "NULL");
    }
    printf("\n");
    return 0;
}

void showOldest(sqlite3* db, char *err_msg) {
    char sql[256];
    sprintf(sql, "SELECT min(year), course FROM STUDENTS INNER JOIN GROUPS ON GROUPS.id = STUDENTS.id GROUP BY course");
    sqlite3_exec(db, sql, callbackPrintAll, 0, &err_msg);
}

void showMaxAndTotal(sqlite3* db, char *err_msg) {
    char sql[256];
    sprintf(sql, "SELECT course, SUM(mark) FROM STUDENTS INNER JOIN GROUPS ON STUDENTS.id = GROUPS.id INNER JOIN MARKS ON MARKS.id = STUDENTS.id GROUP BY course");
    sqlite3_exec(db, sql, callbackPrintAll, 0, &err_msg);
    sprintf(sql, "select max(total), course, idd, students.fname from (select sum(mark) as total, groups.course as course, groups.id as idd from marks inner join groups on groups.id = marks.id group by marks.id) inner join students on idd = students.id group by course");
    sqlite3_exec(db, sql, callbackPrintAll, 0, &err_msg);
}

void showAverage(sqlite3* db, char *err_msg) {
    char sql[256];
    sprintf(sql, "SELECT GROUPS.course, avg(MARKS.mark), GROUPS.groupnum FROM STUDENTS INNER JOIN GROUPS ON STUDENTS.id = GROUPS.id INNER JOIN MARKS ON MARKS.id = STUDENTS.id GROUP BY course, groupnum");
    sqlite3_exec(db, sql, callbackPrintAll, 0, &err_msg);
}

int main(int argc, const char * argv[]) {
    sqlite3 *db = NULL;
    sqlite3_open("db.db", &db);
    char *err_msg = 0;
    
    int dec = -1;
    while(dec != '0') {
        printMenu();
        dec = getchar();
        getchar();
        
        switch (dec) {
            case '1':
                showOldest(db, err_msg);
                break;
            case '2':
                showMaxAndTotal(db, err_msg);
                break;
            case '3':
                showAverage(db, err_msg);
                break;
            case '0':
                return 0;
            default:
                break;
        }
    }
    return 0;
}
