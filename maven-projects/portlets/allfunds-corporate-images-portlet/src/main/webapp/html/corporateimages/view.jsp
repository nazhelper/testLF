<%@ include file="../init.jsp" %>

<portlet:resourceURL var="loadImagesURL">
	<portlet:param name="<%=Constants.CMD%>" value="<%=Constants.READ%>"/>
</portlet:resourceURL>
<%
Integer pageSize = GetterUtil.getInteger(portletPreferences.getValue("pageSize", "9"));
Long ddmStructureId_cfg = GetterUtil.getLong(portletPreferences.getValue("ddmStructureId", "0L"));

if(ddmStructureId_cfg != 0L){
	DDMStructure structure = DDMStructureLocalServiceUtil.getDDMStructure(ddmStructureId_cfg);
	String xsd = structure.getXsd();
	
	Document structureDocument = SAXReaderUtil.read(xsd);
	Element xsdParentElement = structureDocument.getRootElement();
	List<Element> elementsXSD = xsdParentElement.elements();
	List<Element> categories = new ArrayList<Element>();
	
	for(Element element: elementsXSD){
		String name = element.attributeValue("name", "");
		if(name.equalsIgnoreCase("category")){
			categories = element.elements("dynamic-element");
			break;
		}
	}
%>
<div class="panel panel-default panel-category">
    <div class="panel-body">
        <div class="boxform">
            <label><%=LanguageUtil.get(locale, "allfunds.adt.categories.corporate.images")%></label>
            <div class="checkbox inline">
	    	    <%for(Element category: categories){ 
	    	    	String value = category.attributeValue("value");
	    	    	Element metaData = category.element("meta-data").element("entry");
	    	    	String label = metaData.getText().trim();
	    	    %>
                <label class="inline" id="category">
                    <input id="<%=value%>" name="CorporateImages" value="<%=value%>" type="checkbox" class="image-checkbox" checked="checked">
                    <span></span>
					<a href="#"></a>
                    <%=label%>
                </label>
	    	    <%} %>
            </div>
        </div>
    </div>
</div>
<div class="panel panel-default panel-clear-top">
	<div class="panel-body">
		<div id="images-panel-body">
		</div>
		<input type="hidden" id="currentPage" name="currentPage" value="1"/>
		<div class='clearfix'></div>
		<div id="loadMore" class="">
           	<div class="btn btn-block btn-info"><%=LanguageUtil.get(locale,"allfunds.adt.general.load.more")%></div>
       	</div>
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

function loadImages(structureId, from, to, reset) {
	//Get selected Categories
	var categories = []; 
	
	var vocabulary = $("#category .image-checkbox:checked");
	
	for(var i=0; i<vocabulary.length; i++){
	    var category = vocabulary.eq(i).val();
	    categories.push(category);
	}
	    console.log(categories);
	
	jQuery.ajax({
		type: "POST",
		url: '<%=loadImagesURL%>',
		async: false,
		data: {
			<portlet:namespace/>idStructure: structureId,
			<portlet:namespace/>categories: categories,
			<portlet:namespace/>from: from,
			<portlet:namespace/>to: to
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
			
			var htmlTabla = "";
			if(!reset){
				htmlTabla =	document.getElementById("images-panel-body").innerHTML;
			}else{
				$("#images-panel-body").fadeOut();
			}
			if(images.length > 0){
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
				document.getElementById("images-panel-body").innerHTML = htmlTabla;
				$("#images-panel-body").fadeIn();

			}else{
				$("#images-panel-body").fadeOut();
				
			}
			$('#currentPage').val(data.currentPage);

			$(".thumbnail").hover(function() {
				$(this).find('.caption').slideDown(250);
			}, function() {
				$(this).find('.caption').slideUp(250);
			});
			
			var loadMore = data.loadMore;
			
			if(loadMore){
				$('#loadMore').css("display", "block");
			}else{
				$('#loadMore').css("display", "none");
			}

		}
	});
}
	$("#category .image-checkbox").on("click", function() {
		var imagessPageSize = <%=pageSize%>;
		var structureId = <%=ddmStructureId_cfg%>; 
		var from = 0;
		var to = from + imagessPageSize;
		
		loadImages(structureId, from, to, true);
	});

	$("#loadMore .btn").on("click", function() {
		var imagessPageSize = <%=pageSize%>;
		var structureId = <%=ddmStructureId_cfg%>; 
		var currentPage = $('#currentPage').val();
		var from = (currentPage - 1) * imagessPageSize;
		var to = from + imagessPageSize;
		
		loadImages(structureId, from, to, false);
	});

	$(document).ready(function() {
		var structureId = <%=ddmStructureId_cfg%>; 
		var imagessPageSize = <%=pageSize%>;
		var currentPage = $('#currentPage').val();
		var from = (currentPage - 1) * imagessPageSize;
		var to = from + imagessPageSize;
		
		loadImages(structureId, from, to, false);
	});
</script>