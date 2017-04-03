package com.allfunds.intranet.plugins.portlet;

import com.liferay.portal.kernel.exception.PortalException;
import com.liferay.portal.kernel.exception.SystemException;
import com.liferay.portal.kernel.json.JSONArray;
import com.liferay.portal.kernel.json.JSONFactoryUtil;
import com.liferay.portal.kernel.json.JSONObject;
import com.liferay.portal.kernel.language.LanguageUtil;
import com.liferay.portal.kernel.search.BooleanClauseOccur;
import com.liferay.portal.kernel.search.BooleanQuery;
import com.liferay.portal.kernel.search.BooleanQueryFactoryUtil;
import com.liferay.portal.kernel.search.Document;
import com.liferay.portal.kernel.search.Hits;
import com.liferay.portal.kernel.search.SearchContext;
import com.liferay.portal.kernel.search.SearchContextFactory;
import com.liferay.portal.kernel.search.SearchEngineUtil;
import com.liferay.portal.kernel.search.Sort;
import com.liferay.portal.kernel.search.TermQuery;
import com.liferay.portal.kernel.search.TermQueryFactoryUtil;
import com.liferay.portal.kernel.util.Constants;
import com.liferay.portal.kernel.util.ListUtil;
import com.liferay.portal.kernel.util.ParamUtil;
import com.liferay.portal.kernel.util.StringUtil;
import com.liferay.portal.kernel.util.Validator;
import com.liferay.portal.kernel.util.WebKeys;
import com.liferay.portal.kernel.workflow.WorkflowConstants;
import com.liferay.portal.service.ClassNameLocalServiceUtil;
import com.liferay.portal.theme.ThemeDisplay;
import com.liferay.portal.util.PortalUtil;
import com.liferay.portlet.documentlibrary.model.DLFileEntry;
import com.liferay.portlet.documentlibrary.model.DLFileEntryMetadata;
import com.liferay.portlet.documentlibrary.model.DLFileEntryType;
import com.liferay.portlet.documentlibrary.model.DLFileVersion;
import com.liferay.portlet.documentlibrary.service.DLFileEntryLocalServiceUtil;
import com.liferay.portlet.documentlibrary.service.DLFileEntryMetadataLocalServiceUtil;
import com.liferay.portlet.documentlibrary.service.DLFileEntryTypeLocalServiceUtil;
import com.liferay.portlet.documentlibrary.util.RawMetadataProcessor;
import com.liferay.portlet.dynamicdatamapping.model.DDMStructure;
import com.liferay.portlet.dynamicdatamapping.service.DDMStructureLocalServiceUtil;
import com.liferay.portlet.dynamicdatamapping.storage.Fields;
import com.liferay.portlet.dynamicdatamapping.storage.StorageEngineUtil;
import com.liferay.util.bridges.mvc.MVCPortlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.portlet.PortletException;
import javax.portlet.ResourceRequest;
import javax.portlet.ResourceResponse;
import javax.servlet.http.HttpServletRequest;

/**
 * Portlet implementation class CorporateImagesPortlet
 */
public class CorporateImagesPortlet extends MVCPortlet {
	@Override
	public void serveResource(ResourceRequest resourceRequest, ResourceResponse resourceResponse) throws IOException, PortletException {
		HttpServletRequest httpServletRequest = PortalUtil.getHttpServletRequest(resourceRequest);
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
			    	
			    	SearchContext searchContext = SearchContextFactory.getInstance(httpServletRequest);
		    		searchContext.setEntryClassNames( new String[] { DLFileEntry.class.getName() } );
		    		BooleanQuery booleanQuery = BooleanQueryFactoryUtil.create(searchContext);
		    		TermQuery groupQuery = TermQueryFactoryUtil.create(searchContext, "scopeGroupId", groupID);
		    		TermQuery classQuery = TermQueryFactoryUtil.create(searchContext, "entryClassName", DLFileEntry.class.getName());
		    		TermQuery statusQuery = TermQueryFactoryUtil.create(searchContext, "status", WorkflowConstants.STATUS_APPROVED);
		    		TermQuery typeQuery = TermQueryFactoryUtil.create(searchContext, "fileEntryTypeId", fileEntryType.getFileEntryTypeId());
		    		BooleanQuery categoriesQuery = BooleanQueryFactoryUtil.create(searchContext);
		    		TermQuery categoryQuery = null;
		    		
		    		booleanQuery.add(groupQuery, BooleanClauseOccur.MUST);
		    		booleanQuery.add(classQuery, BooleanClauseOccur.MUST);
		    		booleanQuery.add(statusQuery, BooleanClauseOccur.MUST);
		    		booleanQuery.add(typeQuery, BooleanClauseOccur.MUST);
		    		
		    		String categoryField = "ddm/" + fileEntryType.getDDMStructures().get(0).getStructureId() +  "/category_" + locale;
		    		
			    		for(String categoryId: categories){
			    			categoryQuery = TermQueryFactoryUtil.create(searchContext, categoryField, categoryId);
			    			categoriesQuery.add(categoryQuery, BooleanClauseOccur.SHOULD);
			    		}
			    		booleanQuery.add(categoriesQuery, BooleanClauseOccur.MUST);
		    		
		    		
		    		Sort[] sorts = new Sort[] {new Sort("localized_title_"+locale+"_sortable", true)};
		    		searchContext.setSorts(sorts);
		    		
		    		SearchContext searchContextCount = searchContext;

		    		searchContext.setStart(from);
		    		searchContext.setEnd(to);
		    		
		    		Integer total = SearchEngineUtil.search(searchContextCount, booleanQuery).getLength();
		    		
		    		Hits hits =  SearchEngineUtil.search(searchContext, booleanQuery);
		    		
		    		List<DLFileEntry> entries = new ArrayList<DLFileEntry>();
		    		for(Document doc: hits.getDocs()){
		    			String uid = doc.get("uid");
		    			Long dlFileEntry = Long.parseLong(StringUtil.extractLast(uid, "20_PORTLET_"));
		    			
		    			if(Validator.isNotNull(dlFileEntry)){
		    				DLFileEntry fileEntry = DLFileEntryLocalServiceUtil.getDLFileEntry(dlFileEntry);
		    				entries.add(fileEntry);
		    			}
		    		}

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
