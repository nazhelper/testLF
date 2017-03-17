<#--
Application display templates can be used to modify the look of a
specific application.

Please use the left panel to quickly add commonly used variables.
Autocomplete is also available and can be invoked by typing "${".
-->
<#assign x = 1>

<#if entries?has_content>
	 <#list entries?chunk(3)as entriesList>
	    <div class="row-fluid">
	       <#list entriesList as curEntry >
	            <#assign expirationDate = "" />
	            <#assign entry = curEntry />
                <#assign assetRenderer = entry.getAssetRenderer() />
                <#assign assetRendererb = entry.getCategories()/>
                <#assign assetRendererc = entry.getCategoryIds()/>
                <#assign assetTagNames = entry.getTagNames()/>
                <#assign title = entry.getAssetRenderer().getArticle().getTitle(locale)/>
                <#assign journalArticleId = entry.getAssetRenderer().getArticle().getArticleId()>
                <#assign journalArticleResourceLocalServiceUtil = staticUtil["com.liferay.portlet.journal.service.JournalArticleResourceLocalServiceUtil"]>
                <#assign assetCategoryLocalServiceUtil = staticUtil["com.liferay.portlet.asset.service.AssetCategoryLocalServiceUtil"]>
                <#assign articleResourcePK = journalArticleResourceLocalServiceUtil.getArticleResourcePrimKey(groupId, journalArticleId)/>
                <#assign categoryList=assetCategoryLocalServiceUtil.getCategories("com.liferay.portlet.journal.model.JournalArticle",articleResourcePK) >
                <#assign docXml = saxReaderUtil.read(entry.getAssetRenderer().getArticle().getContentByLocale(locale)) />
                <#assign assetRenderere = entry.getDescriptionMap()/>
                <#assign viewURL = assetPublisherHelper.getAssetViewURL(renderRequest, renderResponse, entry) />
                <#if assetLinkBehavior != "showFullContent">
                    <#assign viewURL = assetRenderer.getURLViewInContext(renderRequest, renderResponse, viewURL) />
                </#if>  
                
                <#assign videoType = docXml.valueOf("//dynamic-element[@name='videoType']/dynamic-content/text()") />
                <#assign videoDate = docXml.valueOf("//dynamic-element[@name='videoDate']/dynamic-content/text()") />
                <#assign Fecha_Video_DateObj = dateUtil.newDate(getterUtil.getLong("${videoDate}"))>
    	        <#assign Fecha_Videob = dateUtil.getDate(Fecha_Video_DateObj, "MMM yyyy", locale)>
                <#assign fieldDescrVideo = docXml.valueOf("//dynamic-element[@name='descriptionVideo']/dynamic-content/text()") />
                <#assign video = docXml.valueOf("//dynamic-element[@name='video']/dynamic-content/text()") />
                <#assign imgPreVideo = docXml.valueOf("//dynamic-element[@name='imgPreVideo']/dynamic-content/text()") />
                

                
<div class="span4 panel panel-default clearfix news">

    <#if (imgPreVideo != "")>
            <div class="span12 omega img-panel-big" style="background-image: url(${imgPreVideo});">
               <a id="aLinkToVideo${x}" data-toggle="modal" href="#myModalVideo${x}" class="linkToVideoJquery button"><span class="indicador icon-play-video"></span></a>
            </div>
    </#if>

    <div class="span12 omega">
        <span class="indicador icon-video"></span>
            <div class="panel-body panel-big-text clearfix">
                    <h4 class="titular">
                    ${title}, <small>${Fecha_Videob}</small></h4>
                    <p>
                    <#if fieldDescrVideo?length &gt; 200>
                        <#assign textBoxSub = fieldDescrVideo?substring(0,200)/>
                        ${textBoxSub}
                        <@liferay.language key="allfunds.template.points" /> 
                    <#else>
                        ${fieldDescrVideo}
                    </#if>
                    </p>
            </div>
    </div>
</div>
                
<div class="modal fade modalVideoPers" id="myModalVideo${x}" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display:none;">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-body">
        <button id="buttonCloseModal" type="button" class="close closeButtonJquery" data-dismiss="modal" aria-hidden="true">&times;</button>
        <video id="videoCommunication" class="videoCommunicationJquery" controls name="media"><source id="videoJquery" src="${video}" type="video/mp4"></video>
      </div>
    </div>
  </div>
  <div id="containerModalImg">
      <div id="modalImgText">${title}</div>
  </div>
</div>

                    <#assign x = x + x>
                </#list>
            </div>
	   </#list>
</#if>