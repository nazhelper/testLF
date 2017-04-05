<%@page import="com.liferay.portal.security.permission.ActionKeys"%>
<%@page import="com.liferay.portal.kernel.util.WebKeys"%>
<%@page import="java.util.Objects"%>
<%@page import="com.liferay.portal.util.PortalUtil"%>
<%@page import="com.liferay.portal.service.ResourcePermissionLocalServiceUtil"%>
<%@page import="com.liferay.portal.model.ResourcePermission"%>
<%@include file="../init.jsp" %>


<portlet:resourceURL var="loadFoldersURL">
	<portlet:param name="<%=Constants.CMD%>" value="<%=Constants.READ%>"/>
</portlet:resourceURL>

<%
	Long DLFolderid = GetterUtil.getLong(portletPreferences.getValue("DLFolderid", "0L"));
	Long companyId = PortalUtil.getDefaultCompanyId();
	Long groupID = themeDisplay.getScopeGroupId();
	Integer x = 0;
	List <ResourcePermission> rp = new ArrayList <ResourcePermission> ();
	List<DLFolder> folders = DLFolderLocalServiceUtil.getFolders(themeDisplay.getScopeGroupId(), DLFolderid, Boolean.FALSE);
	Map<DLFolder, Map> allTheFolders = DLFolderPorletUtils.getFoldersView(folders, themeDisplay.getScopeGroupId());
%>
		<div>
			<div class="panel-body">
			 <ul id='<portlet:namespace/>tree' class="tree">
				<%
					for(Map.Entry<DLFolder, Map> entry : allTheFolders.entrySet()){
						boolean showfolder = false;
						showfolder = permissionChecker.hasPermission(groupID, entry.getKey().getModelClassName(), entry.getKey().getFolderId(), ActionKeys.VIEW);
						if(showfolder){
				%>
				<li>
					<allfunds:field-folder folderMap="<%=entry.getValue()%>" folder="<%=entry.getKey()%>"></allfunds:field-folder>
				</li>		
					<%
						}	
					}			
					List<DLFileEntry> entries = DLFileEntryLocalServiceUtil.getFileEntries(themeDisplay.getScopeGroupId(), DLFolderid); 
					for(DLFileEntry entry : entries){
						boolean showFile = false;
						if(!entry.isInTrash()){
							DLFileEntry fileEntry = entry.toEscapedModel();	
							long fileEntryId = fileEntry.getFileEntryId();
							long folderId = fileEntry.getFolderId();
							String name = fileEntry.getName();
							String extension = fileEntry.getExtension();
							String title = fileEntry.getTitle();
							String fileUrl = themeDisplay.getPortalURL() + themeDisplay.getPathContext() + "/documents/" + themeDisplay.getScopeGroupId() + "//" + folderId +  "//" + HttpUtil.encodeURL(HtmlUtil.unescape(title));
							showFile = permissionChecker.hasPermission(groupID, DLFileEntry.class.getName(), fileEntry.getPrimaryKey(), ActionKeys.VIEW);
							if(showFile){
						%>
							<li><a href="<%=fileUrl%>" target="_blank"><%=entry.getTitle()%></a></li>
						<%
							}
						}
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

		
		