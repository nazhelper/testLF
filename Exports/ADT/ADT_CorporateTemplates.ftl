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
                <th><@liferay.language key="allfunds.adt.corporate.templates" /></th>
            <tr>
        </thead>
        <tbody>
        <#if entries?has_content>
	        <#list entries as curEntry>
	            <#assign fileExtension = "">
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
                <#assign fieldTempDocum = docXml.valueOf("//dynamic-element[@name='tempDocum']/dynamic-content/text()") />
                
                <#if (fieldTempDocum)?? || fieldTempDocum != "">
                <#assign counter = 0 >
                <#list fieldTempDocum?split("/") as x>
                <#if counter == 2>
                    <#assign groupId = x?number >
                </#if>
                <#if counter == 5>
                    <#assign uuId = x >
                </#if>
                    <#assign counter = counter+1 >
                </#list>
                </#if>

                
                <#assign fileEntry = staticUtil["com.liferay.portlet.documentlibrary.service.DLFileEntryLocalServiceUtil"]>
                
                <#if (uuId)??>
                    <#assign file = fileEntry.getFileEntryByUuidAndGroupId(uuId,groupId) >
                    <#assign fileExtension = file.getExtension()?string>
                </#if>
                
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
                 <td>
                    <#if fileExtension?contains("doc")>
                        <a class="btnTable btn-default btn-rounder btn-rounder-tb btn-download-doc" href="${fileExtension}"> </a>
                    </#if>
                    <#if fileExtension?contains("xl")>
                        <a class="btnTable btn-default btn-rounder btn-rounder-tb btn-download-xls" href="${fileExtension}"> </a>
                    </#if>
                    <#if fileExtension?contains("pp")>
                        <a class="btnTable btn-default btn-rounder btn-rounder-tb btn-download-ppt" href="${fileExtension}"> </a>
                    </#if>
                    <#if fileExtension?contains("pdf")>
                        <a class="btnTable btn-default btn-rounder btn-rounder-tb btn-download-pdf" href="${fileExtension}"> </a>
                    </#if>
                 </td>
                </tr>
                </#if> 


                <#assign fieldTempDocum = "">
	        </#list>
        </#if>
            
        </tbody>
    </table>
    </div>
</div>