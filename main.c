#include <stdio.h>
#include <stdlib.h>

int N, K, M;
int used[11];
int ans[10];
int fact[11];

void build(int pos, int m)
{
    if (pos == K)
    {
        for (int i = 0; i < K; i++)
        {
            if (i > 0) printf(" ");
            printf("%d", ans[i]);
        }
        printf("\n");
        exit(0);
    }

    for (int x = 1; x <= N; x++)
    {
        if (!used[x])
        {
            int cnt = fact[N - pos - 1] / fact[N - K];
            if (m > cnt)
            {
                m -= cnt;
            }
            else
            {
                ans[pos] = x;
                used[x] = 1;
                build(pos + 1, m);
                used[x] = 0;
                return;
            }
        }
    }
}

int main()
{
    
    scanf("%d %d %d", &N, &K, &M);

    fact[0] = 1;
    for (int i = 1; i <= 10; i++) fact[i] = fact[i - 1] * i;

    build(0, M);
    return 0;
}