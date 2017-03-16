<#--
Application display templates can be used to modify the look of a
specific application.

Please use the left panel to quickly add commonly used variables.
Autocomplete is also available and can be invoked by typing "${".
-->

<div class="container-fluid">
<div id="adtNoticias">
<#assign assetEntryService = serviceLocator.findService("com.liferay.portlet.asset.service.AssetEntryLocalService")>

<#assign journalArticleResourceLocal = serviceLocator.findService("com.liferay.portlet.journal.service.JournalArticleResourceLocalService")>

<#assign journalArticleLocal = serviceLocator.findService("com.liferay.portlet.journal.service.JournalArticleLocalService")>

<#assign journalContentUtil = utilLocator.findUtil("com.liferay.portlet.journalcontent.util.JournalContent")>

<#assign languageId = themeDisplay.getLanguageId()>

<#assign groupId = getterUtil.getLong(themeDisplay.getScopeGroupId())>

<#if entries?has_content>
	<#list entries as curEntry>
    
    <#assign journalArticleResource = journalArticleResourceLocal.getJournalArticleResource(curEntry.getClassPK())>
    
    <#assign journalArticle = journalArticleLocal.getArticle(groupId,journalArticleResource.getArticleId())>
    
    <#assign latestArticle= journalArticleLocal.getLatestArticle(groupId,journalArticle.getArticleId())>

    <#assign journalArticleDisplay = journalContentUtil.getDisplay(groupId,latestArticle.getArticleId(), "", languageId , themeDisplay)>
    
    ${journalArticleDisplay.getContent()}
  
</#list>
</#if>
<div class="clearfix">
</div>
</div>
</div>