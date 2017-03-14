<#--
Web content templates are used to lay out the fields defined in a web
content structure.

Please use the left panel to quickly add commonly used variables.
Autocomplete is also available and can be invoked by typing "${".
-->
<#assign tipoNoticia = SelectTipoNoticia.getData()>

<div class="span12 events">
    <#if tipoNoticia == "1">
        <span class="indicador icon-noticia"></span>
    <#elseif tipoNoticia == "2">
        <span class="indicador icon-noticia"></span>
    <#elseif tipoNoticia == "3">
        <span class="indicador icon-documento"></span>
    <#elseif tipoNoticia == "4">
        <span class="indicador icon-event"></span>
    <#elseif tipoNoticia == "5">
        <span class="indicador icon-noticia"></span>
    <#elseif tipoNoticia == "6">
        <span class="indicador icon-event"></span>
    <#elseif tipoNoticia == "7">
        <span class="indicador icon-event"></span>
    <#elseif tipoNoticia == "8">
        <span class="indicador icon-video"></span>
    </#if>
<div class="span5">
<p class="marginTopParrafoTitular"><a href="${PDFNoticia.getData()}">
	${TextTitularNoticia.getData()}
 </a>,<#assign FechaNoticia_Data = getterUtil.getLong(FechaNoticia.getData())>
<#if (FechaNoticia_Data > 0)>
	<#assign FechaNoticia_DateObj = dateUtil.newDate(FechaNoticia_Data)>

	${dateUtil.getDate(FechaNoticia_DateObj, "MMMM yyyy", locale)}
</#if></p>
<p class="marginTopParrafo">${TextBoxNoticia.getData()?substring(0,150)}...<a target="_blank" href="${PDFNoticia.getData()}">
	read more
 </a></p>
</div>
<#if (imagenNoticia.getData() != "")>
    <div class="span6">
        <img alt="Foto" src="${imagenNoticia.getData()}" />
    </div>
</#if>
</div>