<#--
Web content templates are used to lay out the fields defined in a web
content structure.

Please use the left panel to quickly add commonly used variables.
Autocomplete is also available and can be invoked by typing "${".
-->

<#assign startDate_Data = getterUtil.getLong(startDate.getData())>

<#if (startDate_Data > 0)>
	<#assign startDate_DateObj = dateUtil.newDate(startDate_Data)>

	${dateUtil.getDate(startDate_DateObj, "dd MMM yyyy - HH:mm:ss", locale)}
</#if>

${descriptionProc.getData()}

<a href="${documentProc.getData()}">
	${languageUtil.format(locale, "download-x", "PDF")}
</a>

${languageSelect.getData()}