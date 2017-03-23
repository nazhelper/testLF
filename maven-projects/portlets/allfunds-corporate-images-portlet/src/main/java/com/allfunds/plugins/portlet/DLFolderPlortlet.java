package com.allfunds.plugins.portlet;

import com.liferay.portal.kernel.exception.SystemException;
import com.liferay.portal.kernel.util.WebKeys;
import com.liferay.portal.theme.ThemeDisplay;
import com.liferay.portlet.documentlibrary.model.DLFolder;
import com.liferay.portlet.documentlibrary.model.DLFolderConstants;
import com.liferay.portlet.documentlibrary.service.DLFolderLocalServiceUtil;
import com.liferay.util.bridges.mvc.MVCPortlet;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.portlet.PortletException;
import javax.portlet.RenderRequest;
import javax.portlet.RenderResponse;


public class DLFolderPlortlet extends MVCPortlet {

	
	@Override
	public void doView(RenderRequest renderRequest,
			RenderResponse renderResponse) throws IOException, PortletException {
		
		ThemeDisplay themeDisplay = (ThemeDisplay) renderRequest.getAttribute(WebKeys.THEME_DISPLAY);

		Long groupId = themeDisplay.getScopeGroupId();
		
		Map<DLFolder, Map> systemFolders = new HashMap<DLFolder,Map>();
		try {
			List<DLFolder> baseFolders = DLFolderLocalServiceUtil.getFolders(groupId, DLFolderConstants.DEFAULT_PARENT_FOLDER_ID, Boolean.FALSE);
			systemFolders = getFolders(baseFolders, groupId);
		} catch (SystemException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	private Map<DLFolder, Map>  getFolders(List<DLFolder> folders, long groupId) throws SystemException{
		Map<DLFolder, Map> internalFolders = new HashMap<DLFolder,Map>();
		
		for (DLFolder dlFolder : folders) {
			List<DLFolder> childrens = DLFolderLocalServiceUtil.getFolders(groupId, dlFolder.getFolderId(), Boolean.FALSE);
			
			if(!childrens.isEmpty()){
				//Caso recursivo
				Map<DLFolder, Map> internalMap = getFolders(childrens, groupId);
				internalFolders.put(dlFolder, internalMap);
			}else{
				//Caso base
				internalFolders.put(dlFolder, null);
			}
		}
		
		
		return internalFolders;
		
	}
}
