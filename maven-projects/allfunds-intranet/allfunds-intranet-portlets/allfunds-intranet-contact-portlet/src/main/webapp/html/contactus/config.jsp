<%@page import="com.liferay.portal.kernel.util.Constants"%>
<%@ taglib uri="http://java.sun.com/portlet_2_0" prefix="portlet" %>
<%@ include file="../init.jsp" %>

<portlet:defineObjects />

<liferay-portlet:actionURL portletConfiguration="true" var="configurationURL" />
<portlet:resourceURL var="getContentURL"></portlet:resourceURL>

<%  
long groupID = themeDisplay.getScopeGroupId();
Long ddmStructureId_cfg = GetterUtil.getLong(portletPreferences.getValue("ddmStructureId", "0L"));

List<DDMStructure> availablesST = new ArrayList<DDMStructure>();
availablesST = DDMStructureLocalServiceUtil.getStructures(groupID, ClassNameLocalServiceUtil.getClassNameId(JournalArticle.class));

%> 
<aui:form action="<%= configurationURL %>" method="post" name="fm">
    <aui:input name="<%= Constants.CMD %>" type="hidden" value="<%= Constants.UPDATE %>" />

    <aui:select name="preferences--ddmStructureId--" showEmptyOption="false" label="allfunds.estructure.structureId">
		<%
		for (DDMStructure structure : availablesST) {
			if (structure.getStructureKey().equals(Objects.toString(ddmStructureId_cfg.longValue()))) {
		%>
			<aui:option label="<%=structure.getName(locale, true)%>"
				value="<%=structure.getStructureKey()%>" selected="true" />
		<%
			} else {
		%>
			<aui:option label="<%=structure.getName(locale, true)%>"
				value="<%=structure.getStructureKey()%>" />
		<%
			}
		}
		%>
	</aui:select> 
	
    <aui:button-row>
        <aui:button type="submit" />
    </aui:button-row>
</aui:form>