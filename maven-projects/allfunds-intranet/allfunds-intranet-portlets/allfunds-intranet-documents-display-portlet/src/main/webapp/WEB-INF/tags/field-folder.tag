<%@tag import="com.liferay.portal.security.permission.ActionKeys"%>
<%@tag import="com.liferay.portal.model.ResourcePermission"%>
<%@tag import="com.liferay.portal.kernel.util.HtmlUtil"%>
<%@tag import="com.liferay.portal.kernel.util.HttpUtil"%>
<%@tag import="com.liferay.portlet.documentlibrary.model.DLFileEntry"%>
<%@tag import="com.liferay.portal.theme.ThemeDisplay"%>
<%@tag import="java.util.ArrayList"%>
<%@tag import="java.util.List"%>
<%@tag import="com.liferay.portal.model.Role"%>
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
			List <ResourcePermission> rp = new ArrayList <ResourcePermission> ();
			if(Validator.isNotNull(folderMap)){
			for(Map.Entry<DLFolder, Map> entry : castFolderMap.entrySet()){
					boolean showfolder = false;
					Map<DLFolder, Map> children = entry.getValue();
					DLFolder childFolder = entry.getKey();
					if(!childFolder.isInTrash()){
						showfolder = permissionChecker.hasPermission(themeDisplay.getScopeGroupId(), entry.getKey().getModelClassName(), entry.getKey().getFolderId(), ActionKeys.VIEW);
						if(showfolder){
			%>
					<li>
						<allfunds:field-folder folderMap="<%=children%>" folder="<%=childFolder%>"></allfunds:field-folder>
					</li>
			<%			
						}
					}
				}	
			}
				List<DLFileEntry>entries = DLFileEntryLocalServiceUtil.getFileEntries(themeDisplay.getScopeGroupId(), folder.getFolderId());
				for(DLFileEntry entry : entries){
					boolean showFile = false;
					if(!entry.isInTrash()){
						DLFileEntry fileEntry = entry.toEscapedModel();	
						long fileEntryId = fileEntry.getFileEntryId();
						long folderId = fileEntry.getFolderId();
						String name = fileEntry.getName();
						String extension = fileEntry.getExtension();
						String title = fileEntry.getTitle();
						String fileUrl = themeDisplay.getPortalURL() + themeDisplay.getPathContext() + "/documents/" + themeDisplay.getScopeGroupId() + "//" + folderId +  "//" + HttpUtil.encodeURL(HtmlUtil.unescape(title));				
						showFile = permissionChecker.hasPermission(themeDisplay.getScopeGroupId(), DLFileEntry.class.getName(), fileEntry.getPrimaryKey(), ActionKeys.VIEW);
						if(showFile){
			%>			
					<li><a href="<%=fileUrl%>" target="_blank"><%=entry.getTitle()%></a></li>	
			<%			}
					}
				}
			%>
			</ul>
	