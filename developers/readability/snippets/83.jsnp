	public void filter(Filter filter) throws NoTestsRemainException {
		for (Iterator<Method> iter= fTestMethods.iterator(); iter.hasNext();) {
			Method method= iter.next();
			if (!filter.shouldRun(methodDescription(method)))
				iter.remove();
		}
		if (fTestMethods.isEmpty())
			throw new NoTestsRemainException();
