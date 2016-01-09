	/**
		Get the top level namespace or this namespace if we are the top.
		Note: this method should probably return type bsh.This to be consistent
		with getThis();
	*/
    public This getGlobal( Interpreter declaringInterpreter )
    {
		if ( parent != null )
			return parent.getGlobal( declaringInterpreter );
		else
			return getThis( declaringInterpreter );
