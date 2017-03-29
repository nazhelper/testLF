<%@page import="com.allfunds.plugins.portlet.DLFolderPorletUtils"%>
<%@page import="com.liferay.portlet.documentlibrary.model.DLFolderConstants"%>
<%@page import="com.liferay.portlet.documentlibrary.service.DLFolderLocalServiceUtil"%>
<%@page import="com.liferay.portlet.documentlibrary.service.DLFolderLocalService"%>
<%@page import="java.util.spi.LocaleServiceProvider"%>
<%@page import="com.liferay.portlet.documentlibrary.model.DLFileEntryMetadata"%>
<%@page import="com.liferay.portal.theme.ThemeDisplay"%>
<%@page import="com.liferay.portlet.documentlibrary.model.DLFileEntry"%>
<%@page import="com.liferay.portlet.asset.service.AssetVocabularyLocalServiceUtil"%>
<%@page import="com.liferay.portlet.asset.model.AssetVocabulary"%>
<%@page import="com.liferay.portlet.documentlibrary.model.DLFolder"%>
<%@page import="com.liferay.portlet.asset.VocabularyNameException"%>
<%@page import="com.liferay.portlet.journal.model.JournalArticle"%>
<%@page import="com.liferay.portal.service.ClassNameLocalServiceUtil"%>
<%@page import="com.liferay.portlet.dynamicdatamapping.service.DDMStructureLocalServiceUtil"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.liferay.portlet.dynamicdatamapping.model.DDMStructure"%>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.liferay.portal.kernel.util.Constants"%>
<%@page import="com.liferay.portal.kernel.util.StringPool"%>
<%@page import="com.liferay.portal.kernel.util.GetterUtil"%>
<%@ taglib uri="http://java.sun.com/portlet_2_0" prefix="portlet" %>
<%@ taglib uri="http://liferay.com/tld/portlet" prefix="liferay-portlet" %>
<%@ taglib uri="http://alloy.liferay.com/tld/aui" prefix="aui" %>
<%@ taglib uri="http://liferay.com/tld/theme" prefix="liferay-theme"%>
<%@ taglib uri="http://java.sun.com/portlet_2_0" prefix="portlet" %>
<%@ include file="../init.jsp" %>

<liferay-portlet:actionURL portletConfiguration="true" var="configurationURL" />
<portlet:resourceURL var="getContentURL"></portlet:resourceURL>

<% 
	Long DLFolderid = GetterUtil.getLong(portletPreferences.getValue("DLFolderid", "0L"));
	DLFolderPorletUtils dl = new DLFolderPorletUtils();
	Long groupId = themeDisplay.getScopeGroupId();
	Map<Integer, Map> systemFolders = new HashMap<Integer, Map>();

	List<DLFolder> baseFolders = DLFolderLocalServiceUtil.getFolders(groupId, DLFolderConstants.DEFAULT_PARENT_FOLDER_ID, Boolean.FALSE);
	systemFolders = dl.getFolders(baseFolders, groupId, "");
%>
	
<aui:form action="<%= configurationURL %>" method="post">

	<aui:input name="<%= Constants.CMD %>" type="hidden" value="<%= Constants.UPDATE %>" />
	<aui:select  name="preferences--DLFolderid--" showEmptyOption="true" required="true" showRequiredLabel="false">
			<%  if((DLFolderid.longValue() == 0L)){  %>	
				<aui:option label="Todos" value="0" selected="true"/>	
			<%
				}else{	
				%>	
					<aui:option label="Todos" value="0" />
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




