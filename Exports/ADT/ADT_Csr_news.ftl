<#--
Application display templates can be used to modify the look of a
specific application.

Please use the left panel to quickly add commonly used variables.
Autocomplete is also available and can be invoked by typing "${".
-->
<#assign x = 1>
<#assign categoria = "">

<#if entries?has_content>
    <#list entries?chunk(2)as entriesList>
      <div class="row-fluid">
	   <#list entriesList as curEntry>
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
                <#if (categoryList)??>
                    <#list categoryList as currCategoryName>
                        <#assign categoria = currCategoryName.getName()> 
                    </#list>
                </#if>
                
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
                
                <#assign titularNoticia = docXml.valueOf("//dynamic-element[@name='TextTitularNoticia']/dynamic-content/text()") />
                <#assign textBoxNoticia = docXml.valueOf("//dynamic-element[@name='TextBoxNoticia']/dynamic-content/text()") />
                <#assign fechaNoticia = docXml.valueOf("//dynamic-element[@name='FechaNoticia']/dynamic-content/text()") />
                <#assign Fecha_Noticia_DateObj = dateUtil.newDate(getterUtil.getLong("${fechaNoticia}"))>
    	        <#assign Fecha_Noticiab = dateUtil.getDate(Fecha_Noticia_DateObj, "MMM yyyy", locale)>
                <#assign imagenNews = docXml.valueOf("//dynamic-element[@name='imagenNews']/dynamic-content/text()") />
                <#assign readMore = docXml.valueOf("//dynamic-element[@name='readMore']/dynamic-content/text()") />
                <#assign urlPdfNews = docXml.valueOf("//dynamic-element[@name='urlPdfNews']/dynamic-content/text()") />
                <#assign urlExterna = docXml.valueOf("//dynamic-element[@name='urlExterna']/dynamic-content/text()") />
                <#assign urlImage = docXml.valueOf("//dynamic-element[@name='urlImage']/dynamic-content/text()") />

                
               <#if (video)?? && video != "">
                    <div class="span6 panel panel-default clearfix csr">
                        <#if (imgPreVideo != "")>
                            <div class="span12 omega img-panel-big" style="background-image: url(${imgPreVideo}); background-size: cover;">
                            <a id="aLinkToVideo" data-toggle="modal" href="#myModalVideo${x}" class="linkToVideoJquery button"><span class="indicador icon-play-video csr"></span></a>
                            </div>
                        </#if>

                        <div class="span12 omega">
                            <span class="indicador icon-video csr"></span>
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
 
                    <#assign videoType = "" />
                    <#assign videoDate = "" />
                    <#assign Fecha_Video_DateObj = "">
    	            <#assign Fecha_Videob = "">
                    <#assign fieldDescrVideo = "" />
                    <#assign video = "" />
                    <#assign imgPreVideo = "" />
        
 
                <#elseif (titularNoticia)?? && titularNoticia != "">
                    <div class="span6 panel panel-default clearfix csr">
                        <#if (imagenNews != "")>
                            <div class="span12 omega img-panel-big" style="background-image: url(${imagenNews}); background-size: cover;"></div>
                        </#if>

                        <div class="span12 omega">
                            <#if categoria?contains("News")>
                                <span class="indicador icon-noticia"></span>
                            <#elseif categoria?contains("Events")>
                                <span class="indicador icon-event"></span>
                            <#else>
                                <span class="indicador icon-solidario"></span>
                            </#if>
                            <div class="panel-body panel-big-text clearfix">
                                <h4 class="titular">
                                ${title}, <small>${Fecha_Noticiab}</small></h4>
                                <p>
                                <#if textBoxNoticia?length &gt; 200>
                                    <#assign textBoxSub = textBoxNoticia?substring(0,200)/>
                                    ${textBoxSub}
                                    <@liferay.language key="allfunds.template.points" /> 
                                <#else>
                                    ${textBoxNoticia}
                                </#if>
                                <#if readMore?contains("pdf")> 
                                    <#if (urlPdfNews)??>
                                        <a target="_blank" href="${urlPdfNews}">
                                    </#if>
                                <#elseif readMore?contains("image")>
                                    <#if (urlImage)??>
                                        <a data-toggle="modal" href="#myModal" class="button">
                                    </#if>
                                <#elseif readMore?contains("none")>
                                        <a>
                                <#elseif readMore?contains("url")>
                                    <#if (urlExterna)??>
                                        <a target="_blank" href="${urlExterna}">
                                    </#if>
                                </#if> 
                    	                <@liferay.language key="allfunds.template.readmore" />
                                    </a>
                                </p>
                            </div>
                        </div>
                    </div>
                    
                    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display:none;">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-body">
                                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                    <img id="myImg" alt="Image News" src="${urlImage}" />
                                </div>
                             </div>
                        </div>
                        <div id="containerModalImg">
                            <div id="modalImgText">${titularNoticia}</div>
                        </div>
                    </div>
                    
                    <#assign titularNoticia = "" />
                    <#assign textBoxNoticia = "" />
                    <#assign fechaNoticia = "" />
                    <#assign Fecha_Noticia_DateObj = "">
    	            <#assign Fecha_Noticiab = "">
                    <#assign imagenNews = "" />
                    <#assign readMore = "" />
                    <#assign urlPdfNews = "" />
                    <#assign urlExterna = "" />
                    <#assign urlImage = "" />
                    
                </#if>
            </#list>
            </div>
	</#list>
</#if>