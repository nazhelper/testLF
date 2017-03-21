<#--
Display templates are used to lay out the fields defined in a data
definition.

Please use the left panel to quickly add commonly used variables.
Autocomplete is also available and can be invoked by typing "${".
-->

<div class="">
    <div class="panel panel-default">
        <div class="panel-body pad-full">
            <#if (imageLink.getData())?? && imageLink.getData() != "">
                <img alt="Image" src="${imageLink.getData()}" />
            </#if>
        </div>
        <div class="panel-footer text-center">
            <#if (pdfLink)??>
                <a href="${pdfLink.getData()}" target="_blank;">
                    ${name.getData()}
                </a>
            <#else>
                <a>
    	            ${name.getData()}
                </a>
            </#if>
        </div>
    </div>
</div>