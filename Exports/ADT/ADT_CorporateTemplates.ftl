<#--
Application display templates can be used to modify the look of a
specific application.

Please use the left panel to quickly add commonly used variables.
Autocomplete is also available and can be invoked by typing "${".
-->

<#assign assetEntryService = serviceLocator.findService("com.liferay.portlet.asset.service.AssetEntryLocalService")>

<#assign journalArticleResourceLocal = serviceLocator.findService("com.liferay.portlet.journal.service.JournalArticleResourceLocalService")>

<#assign journalArticleLocal = serviceLocator.findService("com.liferay.portlet.journal.service.JournalArticleLocalService")>

<#assign journalContentUtil = utilLocator.findUtil("com.liferay.portlet.journalcontent.util.JournalContent")>

<#assign languageId = themeDisplay.getLanguageId()>

<#assign groupId = getterUtil.getLong(themeDisplay.getScopeGroupId())>

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
		            <#assign journalArticleResource = journalArticleResourceLocal.getJournalArticleResource(curEntry.getClassPK())>
                    <#assign journalArticle = journalArticleLocal.getArticle(groupId,journalArticleResource.getArticleId())>
                    <#assign latestArticle= journalArticleLocal.getLatestArticle(groupId,journalArticle.getArticleId())>
                    <#assign journalArticleDisplay = journalContentUtil.getDisplay(groupId,latestArticle.getArticleId(), "", languageId , themeDisplay)>
                    ${journalArticleDisplay.getContent()}
	            </#list>
            </#if>
        </tbody>
    </table>
    </div>
</div>