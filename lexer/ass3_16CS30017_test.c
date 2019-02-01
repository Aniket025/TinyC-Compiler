/*C implementation of Rabin Karp Algorithm  */
#include<stdio.h>
#include<string.h>
#define d 256

void search(char pat[], char txt[], int q);

int main()
{
    char txt[] = "LEXER TEST FOR TINYC";
    char pat[] = "LEXER TEST";
    char txt1[] = "IDENTIFIER AND KEYWORD FOR TINYC INT";
    int x,a,b ;
    char pat1[] = "IDENTIFIER AND KEYWORD TESTED";
    char txt2[] = "CONSTANT CHECK";
    char pat2[] = "ALREADY DONE BY DEFINING d";
    char txt3[] = "PUNCTUATOR TEST";
    if (x != 1)
        char pat3[] = "THERE WAS A PUNCTUATOR ";
    else
        char pat3[] = "DONE AS ALMOST EVERY LINE HAS A PUNCTUATOR";
    char txt4[] = "STRING LITERAL TEST ALSO DONE IN MANY LINES";
    // SINGLE LINE COMMENT CHECK
    /* MULTILINE COMMENT CHECK
      this has multiple line
      another line */
    char pat[] = "COMMENT TEST ALSO DONE";
    int q = 101;
    search(pat, txt, q);
    return 0;
}

void search(char pat[], char txt[], int q)
{
    int M = strlen(pat);
    int N = strlen(txt);
    int i, j;
    int p = 0;
    int t = 0;
    int h = 1;


    for (i = 0; i < M-1; i++)
        h = (h*d)%q;

    for (i = 0; i < M; i++)
    {
        p = (d*p + pat[i])%q;
        t = (d*t + txt[i])%q;
    }

    for (i = 0; i <= N - M; i++)
    {

        if ( p == t )

            for (j = 0; j < M; j++)
            {
                if (txt[i+j] != pat[j])
                    break;
            }

            if (j == M)
                printf("Pattern found at index %d \n", i);
        }

        if ( i < N-M )
        {
            t = (d*(t - txt[i]*h) + txt[i+M])%q;

            if (t < 0)
            t = (t + q);
        }
    }
}
