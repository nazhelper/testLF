<#--
Application display templates can be used to modify the look of a
specific application.

Please use the left panel to quickly add commonly used variables.
Autocomplete is also available and can be invoked by typing "${".
-->

<#assign liferay_ui = taglibLiferayHash["/WEB-INF/tld/liferay-ui.tld"] />
<#assign aui = taglibLiferayHash["/WEB-INF/tld/aui.tld"] />

<div id="carousel-example-generic" class="carousel slide carousel-fade" data-ride="carousel"> 
          <#if entries?has_content>
            <ol class="carousel-indicators topBanner">
	            <#list entries as curEntryOl>
	                <#if curEntryOl_index == 0>
                        <li data-target="#carousel-example-generic" data-slide-to="${curEntryOl_index}" class="active"></li>
                    <#else>
                        <li data-target="#carousel-example-generic" data-slide-to="${curEntryOl_index}" class=""></li>
                    </#if>
                </#list>
            </ol>
          </#if>
          
          <div class="carousel-inner" role="listbox">
          <#if entries?has_content>
	        <#list entries as curEntry>
	            <#assign entry = curEntry />
    	        <#assign assetRenderer = entry.getAssetRenderer() />
    	        <#assign assetRendererb = entry.getCategories()/>
    	        <#assign assetRendererc = entry.getCategoryIds()/>
    	        <#assign assetTagNames = entry.getTagNames()/>
    	        <#assign docXml = saxReaderUtil.read(entry.getAssetRenderer().getArticle().getContentByLocale(locale)) />
    	        <#assign assetRenderere = entry.getDescriptionMap()/>
    	        <#assign viewURL = assetPublisherHelper.getAssetViewURL(renderRequest, renderResponse, entry) />
    	        <#if assetLinkBehavior != "showFullContent">
    		        <#assign viewURL = assetRenderer.getURLViewInContext(renderRequest, renderResponse, viewURL) />
    	        </#if>
	            <#assign fieldVal = docXml.valueOf("//dynamic-element[@name='archivoImagen']/dynamic-content/text()") /> 
	        
	            <#if curEntry_index == 0>
	                <div class="item active">
	            <#else>
                     <div class="item">
		        </#if>
		            <img src="${fieldVal}" alt="${curEntry.getTitle(locale)}"/>
		        </div>
	        </#list>
          </#if>
          </div>
        
          <!-- Controls --> 
          
          <a class="leftBannerTop carousel-controlBannerTop" href="#carousel-example-generic" role="button" data-slide="prev"> 
            <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span> 
            <span class="sr-only"><@liferay.language key="allfunds.template.previous" /></span> 
          </a> 
          
          <a class="rightBannerTop carousel-controlBannerTop" href="#carousel-example-generic" role="button" data-slide="next"> 
            <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span> 
            <span class="sr-only"><@liferay.language key="allfunds.template.next" /></span> 
          </a> 
</div>