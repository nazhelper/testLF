<%@tag import="com.liferay.portal.kernel.util.HtmlUtil"%>
<%@tag import="com.liferay.portal.kernel.util.HttpUtil"%>
<%@tag import="com.liferay.portlet.documentlibrary.model.DLFileEntry"%>
<%@tag import="com.liferay.portal.theme.ThemeDisplay"%>
<%@tag import="java.util.ArrayList"%>
<%@tag import="java.util.List"%>
<%@tag import="com.liferay.portal.kernel.util.Validator"%>
<%@tag import="com.liferay.portlet.documentlibrary.model.DLFolder"%>
<%@tag import="com.liferay.portal.theme.ThemeDisplay"%>
<%@taglib uri="http://liferay.com/tld/theme" prefix="liferay-theme"%>
<%@tag import="java.util.Map"%>
<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ tag description="Field Folder"%>
<%@taglib prefix="allfunds" tagdir="/WEB-INF/tags"%>
<%@tag import="com.liferay.portlet.documentlibrary.service.DLFileEntryLocalServiceUtil"%>
<%@ attribute name="folder" required="true" rtexprvalue="true"
	type="com.liferay.portlet.documentlibrary.model.DLFolder"%>
<%@ attribute name="folderMap" required="true" rtexprvalue="true"
	type="java.util.Map"%>

<liferay-theme:defineObjects />

	<%=folder.getName()%>
			<ul>
			<%
			Map<DLFolder,Map> castFolderMap  = (Map<DLFolder, Map>) folderMap;	
			if(Validator.isNotNull(folderMap)){
			for(Map.Entry<DLFolder, Map> entry : castFolderMap.entrySet()){
					Map<DLFolder, Map> children = entry.getValue();
					DLFolder childFolder = entry.getKey();
			%>
					<li>
						<allfunds:field-folder folderMap="<%=children%>" folder="<%=childFolder%>"></allfunds:field-folder>
					</li>
			<%
				}	
			}
				List<DLFileEntry>entries = DLFileEntryLocalServiceUtil.getFileEntries(themeDisplay.getScopeGroupId(), folder.getFolderId());
				for(DLFileEntry entry : entries){
				DLFileEntry fileEntry = entry.toEscapedModel();	
				long fileEntryId = fileEntry.getFileEntryId();
				long folderId = fileEntry.getFolderId();
				String name = fileEntry.getName();
				String extension = fileEntry.getExtension();
				String title = fileEntry.getTitle();
				String fileUrl = themeDisplay.getPortalURL() + themeDisplay.getPathContext() + "/documents/" + themeDisplay.getScopeGroupId() + "//" + folderId +  "//" + HttpUtil.encodeURL(HtmlUtil.unescape(title));				
			%>
					<li><a href="<%=fileUrl%>" target="_blank"><%=entry.getTitle()%></a></li>	
			<%
				}
			%>
			</ul>
	