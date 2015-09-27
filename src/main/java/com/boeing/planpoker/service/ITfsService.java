package com.boeing.planpoker.service;

import com.microsoft.tfs.core.clients.workitem.query.WorkItemCollection;

public interface ITfsService {

	WorkItemCollection getWorkItems(String tfsIterationPath);

}
