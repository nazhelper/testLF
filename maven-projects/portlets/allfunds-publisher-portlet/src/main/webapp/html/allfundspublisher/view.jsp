<%@page import="com.liferay.portal.kernel.language.LanguageUtil"%>
<%@page import="com.liferay.portal.kernel.util.Constants"%>
<%@page import="com.liferay.portal.kernel.search.Sort"%>
<%@page import="com.liferay.portal.kernel.search.BooleanClauseOccur"%>
<%@page import="com.liferay.portal.kernel.search.TermQuery"%>
<%@page import="com.liferay.portal.kernel.search.TermQueryFactoryUtil"%>
<%@page import="com.liferay.portal.kernel.search.SearchEngineUtil"%>
<%@page import="com.liferay.portal.kernel.search.Field"%>
<%@page import="com.liferay.portal.kernel.search.BooleanQueryFactoryUtil"%>
<%@page import="com.liferay.portal.kernel.search.BooleanQuery"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.liferay.portal.kernel.search.Document"%>
<%@page import="com.liferay.portal.kernel.search.SearchException"%>
<%@page import="com.liferay.portal.kernel.search.Hits"%>
<%@page import="com.liferay.portal.kernel.search.SearchContextFactory"%>
<%@page import="com.liferay.portal.kernel.search.SearchContext"%>
<%@page import="com.liferay.portal.kernel.util.PortalClassLoaderUtil"%>
<%@page import="com.liferay.portlet.asset.service.AssetEntryLocalServiceUtil"%>
<%@page import="com.liferay.portlet.portletdisplaytemplate.util.PortletDisplayTemplateUtil"%>
<%@page import="com.liferay.portlet.dynamicdatamapping.model.DDMStructure"%>
<%@page import="com.liferay.portlet.dynamicdatamapping.service.DDMStructureLocalServiceUtil"%>
<%@page import="com.liferay.portlet.journal.model.JournalArticle"%>
<%@page import="java.util.List"%>
<%@page import="com.liferay.portlet.journal.service.JournalArticleLocalServiceUtil"%>
<%@page import="com.liferay.portal.kernel.util.WebKeys"%>
<%@ include file="init.jsp" %>
<portlet:resourceURL var="fetchJSPUrl">
	<portlet:param name="<%=Constants.CMD%>" value="JSP"/>
</portlet:resourceURL>
<portlet:resourceURL var="loadDataURL">
	<portlet:param name="<%=Constants.CMD%>" value="<%=Constants.READ%>"/>
</portlet:resourceURL>
<%
Integer pageSize_cfg = GetterUtil.getInteger(portletPreferences.getValue("pageSize", "3"));
String ddmStructureId_cfg = portletPreferences.getValue("ddmStructureId", "0L");
String categoryIds_cfg = portletPreferences.getValue("categories","");
String background_cfg = GetterUtil.getString(portletPreferences.getValue("background", "white"));
Boolean collapse_cfg = GetterUtil.getBoolean(portletPreferences.getValue("collapseSection", Boolean.FALSE.toString()));
String wrapperClass = "";
String panelBodyClass = "";

if(!ddmStructureId_cfg.equalsIgnoreCase("0L")){

	if(background_cfg.equalsIgnoreCase("white")){
		wrapperClass += " panel panel-default ";
		panelBodyClass += "panel-body";
		if(collapse_cfg){
			wrapperClass += " panel-clear-top ";
		}
	} 
%>
	<div class="<%=wrapperClass%>">
		<div class="<%=panelBodyClass%>">
			<c:choose>
				<c:when test="<%= portletDisplayDDMTemplateId > 0 %>">
					<div id="publisher-wrapper">
					
					</div>
					<input type="hidden" id="currentPage" name="currentPage" value="1"/>
					<div class='clearfix'></div>
					<div id="loadMore" class="" style="display: none;">
			           	<div class="btn btn-block btn-info"><%=LanguageUtil.get(locale,"allfunds.adt.general.load.more")%></div>
			       	</div>
				</c:when>
				<c:otherwise>
				<%
					renderRequest.setAttribute(WebKeys.PORTLET_CONFIGURATOR_VISIBILITY, Boolean.TRUE);
				%>
					<div class="portlet-msg-info">
						<liferay-ui:message key="allfunds.corporate.images.config.instance.required"/>
					</div>
				</c:otherwise>
			</c:choose>		
		</div>
	</div>

<%
}else{ 

	renderRequest.setAttribute(WebKeys.PORTLET_CONFIGURATOR_VISIBILITY, Boolean.TRUE);
%>
	<div class="portlet-msg-info">
		<liferay-ui:message key="allfunds.corporate.images.config.instance.required"/>
	</div>
<%} %>

<script type="text/javascript">
function ddmFormat(articles, loadMore){
    $.ajax({
    	type: "POST",
        url : '<%=renderResponse.encodeURL(fetchJSPUrl.toString())%>',
        async: false,
        data : {
        	<portlet:namespace/>articles: articles
        },
        cache : false, // guarantees jsp is always called
        success: function(data) {
        	var html = document.getElementById("publisher-wrapper").innerHTML;
            var result = data;
            
            var html = html.concat(result);
            document.getElementById("publisher-wrapper").innerHTML = html;
            $("#publisher-wrapper").fadeIn();
 
			$(".thumbnail").hover(function() {
				$(this).find('.caption').slideDown(250);
			}, function() {
				$(this).find('.caption').slideUp(250);
			});
			
            if(loadMore){
				$('#loadMore').css("display", "block");
			}else{
				$('#loadMore').css("display", "none");
			}
        }
   });
}


function loadData(structureId, ddmTemplate, categories, from, to) {
	jQuery.ajax({
		type: "POST",
		url: '<%=loadDataURL%>',
		async: false,
		data: {
			<portlet:namespace/>idStructure: structureId,
			<portlet:namespace/>portletDisplayDDMTemplateId: ddmTemplate,
			<portlet:namespace/>categories: categories,
			<portlet:namespace/>from: from,
			<portlet:namespace/>to: to
		},
		dataType: 'json',
		success: function(data){
			var loadMore = data.loadMore;
			var currentPage = data.currentPage;
			var articles = data.articles;
			
			$('#currentPage').val(currentPage);


			if(articles.length > 0){
				ddmFormat(articles, loadMore);
			}else{
				$("#publisher-wrapper").fadeOut();
				$('#loadMore').css("display", "none");
			}
		}
	});
}

$("#loadMore .btn").on("click", function() {
	var imagessPageSize = <%=pageSize_cfg%>;
	var categories = '<%=categoryIds_cfg%>';
	var structureId = '<%=ddmStructureId_cfg%>'; 
	var ddmTemplate = <%=portletDisplayDDMTemplateId%>;
	var currentPage = $('#currentPage').val();
	var from = (currentPage - 1) * imagessPageSize;
	var to = from + imagessPageSize;
	
	loadData(structureId, ddmTemplate, categories, from, to);
});

$(document).ready(function() {
	var imagesPageSize = <%=pageSize_cfg%>;
	var categories = '<%=categoryIds_cfg%>';
	var structureId = '<%=ddmStructureId_cfg%>'; 
	var ddmTemplate = <%=portletDisplayDDMTemplateId%>; 
	var from = 0;
	var to = from + imagesPageSize; 
	
	if(structureId != "0L" && ddmTemplate > 0){
		loadData(structureId, ddmTemplate, categories, from, to);
	}
});
</script>