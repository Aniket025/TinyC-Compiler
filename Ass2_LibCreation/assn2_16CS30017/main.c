#include "myl.h"

int main()
{
    char newline[2] = "\n";
    char name[20] = "Kumar Aniket\0";
    printStr(newline);
    printStr(name);
    int n = 30017 ;
    printInt(n);
    printStr(newline);
    char name2[20] = "Give int : \n\0";
    printStr(name2);
    int i, j;
    i = readInt(&j);
    printInt(j);
    printStr(newline);
    char name3[20] = "Give float : \n\0";
    printStr(name3);
    float m, x;
    x = readFlt(&m);
    printFlt(m);
    printStr(newline);

}
