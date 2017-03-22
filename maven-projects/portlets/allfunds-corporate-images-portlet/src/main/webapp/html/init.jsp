<%@page import="com.liferay.portal.kernel.workflow.WorkflowConstants"%>
<%@page import="com.liferay.portal.kernel.util.Constants"%>
<%@page import="com.liferay.portal.kernel.dao.orm.PropertyFactoryUtil"%>
<%@page import="com.liferay.portal.kernel.util.PortalClassLoaderUtil"%>
<%@page import="com.liferay.portal.kernel.dao.orm.DynamicQueryFactoryUtil"%>
<%@page import="com.liferay.portlet.documentlibrary.service.DLFileEntryLocalServiceWrapper"%>
<%@page import="com.liferay.portlet.documentlibrary.util.RawMetadataProcessor"%>
<%@page import="com.liferay.util.SerializableUtil"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.Locale"%>
<%@page import="com.liferay.portal.kernel.util.StringUtil"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="com.liferay.portal.kernel.language.LanguageUtil"%>
<%@page import="com.liferay.portal.kernel.util.ListUtil"%>
<%@page import="java.util.Map"%>
<%@page import="java.io.Serializable"%>
<%@page import="com.liferay.portlet.dynamicdatamapping.storage.Fields"%>
<%@page import="com.liferay.portlet.dynamicdatamapping.storage.StorageEngineUtil"%>
<%@page import="com.liferay.portlet.documentlibrary.model.DLFileEntryMetadata"%>
<%@page import="com.liferay.portlet.documentlibrary.service.DLFileEntryMetadataLocalServiceUtil"%>
<%@page import="com.liferay.portlet.documentlibrary.model.DLFileVersion"%>
<%@page import="com.liferay.portal.service.ClassNameLocalServiceUtil"%>
<%@page import="com.liferay.portlet.documentlibrary.service.persistence.DLFileEntryFinderUtil"%>
<%@page import="com.liferay.portlet.documentlibrary.service.DLFileEntryLocalServiceUtil"%>
<%@page import="com.liferay.portlet.documentlibrary.model.DLFileEntry"%>
<%@page import="com.liferay.portlet.dynamicdatamapping.service.DDMStructureLocalServiceUtil"%>
<%@page import="com.liferay.portlet.dynamicdatamapping.model.DDMStructure"%>
<%@page import="com.liferay.portlet.journal.model.JournalArticle"%>
<%@page import="java.util.List"%>
<%@page import="com.liferay.portlet.journal.service.JournalArticleLocalServiceUtil"%>
<%@page import="com.liferay.portal.kernel.util.GetterUtil"%>
<%@ taglib uri="http://java.sun.com/portlet_2_0" prefix="portlet" %>
<%@ taglib uri="http://liferay.com/tld/theme" prefix="liferay-theme"%>

<portlet:defineObjects />
<liferay-theme:defineObjects/>