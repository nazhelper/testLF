<#--
Web content templates are used to lay out the fields defined in a web
content structure.

Please use the left panel to quickly add commonly used variables.
Autocomplete is also available and can be invoked by typing "${".
-->

<#assign textBoxSub = "">
<#assign tipoNoticia = "">
<#assign journalArticleId = .vars['reserved-article-id'].data>
<#assign journalArticleResourceLocalServiceUtil = staticUtil["com.liferay.portlet.journal.service.JournalArticleResourceLocalServiceUtil"]>
<#assign assetCategoryLocalServiceUtil = staticUtil["com.liferay.portlet.asset.service.AssetCategoryLocalServiceUtil"]>

<#assign articleResourcePK = journalArticleResourceLocalServiceUtil.getArticleResourcePrimKey(groupId, journalArticleId)/>
<#assign categoryList=assetCategoryLocalServiceUtil.getCategories("com.liferay.portlet.journal.model.JournalArticle",articleResourcePK) >

<#if (categoryList)??>
    <#list categoryList as categoryList>
        <#assign tipoNoticia = categoryList.getName()>
    </#list>
</#if>

<#assign isVisible = "">


<div class="span12 panel panel-default clearfix news">
    <#if (imagenNews.getData() != "")>
        <div class="span12 omega img-panel-big" style="background-image: url(${imagenNews.getData()});"></div>
    </#if>
    <div class="span12 omega">
    <#if tipoNoticia == "AllFunds Bank News">
        <span class="indicador icon-noticia"></span>
    <#elseif tipoNoticia == "CSR News">
        <span class="indicador icon-solidario"></span>
    <#elseif tipoNoticia == "Fund Industry News">
        <span class="indicador icon-noticia"></span>
    <#elseif tipoNoticia == "Press Clipping">
        <span class="indicador icon-documento"></span>
    <#elseif tipoNoticia == "CSR Events">
        <span class="indicador icon-solidario"></span>
    <#elseif tipoNoticia == "Fund Industry Events">
        <span class="indicador icon-event"></span>
    <#elseif tipoNoticia == "Internal Events">
        <span class="indicador icon-event"></span>
    <#else>
        <span class="indicador icon-event"></span>
    </#if>
        <div class="panel-body panel-big-text">    
            <h4 class="titular">
                <#if readMore.getData()?contains("pdf")> 
                    <#if (urlPdfNews)??>
                        <a target="_blank" href="${urlPdfNews.getData()}">
                    </#if>
                <#elseif readMore.getData()?contains("image")>
                    <#if (urlImage)??>
                        <a data-toggle="modal" href="#myModal" class="button">
                    </#if>
                <#elseif readMore.getData()?contains("none")>
                    <a>
                <#elseif readMore.getData()?contains("url")>
                    <#if (urlExterna)??>
                        <a target="_blank" href="${urlExterna.getData()}">
                    </#if>
                </#if>
            	    ${TextTitularNoticia.getData()},
                </a>
                <#assign FechaNoticia_Data = getterUtil.getLong(FechaNoticia.getData())>
                <#if (FechaNoticia_Data > 0)>
            	    <#assign FechaNoticia_DateObj = dateUtil.newDate(FechaNoticia_Data)>
            
            	    <small>${dateUtil.getDate(FechaNoticia_DateObj, "MMMM yyyy", locale)}</small>
                </#if>
            </h4>
            <p>
                <#if TextBoxNoticia.getData()?length &gt; 220>
                    <#assign textBoxSub = TextBoxNoticia.getData()?substring(0,220)/>
                    ${textBoxSub}
                    <@liferay.language key="allfunds.template.points" /> 
                <#else>
                    ${TextBoxNoticia.getData()}
                </#if>
                <#if readMore.getData()?contains("pdf")> 
                    <#if (urlPdfNews)??>
                        <a target="_blank" href="${urlPdfNews.getData()}">
                    </#if>
                <#elseif readMore.getData()?contains("image")>
                    <#if (urlImage)??>
                        <a data-toggle="modal" href="#myModal" class="button">
                    </#if>
                <#elseif readMore.getData()?contains("none")>
                    <a>
                <#elseif readMore.getData()?contains("url")>
                    <#if (urlExterna)??>
                        <a target="_blank" href="${urlExterna.getData()}">
                    </#if>
                </#if> 
                    	<@liferay.language key="allfunds.template.readmore" />
                </a>
             </p>
        </div>
    </div>
</div>

<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-body">
      <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
       <img id="myImg" alt="Image News" src="${urlImage.getData()}" />
      </div>
    </div>
  </div>
  <div id="containerModalImg">
      <div id="modalImgText">${TextTitularNoticia.getData()}</div>
  </div>
</div>