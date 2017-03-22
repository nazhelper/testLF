<#--
Web content templates are used to lay out the fields defined in a web
content structure.

Please use the left panel to quickly add commonly used variables.
Autocomplete is also available and can be invoked by typing "${".
-->

${.vars['reserved-article-title'].data}

<#assign valueDateCorp_Data = getterUtil.getLong(valueDateCorp.getData())>

<#if (valueDateCorp_Data > 0)>
	<#assign valueDateCorp_DateObj = dateUtil.newDate(valueDateCorp_Data)>

	${dateUtil.getDate(valueDateCorp_DateObj, "dd MMM yyyy - HH:mm:ss", locale)}
</#if>

${rolVisible.getData()}

${oficGloSelect.getData()}

${descrTextBox.getData()}

<#if tempDocum.getSiblings()?has_content>
	<#list tempDocum.getSiblings() as cur_tempDocum>
		<a href="${cur_tempDocum.getData()}">
			${languageUtil.format(locale, "download-x", "Documents")}
		</a>
	</#list>
</#if>