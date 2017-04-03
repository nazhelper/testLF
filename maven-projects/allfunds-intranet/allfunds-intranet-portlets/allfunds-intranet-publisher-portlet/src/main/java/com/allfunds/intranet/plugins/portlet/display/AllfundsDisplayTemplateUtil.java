package com.allfunds.intranet.plugins.portlet.display;

import com.liferay.portal.kernel.servlet.GenericServletWrapper;
import com.liferay.portal.kernel.servlet.PipingServletResponse;
import com.liferay.portal.kernel.template.TemplateConstants;
import com.liferay.portal.kernel.util.ArrayUtil;
import com.liferay.portal.kernel.util.JavaConstants;
import com.liferay.portal.kernel.util.PropsKeys;
import com.liferay.portal.theme.ThemeDisplay;
import com.liferay.portal.util.PortalUtil;
import com.liferay.portlet.PortletURLUtil;
import com.liferay.portlet.dynamicdatamapping.model.DDMTemplate;
import com.liferay.portlet.dynamicdatamapping.service.DDMTemplateLocalServiceUtil;
import com.liferay.portlet.portletdisplaytemplate.util.PortletDisplayTemplateConstants;
import com.liferay.taglib.util.VelocityTaglib;
import com.liferay.taglib.util.VelocityTaglibImpl;
import com.liferay.util.freemarker.FreeMarkerTaglibFactoryUtil;

import freemarker.ext.servlet.HttpRequestHashModel;
import freemarker.ext.servlet.ServletContextHashModel;
import freemarker.template.ObjectWrapper;
import freemarker.template.TemplateHashModel;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.portlet.PortletPreferences;
import javax.portlet.PortletRequest;
import javax.portlet.PortletResponse;
import javax.portlet.PortletURL;
import javax.portlet.RenderRequest;
import javax.portlet.RenderResponse;
import javax.servlet.GenericServlet;
import javax.servlet.Servlet;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.PageContext;


public class AllfundsDisplayTemplateUtil{
	private static AllfundsTransformer transformer = new AllfundsTransformer(PropsKeys.DYNAMIC_DATA_LISTS_ERROR_TEMPLATE, true);
	
	
	public static String resourceDDMTransform(PageContext pageContext, RenderRequest renderRequest, RenderResponse renderResponse, ThemeDisplay themeDisplay, long portletDisplayDDMTemplateId, List<?> entries) throws Exception {
		Map<String, Object> contextObjects = new HashMap<String, Object>();
		contextObjects.put(PortletDisplayTemplateConstants.TEMPLATE_ID, portletDisplayDDMTemplateId);
		contextObjects.put(PortletDisplayTemplateConstants.ENTRIES, entries);
		
		if (!entries.isEmpty()) {
			contextObjects.put(
				PortletDisplayTemplateConstants.ENTRY, entries.get(0));
		}
		
		HttpServletRequest request = (HttpServletRequest)themeDisplay.getRequest();
		
		PortletRequest portletRequest = (PortletRequest)request.getAttribute(
				JavaConstants.JAVAX_PORTLET_REQUEST);
		
		PortletResponse portletResponse = (PortletResponse)request.getAttribute(
				JavaConstants.JAVAX_PORTLET_RESPONSE);
		
		PortletPreferences portletPreferences = portletRequest.getPreferences();
		
		contextObjects.put(PortletDisplayTemplateConstants.LOCALE, request.getLocale());
		
		contextObjects.put(PortletDisplayTemplateConstants.REQUEST, request);
		
		contextObjects.put(PortletDisplayTemplateConstants.RENDER_REQUEST, renderRequest);		
		
		contextObjects.put(PortletDisplayTemplateConstants.RENDER_RESPONSE, renderResponse);
		
		PortletURL currentURL = PortletURLUtil.getCurrent(PortalUtil.getLiferayPortletRequest(portletRequest), 
														PortalUtil.getLiferayPortletResponse(portletResponse));

		contextObjects.put(PortletDisplayTemplateConstants.CURRENT_URL, currentURL.toString());
		
		contextObjects.put(PortletDisplayTemplateConstants.THEME_DISPLAY, themeDisplay);
		
		DDMTemplate ddmTemplate = DDMTemplateLocalServiceUtil.getTemplate(portletDisplayDDMTemplateId);
			

		Map<String, String[]> map = portletPreferences.getMap();
			
		contextObjects.put(PortletDisplayTemplateConstants.PORTLET_PREFERENCES, map);

		for (Map.Entry<String, String[]> entry : map.entrySet()) {
			String[] values = entry.getValue();

			if (ArrayUtil.isEmpty(values)) {
				continue;
			}

			String value = values[0];

			if (value == null) {
				continue;
			}

			contextObjects.put(entry.getKey(), value);
		}
				
				
		contextObjects.put("class_name_id", ddmTemplate.getClassNameId());
		String language = ddmTemplate.getLanguage();
		
		if (language.equals(TemplateConstants.LANG_TYPE_FTL)) {
			_addTaglibSupportFTL(contextObjects, pageContext);
		}
		else if (language.equals(TemplateConstants.LANG_TYPE_VM)) {
			_addTaglibSupportVM(contextObjects, pageContext);
		}

		
		return  transformer.transform(themeDisplay, contextObjects, ddmTemplate.getScript(), language);
	}

	private static void _addTaglibSupportFTL(Map<String, Object> contextObjects, PageContext pageContext)
		throws Exception {

		// FreeMarker servlet application

		final Servlet servlet = (Servlet)pageContext.getPage();

		GenericServlet genericServlet = null;

		if (servlet instanceof GenericServlet) {
			genericServlet = (GenericServlet)servlet;
		}
		else {
			genericServlet = new GenericServletWrapper(servlet);

			genericServlet.init(pageContext.getServletConfig());
		}

		ServletContextHashModel servletContextHashModel = new ServletContextHashModel(
				genericServlet, ObjectWrapper.DEFAULT_WRAPPER);

		contextObjects.put(PortletDisplayTemplateConstants.FREEMARKER_SERVLET_APPLICATION,
			servletContextHashModel);

		// FreeMarker servlet request

		HttpServletRequest request = (HttpServletRequest)pageContext.getRequest();
		HttpServletResponse response = (HttpServletResponse)pageContext.getResponse();

		HttpRequestHashModel requestHashModel = new HttpRequestHashModel(
			request, response, ObjectWrapper.DEFAULT_WRAPPER);

		contextObjects.put(PortletDisplayTemplateConstants.FREEMARKER_SERVLET_REQUEST,
							requestHashModel);

		// Taglib Liferay hash

		TemplateHashModel taglibLiferayHash =
			FreeMarkerTaglibFactoryUtil.createTaglibFactory(
				pageContext.getServletContext());

		contextObjects.put(PortletDisplayTemplateConstants.TAGLIB_LIFERAY_HASH,
							taglibLiferayHash);
	}
	private static void _addTaglibSupportVM(Map<String, Object> contextObjects, PageContext pageContext) {

		contextObjects.put(PortletDisplayTemplateConstants.TAGLIB_LIFERAY,
				_getVelocityTaglib(pageContext));
	}
	
	private static VelocityTaglib _getVelocityTaglib(PageContext pageContext) {
		HttpServletRequest request = (HttpServletRequest)pageContext.getRequest();

		HttpSession session = request.getSession();

		ServletContext servletContext = session.getServletContext();

		HttpServletResponse response =
			(HttpServletResponse)pageContext.getResponse();

		VelocityTaglib velocityTaglib = new VelocityTaglibImpl(
			servletContext, request,
			new PipingServletResponse(response, pageContext.getOut()),
			pageContext, null);

		return velocityTaglib;
	}
}
