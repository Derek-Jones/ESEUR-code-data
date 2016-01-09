		public String compact(String message) {
			if (fExpected == null || fActual == null || areStringsEqual())
				return Assert.format(message, fExpected, fActual);

			findCommonPrefix();
			findCommonSuffix();
