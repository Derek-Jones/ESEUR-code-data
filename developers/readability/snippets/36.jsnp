			Class clas = object.getClass();
			Field field = Reflect.resolveJavaField( 
				clas, name, false/*onlyStatic*/ );
			if ( field != null )
				return new Variable( 
					name, field.getType(), new LHS( object, field ) );
