<#--
Application display templates can be used to modify the look of a
specific application.

Please use the left panel to quickly add commonly used variables.
Autocomplete is also available and can be invoked by typing "${".
-->

<#assign liferay_ui = taglibLiferayHash["/WEB-INF/tld/liferay-ui.tld"] />
<#assign aui = taglibLiferayHash["/WEB-INF/tld/aui.tld"] />

<div class="panel-accordion" id="accordion">
<div class="table-responsive">
        <table class="table table-hover table-striped">
        <thead>
            <tr>
                <th><@liferay.language key="allfunds.adt.corporate.procedureName" /></th>
                <th><@liferay.language key="allfunds.adt.corporate.description" /></th>
                <th><@liferay.language key="allfunds.adt.corporate.from" /></th>
                <th><@liferay.language key="allfunds.adt.corporate.applyto" /></th>
                <th><@liferay.language key="allfunds.adt.corporate.language" /></th>
                <th><@liferay.language key="allfunds.adt.corporate.download" /></th>
            </tr>
        </thead>
        <tbody>
        <#if entries?has_content>
	        <#list entries as curEntry>
	            <#assign expirationDate = "" />
	            <#assign entry = curEntry />
                <#assign assetRenderer = entry.getAssetRenderer() />
                <#assign assetRendererb = entry.getCategories()/>
                <#assign assetRendererc = entry.getCategoryIds()/>
                <#assign assetTagNames = entry.getTagNames()/>
                <#assign title = entry.getAssetRenderer().getArticle().getTitle(locale)/>
                <#if (entry.getAssetRenderer().getArticle().getExpirationDate())??>
                    <#assign expirationDate = entry.getAssetRenderer().getArticle().getExpirationDate()/>
                    <#assign expirationDate = expirationDate?string["dd/MM/yyyy"]/>
                <#else>
                    <#assign expirationDate = "-"/>
                </#if>
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
                
                <#assign fieldDateCorp = docXml.valueOf("//dynamic-element[@name='startDate']/dynamic-content/text()") />
                <#assign Fecha_Noticia_DateObj = dateUtil.newDate(getterUtil.getLong("${fieldDateCorp}"))>
    	        <#assign Fecha_Noticiab = dateUtil.getDate(Fecha_Noticia_DateObj, "dd/MM/yyyy", locale)>
                <#assign fieldDescrTextBox = docXml.valueOf("//dynamic-element[@name='descriptionProc']/dynamic-content/text()") />
                <#assign fieldTemplatePDF = docXml.valueOf("//dynamic-element[@name='documentProc']/dynamic-content/text()") />
                <#assign fieldSelectLanguage = docXml.valueOf("//dynamic-element[@name='languageSelect']/dynamic-content/text()") />
                
                <tr>
                 <td>${title}</td>
                 <td>${fieldDescrTextBox}</td>
                 <td>${Fecha_Noticiab}</td>
                 <td>${expirationDate}</td>
                 <td class="text-center language">
                 <#if fieldSelectLanguage == "es">
                    <img alt="Language" src="/html/themes/control_panel/images/language/es_ES.png">
                 <#elseif fieldSelectLanguage == "en">
                    <img alt="Language" src="/html/themes/control_panel/images/language/en_GB.png">
                 <#elseif fieldSelectLanguage == "it">
                    <img alt="Language" src="/html/themes/control_panel/images/language/it_IT.png">
                <#elseif fieldSelectLanguage == "por">
                    <img alt="Language" src="/html/themes/control_panel/images/language/pt_PT.png">
                 </#if>
                 </td>
                 <td class="text-center"> <a class="btnTable btn-default btn-rounder btn-rounder-tb btn-download-pdf" href="${fieldTemplatePDF}"> </a> </td>
                </tr>
                
	        </#list>
        </#if>
        </tbody>
    </table>
    </div>
</div>