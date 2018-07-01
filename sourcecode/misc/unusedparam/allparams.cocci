// allparams.cocci,  6 May 11

@ fn_p_any @
type ret_T, pany_T;
identifier fn, p_any;
@@

ret_T fn(..., pany_T p_any, ...)
{
... when != p_any
}

@script:python @
param_any << fn_p_any.p_any;
func << fn_p_any.fn;
@@
print "unused", func, param_any


