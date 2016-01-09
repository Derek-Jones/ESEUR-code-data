/*
 * sql2csv.c,  5 Jun 13
 */

#include <stdio.h>

int main(void)
{
int paren_cnt = 0;
char ch;
unsigned char in_string = 0;

while (!feof(stdin))
   {
   ch=getchar();
   if ((ch == '\\') && (in_string == 1))
      {
      putchar(ch);
      ch=getchar();
      putchar(ch);
      }
   else if (ch == '\'')
      {
      putchar(ch);
      if (in_string)
         in_string=0;
      else
         in_string=1;
      }
   else if (in_string == 1)
      putchar(ch);
   else if (ch == '(')
      {
      if (paren_cnt > 0)
         putchar(ch);
      paren_cnt++;
      }
   else
      {
      if (ch == ')')
	 {
	 if (paren_cnt == 1)
	    printf("\n");
	 else if (paren_cnt > 1)
	    putchar(ch);
	 if (paren_cnt > 0)
	    paren_cnt--;
	 }
      else
	 if (paren_cnt > 0)
	    putchar(ch);
      }
   }

}

