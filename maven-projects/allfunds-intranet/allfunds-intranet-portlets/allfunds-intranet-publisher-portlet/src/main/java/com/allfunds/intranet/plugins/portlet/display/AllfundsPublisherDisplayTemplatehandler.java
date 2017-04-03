package com.allfunds.intranet.plugins.portlet.display;

import com.liferay.portal.kernel.portletdisplaytemplate.BasePortletDisplayTemplateHandler;
import com.liferay.portal.kernel.template.TemplateVariableGroup;
import com.liferay.portlet.journal.model.JournalArticle;
import com.liferay.portlet.portletdisplaytemplate.util.PortletDisplayTemplateConstants;

import java.util.List;
import java.util.Locale;
import java.util.Map;

public class AllfundsPublisherDisplayTemplatehandler extends
		BasePortletDisplayTemplateHandler {

	@Override
	public String getClassName() {
		return JournalArticle.class.getName();
	}

	@Override
	public String getName(Locale locale) {
		return "Allfunds Publisher Template";
	}

	@Override
	public String getResourceName() {
		return "allfundspublisher_WAR_allfundspublisherportlet";
	}
	
	 public Map<String, TemplateVariableGroup> getTemplateVariableGroups(long classPK, String language, Locale locale) throws Exception {

		 Map<String, TemplateVariableGroup> templateVariableGroups = super.getTemplateVariableGroups(classPK, language, locale);

		 TemplateVariableGroup templateVariableGroup = templateVariableGroups.get("fields");

		 templateVariableGroup.empty();

		 templateVariableGroup.addCollectionVariable("entries", List.class, PortletDisplayTemplateConstants.ENTRIES,
				 									 "entry", JournalArticle.class, "curEntry", "title");
		 
		 return templateVariableGroups;
	}

}
