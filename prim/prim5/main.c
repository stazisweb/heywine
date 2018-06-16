//
//  main.c
//  task5
//
//  Created by Яна Лис on 15.06.2018.
//  Copyright © 2018 Яна Лис. All rights reserved.
//

#include <stdio.h>
#include <sqlite3.h>

void printMenu() {
    printf("[1] - Add student\n");
    printf("[2] - Add mark\n");
    printf("[0] - Exit\n");
}

void addStudent(sqlite3* db, char *err_msg, char firstname[32], char secondname[32], char lastname[32], char sex[1], int year) {
    char sql[256];
    sprintf(sql, "INSERT INTO STUDENTS(firstname, secondname, lastname, sex, year) values(\'%s\', \'%s\', \'%s\', \'%s\', \'%d\');", firstname, secondname, lastname, sex, year);
    sqlite3_exec(db, sql, 0, 0, &err_msg);
}

int callbackPrintAll(void *NotUsed, int argc, char **argv, char **azColName) {
    NotUsed = 0;
    for (int i = 0; i < argc; i++) {
        printf("%s = %s\n", azColName[i], argv[i] ? argv[i] : "NULL");
    }
    printf("\n");
    return 0;
}

void showStudents(sqlite3* db, char *err_msg) {
    char sql[256];
    sprintf(sql, "SELECT * FROM STUDENTS");
    sqlite3_exec(db, sql, callbackPrintAll, 0, &err_msg);
}

void showMarks(sqlite3* db, char *err_msg, int id) {
    char sql[256];
    sprintf(sql, "SELECT * FROM MARKS WHERE MARKS.id = %d", id);
    sqlite3_exec(db, sql, callbackPrintAll, 0, &err_msg);
}

void addMark(sqlite3* db, char *err_msg, int id, char subject[32], int mark) {
    int rc;
    char sql[256];
    sprintf(sql, "INSERT INTO MARKS(id, subject, mark) values(\'%d\', \'%s\', \'%d\');", id, subject, mark);
    rc = sqlite3_exec(db, sql, 0, 0, &err_msg);
}

int main(int argc, const char * argv[]) {
    sqlite3 *db = NULL;
    sqlite3_open("bd.db", &db);
    char *err_msg = 0;
    
    int dec = -1;
    while(dec != '0') {
        printMenu();
        dec = getchar();
        getchar();
        
        switch (dec) {
            case '1': {
                char firstname[32];
                char secondname[32];
                char lastname[32];
                char sex[1];
                int year;
                printf("Firstname:");
                scanf("%s", &firstname);
                printf("Secondname:");
                scanf("%s", &secondname);
                printf("Lastname:");
                scanf("%s", &lastname);
                printf("Sex (f for female, m for male):");
                scanf("%s", &sex);
                printf("Year:");
                scanf("%d", &year);
                getchar();
                addStudent(db, err_msg, firstname, secondname, lastname, sex, year);
                break;
            }
            case '2': {
                showStudents(db, err_msg);
                int id;
                char subject[32];
                int mark;
                printf("ID:");
                scanf("%d", &id);
                getchar();
                showMarks(db, err_msg, id);
                printf("Subject:");
                scanf("%s", &subject);
                printf("Mark:");
                scanf("%d", &mark);
                getchar();
                addMark(db, err_msg, id, subject, mark);
                break;
            }
            case '0':
                return 0;
            default:
                break;
        }
    }
    return 0;
}
