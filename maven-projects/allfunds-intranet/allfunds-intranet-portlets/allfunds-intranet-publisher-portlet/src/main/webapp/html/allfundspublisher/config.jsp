<%@page import="java.util.Arrays"%>
<%@page import="com.liferay.portal.kernel.util.ListUtil"%>
<%@page import="com.liferay.portal.kernel.util.ArrayUtil"%>
<%@page import="com.liferay.portal.util.PortalUtil"%>
<%@page import="com.liferay.portal.kernel.template.TemplateHandlerRegistryUtil"%>
<%@page import="com.liferay.portal.kernel.template.TemplateHandler"%>
<%@page import="com.liferay.portal.kernel.util.Constants"%>
<%@page import="com.liferay.portlet.journal.model.JournalArticle"%>
<%@page import="com.liferay.portal.service.ClassNameLocalServiceUtil"%>
<%@page import="java.util.List"%>
<%@page import="com.liferay.portlet.dynamicdatamapping.model.DDMStructure"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.liferay.portlet.dynamicdatamapping.service.DDMStructureLocalServiceUtil"%>
<%@ include file="init.jsp" %>

<liferay-portlet:actionURL portletConfiguration="true" var="configurationURL" />
<%  
boolean showLocationAddress_view = GetterUtil.getBoolean(portletPreferences.getValue("showLocationAddress", StringPool.TRUE));

String ddmStructureId_cfg = portletPreferences.getValue("ddmStructureId", "0L");
String[] ddmStructureList = ddmStructureId_cfg.split(",");

String categoryIds_cfg = portletPreferences.getValue("categories","");

Integer pageSize_cfg = GetterUtil.getInteger(portletPreferences.getValue("pageSize", "3"));
String background_cfg = GetterUtil.getString(portletPreferences.getValue("background", "white"));
Boolean collapse_cfg = GetterUtil.getBoolean(portletPreferences.getValue("collapseSection", Boolean.FALSE.toString()));

List<DDMStructure> availablesST = new ArrayList<DDMStructure>();
availablesST = DDMStructureLocalServiceUtil.getStructures(scopeGroupId, ClassNameLocalServiceUtil.getClassNameId(JournalArticle.class));

%>

<aui:form action="<%= configurationURL %>" method="post" name="fm">
    <aui:input name="<%= Constants.CMD %>" type="hidden" value="<%= Constants.UPDATE %>" />

	<aui:fieldset>
	    <!-- Preference control goes here -->
	     <div class="display-template">

		<%
		TemplateHandler templateHandler = TemplateHandlerRegistryUtil.getTemplateHandler(JournalArticle.class.getName());
		%>
		
		<liferay-ui:ddm-template-selector
		classNameId="<%= PortalUtil.getClassNameId(templateHandler.getClassName()) %>"
		displayStyle="<%= displayStyle %>"
		displayStyleGroupId="<%= displayStyleGroupId %>"
		refreshURL="<%= PortalUtil.getCurrentURL(request) %>"
		showEmptyOption="<%= true %>"
		/>
		</div>
	    
	    <aui:select name="preferences--ddmStructureId--" showEmptyOption="true" label="allfunds.publisher.structureId" multiple="true">
			<%
			for (DDMStructure structure : availablesST) {
				String id = String.valueOf(structure.getStructureId());
				if (ArrayUtil.contains( ddmStructureList, id ) ) {
			%>
				<aui:option label="<%=structure.getName(locale, true)%>"
					value="<%=String.valueOf(structure.getStructureId())%>" selected="true" />
			<%
				} else {
			%>
				<aui:option label="<%=structure.getName(locale, true)%>"
					value="<%=String.valueOf(structure.getStructureId())%>" />
			<%
				}
			}
			%>
		</aui:select> 
		<liferay-ui:asset-categories-selector
				curCategoryIds="<%=categoryIds_cfg %>"
	            className="<%= JournalArticle.class.getName() %>"
        />
		
		
		<aui:select name="preferences--background--" label="allfunds.publisher.background.color">
			<aui:option label="white"
					value="white" selected='<%=background_cfg.equalsIgnoreCase("white") %>' />
			<aui:option label="transparent"
					value="transparent" selected='<%=background_cfg.equalsIgnoreCase("transparent") %>'  />
		</aui:select> 
		
		<aui:input name="preferences--collapseSection--" label="allfunds.publisher.section.collapse" value="<%=collapse_cfg %>" type="checkbox"/>
		
		<aui:input name="preferences--pageSize--" label="allfunds.config.pagination.pageSize" value="<%=pageSize_cfg %>" autoSize="true" style="width: 5em;">
		<aui:validator name="number"></aui:validator>
		<aui:validator name="max">30</aui:validator>
		 <aui:validator name="required"/>
		</aui:input>
    
    
    </aui:fieldset>
	
    <aui:button-row>
        <aui:button type="submit" />
    </aui:button-row>
</aui:form>
