	/**
		subsequent imports override earlier ones
	*/
    public void	importPackage(String name)
    {
		if(importedPackages == null)
			importedPackages = new Vector();

		// If it exists, remove it and add it at the end (avoid memory leak)
		if ( importedPackages.contains( name ) )
			importedPackages.remove( name );

		importedPackages.addElement(name);
