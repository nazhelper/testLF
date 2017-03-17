<#--
Application display templates can be used to modify the look of a
specific application.

Please use the left panel to quickly add commonly used variables.
Autocomplete is also available and can be invoked by typing "${".
-->

<#assign liferay_ui = taglibLiferayHash["/WEB-INF/tld/liferay-ui.tld"] />
<#assign aui = taglibLiferayHash["/WEB-INF/tld/aui.tld"] />

<#assign user = themeDisplay.getUser()>
<#assign rolesUser = user.getRoles()>
<#assign allRoles = "">

<#list rolesUser as usrRoles>
    <#assign allRoles = allRoles +" "+ usrRoles.getName()/>
</#list>


<div class="panel-accordion" id="accordion">
    <div class="table-responsive">
    <table class="table table-hover table-striped">
        <thead>
            <tr>
                <th><@liferay.language key="allfunds.adt.corporate.branding" /></th>
                <th><@liferay.language key="allfunds.adt.corporate.date" /></th>
                <th><@liferay.language key="allfunds.adt.corporate.applyto" /></th>
                <th><@liferay.language key="allfunds.adt.corporate.details" /></th>
                <th><@liferay.language key="allfunds.adt.corporate.templates" /></th>
            <tr>
        </thead>
        <tbody>
        <#if entries?has_content>
	        <#list entries as curEntry>
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
                
                <#assign fieldDateCorp = docXml.valueOf("//dynamic-element[@name='valueDateCorp']/dynamic-content/text()") />
                <#assign Fecha_Noticia_DateObj = dateUtil.newDate(getterUtil.getLong("${fieldDateCorp}"))>
    	        <#assign Fecha_Noticiab = dateUtil.getDate(Fecha_Noticia_DateObj, "dd/MM/yyyy", locale)>
                <#assign fieldRolCorp = docXml.valueOf("//dynamic-element[@name='rolVisible']/dynamic-content/text()") />
                <#assign fieldOficGloSelect = docXml.valueOf("//dynamic-element[@name='oficGloSelect']/dynamic-content/text()") />
                <#assign fieldDescrTextBox = docXml.valueOf("//dynamic-element[@name='descrTextBox']/dynamic-content/text()") />
                <#assign fieldTemplateWord = docXml.valueOf("//dynamic-element[@name='templateWord']/dynamic-content/text()") />
                <#assign fieldTemplateExcel = docXml.valueOf("//dynamic-element[@name='templateExcel']/dynamic-content/text()") />
                <#assign fieldTemplatePP = docXml.valueOf("//dynamic-element[@name='templatePP']/dynamic-content/text()") />
                <#assign fieldTemplatePDF = docXml.valueOf("//dynamic-element[@name='templatePDF']/dynamic-content/text()") />
                
                <#assign isVisible = "false">
                
                <#if fieldRolCorp == "Todos">
                    <#assign isVisible = "true"/>
                <#elseif allRoles?contains(fieldRolCorp)>
                    <#assign isVisible = "true"/>
                </#if>
                
                <#if isVisible == "true">
                
                <tr>
                 <td>${title}</td>
                 <td>${Fecha_Noticiab}</td>
                 <td>${fieldRolCorp}</td>
                 <td>${fieldDescrTextBox}</td>
                 <td>
                    <#if fieldTemplateWord != "">
                        <a class="btnTable btn-default btn-rounder btn-rounder-tb btn-download-doc" href="${fieldTemplateWord}"> </a>
                    </#if>
                    <#if fieldTemplateExcel != "">
                        <a class="btnTable btn-default btn-rounder btn-rounder-tb btn-download-xls" href="${fieldTemplateExcel}"> </a>
                    </#if>
                    <#if fieldTemplatePP != "">
                        <a class="btnTable btn-default btn-rounder btn-rounder-tb btn-download-ppt" href="${fieldTemplatePP}"> </a>
                    </#if>
                    <#if fieldTemplatePDF != "">
                        <a class="btnTable btn-default btn-rounder btn-rounder-tb btn-download-pdf" href="${fieldTemplatePDF}"> </a>
                    </#if>
                 </td>
                </tr>
                </#if> 

	        </#list>
        </#if>
        </tbody>
    </table>
    </div>
</div>