package kr.co.unp.batch.job;


import kr.co.unp.batch.task.SearchServiceTask;

import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.springframework.scheduling.quartz.QuartzJobBean;

public class SearchJobSchedulerBean extends QuartzJobBean {

	private SearchServiceTask searchServiceTask;

	public SearchServiceTask getSearchServiceTask() {
		return searchServiceTask;
	}

	public void setSearchServiceTask(SearchServiceTask searchServiceTask) {
		this.searchServiceTask = searchServiceTask;
	}


	@Override
	protected void executeInternal(JobExecutionContext arg0)
			throws JobExecutionException {

		try {
			searchServiceTask.doTaskProc();


		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
