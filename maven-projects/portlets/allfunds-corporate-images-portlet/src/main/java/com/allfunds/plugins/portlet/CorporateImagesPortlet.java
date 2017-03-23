package com.allfunds.plugins.portlet;

import com.liferay.portal.kernel.dao.orm.Criterion;
import com.liferay.portal.kernel.dao.orm.DynamicQuery;
import com.liferay.portal.kernel.dao.orm.DynamicQueryFactoryUtil;
import com.liferay.portal.kernel.dao.orm.Junction;
import com.liferay.portal.kernel.dao.orm.OrderFactoryUtil;
import com.liferay.portal.kernel.dao.orm.ProjectionFactoryUtil;
import com.liferay.portal.kernel.dao.orm.PropertyFactoryUtil;
import com.liferay.portal.kernel.dao.orm.RestrictionsFactoryUtil;
import com.liferay.portal.kernel.exception.PortalException;
import com.liferay.portal.kernel.exception.SystemException;
import com.liferay.portal.kernel.json.JSONArray;
import com.liferay.portal.kernel.json.JSONFactoryUtil;
import com.liferay.portal.kernel.json.JSONObject;
import com.liferay.portal.kernel.language.LanguageUtil;
import com.liferay.portal.kernel.util.Constants;
import com.liferay.portal.kernel.util.ListUtil;
import com.liferay.portal.kernel.util.ParamUtil;
import com.liferay.portal.kernel.util.PortalClassLoaderUtil;
import com.liferay.portal.kernel.util.StringUtil;
import com.liferay.portal.kernel.util.WebKeys;
import com.liferay.portal.kernel.workflow.WorkflowConstants;
import com.liferay.portal.service.ClassNameLocalServiceUtil;
import com.liferay.portal.theme.ThemeDisplay;
import com.liferay.portlet.documentlibrary.model.DLFileEntry;
import com.liferay.portlet.documentlibrary.model.DLFileEntryMetadata;
import com.liferay.portlet.documentlibrary.model.DLFileEntryType;
import com.liferay.portlet.documentlibrary.model.DLFileVersion;
import com.liferay.portlet.documentlibrary.service.DLFileEntryLocalServiceUtil;
import com.liferay.portlet.documentlibrary.service.DLFileEntryMetadataLocalServiceUtil;
import com.liferay.portlet.documentlibrary.service.DLFileEntryTypeLocalServiceUtil;
import com.liferay.portlet.documentlibrary.util.RawMetadataProcessor;
import com.liferay.portlet.dynamicdatamapping.model.DDMContent;
import com.liferay.portlet.dynamicdatamapping.model.DDMStructure;
import com.liferay.portlet.dynamicdatamapping.service.DDMStructureLocalServiceUtil;
import com.liferay.portlet.dynamicdatamapping.storage.Fields;
import com.liferay.portlet.dynamicdatamapping.storage.StorageEngineUtil;
import com.liferay.util.bridges.mvc.MVCPortlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.DecimalFormat;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.portlet.PortletException;
import javax.portlet.ResourceRequest;
import javax.portlet.ResourceResponse;

/**
 * Portlet implementation class CorporateImagesPortlet
 */
public class CorporateImagesPortlet extends MVCPortlet {
	@Override
	public void serveResource(ResourceRequest resourceRequest, ResourceResponse resourceResponse) throws IOException, PortletException {
		ThemeDisplay themeDisplay = (ThemeDisplay) resourceRequest.getAttribute(WebKeys.THEME_DISPLAY);
		String action = ParamUtil.get(resourceRequest, Constants.CMD, "");
	    if (action.equals(Constants.READ)) {
	    	Long ddmStructureId = ParamUtil.getLong(resourceRequest, "idStructure", 0);
	    	Integer from = ParamUtil.getInteger(resourceRequest, "from", 0);
		    Integer to = ParamUtil.getInteger(resourceRequest, "to", 0);
		    String[] categories = ParamUtil.getParameterValues(resourceRequest, "categories[]", new String []{});
		    
    		JSONArray jsonArrayImages = JSONFactoryUtil.createJSONArray();
    		JSONObject jsonObjectImage;    
		    try {
		    
			    long groupID = themeDisplay.getScopeGroupId();
			    Locale locale = themeDisplay.getLocale();
			    Boolean loadMore = true;
			    
			    DecimalFormat formatInt = new DecimalFormat ("##");
			    DecimalFormat formater = new DecimalFormat("0.##");
	
			    if(ddmStructureId != 0L){
			    	DLFileEntryType fileEntryType = DLFileEntryTypeLocalServiceUtil.getDDMStructureDLFileEntryTypes(ddmStructureId).get(0);
			    	
			    	
			    	Junction disjunction = RestrictionsFactoryUtil.disjunction();
			    	
			    	if(categories.length > 0){
				    	for (String category : categories) {
				    		StringBuilder categoryFilter = new StringBuilder();
					    	categoryFilter.append("%<dynamic-element%name=%category%>%");
					    	categoryFilter.append("%<dynamic-content%>%");
					    	categoryFilter.append("%<![CDATA[[%"+category+"%]]]>%");
					    	categoryFilter.append("%</dynamic-content>%");
					    	categoryFilter.append("%</dynamic-element>%");
					    	
					    	Criterion categoryfilterDQ = PropertyFactoryUtil.forName("xml").like(categoryFilter.toString());
					    	disjunction.add(categoryfilterDQ);
						}
			    	}else{
			    		StringBuilder categoryFilter = new StringBuilder();
				    	Criterion categoryfilterDQ = PropertyFactoryUtil.forName("xml").like(categoryFilter.toString());
				    	disjunction.add(categoryfilterDQ);
			    	}
			    	
			    	
			    	
			    	DynamicQuery metaDataQuery = DynamicQueryFactoryUtil.forClass(DLFileEntryMetadata.class, PortalClassLoaderUtil.getClassLoader())
			    								.setProjection(ProjectionFactoryUtil.property("DDMStorageId"))
												.add(PropertyFactoryUtil.forName("fileEntryTypeId").eq(fileEntryType.getFileEntryTypeId()));
			    	
			    	DynamicQuery categoryQuery = DynamicQueryFactoryUtil.forClass(DDMContent.class, PortalClassLoaderUtil.getClassLoader())
			    								.setProjection(ProjectionFactoryUtil.property("contentId"))
			    								.add(PropertyFactoryUtil.forName("groupId").eq(groupID))
												.add(PropertyFactoryUtil.forName("contentId").in(metaDataQuery))
												.add(disjunction);
			    	
			    	DynamicQuery metaDataCatQuery = DynamicQueryFactoryUtil.forClass(DLFileEntryMetadata.class, PortalClassLoaderUtil.getClassLoader())
			    								.setProjection(ProjectionFactoryUtil.property("fileVersionId"))
			    								.add(PropertyFactoryUtil.forName("DDMStorageId").in(categoryQuery));
			    	
			    	DynamicQuery versionQuery =  DynamicQueryFactoryUtil.forClass(DLFileVersion.class, PortalClassLoaderUtil.getClassLoader())
			    			.setProjection(ProjectionFactoryUtil.property("fileEntryId"))
			    			.add(PropertyFactoryUtil.forName("fileVersionId").in(metaDataCatQuery))
			    			.add(PropertyFactoryUtil.forName("status").eq(WorkflowConstants.STATUS_APPROVED));
			    	
			    	DynamicQuery queryCount = DynamicQueryFactoryUtil.forClass(DLFileEntry.class, PortalClassLoaderUtil.getClassLoader())
											.add(PropertyFactoryUtil.forName("fileEntryId").in(versionQuery));
			    	
			    	DynamicQuery query = DynamicQueryFactoryUtil.forClass(DLFileEntry.class, PortalClassLoaderUtil.getClassLoader())
			    						.add(PropertyFactoryUtil.forName("fileEntryId").in(versionQuery))
			    						.addOrder(OrderFactoryUtil.desc("title"));
			    	Long total =  DLFileEntryLocalServiceUtil.dynamicQueryCount(queryCount);
			    	
			    	query.setLimit(from, to); 

			    	List<DLFileEntry> entries = (List<DLFileEntry>) DLFileEntryLocalServiceUtil.dynamicQuery(query);

			    	Integer currentPage = to/(to-from) + 1;
			    	if(to >= total){
			    		loadMore = false;
			    	}
			    	
			    	Long rawClassId = ClassNameLocalServiceUtil.getClassNameId(RawMetadataProcessor.class);
			    	List<DDMStructure> rawMetaDataStructure = DDMStructureLocalServiceUtil.getClassStructures(themeDisplay.getCompanyId(), rawClassId);
			    	if(!entries.isEmpty()){
			    		for(DLFileEntry entry: entries){ 
			    			jsonObjectImage = JSONFactoryUtil.createJSONObject();
							DLFileVersion entryFileVersion = entry.getFileVersion();
							Long folderId = entry.getFolderId();
							String fileNameURL = entry.getTitle();
							String imageURL = themeDisplay.getPortalURL() + themeDisplay.getPathContext() + "/documents/" + 
												themeDisplay.getScopeGroupId() + "/" + folderId + "/" + fileNameURL ;
							
							
							String formatsize = "KB";
							float fileSize = entry.getSize() / 1024;
							if(fileSize > 1024){
								formatsize = "MB";
								fileSize = fileSize / 1024;
							}
							
							DLFileEntryMetadata dlFileMetadata = DLFileEntryMetadataLocalServiceUtil
																	.fetchFileEntryMetadata(rawMetaDataStructure.get(0).getStructureId(), 
																							entryFileVersion.getFileVersionId());
							Fields rawFields = StorageEngineUtil.getFields(dlFileMetadata.getDDMStorageId());
							Float imageLength = Float.parseFloat((String) rawFields.get("TIFF_IMAGE_LENGTH").getValue(locale));
							Float imageWidth = Float.parseFloat((String) rawFields.get("TIFF_IMAGE_WIDTH").getValue(locale));
							Float captionHeight = imageWidth / imageLength;
							String resume = "";
							if(captionHeight > 1.8){
								resume = "hidden";
							}
							
							Map<String, Fields> fieldsMap = entry.getFieldsMap(entryFileVersion.getFileVersionId());
							List<Fields> fields =  ListUtil.fromCollection(fieldsMap.values());
							String formatField = (String) fields.get(0).get("size").getValue(locale);
							String formatClass = "";
							
							if(formatField.contains("horizontal")){
								formatClass = "span4";
							}else{
								formatClass = "span2";
							}
//							FileEntry fileEntry = DLAppServiceUtil.getFileEntry(entry.getFileEntryId());
//							FileVersion fileVersion = (FileVersion) fileEntry.getLatestFileVersion();
							
							
//							imageURL = DLUtil.getThumbnailSrc(fileEntry, fileVersion, null, themeDisplay);
							String imageFormat = StringUtil.upperCase(entry.getExtension()) + " " + LanguageUtil.get(locale, "format");
							String imageDimension = LanguageUtil.get(locale, "size") + ": " + formatInt.format(imageWidth) + " x " + formatInt.format(imageLength);
							String imageSize = formater.format(fileSize) + " " + formatsize;
							//Data for view
							jsonObjectImage.put("officeClass", formatClass);
							jsonObjectImage.put("title", entry.getTitle());
							jsonObjectImage.put("description", entry.getDescription());
							jsonObjectImage.put("shortView", resume);
							jsonObjectImage.put("imageFormat", imageFormat);
							jsonObjectImage.put("imageDimension",imageDimension);
							jsonObjectImage.put("imageSize", imageSize);
							jsonObjectImage.put("imageURL", imageURL);
							jsonArrayImages.put(jsonObjectImage);
			    		}
			    	}
			    	
			    	// Escritura de datos
			    	JSONObject jsonObject = JSONFactoryUtil.createJSONObject();
			    	jsonObject.put("images", jsonArrayImages);
			    	jsonObject.put("currentPage", currentPage);
			    	jsonObject.put("loadMore", loadMore);
			    	resourceResponse.setContentType("application/json");
			    	PrintWriter writer = resourceResponse.getWriter();
			    	writer.print(jsonObject.toString());
			    	writer.flush();
			    	writer.close();
			    }
			} catch (PortalException | SystemException e) {
				e.printStackTrace();
			} catch (Exception e) {
				e.printStackTrace();
			}
		    
	    }

		
		
		super.serveResource(resourceRequest, resourceResponse);
	}

	
	
	
}
