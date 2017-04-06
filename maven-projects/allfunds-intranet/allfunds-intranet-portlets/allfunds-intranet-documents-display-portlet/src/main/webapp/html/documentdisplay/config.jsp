<%@ include file="../init.jsp" %>

<liferay-theme:defineObjects />
<liferay-portlet:actionURL portletConfiguration="true" var="configurationURL" />
<portlet:resourceURL var="getContentURL"></portlet:resourceURL>

<% 
	Long DLFolderid = GetterUtil.getLong(portletPreferences.getValue("DLFolderid", "0L"));
	Long groupId = themeDisplay.getScopeGroupId();
	Map<Integer, Map> systemFolders = new HashMap<Integer, Map>();
	List<DLFolder> baseFolders = DLFolderLocalServiceUtil.getFolders(groupId, DLFolderConstants.DEFAULT_PARENT_FOLDER_ID, Boolean.FALSE);
	systemFolders = DLFolderPorletUtils.getFolders(baseFolders, groupId, "");
%>
	
<aui:form action="<%= configurationURL %>" method="post">

	<aui:input name="<%= Constants.CMD %>" type="hidden" value="<%= Constants.UPDATE %>" />
	<aui:select  name="preferences--DLFolderid--" required="true" showRequiredLabel="false">
			<%  if((DLFolderid.longValue() == 0L)){  %>	
					<aui:option label="allfunds.documents.displayall" value="0" selected="true"/>	
			<%
				}else{	
				%>	
					<aui:option label="allfunds.documents.displayall" value="0" />
				<%	
				}
			%>
		<%
			for(Map.Entry<Integer, Map> entry : systemFolders.entrySet()){
				Map.Entry<Long,String> folderMap = (Map.Entry<Long,String>) entry.getValue().entrySet().iterator().next();
				Long dlFolderId = folderMap.getKey();
				String folderName = folderMap.getValue();

			 	if(dlFolderId.longValue() == DLFolderid.longValue()){
			%>
					<aui:option label="<%=folderName%>"
					value="<%=dlFolderId%>" selected="true"/>
			<%			
				}else{
			%>
					<aui:option label="<%=folderName%>"
					value="<%=dlFolderId%>"/>
			<%
					}
				} 
			%>
	</aui:select>

	
	<aui:button-row>
        <aui:button type="submit" />
    </aui:button-row>
</aui:form>




