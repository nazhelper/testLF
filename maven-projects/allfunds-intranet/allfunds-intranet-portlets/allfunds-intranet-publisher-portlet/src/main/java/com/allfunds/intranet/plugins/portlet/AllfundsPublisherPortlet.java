package com.allfunds.intranet.plugins.portlet;

import com.liferay.portal.kernel.exception.PortalException;
import com.liferay.portal.kernel.exception.SystemException;
import com.liferay.portal.kernel.json.JSONArray;
import com.liferay.portal.kernel.json.JSONFactoryUtil;
import com.liferay.portal.kernel.json.JSONObject;
import com.liferay.portal.kernel.search.BooleanClauseOccur;
import com.liferay.portal.kernel.search.BooleanQuery;
import com.liferay.portal.kernel.search.BooleanQueryFactoryUtil;
import com.liferay.portal.kernel.search.Document;
import com.liferay.portal.kernel.search.Field;
import com.liferay.portal.kernel.search.Hits;
import com.liferay.portal.kernel.search.SearchContext;
import com.liferay.portal.kernel.search.SearchContextFactory;
import com.liferay.portal.kernel.search.SearchEngineUtil;
import com.liferay.portal.kernel.search.SearchException;
import com.liferay.portal.kernel.search.Sort;
import com.liferay.portal.kernel.search.TermQuery;
import com.liferay.portal.kernel.search.TermQueryFactoryUtil;
import com.liferay.portal.kernel.util.Constants;
import com.liferay.portal.kernel.util.ParamUtil;
import com.liferay.portal.kernel.util.Validator;
import com.liferay.portal.kernel.util.WebKeys;
import com.liferay.portal.theme.ThemeDisplay;
import com.liferay.portal.util.PortalUtil;
import com.liferay.portlet.dynamicdatamapping.model.DDMStructure;
import com.liferay.portlet.dynamicdatamapping.service.DDMStructureLocalServiceUtil;
import com.liferay.portlet.journal.model.JournalArticle;
import com.liferay.util.bridges.mvc.MVCPortlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.portlet.PortletException;
import javax.portlet.PortletRequestDispatcher;
import javax.portlet.ResourceRequest;
import javax.portlet.ResourceResponse;
import javax.servlet.http.HttpServletRequest;

/**
 * Portlet implementation class AllfundsPublisherPortlet
 */
public class AllfundsPublisherPortlet extends MVCPortlet {
 
	@Override
	public void serveResource(ResourceRequest resourceRequest, ResourceResponse resourceResponse) throws IOException, PortletException {
		HttpServletRequest httpServletRequest = PortalUtil.getHttpServletRequest(resourceRequest);
		ThemeDisplay themeDisplay = (ThemeDisplay) resourceRequest.getAttribute(WebKeys.THEME_DISPLAY);
		
		String action = ParamUtil.get(resourceRequest, Constants.CMD, "");
		long groupId = themeDisplay.getScopeGroupId();
		
		if (action.equals(Constants.READ)) {
	    	
	    	String ddmStructureId = ParamUtil.getString(resourceRequest, "idStructure", "");
	    	String categoriesIds = ParamUtil.getString(resourceRequest, "categories", "");
	    	String[] ddmStructureList = ddmStructureId.split(",");
	    	String[] categories = categoriesIds.split(",");
	    	Integer from = ParamUtil.getInteger(resourceRequest, "from", -1);
		    Integer to = ParamUtil.getInteger(resourceRequest, "to", -1);
		    Boolean loadMore = true;
		    
		    JSONArray jsonData = JSONFactoryUtil.createJSONArray();
    		JSONObject jsonObjectArticle;  
		    
		    try {
		    	if(ddmStructureList.length > 0 && to > 0 ){
		    		SearchContext searchContext = SearchContextFactory.getInstance(httpServletRequest);
		    		searchContext.setEntryClassNames( new String[] { JournalArticle.class.getName() } );
		    		BooleanQuery booleanQuery = BooleanQueryFactoryUtil.create(searchContext);
		    		BooleanQuery categoriesQuery = BooleanQueryFactoryUtil.create(searchContext);
		    		BooleanQuery typesQuery = BooleanQueryFactoryUtil.create(searchContext);
		    		TermQuery typeQuery = null;
		    		TermQuery categoryQuery = null;
		    		TermQuery groupQuery = TermQueryFactoryUtil.create(searchContext, "scopeGroupId", groupId);
		    		TermQuery classQuery = TermQueryFactoryUtil.create(searchContext, "entryClassName", JournalArticle.class.getName());
		    		TermQuery headQuery = TermQueryFactoryUtil.create(searchContext, "head", Boolean.TRUE.toString());
		    		
		    		booleanQuery.add(groupQuery, BooleanClauseOccur.MUST);
		    		booleanQuery.add(classQuery, BooleanClauseOccur.MUST);
		    		booleanQuery.add(headQuery, BooleanClauseOccur.MUST);

		    		for(String structureId: ddmStructureList){
		    			DDMStructure structure = DDMStructureLocalServiceUtil.getDDMStructure(Long.parseLong(structureId));
		    			typeQuery = TermQueryFactoryUtil.create(searchContext, "ddmStructureKey", structure.getStructureKey());
		    			typesQuery.add(typeQuery, BooleanClauseOccur.SHOULD);
		    		}
		    		booleanQuery.add(typesQuery, BooleanClauseOccur.MUST);
		    		
		    		if(!Validator.isBlank(categoriesIds)){
			    		for(String categoryId: categories){
			    			categoryQuery = TermQueryFactoryUtil.create(searchContext, "assetCategoryIds", categoryId);
			    			categoriesQuery.add(categoryQuery, BooleanClauseOccur.SHOULD);
			    		}
			    		booleanQuery.add(categoriesQuery, BooleanClauseOccur.MUST);
		    		
		    		}
		    		Sort[] sorts = new Sort[] {new Sort(Field.PUBLISH_DATE, true)};
		    		searchContext.setSorts(sorts);
		    		SearchContext searchContextCount = searchContext;

		    		searchContext.setStart(from);
		    		searchContext.setEnd(to);
		    		
		    		
		    		Integer total = SearchEngineUtil.search(searchContextCount, booleanQuery).getLength();
		    		
			    	Integer currentPage = to/(to-from) + 1;
			    	if(to >= total){
			    		loadMore = false;
			    	}
		    		
		    		Hits hits =  SearchEngineUtil.search(searchContext, booleanQuery);
		    		
		    		for(Document doc: hits.getDocs()){
		    			String articleId = doc.get("articleId");
		    			Double version = Double.parseDouble(doc.get("version"));
		    			
		    			jsonObjectArticle = JSONFactoryUtil.createJSONObject();
		    			
		    			jsonObjectArticle.put("articleId", articleId);
		    			jsonObjectArticle.put("version", version);
		    			jsonData.put(jsonObjectArticle);
		    		}
		    		
			    	// Escritura de datos
			    	JSONObject jsonObject = JSONFactoryUtil.createJSONObject();
			    	jsonObject.put("articles", jsonData.toString());
			    	jsonObject.put("currentPage", currentPage);
			    	jsonObject.put("loadMore", loadMore);
			    	resourceResponse.setContentType("application/json");
			    	PrintWriter writer = resourceResponse.getWriter();
			    	writer.print(jsonObject.toString());
			    	writer.flush();
			    	writer.close();
		    	}
	    	}
	    	catch (SearchException se) {
	    	    // handle search exception
	    	} catch (PortalException e) {
				e.printStackTrace();
			} catch (SystemException e) {
				e.printStackTrace();
			} catch (Exception e) {
				e.printStackTrace();
			}	    	
	    }else if(action.equals("JSP")){
	    	PortletRequestDispatcher dispatcher = resourceRequest.getPortletSession().getPortletContext().getRequestDispatcher("/html/allfundspublisher/ddmFormater.jsp");

	    	dispatcher.include(resourceRequest, resourceResponse);
	    }
	}
}
