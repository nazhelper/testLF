<%@page import="com.liferay.portal.kernel.util.HtmlUtil"%>
<%@page import="com.liferay.portal.kernel.util.HttpUtil"%>
<%@page import="com.liferay.portal.kernel.dao.orm.ProjectionFactoryUtil"%>
<%@page import="com.liferay.portal.kernel.dao.orm.DynamicQuery"%>
<%@page import="com.liferay.portlet.documentlibrary.model.DLFileEntryType"%>
<%@page import="com.liferay.portlet.documentlibrary.service.DLFileEntryTypeLocalServiceUtil"%>
<%@page import="com.allfunds.plugins.portlet.DLFolderPorletUtils"%>
<%@page import="com.liferay.portlet.documentlibrary.model.DLFolder"%>
<%@page import="com.liferay.portlet.documentlibrary.service.DLFolderLocalServiceUtil"%>
<%@page import="com.liferay.portlet.documentlibrary.service.DLFolderLocalService"%>
<%@include file="../init.jsp" %>


<portlet:resourceURL var="loadFoldersURL">
	<portlet:param name="<%=Constants.CMD%>" value="<%=Constants.READ%>"/>
</portlet:resourceURL>

<%
	Long DLFolderid = GetterUtil.getLong(portletPreferences.getValue("DLFolderid", "0L"));
	Integer x = 0;
	DLFolderPorletUtils dl = new DLFolderPorletUtils();
	List<DLFolder> folders = DLFolderLocalServiceUtil.getFolders(themeDisplay.getScopeGroupId(), DLFolderid, Boolean.FALSE);
	Map<DLFolder, Map> allTheFolders = dl.getFoldersView(folders, themeDisplay.getScopeGroupId());
%>
		<div class="panel panel-default panel-clear-top">
			<div class="panel-body">
			 <ul id='<portlet:namespace/>tree' class="tree">
			 	
				<%
					for(Map.Entry<DLFolder, Map> entry : allTheFolders.entrySet()){		
				%>
				<li>
					<allfunds:field-folder folderMap="<%=entry.getValue()%>" folder="<%=entry.getKey()%>"></allfunds:field-folder>
				</li>		
					<%
					}			
					List<DLFileEntry> entries = DLFileEntryLocalServiceUtil.getFileEntries(themeDisplay.getScopeGroupId(), DLFolderid); 
					for(DLFileEntry entry : entries){
						DLFileEntry fileEntry = entry.toEscapedModel();	
						long fileEntryId = fileEntry.getFileEntryId();
						long folderId = fileEntry.getFolderId();
						String name = fileEntry.getName();
						String extension = fileEntry.getExtension();
						String title = fileEntry.getTitle();
						String fileUrl = themeDisplay.getPortalURL() + themeDisplay.getPathContext() + "/documents/" + themeDisplay.getScopeGroupId() + "//" + folderId +  "//" + HttpUtil.encodeURL(HtmlUtil.unescape(title));
						
					%>
					<li><a href="<%=fileUrl%>" target="_blank"><%=entry.getTitle()%></a></li>
					<%
					}					
					%>
			</ul>
			</div>
		</div>
		
<script type="text/javascript">

$(document).ready(function(){
$.fn.extend({
		treed: function (o) {
		  
		  var openedClass = 'glyphicon-minus-sign';
		  var closedClass = 'glyphicon-plus-sign';
		  
		  if (typeof o != 'undefined'){
			if (typeof o.openedClass != 'undefined'){
			openedClass = o.openedClass;
			}
			if (typeof o.closedClass != 'undefined'){
			closedClass = o.closedClass;
			}
		  };
		  

			var tree = $(this);
			var len = tree.find('li').has("ul").length;
			tree.addClass("tree");
			tree.find('li').has("ul").each(function () {
				var branch = $(this);
				branch.prepend("<i class='indicator glyphicon " + closedClass + "'></i>");
				branch.addClass('branch');
				branch.on('click', function (e) {
					if (this == e.target) {
						var icon = $(this).children('i:first');
						icon.toggleClass(openedClass + " " + closedClass);
						$(this).children().children().toggle();
					}
				})
				branch.children().children().toggle();
			});
			
			
		  tree.find('.branch .indicator').each(function(){
			$(this).on('click', function () {
				$(this).closest('li').click();
			});
		  });
			
			tree.find('.branch>a').each(function () {
				$(this).on('click', function (e) {
					$(this).closest('li').click();
					e.preventDefault();
				});
			});

			tree.find('.branch>button').each(function () {
				$(this).on('click', function (e) {
					$(this).closest('li').click();
					e.preventDefault();
				});
			});
		}
	});
	
	$('').treed();
	
	$('#<portlet:namespace/>tree').treed({openedClass:'glyphicon-folder-open', closedClass:'glyphicon-folder-close'});
	
	$('').treed({openedClass:'glyphicon-chevron-right', closedClass:'glyphicon-chevron-down'});
	
	});
</script>

		
		