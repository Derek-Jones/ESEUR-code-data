	public void filter(Filter filter) throws NoTestsRemainException {
		for (Iterator<Runner> iter= fRunners.iterator(); iter.hasNext();) {
			Runner runner= iter.next();
			if (filter.shouldRun(runner.getDescription()))
				filter.apply(runner);
			else
				iter.remove();
