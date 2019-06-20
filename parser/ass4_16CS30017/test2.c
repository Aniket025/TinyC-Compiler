//this is a function for fibonacci sequence
void iterative_fibonacci(int *array, int n)
{
    int i = 2;
    array[0] = 1;
    array[1] = 1;
    for (i = 2; i < n; i++)
        array[i] = array[i - 1] + array[i - 2];
    return;
}

//the main function
int main()
{
    int i = 0, array[20], a, b;
    float c = 0.2e+20;
    scanf("%d", &a);
    iterative_fibonacci(array, 20);
    for (i = 0; i < 20; i++)
        printf("%d", array[i]);
    i = 0;/*
    this comment is ignored*/
    while(i < 20)
    {
        printf("%d", array[i]);
        i++;
    }
    a = 20;
    b = 240;
    i = (a + b) * (-c/2.4);
    pritnf("%d", i);
    if(20 > 30)
        return -1;
    return 0;
}
