<%@page import="com.liferay.portlet.documentlibrary.model.DLFileEntryMetadata"%>
<%@page import="com.liferay.portlet.documentlibrary.model.DLFileEntry"%>
<%@page import="com.liferay.portlet.asset.service.AssetVocabularyLocalServiceUtil"%>
<%@page import="com.liferay.portlet.asset.model.AssetVocabulary"%>
<%@page import="com.liferay.portlet.asset.VocabularyNameException"%>
<%@page import="com.liferay.portlet.journal.model.JournalArticle"%>
<%@page import="com.liferay.portal.service.ClassNameLocalServiceUtil"%>
<%@page import="com.liferay.portlet.dynamicdatamapping.service.DDMStructureLocalServiceUtil"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.liferay.portlet.dynamicdatamapping.model.DDMStructure"%>
<%@page import="java.util.List"%>
<%@page import="com.liferay.portal.kernel.util.Constants"%>
<%@page import="com.liferay.portal.kernel.util.StringPool"%>
<%@page import="com.liferay.portal.kernel.util.GetterUtil"%>
<%@ taglib uri="http://java.sun.com/portlet_2_0" prefix="portlet" %>
<%@ taglib uri="http://liferay.com/tld/portlet" prefix="liferay-portlet" %>
<%@ taglib uri="http://alloy.liferay.com/tld/aui" prefix="aui" %>
<%@ taglib uri="http://liferay.com/tld/theme" prefix="liferay-theme"%>

<portlet:defineObjects />
<liferay-theme:defineObjects/>

<liferay-portlet:actionURL portletConfiguration="true" var="configurationURL" />
<%  
long groupID = themeDisplay.getScopeGroupId();
Long ddmStructureId_cfg = GetterUtil.getLong(portletPreferences.getValue("ddmStructureId", "0L"));
Integer pageSize_cfg = GetterUtil.getInteger(portletPreferences.getValue("pageSize", "9"));

List<DDMStructure> availablesST = new ArrayList<DDMStructure>();
availablesST = DDMStructureLocalServiceUtil.getStructures(groupID, ClassNameLocalServiceUtil.getClassNameId(DLFileEntryMetadata.class));

%>

<aui:form action="<%= configurationURL %>" method="post" name="fm">
    <aui:input name="<%= Constants.CMD %>" type="hidden" value="<%= Constants.UPDATE %>" />

    <!-- Preference control goes here -->
    <aui:select name="preferences--ddmStructureId--" showEmptyOption="true" label="allfunds.categories.structureId">
		<%
		for (DDMStructure structure : availablesST) {
			if (structure.getStructureId() == ddmStructureId_cfg) {
		%>
			<aui:option label="<%=structure.getName(locale, true)%>"
				value="<%=structure.getStructureId()%>" selected="true" />
		<%
			} else {
		%>
			<aui:option label="<%=structure.getName(locale, true)%>"
				value="<%=structure.getStructureId()%>" />
		<%
			}
		}
		%>
	</aui:select> 
	
	<aui:input name="preferences--pageSize--" label="allfunds.categories.pageSize" value="<%=pageSize_cfg %>" autoSize="true" style="width: 5em;">
	
	</aui:input>
    
	
    <aui:button-row>
        <aui:button type="submit" />
    </aui:button-row>
</aui:form>