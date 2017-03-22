<#--
Web content templates are used to lay out the fields defined in a web
content structure.

Please use the left panel to quickly add commonly used variables.
Autocomplete is also available and can be invoked by typing "${".
-->
<#assign tipoVideo = "">

<#assign journalArticleId = .vars['reserved-article-id'].data>
<#assign journalArticleResourceLocalServiceUtil = staticUtil["com.liferay.portlet.journal.service.JournalArticleResourceLocalServiceUtil"]>
<#assign assetCategoryLocalServiceUtil = staticUtil["com.liferay.portlet.asset.service.AssetCategoryLocalServiceUtil"]>
<#assign articleResourcePK = journalArticleResourceLocalServiceUtil.getArticleResourcePrimKey(groupId, journalArticleId)/>
<#assign categoryList=assetCategoryLocalServiceUtil.getCategories("com.liferay.portlet.journal.model.JournalArticle",articleResourcePK) >

<#list categoryList as curCategory>
    <#assign tipoVideo = curCategory.getName()>
</#list>


<#if tipoVideo == "CSR Video">
        <div class="panel panel-default csr clearfix">
    <#elseif tipoVideo?contains("Events") && !tipoVideo?contains("Internal")>
        <div class="panel panel-default events clearfix">
    <#elseif tipoVideo?contains("Internal")>
        <div class="panel panel-default empleados clearfix">
    <#else>
        <div class="panel panel-default news clearfix">
</#if>
    <div class="img-panel-big" style="background-image: url(${imgPreVideo.getData()});">
        <span class="indicador icon-video"> </span> 
        <a id="aLinkToVideo" data-toggle="modal" href="#myModalVideoHome" class="linkToVideoJquery button"><span class="indicador icon-play-video"></span></a> 
    </div>
</div>

<div class="modal fade modalVideoPers" id="myModalVideoHome" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display:none;">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-body">
        <button id="buttonCloseModal" type="button" class="close closeButtonJquery" data-dismiss="modal" aria-hidden="true">&times;</button>
        <video id="videoCommunication" class="videoCommunicationJquery" controls name="media"><source id="videoJquery" src="${video.getData()}" type="video/mp4"></video>
      </div>
    </div>
  </div>
</div>