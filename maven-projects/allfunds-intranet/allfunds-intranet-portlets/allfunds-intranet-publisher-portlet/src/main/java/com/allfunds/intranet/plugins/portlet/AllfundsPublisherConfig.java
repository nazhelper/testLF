package com.allfunds.intranet.plugins.portlet;

import com.liferay.portal.kernel.portlet.DefaultConfigurationAction;
import com.liferay.portal.kernel.util.ParamUtil;
import com.liferay.portal.kernel.util.StringPool;
import com.liferay.portal.kernel.util.Validator;
import com.liferay.portal.kernel.util.WebKeys;
import com.liferay.portal.theme.ThemeDisplay;
import com.liferay.portlet.asset.model.AssetVocabulary;
import com.liferay.portlet.asset.service.AssetVocabularyLocalServiceUtil;

import java.util.List;

import javax.portlet.ActionRequest;
import javax.portlet.ActionResponse;
import javax.portlet.PortletConfig;
import javax.portlet.PortletPreferences;

public class AllfundsPublisherConfig extends DefaultConfigurationAction  {

	
	@Override
	public void processAction(PortletConfig portletConfig, ActionRequest actionRequest, ActionResponse actionResponse) throws Exception{
		ThemeDisplay themeDisplay = (ThemeDisplay) actionRequest.getAttribute(WebKeys.THEME_DISPLAY);
		PortletPreferences prefs = actionRequest.getPreferences();
		long groupId = themeDisplay.getScopeGroupId();
		String categories = "";
		String categoriesbyId = "";
	    List<AssetVocabulary> vocabularies = AssetVocabularyLocalServiceUtil.getGroupVocabularies(groupId, false);
	    for(AssetVocabulary vocabulary: vocabularies){
	    	String vocabularyId = String.valueOf(vocabulary.getVocabularyId());
	    	String paramName = "assetCategoryIds_" + vocabularyId;
	    	categoriesbyId = ParamUtil.get(actionRequest, paramName, "");
	    	if(Validator.isBlank(categories)){
	    		categories = categoriesbyId;
	    	}else if(!Validator.isBlank(categoriesbyId)){
	    		categories = categories + StringPool.COMMA + categoriesbyId;
	    	}
	    }
	    
	    prefs.setValue("categories", categories);
	    prefs.store();
	    
	    super.processAction(portletConfig, actionRequest, actionResponse);
	}
}
