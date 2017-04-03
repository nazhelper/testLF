package com.allfunds.intranet.plugins.portlet;

import com.liferay.portal.kernel.exception.SystemException;
import com.liferay.portal.kernel.util.StringPool;
import com.liferay.portlet.documentlibrary.model.DLFolder;
import com.liferay.portlet.documentlibrary.service.DLFolderLocalServiceUtil;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class DLFolderPorletUtils {

	private static Map<Integer, Map<?,?>> internalFolders = new HashMap<Integer, Map<?,?>>();
	private static Integer index = 0;

	public static Map<Integer, Map<?,?>> getFolders(List<DLFolder> folders, long groupId,
			String guion) throws SystemException {
		Map<Long, String> foldersTest = new HashMap<Long, String>();
		for (DLFolder dlFolder : folders) {
			index++;
			List<DLFolder> childrens = DLFolderLocalServiceUtil.getFolders(
					groupId, dlFolder.getFolderId(), Boolean.FALSE);
			if (!childrens.isEmpty()) {
				foldersTest = new HashMap<Long, String>();
				foldersTest.put(dlFolder.getFolderId(),
						guion + dlFolder.getName());
				internalFolders.put(index, foldersTest);
				getFolders(childrens, groupId, guion + " " + StringPool.DASH
						+ " ");
			} else {
				foldersTest = new HashMap<Long, String>();
				foldersTest.put(dlFolder.getFolderId(),
						guion + dlFolder.getName());
				internalFolders.put(index, foldersTest);
			}
		}
		return internalFolders;
	}

	public static Map<DLFolder, Map<?,?>> getFoldersView(List<DLFolder> folders, long groupId)
			throws SystemException {
		Map <DLFolder, Map<?,?>> internalFolders = new HashMap<DLFolder, Map<?,?>>();
		for (DLFolder dlFolder : folders) {			
			List<DLFolder> childrens = DLFolderLocalServiceUtil.getFolders(groupId, dlFolder.getFolderId(), Boolean.FALSE);	
			if(!childrens.isEmpty()){
				Map <DLFolder, Map<?,?>> internalMap = getFoldersView(childrens, groupId);
				internalFolders.put(dlFolder, internalMap);
			}else{
				internalFolders.put(dlFolder, null);
			}
		}	
		return internalFolders;
	}

}
