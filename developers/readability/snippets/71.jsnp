	/**
		Translate bsh.Modifiers into ASM modifier bitflags.
	*/
	static int getASMModifiers( Modifiers modifiers ) 
	{
		int mods = 0;
		if ( modifiers == null )
			return mods;

		if ( modifiers.hasModifier("public") )
			mods += ACC_PUBLIC;
