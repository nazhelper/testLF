<#assign dlFileEntryService = serviceLocator.findService("com.liferay.portlet.documentlibrary.service.DLFileEntryLocalService") />
<#assign ddmStructureUtil = serviceLocator.findService("com.liferay.portlet.dynamicdatamapping.service.DDMStructureLocalService")/>
<#assign classNameUtil = serviceLocator.findService("com.liferay.portal.service.ClassNameLocalService")/>
<#assign dlFileEntryMetadataService = serviceLocator.findService("com.liferay.portlet.documentlibrary.service.DLFileEntryMetadataLocalService") />
<#assign rawClassName = "com.liferay.portlet.documentlibrary.util.RawMetadataProcessor" />
<#assign rawClassId = classNameUtil.getClassNameId(rawClassName) />
<#assign storageEngineUtil = staticUtil["com.liferay.portlet.dynamicdatamapping.storage.StorageEngineUtil"] />
<#assign rawMetaDataStructure = ddmStructureUtil.getClassStructures(companyId, rawClassId) />


<div class="panel panel-default panel-clear-top">
<div class="panel-body">
<#if entries?has_content>
	<#list entries as entry>
        <#assign classPk = entry.getClassPK() />
        <#assign fileEntry = dlFileEntryService.getDLFileEntry(classPk)/>
        <#assign dlFileVersion = fileEntry.getFileVersion() />
        
        <#assign dlFileMetadata = dlFileEntryMetadataService.fetchFileEntryMetadata(rawMetaDataStructure[0].getStructureId(), dlFileVersion.getFileVersionId()) />
        <#assign rawFields = storageEngineUtil.getFields(dlFileMetadata.getDDMStorageId()) />
        <#assign imageLength = rawFields.get("TIFF_IMAGE_LENGTH").getValue(locale) />
        <#assign imageWidth = rawFields.get("TIFF_IMAGE_WIDTH").getValue(locale) />
        
        <#assign fieldsMap = fileEntry.getFieldsMap(dlFileVersion.getFileVersionId()) />
        <#assign fields = fieldsMap?values />
        <#assign formatField = fields[0].get("size").getValue(locale) />
        <#assign formatClass = "" />
        <#if formatField == '["horizontal"]'>
            <#assign formatClass = "span4" />
        <#else>
            <#assign formatClass = "span2" />
        </#if>
        
        <#assign folderId = fileEntry.getFolderId()/>
        <#assign fileNameUrl = entry.getTitle(locale) />
        <#assign imageURL = themeDisplay.getPortalURL() + themeDisplay.getPathContext() + "/documents/" + 
themeDisplay.getScopeGroupId() + "/" + folderId + "/" + fileNameUrl/>

        <#assign formatsize = "KB" />
        <#assign fileSize = fileEntry.getSize()/1024 />
        <#if fileSize gt 1024 >
            <#assign formatsize = "MB" />
            <#assign fileSize = fileSize/1024 />
        </#if>
        <#assign captionHeight = imageWidth?eval / imageLength?eval />
        <#assign resume = "" />
        <#if captionHeight gt 1.8> 
            <#assign resume = "hidden" />
        </#if>
        
        
	    <div class="img-offices ${formatClass}">
	        <div class="thumbnail">
	            <div class="caption" style="display: none;">
                        <h4>${entry.getTitle(locale)}</h4>
                        <p>${entry.getDescription()}</p>
                        <div class="divider"></div>
                        
                        <p class="${resume}">${stringUtil.upperCase(fileEntry.getExtension())} <@liferay.language key="format" /></p>
                        <p class="${resume}"><@liferay.language key="size" />: ${imageWidth} x ${imageLength}</p>
                        <p class="${resume}">${fileSize?string["0.##"]} ${formatsize}</p>
                        <p><a href="${imageURL}" target="_blank;" class="label label-danger" rel="tooltip" title="" data-original-title="<@liferay.language key="download" />">
                            <span class="glyphicon glyphicon-save"> </span> <@liferay.language key="download" /> </a>
                        </p>
                </div>
                <img src="${imageURL}"/>
		    </div>
	    </div>
	</#list>
</#if>
<div class="clearfix"> </div>
</div>
</div>