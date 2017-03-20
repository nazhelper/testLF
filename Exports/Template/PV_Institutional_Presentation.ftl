<#--
Web content templates are used to lay out the fields defined in a web
content structure.

Please use the left panel to quickly add commonly used variables.
Autocomplete is also available and can be invoked by typing "${".
-->

<#assign counter = 0 >
<#list "${pdfPresentation.getData()}"?split("/") as x>
<#if counter == 2>
<#assign groupId = x?number >
</#if>
<#if counter == 5>
<#assign uuId = x >
</#if>
<#assign counter = counter+1 >
</#list>

<#assign fileEntry = staticUtil["com.liferay.portlet.documentlibrary.service.DLFileEntryLocalServiceUtil"]>
<#assign file = fileEntry.getFileEntryByUuidAndGroupId(uuId,groupId) >

<#assign fileSize = file.getSize()?string>
<#assign fileSizeb = fileSize?substring(0,3)>




<div class="span3">
    <div class="panel panel-default clearfix">
        <div class="panel-body">
             <h4>${.vars['reserved-article-title'].data}</h4>
            <p class="pad-bottom"><@liferay.language key="allfunds.template.institutional" /><#assign datePresentation_Data = getterUtil.getLong(datePresentation.getData())>
            <#if (datePresentation_Data > 0)>
	            <#assign datePresentation_DateObj = dateUtil.newDate(datePresentation_Data)>
                ${dateUtil.getDate(datePresentation_DateObj, "MMMM yyyy", locale)}
            </#if>
            </p>
            <p class="pad-bottom"><@liferay.language key="allfunds.template.institutional.language" />
                <#if languageSelect.getData() == "es">
                        <img alt="Language" src="http://localhost:8080/html/themes/control_panel/images/language/es_ES.png">
                     <#elseif languageSelect.getData() == "en">
                        <img alt="Language" src="http://localhost:8080/html/themes/control_panel/images/language/en_GB.png">
                    <#elseif languageSelect.getData() == "it">
                        <img alt="Language" src="http://localhost:8080/html/themes/control_panel/images/language/it_IT.png">
                    <#elseif languageSelect.getData() == "por">
                        <img alt="Language" src="http://localhost:8080/html/themes/control_panel/images/language/pt_PT.png">
                </#if>
            </p>
        </div>
        <div class="clearfix">
            <form method="get" class="noMarginForm" action="${pdfPresentation.getData()}" target="_blank">
                <button class="btn btn-default btn-block btn-recto"><@liferay.language key="allfunds.template.institutional.download" /><span class="icon icon-download-pdf"> </span>${fileSizeb}<@liferay.language key="allfunds.template.institutional.kb" /></button>
            </form>
        </div>
    </div>
</div>