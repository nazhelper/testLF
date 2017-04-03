package com.allfunds.intranet.plugins.portlet.display;

import com.liferay.portal.kernel.configuration.Filter;
import com.liferay.portal.kernel.io.unsync.UnsyncStringWriter;
import com.liferay.portal.kernel.mobile.device.Device;
import com.liferay.portal.kernel.mobile.device.UnknownDevice;
import com.liferay.portal.kernel.template.StringTemplateResource;
import com.liferay.portal.kernel.template.Template;
import com.liferay.portal.kernel.template.TemplateConstants;
import com.liferay.portal.kernel.template.TemplateManagerUtil;
import com.liferay.portal.kernel.template.TemplateResource;
import com.liferay.portal.kernel.template.URLTemplateResource;
import com.liferay.portal.kernel.templateparser.TransformException;
import com.liferay.portal.kernel.util.GetterUtil;
import com.liferay.portal.kernel.util.PropsUtil;
import com.liferay.portal.kernel.util.StringBundler;
import com.liferay.portal.kernel.util.StringPool;
import com.liferay.portal.kernel.util.StringUtil;
import com.liferay.portal.kernel.util.Validator;
import com.liferay.portal.model.Company;
import com.liferay.portal.security.permission.PermissionThreadLocal;
import com.liferay.portal.service.CompanyLocalServiceUtil;
import com.liferay.portal.theme.ThemeDisplay;
import com.liferay.portlet.portletdisplaytemplate.util.PortletDisplayTemplateConstants;
import com.liferay.taglib.util.VelocityTaglib;

import java.net.URL;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;

public class AllfundsTransformer {
	private Map<String, String> _errorTemplateIds = new HashMap<String, String>();
	
	private boolean _restricted;

	public AllfundsTransformer(String errorTemplatePropertyKey, boolean restricted) {
		Set<String> langTypes = TemplateManagerUtil.getSupportedLanguageTypes(
			errorTemplatePropertyKey);

		for (String langType : langTypes) {
			String errorTemplateId = PropsUtil.get(
				errorTemplatePropertyKey, new Filter(langType));

			if (Validator.isNotNull(errorTemplateId)) {
				_errorTemplateIds.put(langType, errorTemplateId);
			}
		}

		_restricted = restricted;
	}

	public AllfundsTransformer(String transformerListenerPropertyKey, String errorTemplatePropertyKey, boolean restricted) {

		this(errorTemplatePropertyKey, restricted);

	}
	
	protected TemplateResource getErrorTemplateResource(String langType) {
		try {
			Class<?> clazz = getClass();

			ClassLoader classLoader = clazz.getClassLoader();

			String errorTemplateId = _errorTemplateIds.get(langType);

			URL url = classLoader.getResource(errorTemplateId);

			return new URLTemplateResource(errorTemplateId, url);
		}
		catch (Exception e) {
		}

		return null;
	}
	
	protected String getTemplateId(String templateId, long companyId, long companyGroupId, long groupId) {

			StringBundler sb = new StringBundler(5);

			sb.append(companyId);
			sb.append(StringPool.POUND);

			if (companyGroupId > 0) {
				sb.append(companyGroupId);
			}
			else {
				sb.append(groupId);
			}

			sb.append(StringPool.POUND);
			sb.append(templateId);

			return sb.toString();
		}

	protected Template getTemplate(String templateId, String script, String langType)
		throws Exception {

		TemplateResource templateResource = new StringTemplateResource(templateId, script);

		TemplateResource errorTemplateResource = getErrorTemplateResource(langType);

		return TemplateManagerUtil.getTemplate(langType, templateResource, errorTemplateResource, _restricted);
	}
	
	protected void prepareTemplate(ThemeDisplay themeDisplay, Template template)
			throws Exception {

			if (themeDisplay == null) {
				return;
			}

			template.prepare(themeDisplay.getRequest());
		}
	protected void mergeTemplate(
			Template template, UnsyncStringWriter unsyncStringWriter)
		throws Exception {

		VelocityTaglib velocityTaglib = (VelocityTaglib)template.get(
			PortletDisplayTemplateConstants.TAGLIB_LIFERAY);

		if (velocityTaglib != null) {
			velocityTaglib.setTemplate(template);
		}

		template.processTemplate(unsyncStringWriter);
	}	
	protected Company getCompany(ThemeDisplay themeDisplay, long companyId)
			throws Exception {

			if (themeDisplay != null) {
				return themeDisplay.getCompany();
			}

			return CompanyLocalServiceUtil.getCompany(companyId);
		}
	protected Device getDevice(ThemeDisplay themeDisplay) {
		if (themeDisplay != null) {
			return themeDisplay.getDevice();
		}

		return UnknownDevice.getInstance();
	}	
	
	protected String getTemplatesPath(
			long companyId, long groupId, long classNameId) {

			StringBundler sb = new StringBundler(7);

			sb.append(TemplateConstants.TEMPLATE_SEPARATOR);
			sb.append(StringPool.SLASH);
			sb.append(companyId);
			sb.append(StringPool.SLASH);
			sb.append(groupId);
			sb.append(StringPool.SLASH);
			sb.append(classNameId);

			return sb.toString();
		}
	
	public String transform(ThemeDisplay themeDisplay, Map<String, Object> contextObjects,
			String script, String langType) throws Exception {

		if (Validator.isNull(langType)) {
			return null;
		}

		long companyId = 0;
		long companyGroupId = 0;
		long scopeGroupId = 0;
		long siteGroupId = 0;

		if (themeDisplay != null) {
			companyId = themeDisplay.getCompanyId();
			companyGroupId = themeDisplay.getCompanyGroupId();
			scopeGroupId = themeDisplay.getScopeGroupId();
			siteGroupId = themeDisplay.getSiteGroupId();
		}

		String templateId = String.valueOf(contextObjects.get("template_id"));

		templateId = getTemplateId(templateId, companyId, companyGroupId, scopeGroupId);

		Template template = getTemplate(templateId, script, langType);

		UnsyncStringWriter unsyncStringWriter = new UnsyncStringWriter();

		try {
			prepareTemplate(themeDisplay, template);

			long classNameId = 0;

			if (contextObjects != null) {
				for (String key : contextObjects.keySet()) {
					template.put(key, contextObjects.get(key));
				}

				classNameId = GetterUtil.getLong(
					contextObjects.get("class_name_id"));
			}

			template.put("company", getCompany(themeDisplay, companyId));
			template.put("companyId", companyId);
			template.put("device", getDevice(themeDisplay));

			String templatesPath = getTemplatesPath(
				companyId, scopeGroupId, classNameId);

			template.put("journalTemplatesPath", templatesPath);
			template.put(
				"permissionChecker",
				PermissionThreadLocal.getPermissionChecker());
			template.put(
				"randomNamespace",
				StringUtil.randomId() + StringPool.UNDERLINE);
			template.put("scopeGroupId", scopeGroupId);
			template.put("siteGroupId", siteGroupId);
			template.put("templatesPath", templatesPath);

			// Deprecated variables

			template.put("groupId", scopeGroupId);

			mergeTemplate(template, unsyncStringWriter);
		}
		catch (Exception e) {
			throw new TransformException("Unhandled exception", e);
		}

		return unsyncStringWriter.toString();
	}
}
