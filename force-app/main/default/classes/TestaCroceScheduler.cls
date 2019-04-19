// This class schedules a TestaCroce object instance to run on a given schedule either by a command line or via Apex Schedule UI

global class TestaCroceScheduler implements Schedulable {
	global void execute(SchedulableContext sc) {
		TestaCroce tc = new TestaCroce();
	}
}