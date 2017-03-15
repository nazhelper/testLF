<#--
Web content templates are used to lay out the fields defined in a web
content structure.

Please use the left panel to quickly add commonly used variables.
Autocomplete is also available and can be invoked by typing "${".
-->
<#assign tipoNoticia = "">
<#assign journalArticleId = .vars['reserved-article-id'].data>
<#assign journalArticleResourceLocalServiceUtil = staticUtil["com.liferay.portlet.journal.service.JournalArticleResourceLocalServiceUtil"]>
<#assign assetCategoryLocalServiceUtil = staticUtil["com.liferay.portlet.asset.service.AssetCategoryLocalServiceUtil"]>

<#assign articleResourcePK = journalArticleResourceLocalServiceUtil.getArticleResourcePrimKey(groupId, journalArticleId)/>
<#assign categoryList=assetCategoryLocalServiceUtil.getCategories("com.liferay.portlet.journal.model.JournalArticle",articleResourcePK) >

<#list categoryList as categoryList>
<#assign tipoNoticia = categoryList.getName()>
</#list>

<div class="span12 events">
     <#if tipoNoticia == "AllFunds Bank News">
        <span class="indicador icon-noticia"></span>
    <#elseif tipoNoticia == "CSR News">
        <span class="indicador icon-solidario"></span>
    <#elseif tipoNoticia == "Fund Industry News">
        <span class="indicador icon-noticia"></span>
    <#elseif tipoNoticia == "Press Clipping">
        <span class="indicador icon-documento"></span>
    <#elseif tipoNoticia == "CSR Events">
        <span class="indicador icon-event"></span>
    <#elseif tipoNoticia == "Fund Industry Events">
        <span class="indicador icon-event"></span>
    <#elseif tipoNoticia == "Internal Events">
        <span class="indicador icon-event"></span>
    <#else>
        <span class="indicador icon-event"></span>
    </#if>
<div class="span5">
<p class="marginTopParrafoTitular"><a href="${PDFNoticia.getData()}">
	${TextTitularNoticia.getData()}
 </a>,<#assign FechaNoticia_Data = getterUtil.getLong(FechaNoticia.getData())>
<#if (FechaNoticia_Data > 0)>
	<#assign FechaNoticia_DateObj = dateUtil.newDate(FechaNoticia_Data)>

	${dateUtil.getDate(FechaNoticia_DateObj, "MMMM yyyy", locale)}
</#if></p>
<p class="marginTopParrafo">${TextBoxNoticia.getData()?substring(0,150)}<@liferay.language key="allfunds.template.points" /><a target="_blank" href="${PDFNoticia.getData()}">
	<@liferay.language key="allfunds.template.readmore" />
 </a></p>
</div>
<#if (imagenNoticia.getData() != "")>
    <div class="span6">
        <img alt="Foto" src="${imagenNoticia.getData()}" />
    </div>
</#if>
</div>