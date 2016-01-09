                       /* timediff.c, 25 Jun 11 */

#include <stdio.h>

int main(void)
{
long long last_time = 0,
          cur_time;

while (!feof(stdin))
   {
   scanf("%lld", &cur_time);
//   if (cur_time-last_time > 10000000)
//      printf("> ");
   if (last_time != 0)
      printf("%lld\n", cur_time-last_time);
   last_time=cur_time;
   }
}

