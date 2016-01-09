			
			if (iterateOverMe instanceof String)
				return createEnumeration(((String)iterateOverMe).toCharArray());
			
			if (iterateOverMe instanceof StringBuffer)
				return createEnumeration(
					iterateOverMe.toString().toCharArray());

			throw new IllegalArgumentException(
				"Cannot enumerate object of type "+iterateOverMe.getClass());
