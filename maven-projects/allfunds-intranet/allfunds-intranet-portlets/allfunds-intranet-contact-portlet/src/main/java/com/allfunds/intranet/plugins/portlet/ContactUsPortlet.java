package com.allfunds.intranet.plugins.portlet;

import com.liferay.mail.service.MailServiceUtil;
import com.liferay.portal.kernel.exception.PortalException;
import com.liferay.portal.kernel.exception.SystemException;
import com.liferay.portal.kernel.mail.MailMessage;
import com.liferay.portal.kernel.servlet.SessionErrors;
import com.liferay.portal.kernel.servlet.SessionMessages;
import com.liferay.portal.kernel.util.PrefsPropsUtil;
import com.liferay.portal.kernel.util.PropsKeys;
import com.liferay.portal.kernel.util.Validator;
import com.liferay.portal.kernel.util.WebKeys;
import com.liferay.portal.kernel.xml.Document;
import com.liferay.portal.kernel.xml.DocumentException;
import com.liferay.portal.kernel.xml.Node;
import com.liferay.portal.kernel.xml.SAXReaderUtil;
import com.liferay.portal.theme.ThemeDisplay;
import com.liferay.portlet.journal.model.JournalArticle;
import com.liferay.portlet.journal.service.JournalArticleServiceUtil;
import com.liferay.util.bridges.mvc.MVCPortlet;

import java.io.IOException;
import java.io.StringReader;
import java.util.logging.Logger;

import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.portlet.ActionRequest;
import javax.portlet.ActionResponse;
import javax.portlet.PortletException;
import javax.portlet.PortletPreferences;
import javax.portlet.RenderRequest;
import javax.portlet.RenderResponse;

/**
 * Portlet implementation class ContactUsPortlet
 */
public class ContactUsPortlet extends MVCPortlet {
 
	private static final Logger LOGGER = Logger.getLogger( ContactUsPortlet.class.getName() ); 
	
	@Override
	public void doView(RenderRequest renderRequest,
			RenderResponse renderResponse) throws IOException, PortletException {
		
		super.doView(renderRequest, renderResponse);
	}
	
	public void sendEmailAction(
            ActionRequest actionRequest, ActionResponse actionResponse)
    throws IOException, PortletException {
        
		ThemeDisplay themeDisplay = (ThemeDisplay) actionRequest.getAttribute(WebKeys.THEME_DISPLAY);
		PortletPreferences prefs = actionRequest.getPreferences();
		MailMessage mailMessage = new MailMessage();
		
		String username = actionRequest.getParameter("username");
		String comment = actionRequest.getParameter("comment");
		String areaSelect = actionRequest.getParameter("areaSelect");
		String body = "";
		// Email de la persona logeada
		String emailUser = themeDisplay.getUser().getEmailAddress();
		Document document = null;
		String email = "";
		try {	
			//Email del administrador
			String adminEmail = PrefsPropsUtil.getString(PropsKeys.ADMIN_EMAIL_FROM_ADDRESS);
			JournalArticle journalArticle = JournalArticleServiceUtil.getArticle(themeDisplay.getScopeGroupId(),areaSelect);
			document = SAXReaderUtil.read(new StringReader(journalArticle.getContent()));
			if(journalArticle.toString().contains("email")){
				Node node = document.selectSingleNode("/root/dynamic-element[@name='emailArea']/dynamic-content");
				if (node.getText() != null && !node.getText().isEmpty()) {
					if(Validator.isEmailAddress(node.getText()) && Validator.isEmailAddress(emailUser)){
					//Email del area
					email = node.getText();
					body = "<h3> Direccion de Correo Electronico del Usuario: "+emailUser+"</h3>\n"+" <h4>Usuario: "+username+"</h4>\n"+"<p> Comentarios del usuario: "+comment+"</p>";
					mailMessage.setHTMLFormat(Boolean.TRUE);
					mailMessage.setBody(body);
					mailMessage.setSubject(Constants.SUBJECT);
					//Email del usuario logado
					mailMessage.setFrom(new InternetAddress(emailUser));
					//Email del area
					mailMessage.setTo(new InternetAddress(email));
					MailServiceUtil.sendEmail(mailMessage);
					SessionMessages.add(actionRequest, "successEmail");
					} else {
						SessionErrors.add(actionRequest, "errorEmailIncorrect");
					}
		    	} else {
		    		SessionErrors.add(actionRequest, "errorMailArea");
		    	}
			} else {
				SessionErrors.add(actionRequest, "errorStructure");
			}
		} catch (NumberFormatException | PortalException | SystemException | DocumentException | AddressException e) {
			LOGGER.info(e.getMessage());
		} 
    }
}
