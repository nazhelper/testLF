<#--
Display templates are used to lay out the fields defined in a data
definition.

Please use the left panel to quickly add commonly used variables.
Autocomplete is also available and can be invoked by typing "${".
-->

<div class="span12">
    <div class="panel panel-default">
        <div class="panel-body pad-full">
            <#if (imageLink.getData())?? && imageLink.getData() != "">
                <img alt="Image" src="${imageLink.getData()}" />
            </#if>
        </div>
        <div class="panel-footer text-center">
            <a href="${linkToPage.getFriendlyUrl()}">
	               ${name.getData()}
            </a>
            <#if (pdfLink)??>
            <a href="${pdfLink.getData()}">
	                ${languageUtil.format(locale, "download-x", "PDF")}
            </a>
            </#if>
        </div>
    </div>
</div>