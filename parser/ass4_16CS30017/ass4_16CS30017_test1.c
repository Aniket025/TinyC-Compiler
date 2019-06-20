int counter_flag(char matrix_key[][3], int n)
{
    float j,k;
    if(matrix_key == NULL || n <= 0)
        return 0;
    if(n == 1)
        return 10;

    int row[] = {0, 0, -1, 0, 1};
    int col[] = {0, -1, 0, 1, 0};

    int counter[10][n+1];
    int i=0, j=0, k=0, shift=0, ro=0, co=0, num = 0;
    int nextNum=0, totalcounter = 0;

    for (i=0; i<=9; i++)
    {
        counter[i][0] = 0;
        counter[i][1] = 1;
    }

    for (k=2; k<=n; k++)
    {
        for (i=0; i<4; i++)
        {
            for (j=0; j<3; j++)
            {

                if (matrix_key[i][j] != '*' && matrix_key[i][j] != '#')
                {
                    num = matrix_key[i][j] - '0';
                    counter[num][k] = 0;

                    for (shift=0; shift<5; shift++)
                    {
                        ro = i + row[shift];
                        co = j + col[shift];
                        if (ro >= 0 && ro <= 3 && co >=0 && co <= 2 &&
                           matrix_key[ro][co] != '*' && matrix_key[ro][co] != '#')
                        {
                            nextNum = matrix_key[ro][co] - '0';
                            counter[num][k] += counter[nextNum][k-1];
                        }
                    }
                }
            }
        }
    }

    totalcounter = 0;
    for (i=0; i<=9; i++)
        totalcounter += counter[i][n];
    return totalcounter;
}


int main(int argc, char *argv[])
{
   char matrix_key[4][3] = {{'1','2','3'},
                        {'4','5','6'},
                        {'7','8','9'},
                        {'*','0','#'}};
   printf("counter for numbers of length %d: %d\n", 1, counter_flag(matrix_key, 1));
   printf("counter for numbers of length %d: %d\n", 2, counter_flag(matrix_key, 2));
   printf("counter for numbers of length %d: %d\n", 3, counter_flag(matrix_key, 3));
   printf("counter for numbers of length %d: %d\n", 4, counter_flag(matrix_key, 4));
   printf("counter for numbers of length %d: %d\n", 5, counter_flag(matrix_key, 5));

   return 0;
}
