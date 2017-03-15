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

<div class="span12 panel panel-default clearfix events">
<div class="span6">
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
    <div class="panel-body panel-big-text">
        <h4 class="titular">
            <a href="${PDFNoticia.getData()}">
	        ${TextTitularNoticia.getData()},
            </a>
            <#assign FechaNoticia_Data = getterUtil.getLong(FechaNoticia.getData())>
            <#if (FechaNoticia_Data > 0)>
	            <#assign FechaNoticia_DateObj = dateUtil.newDate(FechaNoticia_Data)>

	            <small>${dateUtil.getDate(FechaNoticia_DateObj, "MMMM yyyy", locale)}</small>
            </#if>
        </h4>
        <p>
           	<#if TextBoxNoticia.getData()?length &gt; 150>
        		${TextBoxNoticia.getData()?substring(0,150)}
       			 <@liferay.language key="allfunds.template.points" /> 
    		<#else>
        		${TextBoxNoticia.getData()}
    		</#if>  
            <a target="_blank" href="${PDFNoticia.getData()}">
				<@liferay.language key="allfunds.template.readmore" />
            </a>
        </p>
    </div>
</div>
<#if (imagenNoticia.getData() != "")>
    <div class="span6 img-panel-big" style="background-image: url(${imagenNoticia.getData()});">
    </div>
</#if>
</div>