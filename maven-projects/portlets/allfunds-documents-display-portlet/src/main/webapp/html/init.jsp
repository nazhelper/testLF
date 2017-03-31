
<!-- Imports Pagina config.jsp -->
<%@page import="com.liferay.portlet.documentlibrary.service.persistence.DLFolderUtil"%>
<%@page import="java.util.Map"%>
<%@page import="com.allfunds.plugins.portlet.DLFolderPorletUtils"%>
<%@page import="com.liferay.portlet.documentlibrary.model.DLFolderConstants"%>
<%@page import="com.liferay.portlet.documentlibrary.service.DLFolderLocalServiceUtil"%>
<%@page import="com.liferay.portlet.documentlibrary.service.DLFileEntryLocalServiceUtil"%>
<%@page import="com.liferay.portlet.documentlibrary.service.DLFolderLocalService"%>
<%@page import="com.liferay.portal.theme.ThemeDisplay"%>
<%@page import="com.liferay.portlet.documentlibrary.model.DLFileEntry"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.liferay.portlet.dynamicdatamapping.model.DDMStructure"%>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.liferay.portal.kernel.util.Constants"%>
<%@page import="com.liferay.portal.kernel.util.GetterUtil"%>

<!-- Imports Pagina view.jsp -->
<%@page import="com.liferay.portal.kernel.util.HtmlUtil"%>
<%@page import="com.liferay.portal.kernel.util.HttpUtil"%>
<%@page import="com.liferay.portal.kernel.dao.orm.ProjectionFactoryUtil"%>
<%@page import="com.liferay.portlet.documentlibrary.model.DLFileEntryType"%>
<%@page import="com.liferay.portlet.documentlibrary.service.DLFileEntryTypeLocalServiceUtil"%>
<%@page import="com.allfunds.plugins.portlet.DLFolderPorletUtils"%>
<%@page import="com.liferay.portlet.documentlibrary.model.DLFolder"%>
<%@page import="com.liferay.portlet.documentlibrary.service.DLFolderLocalServiceUtil"%>
<%@page import="com.liferay.portlet.documentlibrary.service.DLFolderLocalService"%>

<!-- Imports generales del portlet -->
<%@ taglib uri="http://alloy.liferay.com/tld/aui" prefix="aui" %>
<%@ taglib uri="http://java.sun.com/portlet_2_0" prefix="portlet" %>
<%@ taglib uri="http://liferay.com/tld/portlet" prefix="liferay-portlet" %>
<%@ taglib uri="http://liferay.com/tld/theme" prefix="liferay-theme"%>
<%@taglib prefix="allfunds" tagdir="/WEB-INF/tags"%>


<portlet:defineObjects />
<liferay-theme:defineObjects/>