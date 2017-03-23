<#--
Web content templates are used to lay out the fields defined in a web
content structure.

Please use the left panel to quickly add commonly used variables.
Autocomplete is also available and can be invoked by typing "${".
-->

<#assign fileEntry = staticUtil["com.liferay.portlet.documentlibrary.service.DLFileEntryLocalServiceUtil"]>
<#assign rolesUser = permissionChecker.getUser().getRoles()>
<#assign allRoles = "">
<#assign tipoDocumento = "">
<#assign fileExtension = "">

<#list rolesUser as usrRoles>
    <#assign allRoles = allRoles +" "+ usrRoles.getName()/>
</#list>

<#assign isVisible = "false">
                
<#if rolVisible.getData() == "Todos">
    <#assign isVisible = "true"/>
<#elseif allRoles?contains(rolVisible.getData())>
    <#assign isVisible = "true"/>
</#if>
                
    <#if isVisible == "true">
        <tr>
            <td>${.vars['reserved-article-title'].data}</td>
            <td><#assign valueDateCorp_Data = getterUtil.getLong(valueDateCorp.getData())>
                <#if (valueDateCorp_Data > 0)>
                 <#assign valueDateCorp_DateObj = dateUtil.newDate(valueDateCorp_Data)>
                 ${dateUtil.getDate(valueDateCorp_DateObj, "dd/MM/yyyy", locale)}
                </#if>
            </td>
            <td>${rolVisible.getData()}</td>
            <td>
            <#if (tempDocum)??>
                <#if tempDocum.getSiblings()?has_content>
                 <#list tempDocum.getSiblings() as cur_tempDocum>
                     <#if cur_tempDocum.getData() != "">
                            
                            <#assign counter = 0 >
                            <#assign tempDocumb = cur_tempDocum.getData()?string>
                            <#list tempDocumb?split("/") as x>
                                <#if counter == 2>
                                    <#assign groupId = x?number >
                                </#if>
                                <#if counter == 5>
                                    <#assign uuId = x >
                                    <#if uuId?contains("?t=")>
                                    	<#assign indexTo = uuId?index_of("?t=") >
                                    	<#assign uuId = uuId?substring(0,indexTo) >
                                    </#if>
                                </#if>
                                <#assign counter = counter+1 >
                         </#list>
                         
                         <#if (uuId)??>
                                <#assign file = fileEntry.getFileEntryByUuidAndGroupId(uuId,groupId) >
                                <#assign fileExtension = file.getExtension()?string>
                            </#if>
                      
                      <#if fileExtension?contains("doc")>
                               <a class="btnTable btn-default btn-rounder btn-rounder-tb btn-download-doc" href="${cur_tempDocum.getData()}"> </a>
                            <#elseif fileExtension?contains("xl") || fileExtension?contains("csv")>
                                <a class="btnTable btn-default btn-rounder btn-rounder-tb btn-download-xls" href="${cur_tempDocum.getData()}"> </a>
                            <#elseif fileExtension?contains("pp")>
                                <a class="btnTable btn-default btn-rounder btn-rounder-tb btn-download-ppt" href="${cur_tempDocum.getData()}"> </a>
                            <#elseif fileExtension?contains("pdf")>
                                <a class="btnTable btn-default btn-rounder btn-rounder-tb btn-download-pdf" href="${cur_tempDocum.getData()}" target="_blank"> </a>
                            <#else>
                                <a class="btnTable btn-default btn-rounder btn-rounder-tb btn-download-ico" href="${cur_tempDocum.getData()}" target="_blank"> </a>
                            </#if>
                        </#if>
                 </#list>
                </#if>
            </#if>
            </td>
        </tr>
    </#if>