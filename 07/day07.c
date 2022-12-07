#include <assert.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define LINES 933

struct record {
    size_t size;
    char name[16];
    struct record *children;
    size_t length;
    struct record *parent;
};

void destroy(struct record *record);
struct record *parse(FILE *stream, struct record *root);
bool add(struct record *parent, struct record child);
struct record *cd(struct record *from, char *to);
int dirsize(struct record *root);
int task1(struct record *root);
size_t smallest_deletable(struct record *root, size_t need);
size_t min(size_t a, size_t b);
int task2(struct record *root);
void printdir(struct record *root, int depth);

int main(int argc, char **argv)
{
    if(argc != 2)
        return EXIT_FAILURE;

    FILE *stream = fopen(argv[1], "r");
    if(stream == NULL)
        return EXIT_FAILURE;

    struct record root = { .name="/" };
    parse(stream, &root);
    printf("Root size: %d\n", dirsize(&root));

    printdir(&root, 0);

    printf("Task1: %d\n", task1(&root));
    printf("Task2: %d\n", task2(&root));

    destroy(&root);
    return EXIT_SUCCESS;
}

void destroy(struct record *record)
{
    for(size_t i = 0; i < record->length; i++) {
        destroy(&record->children[i]);
    }
    free(record->children);
}

struct record *parse(FILE *stream, struct record *root)
{
    assert(stream != NULL);
    assert(root != NULL);

    struct record *current = root;

    char *lineptr = NULL;
    size_t n = 0;
    for(int i = 0; i < LINES; i++) {
        if(getline(&lineptr, &n, stream) <= 0)
            assert("wrong number of lines");
        
        struct record child = { .parent=current };
        if(lineptr[0] == '$' && lineptr[2] != 'l') {
            if(lineptr[5] == '.') {
                current = current->parent;
            } else {
                char name[16];
                sscanf(lineptr, "$ cd %s\n", name);
                current = cd(current, name);
                assert(current != NULL);
            }
        } else {
            if(lineptr[0] == 'd') {
                sscanf(lineptr, "dir %s\n", child.name);
            } else {
                sscanf(lineptr, "%zu %s\n", &child.size, child.name);
            }
            add(current, child);
        }

        free(lineptr);
        lineptr = NULL;
    }

    return root;
}

bool add(struct record *parent, struct record child)
{
    struct record *newptr = reallocarray(parent->children,
                            parent->length + 1, sizeof(struct record));
    if(newptr == NULL)
        return false;
    parent->length++;

    parent->children = newptr;
    //memcpy(&parent->children[parent->length - 1], &child, sizeof(child));
    parent->children[parent->length - 1] = child;
    return true;
}

struct record *cd(struct record *from, char *to) 
{
    assert(from != NULL);
    assert(to != NULL);

    for(size_t i = 0; i < from->length; i++) {
        if(strcmp(from->children[i].name, to) == 0) {
            return &from->children[i];
        }
    }
    return NULL;
}

int dirsize(struct record *root)
{
    assert(root != NULL);

    for(size_t i = 0; i < root->length; i++) {
        struct record *child = &root->children[i];

        if(child->children != NULL) {
            dirsize(child);
        }
        root->size += child->size;
    }

    return root->size;
}

int task1(struct record *root)
{
    assert(root != NULL);

    int acc = 0;

    if(root->size <= 100000) {
        acc += root->size;
    }

    for(size_t i = 0; i < root->length; i++) {
        struct record *child = &root->children[i];

        if(child->children != NULL) {
            acc += task1(child);
        }
    }

    return acc;
}

int task2(struct record *root)
{
    assert(root != NULL);

    size_t need = 30000000 - (70000000 - root->size);

    return smallest_deletable(root, need);
}

size_t smallest_deletable(struct record *root, size_t need)
{
    assert(root != NULL);

    size_t current = 70000000;
    if(root->size >= need)
        current = root->size;

    for(size_t i = 0; i < root->length; i++) {
        struct record *child = &root->children[i];

        if(child->children != NULL) {
            current = min(current, smallest_deletable(child, need));
        }
    }

    return current;
}

size_t min(size_t a, size_t b)
{
    if(a < b)
        return a;
    return b;
}

void printdir(struct record *root, int depth)
{
    assert(root != NULL);
    
    for(int i = 0; i < depth; i++) {
        printf(" ");
    }
    printf("- %s ", root->name);
    if(root->children == NULL) {
        printf("(file, size=%zu)\n", root->size);
    } else {
        printf("(DIR, size=%zu)\n", root->size);
        for(size_t i = 0; i < root->length; i++) {
            printdir(&root->children[i], depth+1);
        }
    }
}
