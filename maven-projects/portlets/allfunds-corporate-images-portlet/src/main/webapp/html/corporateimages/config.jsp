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
Long vocabularyKey_cfg = GetterUtil.getLong(portletPreferences.getValue("vocabularyKey", "0L"));

List<DDMStructure> availablesST = new ArrayList<DDMStructure>();
availablesST = DDMStructureLocalServiceUtil.getStructures(groupID, ClassNameLocalServiceUtil.getClassNameId(DLFileEntryMetadata.class));

List<AssetVocabulary> vocabularies = new ArrayList<AssetVocabulary>();

vocabularies = AssetVocabularyLocalServiceUtil.getGroupVocabularies(groupID);

%>

<aui:form action="<%= configurationURL %>" method="post" name="fm">
    <aui:input name="<%= Constants.CMD %>" type="hidden" value="<%= Constants.UPDATE %>" />

    <!-- Preference control goes here -->
    <aui:select name="preferences--ddmStructureId--" showEmptyOption="true">
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
    <aui:select name="preferences--vocabularyKey--" showEmptyOption="true">
		<%
		for (AssetVocabulary vocabulary : vocabularies) {
			if (vocabulary.getVocabularyId() == vocabularyKey_cfg) {
		%>
			<aui:option label="<%=vocabulary.getTitle(locale)%>"
				value="<%=vocabulary.getVocabularyId()%>" selected="true" />
		<%
			} else {
		%>
			<aui:option label="<%=vocabulary.getTitle(locale)%>"
				value="<%=vocabulary.getVocabularyId()%>" />
		<%
			}
		}
		%>
	</aui:select>    
    
	
    <aui:button-row>
        <aui:button type="submit" />
    </aui:button-row>
</aui:form>