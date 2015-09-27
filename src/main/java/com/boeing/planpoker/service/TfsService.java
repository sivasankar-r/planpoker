package com.boeing.planpoker.service;

import org.springframework.stereotype.Service;

import com.microsoft.tfs.core.TFSTeamProjectCollection;
import com.microsoft.tfs.core.clients.workitem.WorkItemClient;
import com.microsoft.tfs.core.clients.workitem.project.Project;
import com.microsoft.tfs.core.clients.workitem.query.WorkItemCollection;

@Service
public class TfsService implements ITfsService {

	@Override
	public WorkItemCollection getWorkItems(String tfsIterationPath) {
		TFSTeamProjectCollection tpc =  SnippetSettings.connectToTFS(); 
		Project project = tpc.getWorkItemClient().getProjects().get(SnippetSettings.PROJECT_NAME);
        WorkItemClient workItemClient = project.getWorkItemClient();
        // Define the WIQL query.
        String wiqlQuery = "Select ID, Title from WorkItems where (System.IterationPath = '"+tfsIterationPath+"') order by Title";
        // Run the query and get the results.
        WorkItemCollection workItems = workItemClient.query(wiqlQuery);
		return workItems;
	}


}
