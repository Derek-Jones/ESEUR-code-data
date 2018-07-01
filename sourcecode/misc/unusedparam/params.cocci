// parampos.cocci,  7 May 11


// 1

@ fn_p1 @
type ret_T, p1_T;
identifier fn, p1;
position p;
@@

ret_T fn@p(p1_T p1)
{
...
}

@script:python @
func << fn_p1.fn;
pos << fn_p1.p;
@@
print "1", func, pos[0].file

@ fn_no_p1 @
type ret_T, p1_T;
identifier fn, p1;
@@

ret_T fn(p1_T p1)
{
... when != p1
}

@script:python @
param_1 << fn_no_p1.p1;
func << fn_no_p1.fn;
@@
print "1_1", func, param_1


// 2

@ fn_p2 @
type ret_T, p1_T, p2_T;
identifier fn, p1, p2;
position p;
@@

ret_T fn@p(p1_T p1, p2_T p2)
{
...
}

@script:python @
func << fn_p2.fn;
pos << fn_p2.p;
@@
print "2", func, pos[0].file

@ fn_no_p2_1 @
type ret_T, p1_T, p2_T;
identifier fn, p1, p2;
@@

ret_T fn(p1_T p1, p2_T p2)
{
... when != p1
}

@script:python @
param_1 << fn_no_p2_1.p1;
func << fn_no_p2_1.fn;
@@
print "2_1", func, param_1

@ fn_no_p2_2 @
type ret_T, p1_T, p2_T;
identifier fn, p1, p2;
@@

ret_T fn(p1_T p1, p2_T p2)
{
... when != p2
}

@script:python @
param_2 << fn_no_p2_2.p2;
func << fn_no_p2_2.fn;
@@
print "2_2", func, param_2

// 3

@ fn_p3 @
type ret_T, p1_T, p2_T, p3_T;
identifier fn, p1, p2, p3;
position p;
@@

ret_T fn@p(p1_T p1, p2_T p2, p3_T p3)
{
...
}

@script:python @
func << fn_p3.fn;
pos << fn_p3.p;
@@
print "3", func, pos[0].file

@ fn_no_p3_1 @
type ret_T, p1_T, p2_T, p3_T;
identifier fn, p1, p2, p3;
@@

ret_T fn(p1_T p1, p2_T p2, p3_T p3)
{
... when != p1
}

@script:python @
param_1 << fn_no_p3_1.p1;
func << fn_no_p3_1.fn;
@@
print "3_1", func, param_1

@ fn_no_p3_2 @
type ret_T, p1_T, p2_T, p3_T;
identifier fn, p1, p2, p3;
@@

ret_T fn(p1_T p1, p2_T p2, p3_T p3)
{
... when != p2
}

@script:python @
param_2 << fn_no_p3_2.p2;
func << fn_no_p3_2.fn;
@@
print "3_2", func, param_2

@ fn_no_p3_3 @
type ret_T, p1_T, p2_T, p3_T;
identifier fn, p1, p2, p3;
@@

ret_T fn(p1_T p1, p2_T p2, p3_T p3)
{
... when != p3
}

@script:python @
param_3 << fn_no_p3_3.p3;
func << fn_no_p3_3.fn;
@@
print "3_3", func, param_3

// 4

@ fn_p4 @
type ret_T, p1_T, p2_T, p3_T, p4_T;
identifier fn, p1, p2, p3, p4;
position p;
@@

ret_T fn@p(p1_T p1, p2_T p2, p3_T p3, p4_T p4)
{
...
}

@script:python @
func << fn_p4.fn;
pos << fn_p4.p;
@@
print "4", func, pos[0].file

@ fn_no_p4_1 @
type ret_T, p1_T, p2_T, p3_T, p4_T;
identifier fn, p1, p2, p3, p4;
@@

ret_T fn(p1_T p1, p2_T p2, p3_T p3, p4_T p4)
{
... when != p1
}

@script:python @
param_1 << fn_no_p4_1.p1;
func << fn_no_p4_1.fn;
@@
print "4_1", func, param_1

@ fn_no_p4_2 @
type ret_T, p1_T, p2_T, p3_T, p4_T;
identifier fn, p1, p2, p3, p4;
@@

ret_T fn(p1_T p1, p2_T p2, p3_T p3, p4_T p4)
{
... when != p2
}

@script:python @
param_2 << fn_no_p4_2.p2;
func << fn_no_p4_2.fn;
@@
print "4_2", func, param_2

@ fn_no_p4_3 @
type ret_T, p1_T, p2_T, p3_T, p4_T;
identifier fn, p1, p2, p3, p4;
@@

ret_T fn(p1_T p1, p2_T p2, p3_T p3, p4_T p4)
{
... when != p3
}

@script:python @
param_3 << fn_no_p4_3.p3;
func << fn_no_p4_3.fn;
@@
print "4_3", func, param_3

@ fn_no_p4_4 @
type ret_T, p1_T, p2_T, p3_T, p4_T;
identifier fn, p1, p2, p3, p4;
@@

ret_T fn(p1_T p1, p2_T p2, p3_T p3, p4_T p4)
{
... when != p4
}

@script:python @
param_4 << fn_no_p4_4.p4;
func << fn_no_p4_4.fn;
@@
print "4_4", func, param_4

// 5

@ fn_p5 @
type ret_T, p1_T, p2_T, p3_T, p4_T, p5_T;
identifier fn, p1, p2, p3, p4, p5;
position p;
@@

ret_T fn@p(p1_T p1, p2_T p2, p3_T p3, p4_T p4, p5_T p5)
{
...
}

@script:python @
func << fn_p5.fn;
pos << fn_p5.p;
@@
print "5", func, pos[0].file

@ fn_no_p5_1 @
type ret_T, p1_T, p2_T, p3_T, p4_T, p5_T;
identifier fn, p1, p2, p3, p4, p5;
@@

ret_T fn(p1_T p1, p2_T p2, p3_T p3, p4_T p4, p5_T p5)
{
... when != p1
}

@script:python @
param_1 << fn_no_p5_1.p1;
func << fn_no_p5_1.fn;
@@
print "5_1", func, param_1

@ fn_no_p5_2 @
type ret_T, p1_T, p2_T, p3_T, p4_T, p5_T;
identifier fn, p1, p2, p3, p4, p5;
@@

ret_T fn(p1_T p1, p2_T p2, p3_T p3, p4_T p4, p5_T p5)
{
... when != p2
}

@script:python @
param_2 << fn_no_p5_2.p2;
func << fn_no_p5_2.fn;
@@
print "5_2", func, param_2

@ fn_no_p5_3 @
type ret_T, p1_T, p2_T, p3_T, p4_T, p5_T;
identifier fn, p1, p2, p3, p4, p5;
@@

ret_T fn(p1_T p1, p2_T p2, p3_T p3, p4_T p4, p5_T p5)
{
... when != p3
}

@script:python @
param_3 << fn_no_p5_3.p5;
func << fn_no_p5_3.fn;
@@
print "5_3", func, param_3

@ fn_no_p5_4 @
type ret_T, p1_T, p2_T, p3_T, p4_T, p5_T;
identifier fn, p1, p2, p3, p4, p5;
@@

ret_T fn(p1_T p1, p2_T p2, p3_T p3, p4_T p4, p5_T p5)
{
... when != p4
}

@script:python @
param_4 << fn_no_p5_4.p4;
func << fn_no_p5_4.fn;
@@
print "5_4", func, param_4

@ fn_no_p5_5 @
type ret_T, p1_T, p2_T, p3_T, p4_T, p5_T;
identifier fn, p1, p2, p3, p4, p5;
@@

ret_T fn(p1_T p1, p2_T p2, p3_T p3, p4_T p4, p5_T p5)
{
... when != p5
}

@script:python @
param_5 << fn_no_p5_5.p5;
func << fn_no_p5_5.fn;
@@
print "5_5", func, param_5

// 6

@ fn_p6 @
type ret_T, p1_T, p2_T, p3_T, p4_T, p5_T, p6_T;
identifier fn, p1, p2, p3, p4, p5, p6;
position p;
@@

ret_T fn@p(p1_T p1, p2_T p2, p3_T p3, p4_T p4, p5_T p5, p6_T p6)
{
...
}

@script:python @
func << fn_p6.fn;
pos << fn_p6.p;
@@
print "6", func, pos[0].file

@ fn_no_p6_1 @
type ret_T, p1_T, p2_T, p3_T, p4_T, p5_T, p6_T;
identifier fn, p1, p2, p3, p4, p5, p6;
@@

ret_T fn(p1_T p1, p2_T p2, p3_T p3, p4_T p4, p5_T p5, p6_T p6)
{
... when != p1
}

@script:python @
param_1 << fn_no_p6_1.p1;
func << fn_no_p6_1.fn;
@@
print "6_1", func, param_1

@ fn_no_p6_2 @
type ret_T, p1_T, p2_T, p3_T, p4_T, p5_T, p6_T;
identifier fn, p1, p2, p3, p4, p5, p6;
@@

ret_T fn(p1_T p1, p2_T p2, p3_T p3, p4_T p4, p5_T p5, p6_T p6)
{
... when != p2
}

@script:python @
param_2 << fn_no_p6_2.p2;
func << fn_no_p6_2.fn;
@@
print "6_2", func, param_2

@ fn_no_p6_3 @
type ret_T, p1_T, p2_T, p3_T, p4_T, p5_T, p6_T;
identifier fn, p1, p2, p3, p4, p5, p6;
@@

ret_T fn(p1_T p1, p2_T p2, p3_T p3, p4_T p4, p5_T p5, p6_T p6)
{
... when != p3
}

@script:python @
param_3 << fn_no_p6_3.p6;
func << fn_no_p6_3.fn;
@@
print "6_3", func, param_3

@ fn_no_p6_4 @
type ret_T, p1_T, p2_T, p3_T, p4_T, p5_T, p6_T;
identifier fn, p1, p2, p3, p4, p5, p6;
@@

ret_T fn(p1_T p1, p2_T p2, p3_T p3, p4_T p4, p5_T p5, p6_T p6)
{
... when != p4
}

@script:python @
param_4 << fn_no_p6_4.p4;
func << fn_no_p6_4.fn;
@@
print "6_4", func, param_4

@ fn_no_p6_5 @
type ret_T, p1_T, p2_T, p3_T, p4_T, p5_T, p6_T;
identifier fn, p1, p2, p3, p4, p5, p6;
@@

ret_T fn(p1_T p1, p2_T p2, p3_T p3, p4_T p4, p5_T p5, p6_T p6)
{
... when != p5
}

@script:python @
param_5 << fn_no_p6_5.p5;
func << fn_no_p6_5.fn;
@@
print "6_5", func, param_5

@ fn_no_p6_6 @
type ret_T, p1_T, p2_T, p3_T, p4_T, p5_T, p6_T;
identifier fn, p1, p2, p3, p4, p5, p6;
@@

ret_T fn(p1_T p1, p2_T p2, p3_T p3, p4_T p4, p5_T p5, p6_T p6)
{
... when != p6
}

@script:python @
param_6 << fn_no_p6_6.p6;
func << fn_no_p6_6.fn;
@@
print "6_6", func, param_6

// 7

@ fn_p7 @
type ret_T, p1_T, p2_T, p3_T, p4_T, p5_T, p6_T, p7_T;
identifier fn, p1, p2, p3, p4, p5, p6, p7;
position p;
@@

ret_T fn@p(p1_T p1, p2_T p2, p3_T p3, p4_T p4, p5_T p5, p6_T p6, p7_T p7)
{
...
}

@script:python @
func << fn_p7.fn;
pos << fn_p7.p;
@@
print "7", func, pos[0].file

@ fn_no_p7_1 @
type ret_T, p1_T, p2_T, p3_T, p4_T, p5_T, p6_T, p7_T;
identifier fn, p1, p2, p3, p4, p5, p6, p7;
@@

ret_T fn(p1_T p1, p2_T p2, p3_T p3, p4_T p4, p5_T p5, p6_T p6, p7_T p7)
{
... when != p1
}

@script:python @
param_1 << fn_no_p7_1.p1;
func << fn_no_p7_1.fn;
@@
print "7_1", func, param_1

@ fn_no_p7_2 @
type ret_T, p1_T, p2_T, p3_T, p4_T, p5_T, p6_T, p7_T;
identifier fn, p1, p2, p3, p4, p5, p6, p7;
@@

ret_T fn(p1_T p1, p2_T p2, p3_T p3, p4_T p4, p5_T p5, p6_T p6, p7_T p7)
{
... when != p2
}

@script:python @
param_2 << fn_no_p7_2.p2;
func << fn_no_p7_2.fn;
@@
print "7_2", func, param_2

@ fn_no_p7_3 @
type ret_T, p1_T, p2_T, p3_T, p4_T, p5_T, p6_T, p7_T;
identifier fn, p1, p2, p3, p4, p5, p6, p7;
@@

ret_T fn(p1_T p1, p2_T p2, p3_T p3, p4_T p4, p5_T p5, p6_T p6, p7_T p7)
{
... when != p3
}

@script:python @
param_3 << fn_no_p7_3.p7;
func << fn_no_p7_3.fn;
@@
print "7_3", func, param_3

@ fn_no_p7_4 @
type ret_T, p1_T, p2_T, p3_T, p4_T, p5_T, p6_T, p7_T;
identifier fn, p1, p2, p3, p4, p5, p6, p7;
@@

ret_T fn(p1_T p1, p2_T p2, p3_T p3, p4_T p4, p5_T p5, p6_T p6, p7_T p7)
{
... when != p4
}

@script:python @
param_4 << fn_no_p7_4.p4;
func << fn_no_p7_4.fn;
@@
print "7_4", func, param_4

@ fn_no_p7_5 @
type ret_T, p1_T, p2_T, p3_T, p4_T, p5_T, p6_T, p7_T;
identifier fn, p1, p2, p3, p4, p5, p6, p7;
@@

ret_T fn(p1_T p1, p2_T p2, p3_T p3, p4_T p4, p5_T p5, p6_T p6, p7_T p7)
{
... when != p5
}

@script:python @
param_5 << fn_no_p7_5.p5;
func << fn_no_p7_5.fn;
@@
print "7_5", func, param_5

@ fn_no_p7_6 @
type ret_T, p1_T, p2_T, p3_T, p4_T, p5_T, p6_T, p7_T;
identifier fn, p1, p2, p3, p4, p5, p6, p7;
@@

ret_T fn(p1_T p1, p2_T p2, p3_T p3, p4_T p4, p5_T p5, p6_T p6, p7_T p7)
{
... when != p6
}

@script:python @
param_6 << fn_no_p7_6.p6;
func << fn_no_p7_6.fn;
@@
print "7_6", func, param_6

@ fn_no_p7_7 @
type ret_T, p1_T, p2_T, p3_T, p4_T, p5_T, p6_T, p7_T;
identifier fn, p1, p2, p3, p4, p5, p6, p7;
@@

ret_T fn(p1_T p1, p2_T p2, p3_T p3, p4_T p4, p5_T p5, p6_T p6, p7_T p7)
{
... when != p7
}

@script:python @
param_7 << fn_no_p7_7.p7;
func << fn_no_p7_7.fn;
@@
print "7_7", func, param_7

// 8

@ fn_p8 @
type ret_T, p1_T, p2_T, p3_T, p4_T, p5_T, p6_T, p7_T, p8_T;
identifier fn, p1, p2, p3, p4, p5, p6, p7, p8;
position p;
@@

ret_T fn@p(p1_T p1, p2_T p2, p3_T p3, p4_T p4, p5_T p5, p6_T p6, p7_T p7, p8_T p8)
{
...
}

@script:python @
func << fn_p8.fn;
pos << fn_p8.p;
@@
print "8", func, pos[0].file

@ fn_no_p8_1 @
type ret_T, p1_T, p2_T, p3_T, p4_T, p5_T, p6_T, p7_T, p8_T;
identifier fn, p1, p2, p3, p4, p5, p6, p7, p8;
@@

ret_T fn(p1_T p1, p2_T p2, p3_T p3, p4_T p4, p5_T p5, p6_T p6, p7_T p7, p8_T p8)
{
... when != p1
}

@script:python @
param_1 << fn_no_p8_1.p1;
func << fn_no_p8_1.fn;
@@
print "8_1", func, param_1

@ fn_no_p8_2 @
type ret_T, p1_T, p2_T, p3_T, p4_T, p5_T, p6_T, p7_T, p8_T;
identifier fn, p1, p2, p3, p4, p5, p6, p7, p8;
@@

ret_T fn(p1_T p1, p2_T p2, p3_T p3, p4_T p4, p5_T p5, p6_T p6, p7_T p7, p8_T p8)
{
... when != p2
}

@script:python @
param_2 << fn_no_p8_2.p2;
func << fn_no_p8_2.fn;
@@
print "8_2", func, param_2

@ fn_no_p8_3 @
type ret_T, p1_T, p2_T, p3_T, p4_T, p5_T, p6_T, p7_T, p8_T;
identifier fn, p1, p2, p3, p4, p5, p6, p7, p8;
@@

ret_T fn(p1_T p1, p2_T p2, p3_T p3, p4_T p4, p5_T p5, p6_T p6, p7_T p7, p8_T p8)
{
... when != p3
}

@script:python @
param_3 << fn_no_p8_3.p8;
func << fn_no_p8_3.fn;
@@
print "8_3", func, param_3

@ fn_no_p8_4 @
type ret_T, p1_T, p2_T, p3_T, p4_T, p5_T, p6_T, p7_T, p8_T;
identifier fn, p1, p2, p3, p4, p5, p6, p7, p8;
@@

ret_T fn(p1_T p1, p2_T p2, p3_T p3, p4_T p4, p5_T p5, p6_T p6, p7_T p7, p8_T p8)
{
... when != p4
}

@script:python @
param_4 << fn_no_p8_4.p4;
func << fn_no_p8_4.fn;
@@
print "8_4", func, param_4

@ fn_no_p8_5 @
type ret_T, p1_T, p2_T, p3_T, p4_T, p5_T, p6_T, p7_T, p8_T;
identifier fn, p1, p2, p3, p4, p5, p6, p7, p8;
@@

ret_T fn(p1_T p1, p2_T p2, p3_T p3, p4_T p4, p5_T p5, p6_T p6, p7_T p7, p8_T p8)
{
... when != p5
}

@script:python @
param_5 << fn_no_p8_5.p5;
func << fn_no_p8_5.fn;
@@
print "8_5", func, param_5

@ fn_no_p8_6 @
type ret_T, p1_T, p2_T, p3_T, p4_T, p5_T, p6_T, p7_T, p8_T;
identifier fn, p1, p2, p3, p4, p5, p6, p7, p8;
@@

ret_T fn(p1_T p1, p2_T p2, p3_T p3, p4_T p4, p5_T p5, p6_T p6, p7_T p7, p8_T p8)
{
... when != p6
}

@script:python @
param_6 << fn_no_p8_6.p6;
func << fn_no_p8_6.fn;
@@
print "8_6", func, param_6

@ fn_no_p8_7 @
type ret_T, p1_T, p2_T, p3_T, p4_T, p5_T, p6_T, p7_T, p8_T;
identifier fn, p1, p2, p3, p4, p5, p6, p7, p8;
@@

ret_T fn(p1_T p1, p2_T p2, p3_T p3, p4_T p4, p5_T p5, p6_T p6, p7_T p7, p8_T p8)
{
... when != p7
}

@script:python @
param_7 << fn_no_p8_7.p7;
func << fn_no_p8_7.fn;
@@
print "8_7", func, param_7

@ fn_no_p8_8 @
type ret_T, p1_T, p2_T, p3_T, p4_T, p5_T, p6_T, p7_T, p8_T;
identifier fn, p1, p2, p3, p4, p5, p6, p7, p8;
@@

ret_T fn(p1_T p1, p2_T p2, p3_T p3, p4_T p4, p5_T p5, p6_T p6, p7_T p7, p8_T p8)
{
... when != p8
}

@script:python @
param_8 << fn_no_p8_8.p8;
func << fn_no_p8_8.fn;
@@
print "8_8", func, param_8


