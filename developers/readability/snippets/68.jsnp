	@Override
	public void run(RunNotifier notifier) {
		TestResult result= new TestResult();
		result.addListener(createAdaptingListener(notifier));
		fTest.run(result);
