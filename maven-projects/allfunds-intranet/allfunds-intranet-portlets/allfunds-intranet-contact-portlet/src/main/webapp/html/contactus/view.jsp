<%@page import="com.allfunds.intranet.plugins.portlet.Constants"%>
<%@page import="java.util.Objects"%>
<%@ include file="../init.jsp" %>
<portlet:defineObjects />

<%  
long groupID = themeDisplay.getScopeGroupId();
Long ddmStructureId_cfg = GetterUtil.getLong(portletPreferences.getValue("ddmStructureId", "0L"));
String errorMessage = Constants.ERROR_STRUCTURE;
String successMessage = Constants.SUCCESS_MESSAGE;

if(ddmStructureId_cfg.longValue() != 0L){
	List<JournalArticle> allJournalsArticles = JournalArticleLocalServiceUtil.getArticles(groupID);
%>

<liferay-portlet:actionURL var="sendEmail" name="sendEmailAction"/>
<liferay-ui:error key="errorStructure" message="<%=errorMessage%>"/>
<liferay-ui:success key="successEmail" message="<%=successMessage%>"/>

<aui:form action="<%=sendEmail%>" method="post" name="emailForm">
<div class="card hovercard">
	<div class="cardheader contact"></div>
	<div class=" text-left">
		<div class="panel-body">
			<h4><%//TODO leer variable título %></h4>
			<p><%//TODO leer variable texto introducción %></p>
		</div>
		
		<div class="panel-body">
			<aui:fieldset>
				<aui:layout>
	      			<aui:column columnWidth="50" first="true">
						<aui:input name="username" label="Your name" placeholder="name" >
							<aui:validator name="required"/>
							<aui:validator name="alpha"/>
						</aui:input>
					</aui:column>
					<aui:column columnWidth="50" last="true">
						<aui:select name="areaSelect" label="Area">
							<% for (JournalArticle article : allJournalsArticles){ 
								if(!article.isInTrash()){
									if(JournalArticleLocalServiceUtil.isLatestVersion(groupID, article.getArticleId(), article.getVersion())){
										if(article.getStructureId().equals(Objects.toString(ddmStructureId_cfg))){			
									%>			
										<aui:option label="<%=article.getTitleCurrentValue()%>" value="<%=article.getArticleId()%>"></aui:option>
									<% 		
													}
												}
											}
										}
									%>
						</aui:select>
					</aui:column>
				</aui:layout>
			</aui:fieldset>
			<aui:fieldset>
				<aui:column columnWidth="100" first="true" last="true">
					<aui:input name="comment" type="textarea" label="Your comment" rows="5" cols="5" placeholder="comment">
						 <aui:validator name="required"/>
						<aui:validator name="alphanum"/>				
					</aui:input>
				</aui:column> 
			</aui:fieldset>
		</div>
		<div class="panel-footer clearfix">
			<aui:button-row cssClass="btn-group pull-right" role="group">
				<aui:button icon="glyphicon glyphicon-send" cssClass="btn btn-info" name="saveButton" type="submit" class="btn btn-info" value="send" role="button" />
		
				<aui:button icon="flaticon-paint reducido" cssClass="btn btn-danger" name="cancelButton" type="button" value="cleaner" role="button" />
			</aui:button-row>
		</div>
	</div>
</div>
</aui:form>
<%
}else{ 
	renderRequest.setAttribute(WebKeys.PORTLET_CONFIGURATOR_VISIBILITY, Boolean.TRUE);
%>
	<div class="portlet-msg-info">
		<liferay-ui:message key="allfunds.corporate.structure.required"/>
	</div>
<%}%>