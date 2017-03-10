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

<div class="panelMenu">
              <div id="carousel-menu" class="carousel slide" data-ride="carousel"> 
                <!-- Wrapper for slides -->
                <div>
                  <h4 class="text-center"><span class="icon-menu"></span>Menu: <small> ${date} to ${assetEntry.getExpirationDate()?string["d MMMM"]} </small></h4>
                  <div class="divider pad-bottom"></div>
                  <div class="">
                    <div class="col-xs-12">
                      <div class="carousel-inner text-center">
                        <div class="item">
                          <div class="carousel-content" style="height: 311px;">
                            <div>
                              <h4 class="red">${diaSemLun.getData()}</h4>
                              <h5>
                              Servicio de desayuno: <#if diaSemLun.serDesLun.getData() == "true"><span class="iconMenu icon-okMenu"></span><#else><span class="iconMenu icon-negativoMenu"></span>
                              <p>${diaSemLun.serDesLun.compDesLun.getData()}</p>
                              </#if>
                              </h5><h5>Servicio de Catering: 
                            <#if diaSemLun.serCaterLun.getData() == "true">
                                <span class="iconMenu icon-okMenu"></span>
                                <h5 class="content">Primer Plato</h5>
                                <p class="pad-bottom">${diaSemLun.serCaterLun.primPlatoLun.getData()}</p>
                                <h5 class="content">Segundo Plato</h5>
                                <p>${diaSemLun.serCaterLun.segunPlatoLun.getData()}</p>
                                <h5 class="content">Postre</h5>
                                <p>${diaSemLun.serCaterLun.postreLunes.getData()}</p>
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
                              Servicio de desayuno: <#if diaSemMar.serDesMar.getData() == "true"><span class="iconMenu icon-okMenu"></span><#else><span class="iconMenu icon-negativoMenu"></span>
                              <p>${diaSemMar.serDesMar.compDesMar.getData()}</p>
                              </#if>
                              </h5><h5>Servicio de Catering: 
                              <#if diaSemMar.serCaterMar.getData() == "true">
                                <span class="iconMenu icon-okMenu"></span>
                                <h5 class="content">Primer Plato</h5>
                                <p class="pad-bottom">${diaSemMar.serCaterMar.primPlatoMar.getData()}</p>
                                <h5 class="content">Segundo Plato</h5>
                                <p>${diaSemMar.serCaterMar.segunPlatoMar.getData()}</p>
                                <h5 class="content">Postre</h5>
                                <p>${diaSemMar.serCaterMar.postreMartes.getData()}</p>
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
                              Servicio de desayuno: <#if diaSemMier.serDesMier.getData() == "true"><span class="iconMenu icon-okMenu"></span><#else><span class="iconMenu icon-negativoMenu"></span>
                              <p>${diaSemMier.serDesMier.compDesMier.getData()}</p>
                              </#if>
                              </h5><h5>Servicio de Catering: 
                              <#if diaSemMier.serCaterMier.getData() == "true"><span class="iconMenu icon-okMenu"></span>
                              <h5 class="content">Primer Plato</h5>
                              <p class="pad-bottom">${diaSemMier.serCaterMier.primPlatoMier.getData()}</p>
                              <h5 class="content">Segundo Plato</h5>
                              <p>${diaSemMier.serCaterMier.segunPlatoMier.getData()}</p>
                              <h5 class="content">Postre</h5>
                              <p>${diaSemMier.serCaterMier.postreMier.getData()}</p>
                              <#else>
                              <span class="iconMenu icon-negativoMenu"></span>
                              </h5>                 
                              </#if>
                            </div>
                          </div>
                        </div>
                        <div class="item active">
                          <div class="carousel-content" style="height: 311px;">
                            <div>
                              <h4 class="red">${diaSemJueves.getData()}</h4>
                              <h5>
                              Servicio de desayuno: <#if diaSemJueves.serDesJueves.getData() == "true"><span class="iconMenu icon-okMenu"></span><#else><span class="iconMenu icon-negativoMenu"></span>
                              <p>${diaSemJueves.serDesJueves.compDesJueves.getData()}</p>
                              </#if>
                              </h5><h5>Servicio de Catering: <#if diaSemJueves.serCaterJueves.getData() == "true">
                              
                              <span class="iconMenu icon-okMenu"></span>
                              <h5 class="content">Primer Plato</h5>
                              <p class="pad-bottom">${diaSemJueves.serCaterJueves.primPlatoJueves.getData()}</p>
                              <h5 class="content">Segundo Plato</h5>
                              <p>${diaSemJueves.serCaterJueves.segunPlatoJueves.getData()}</p>
                              <h5 class="content">Postre</h5>
                              <p>${diaSemJueves.serCaterJueves.postreJueves.getData()}</p>
                              
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
                              Servicio de desayuno: <#if diaSemViernes.serDesViernes.getData() == "true"><span class="iconMenu icon-okMenu"></span><#else><span class="iconMenu icon-negativoMenu"></span>
                              <p>${diaSemViernes.serDesViernes.compDesViernes.getData()}</p>
                              </#if>
                              </h5><h5>Servicio de Catering: 
                         
                              <#if diaSemViernes.serCaterViernes.getData() == "true"><span class="iconMenu icon-okMenu"></span>                              
                              <h5 class="content">Primer Plato</h5>
                              <p class="pad-bottom">${diaSemViernes.serCaterViernes.primPlatoViernes.getData()}</p>
                              <h5 class="content">Segundo Plato</h5>
                              <p>${diaSemViernes.serCaterViernes.segunPlatoViernes.getData()}</p>
                              <h5 class="content">Postre</h5>
                              <p>${diaSemViernes.serCaterViernes.postreViernes.getData()}</p>
                              
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