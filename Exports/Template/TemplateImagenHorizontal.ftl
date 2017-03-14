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

<div class="span12 events">
<#if (imagenNoticia.getData() != "")>
   <p> <img id="myImg" src="${imagenNoticia.getData()}" alt="Ejemplo" > </p>
</#if>
<div class="noMarginLeftNoticia span1">
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
    </#if>
</div>    
<div class="span10 noticiaMargenIzquierda">    
    <p class="marginTopParrafoTitular2"><a href="${PDFNoticia.getData()}">
	${TextTitularNoticia.getData()}
 </a>,<#assign FechaNoticia_Data = getterUtil.getLong(FechaNoticia.getData())>
<#if (FechaNoticia_Data > 0)>
	<#assign FechaNoticia_DateObj = dateUtil.newDate(FechaNoticia_Data)>

	${dateUtil.getDate(FechaNoticia_DateObj, "MMMM yyyy", locale)}
</#if>
</p>
<p class="marginTopParrafoHorizontal">${TextBoxNoticia.getData()?substring(0,150)}...<a target="_blank" href="${PDFNoticia.getData()}">
	read more
 </a></p>
</div>
</div>

<div id="myModal" class="modalImagen">

  <!-- The Close Button -->
  <span class="close" onclick="document.getElementById('myModal').style.display='none'">&times;</span>

  <!-- Modal Content (The Image) -->
  <img class="modal-contentImage" id="img01">

  <!-- Modal Caption (Image Text) -->
  <div id="caption"></div>
</div>