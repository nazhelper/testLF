<%@ include file="../init.jsp" %>

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
	
	<aui:input name="preferences--pageSize--" label="allfunds.config.pagination.pageSize" value="<%=pageSize_cfg %>" autoSize="true" style="width: 5em;">
	<aui:validator name="number"></aui:validator>
	<aui:validator name="max">30</aui:validator>
	 <aui:validator name="required"/>
	</aui:input>
    
	
    <aui:button-row>
        <aui:button type="submit" />
    </aui:button-row>
</aui:form>