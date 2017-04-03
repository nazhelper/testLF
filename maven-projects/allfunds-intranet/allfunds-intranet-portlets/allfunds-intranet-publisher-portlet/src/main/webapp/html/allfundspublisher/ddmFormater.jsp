<%@page import="com.liferay.portal.util.PortalUtil"%>
<%@page import="com.liferay.portal.kernel.util.PropsKeys"%>
<%@page import="com.liferay.portal.kernel.util.ArrayUtil"%>
<%@page import="com.liferay.portlet.dynamicdatamapping.service.DDMTemplateLocalServiceUtil"%>
<%@page import="com.liferay.portlet.dynamicdatamapping.model.DDMTemplate"%>
<%@page import="com.liferay.portlet.PortletURLUtil"%>
<%@page import="javax.portlet.PortletURL"%>
<%@page import="javax.portlet.PortletRequest"%>
<%@page import="com.liferay.portlet.portletdisplaytemplate.util.PortletDisplayTemplateConstants"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.allfunds.intranet.plugins.portlet.display.AllfundsDisplayTemplateUtil"%>
<%@page import="com.liferay.portal.kernel.util.JavaConstants"%>
<%@page import="com.liferay.portlet.portletdisplaytemplate.util.PortletDisplayTemplateUtil"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="com.liferay.portlet.journal.service.JournalArticleLocalServiceUtil"%>
<%@page import="com.liferay.portlet.journal.model.JournalArticle"%>
<%@page import="com.liferay.portal.kernel.json.JSONObject"%>
<%@page import="com.liferay.portal.kernel.json.JSONArray"%>
<%@page import="com.liferay.portal.kernel.json.JSONFactoryUtil"%>
<%@ include file="init.jsp" %>

<% 
	List<JournalArticle> entries = new ArrayList<JournalArticle>();
	String articles = request.getParameter("articles");
	JSONArray jsonArticles = JSONFactoryUtil.createJSONArray(articles);
	for (int i = 0; i < jsonArticles.length(); i++) {
	    JSONObject jsonArticle = jsonArticles.getJSONObject(i);
		String articleId = jsonArticle.getString("articleId");
		double version = jsonArticle.getDouble("version");
		
		JournalArticle article = JournalArticleLocalServiceUtil.getArticle(scopeGroupId, articleId, version);
		entries.add(article);		
	}
		String result = AllfundsDisplayTemplateUtil.resourceDDMTransform(pageContext, renderRequest, renderResponse, themeDisplay, portletDisplayDDMTemplateId, entries);
%>
<%=result %>