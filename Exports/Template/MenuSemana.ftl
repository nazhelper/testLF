<#--
Web content templates are used to lay out the fields defined in a web
content structure.

Please use the left panel to quickly add commonly used variables.
Autocomplete is also available and can be invoked by typing "${".
-->

<#assign date = .vars['reserved-article-display-date'].data>

<#setting time_zone = languageUtil.get(locale, "template-timezone")>

<#assign originalLocale = locale>

<#setting locale = localeUtil.getDefault()>

<#assign date = date?datetime("EEE, d MMM yyyy HH:mm:ss Z")>

<#setting locale = originalLocale>

<#assign dateTimeFormat = "d MMMM">
 
    <#assign date = date?string(dateTimeFormat)>

    <#assign themeDisplay = objectUtil("com.liferay.portal.theme.ThemeDisplay") />

    <#assign journalArticleLocalService = serviceLocator.findService("com.liferay.portlet.journal.service.JournalArticleLocalService")>

    <#assign journalArticleId = .vars['reserved-article-id'].data>

    <#assign ja = journalArticleLocalService.getArticle(groupId, journalArticleId)>

    <#assign resourcePrimKey = ja.getResourcePrimKey()>

    <#assign assetEntryLocalService = serviceLocator.findService("com.liferay.portlet.asset.service.AssetEntryLocalService")>

    <#assign assetEntry = assetEntryLocalService.getEntry("com.liferay.portlet.journal.model.JournalArticle", resourcePrimKey)>
    
    
    <#if (assetEntry.getExpirationDate())??>
        <#assign expirationDate =  assetEntry.getExpirationDate()?string["d MMM"]>
    <#else>
        <#assign expirationDate = "-">
    </#if>
    
<div class="panel panel-default panelMenu">
              <div id="carousel-menu" class="carousel slide" data-ride="carousel"> 
                <!-- Wrapper for slides -->
                <div>
                  <h4 class="text-center"><span class="icon-menu"></span>Menu: <small> ${date} to  ${expirationDate}</small></h4>
                  <div class="divider pad-bottom"></div>
                  <div class="">
                    <div class="col-xs-12">
                      <div class="carousel-inner text-center">
                        <div class="item active">
                          <div class="carousel-content" style="height: 311px;">
                            <div>
                              <h4 class="red">${diaSemLun.getData()}</h4>
                              <h5>
                              <@liferay.language key="allfunds.template.menu.serDes" /> 
		              <#if diaSemLun.serDesLun.getData() == "true">
                              <span class="iconMenu icon-okMenu"></span>
                              </h5>
                              <#if diaSemLun.serDesLun.compDesLun.getSiblings()?has_content>
                                <#list diaSemLun.serDesLun.compDesLun.getSiblings() as currentInputValue>
                                    <p class="pad-bottom"> ${currentInputValue.data}</p>
                                </#list>
                              </#if>
                            <#else>
                              <span class="iconMenu icon-negativoMenu"></span>
                              </h5>
                            </#if>
                              <h5><@liferay.language key="allfunds.template.menu.serCat" />
                            <#if diaSemLun.serCaterLun.getData() == "true">
                                <span class="iconMenu icon-okMenu"></span>
                                <h5 class="content"><@liferay.language key="allfunds.template.menu.primPlato" /></h5>
                                <#if diaSemLun.serCaterLun.primPlatoLun.getSiblings()?has_content>
                                    <#list diaSemLun.serCaterLun.primPlatoLun.getSiblings() as currentInputValue>
                                        <p class="pad-bottom">${currentInputValue.getData()}</p>
                                    </#list>
                                </#if>
                                <h5 class="content"><@liferay.language key="allfunds.template.menu.segPlato" /></h5>
                                <#if diaSemLun.serCaterLun.segunPlatoLun.getSiblings()?has_content>
                                    <#list diaSemLun.serCaterLun.segunPlatoLun.getSiblings() as currentInputValue>
                                        <p class="pad-bottom">${currentInputValue.getData()}</p>
                                    </#list>
                                </#if>
                                <h5 class="content"><@liferay.language key="allfunds.template.menu.postre" /></h5>
                                <#if diaSemLun.serCaterLun.postreLunes.getSiblings()?has_content>
                                    <#list diaSemLun.serCaterLun.postreLunes.getSiblings() as currentInputValue>
                                        <p class="pad-bottom">${currentInputValue.getData()}</p>
                                    </#list>
                                </#if>
                            <#else>
                                <span class="iconMenu icon-negativoMenu"></span></h5>
                            </#if>
                            </div>
                          </div>
                        </div>
                        <div class="item">
                          <div class="carousel-content" style="height: 311px;">
                            <div>
                              <h4 class="red">${diaSemMar.getData()}</h4>
                              <h5>
                              <@liferay.language key="allfunds.template.menu.serDes" /> 
                            <#if diaSemMar.serDesMar.getData() == "true">
                                <span class="iconMenu icon-okMenu"></span>
                              </h5>
                              <#if diaSemMar.serDesMar.compDesMar.getSiblings()?has_content>
                                <#list diaSemMar.serDesMar.compDesMar.getSiblings() as currentInputValue>
                                    <p class="pad-bottom"> ${currentInputValue.data}</p>
                                </#list>
                              </#if>
                            <#else>
                              <span class="iconMenu icon-negativoMenu"></span>
                              </h5>
                            </#if>
                              <h5><@liferay.language key="allfunds.template.menu.serCat" /> 
                              <#if diaSemMar.serCaterMar.getData() == "true">
                                <span class="iconMenu icon-okMenu"></span>
                                <h5 class="content"><@liferay.language key="allfunds.template.menu.primPlato" /></h5>
                                <#if diaSemMar.serCaterMar.primPlatoMar.getSiblings()?has_content>
                                    <#list diaSemMar.serCaterMar.primPlatoMar.getSiblings() as currentInputValue>
                                        <p class="pad-bottom">${currentInputValue.data}</p>
                                    </#list>
                                </#if>
                                <h5 class="content"><@liferay.language key="allfunds.template.menu.segPlato" /></h5>
                                <#if diaSemMar.serCaterMar.segunPlatoMar.getSiblings()?has_content>
                                    <#list diaSemMar.serCaterMar.segunPlatoMar.getSiblings() as currentInputValue>
                                        <p class="pad-bottom">${currentInputValue.data}</p>
                                    </#list>
                                </#if>
                                <h5 class="content"><@liferay.language key="allfunds.template.menu.postre" /></h5>
                                <#if diaSemMar.serCaterMar.postreMartes.getSiblings()?has_content>
                                    <#list diaSemMar.serCaterMar.postreMartes.getSiblings() as currentInputValue>
                                        <p class="pad-bottom">${currentInputValue.data}</p>
                                    </#list>
                                </#if>
                              <#else>
                                <span class="iconMenu icon-negativoMenu"></span>
                              </#if>
                            </div>
                          </div>
                        </div>
                        <div class="item">
                          <div class="carousel-content" style="height: 311px;">
                            <div>
                              <h4 class="red">${diaSemMier.getData()}</h4>
                              <h5>
                                <@liferay.language key="allfunds.template.menu.serDes" /> 
                              <#if diaSemMier.serDesMier.getData() == "true">
                                <span class="iconMenu icon-okMenu"></span>
                                </h5>
                                <#if diaSemMier.serDesMier.compDesMier.getSiblings()?has_content>
                                <#list diaSemMier.serDesMier.compDesMier.getSiblings() as currentInputValue>
                                    <p class="pad-bottom"> ${currentInputValue.data}</p>
                                </#list>
                              </#if>
                              <#else>
                                <span class="iconMenu icon-negativoMenu"></span>
                                </h5>
                              </#if>
                              <h5><@liferay.language key="allfunds.template.menu.serCat" /> 
                              <#if diaSemMier.serCaterMier.getData() == "true"><span class="iconMenu icon-okMenu"></span>
                              <h5 class="content"><@liferay.language key="allfunds.template.menu.primPlato" /></h5>
                              <#if diaSemMier.serCaterMier.primPlatoMier.getSiblings()?has_content>
                                <#list diaSemMier.serCaterMier.primPlatoMier.getSiblings() as currentInputValue>
                                    <p class="pad-bottom"> ${currentInputValue.data}</p>
                                </#list>
                              </#if>
                              <h5 class="content"><@liferay.language key="allfunds.template.menu.segPlato" /></h5>
                              <#if diaSemMier.serCaterMier.segunPlatoMier.getSiblings()?has_content>
                                <#list diaSemMier.serCaterMier.segunPlatoMier.getSiblings() as currentInputValue>
                                    <p class="pad-bottom"> ${currentInputValue.data}</p>
                                </#list>
                              </#if>
                              <h5 class="content"><@liferay.language key="allfunds.template.menu.postre" /></h5>
                              <#if diaSemMier.serCaterMier.postreMiercoles.getSiblings()?has_content>
                                <#list diaSemMier.serCaterMier.postreMiercoles.getSiblings() as currentInputValue>
                                    <p class="pad-bottom"> ${currentInputValue.data}</p>
                                </#list>
                              </#if>
                              <#else>
                              <span class="iconMenu icon-negativoMenu"></span>
                              </h5>                 
                              </#if>
                            </div>
                          </div>
                        </div>
                        <div class="item">
                          <div class="carousel-content" style="height: 311px;">
                            <div>
                               <h4 class="red">${diaSemJueves.getData()}</h4>
                              <h5>
                                <@liferay.language key="allfunds.template.menu.serDes" /> 
                              <#if diaSemJueves.serDesJueves.getData() == "true">
                                <span class="iconMenu icon-okMenu"></span>
                                </h5>
                                <#if diaSemJueves.serDesJueves.compDesJueves.getSiblings()?has_content>
                                <#list diaSemJueves.serDesJueves.compDesJueves.getSiblings() as currentInputValue>
                                    <p class="pad-bottom"> ${currentInputValue.data}</p>
                                </#list>
                              </#if>
                              <#else>
                                <span class="iconMenu icon-negativoMenu"></span>
                                </h5>
                              </#if>
                              <h5><@liferay.language key="allfunds.template.menu.serCat" /> 
		             <#if diaSemJueves.serCaterJueves.getData() == "true">
                              <span class="iconMenu icon-okMenu"></span>
                              <h5 class="content"><@liferay.language key="allfunds.template.menu.primPlato" /></h5>
                              <#if diaSemJueves.serCaterJueves.primPlatoJueves.getSiblings()?has_content>
                                <#list diaSemJueves.serCaterJueves.primPlatoJueves.getSiblings() as currentInputValue>
                                    <p class="pad-bottom"> ${currentInputValue.data}</p>
                                </#list>
                              </#if>
                              <h5 class="content"><@liferay.language key="allfunds.template.menu.segPlato" /></h5>
                              <#if diaSemJueves.serCaterJueves.segunPlatoJueves.getSiblings()?has_content>
                                <#list diaSemJueves.serCaterJueves.segunPlatoJueves.getSiblings() as currentInputValue>
                                    <p class="pad-bottom"> ${currentInputValue.data}</p>
                                </#list>
                              </#if>
                              <h5 class="content"><@liferay.language key="allfunds.template.menu.postre" /></h5>
                              <#if diaSemJueves.serCaterJueves.postreJueves.getSiblings()?has_content>
                                <#list diaSemJueves.serCaterJueves.postreJueves.getSiblings() as currentInputValue>
                                    <p class="pad-bottom"> ${currentInputValue.data}</p>
                                </#list>
                              </#if>
                              <#else>
                              <span class="iconMenu icon-negativoMenu"></span>
                              </h5>                             
                              </#if>
                            </div>
                          </div>
                        </div>
                        <div class="item">
                          <div class="carousel-content" style="height: 311px;">
                            <div>
                              <h4 class="red">${diaSemViernes.getData()}</h4>
                              <h5>
                                <@liferay.language key="allfunds.template.menu.serDes" /> 
                              <#if diaSemViernes.serDesViernes.getData() == "true">
                                <span class="iconMenu icon-okMenu"></span>
                                </h5>
                                <#if diaSemViernes.serDesViernes.compDesViernes.getSiblings()?has_content>
                                <#list diaSemViernes.serDesViernes.compDesViernes.getSiblings() as currentInputValue>
                                    <p class="pad-bottom"> ${currentInputValue.data}</p>
                                </#list>
                              </#if>
                              <#else>
                                <span class="iconMenu icon-negativoMenu"></span>
                                </h5>
                              </#if>
                              <h5><@liferay.language key="allfunds.template.menu.serCat" /> 
                              <#if diaSemViernes.serCaterViernes.getData() == "true"><span class="iconMenu icon-okMenu"></span>                              
                              <h5 class="content"><@liferay.language key="allfunds.template.menu.primPlato" /></h5>
                              <#if diaSemViernes.serCaterViernes.primPlatoViernes.getSiblings()?has_content>
                                <#list diaSemViernes.serCaterViernes.primPlatoViernes.getSiblings() as currentInputValue>
                                    <p class="pad-bottom"> ${currentInputValue.data}</p>
                                </#list>
                              </#if>
                              <h5 class="content"><@liferay.language key="allfunds.template.menu.segPlato" /></h5>
                              <#if diaSemViernes.serCaterViernes.segunPlatoViernes.getSiblings()?has_content>
                                <#list diaSemViernes.serCaterViernes.segunPlatoViernes.getSiblings() as currentInputValue>
                                    <p class="pad-bottom"> ${currentInputValue.data}</p>
                                </#list>
                              </#if>
                              <h5 class="content"><@liferay.language key="allfunds.template.menu.postre" /></h5>
                              <#if diaSemViernes.serCaterViernes.postreViernes.getSiblings()?has_content>
                                <#list diaSemViernes.serCaterViernes.postreViernes.getSiblings() as currentInputValue>
                                    <p class="pad-bottom"> ${currentInputValue.data}</p>
                                </#list>
                              </#if>                              
                              <#else>
                              <span class="iconMenu icon-negativoMenu"></span></h5>   
                              </#if>
                            </div>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                  <div class="clearfix"></div>
                </div>
                <!-- Controls -->
                <a class="left carousel-controlMenu" href="#carousel-menu" data-slide="prev"> <span class="glyphicon glyphicon-chevron-left"></span> </a> 
                <a class="right carousel-controlMenu" href="#carousel-menu" data-slide="next"> <span class="glyphicon glyphicon-chevron-right"></span> </a> </div>
            </div>