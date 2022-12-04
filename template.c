#include <stdio.h>
#include <stdbool.h>
#include <stdlib.h>

#define LINES 1000

struct record {
};

int task1(struct record *records);
int task2(struct record *records);

int main(int argc, char **argv)
{
    if(argc != 2)
        return EXIT_FAILURE;

    FILE *stream = fopen(argv[1], "r");
    if(stream == NULL)
        return EXIT_FAILURE;

    struct record *records = calloc(sizeof(struct record), LINES);
    if(records == NULL)
        return EXIT_FAILURE;

    for(int i = 0; i < LINES; i++) {
    }

    printf("Task1: %d\n", task1(records));
    printf("Task2: %d\n", task2(records));

    free(records);
    return EXIT_SUCCESS;
}

int task1(struct record *records)
{

    for(int i = 0; i < LINES; i++) {
        struct record rec = records[i];

    }

}

int task2(struct record *records)
{

    for(int i = 0; i < LINES; i++) {
        struct record rec = records[i];

    }

}
