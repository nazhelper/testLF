<%@page import="com.liferay.portal.kernel.dao.orm.ProjectionFactoryUtil"%>
<%@page import="com.liferay.portal.kernel.dao.orm.DynamicQuery"%>
<%@page import="com.liferay.portlet.documentlibrary.model.DLFileEntryType"%>
<%@page import="com.liferay.portlet.documentlibrary.service.DLFileEntryTypeLocalServiceUtil"%>
<%@ include file="../init.jsp" %>

<portlet:resourceURL var="loadImagesURL">
	<portlet:param name="<%=Constants.CMD%>" value="<%=Constants.READ%>"/>
</portlet:resourceURL>
<%
Long ddmStructureId_cfg = GetterUtil.getLong(portletPreferences.getValue("ddmStructureId", "0L"));
Long vocabularyKey_cfg = GetterUtil.getLong(portletPreferences.getValue("vocabularyKey", "0L"));
%>
		<div class="panel panel-default panel-clear-top">
			<div class="panel-body" id="images-panel-body">

			</div>
		</div>

<script type="text/javascript">
$(document).ready(function() {
	var imagessPageSize = 10;
	var currentPage = 1;
	var firstEl = (currentPage - 1) * imagessPageSize;
	
	jQuery.ajax({
		type: "POST",
		url: '<%=loadImagesURL%>',
		async: false,
		data: {
			<portlet:namespace/>idStructure: <%=ddmStructureId_cfg%>,
			<portlet:namespace/>from: firstEl,
			<portlet:namespace/>pageSize: imagessPageSize
		},
		dataType: 'json',
		error: function()
		{
		},
		beforeSend: function(){
		},
		complete: function(){
		},
		success: function(data){

			var images = data.images;
			
			if(images.length > 0){
				var htmlTabla = "";
				
				for(var i in images){
					var image = images[i];

					htmlTabla = htmlTabla.concat("<div class='img-offices "+image.officeClass+"'>");
					htmlTabla = htmlTabla.concat("<div class='thumbnail'>");
					htmlTabla = htmlTabla.concat("<div class='caption' style='display: none;'>");
					htmlTabla = htmlTabla.concat("<h4>"+image.title+"</h4>");
					htmlTabla = htmlTabla.concat("<p>"+image.description+"</p>");
					htmlTabla = htmlTabla.concat("<div class='divider'></div>");
					
					htmlTabla = htmlTabla.concat("<p class='"+image.shortView+"'>");
					htmlTabla = htmlTabla.concat(image.imageFormat);
					htmlTabla = htmlTabla.concat("</p>");
					htmlTabla = htmlTabla.concat("<p class='"+image.shortView+"'>");
					htmlTabla = htmlTabla.concat(image.imageDimension);
					htmlTabla = htmlTabla.concat("</p>");
					htmlTabla = htmlTabla.concat("<p class='"+image.shortView+"'>");
					htmlTabla = htmlTabla.concat(image.imageSize);
					htmlTabla = htmlTabla.concat("</p>");
					htmlTabla = htmlTabla.concat("<p>");
					htmlTabla = htmlTabla.concat("<a href='"+image.imageURL+"' target='_blank;' class='label label-danger' rel='tooltip' title='' >");
					htmlTabla = htmlTabla.concat("<span class='glyphicon glyphicon-save'> </span>");
					htmlTabla = htmlTabla.concat('<%=LanguageUtil.get(locale, "download")%>');
					htmlTabla = htmlTabla.concat("</a>");
					htmlTabla = htmlTabla.concat("</p>");
					htmlTabla = htmlTabla.concat("</div>");
					htmlTabla = htmlTabla.concat("<img src='"+image.imageURL+"' />");
					htmlTabla = htmlTabla.concat("</div>");
					htmlTabla = htmlTabla.concat("</div>");
				
				}
				
				htmlTabla = htmlTabla.concat("<div class='clearfix'></div>");
				
				document.getElementById("images-panel-body").innerHTML = htmlTabla;
				
				$( ".thumbnail" ).hover(
					function() {
						$(this).find('.caption').slideDown(250);
					},
					function() {
						$(this).find('.caption').slideUp(250);
						
					}
				);
				
			}
	        
		}
	}); 
	
	
} );
</script>