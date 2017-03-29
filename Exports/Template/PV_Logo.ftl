<#--
Web content templates are used to lay out the fields defined in a web
content structure.

Please use the left panel to quickly add commonly used variables.
Autocomplete is also available and can be invoked by typing "${".
-->

        <div class="span6">
            <div class="panel panel-default">
                <div class="row-col overLogo"> 
                    <div class="span6">
                        <div class="panel-body"> <img class="img-responsive img-logo-download" src="${previewLogo.getData()}"> </div>
                    </div>
                    <div class="span6">
                        <#if (logoJpg.getData())?? && logoJpg.getData() != "">
                            <a href="${logoJpg.getData()}" target="_blank">
                            <div role="button" class="span4 btn btn-recto btn-default">
                        <#else>
                            <a>
                            <div role="button" class="span4 btn btn-recto btn-default disabled">
                        </#if>
                            <p>Download</p>
                            <span class="icon icon-logo-jpg "></span>
                            <p>JPG</p>
                        </div>
                        </a>
                        <#if (logoVectorial.getData())?? && logoVectorial.getData() != "">
                            <a href="${logoVectorial.getData()}" target="_blank">
                            <div role="button" class="span4 omega btn btn-recto btn-default">
                        <#else>
                            <a>
                            <div role="button" class="span4 omega btn btn-recto btn-default disabled">
                        </#if>
                            <p>Download</p>
                            <span class="icon icon-logo-pdf"></span>
                            <p>Vector</p>
                        </div>
                        </a>
                        <#if (logoPng.getData())?? && logoPng.getData() != "">
                            <a href="${logoPng.getData()}" target="_blank">
                            <div role="button" class="span4 omega btn btn-recto btn-default">
                        <#else>
                            <a>
                            <div role="button" class="span4 omega btn btn-recto btn-default disabled">
                        </#if>
                            <p>Download</p>
                            <span class="icon icon-logo-png"></span>
                            <p>Transparent</p>
                        </div>
                        </a>
                        <#if (logoNegative.getData())?? && logoNegative.getData() != "">
                            <a href="${logoNegative.getData()}" target="_blank">
                            <div role="button" class="span4 omega btn btn-recto btn-default">
                        <#else>
                            <a>
                            <div role="button" class="span4 omega btn btn-recto btn-default disabled">
                        </#if>
                            <p>Download</p>
                            <span class="icon icon-logo-png background-inverse"></span>
                            <p>Dark Backg.</p>
                        </div>
                        </a>
                         <#if (useGuide.getData())?? && useGuide.getData() != "">
                            <a href="${useGuide.getData()}" target="_blank">
                            <div role="button" class="span8 omega btn btn-recto btn-default">
                        <#else>
                            <a>
                            <div role="button" class="span8 omega btn btn-recto btn-default disabled">
                        </#if>
                            <div class="text-center">
                                <p class="content-s">Download Guidelines</p>
                                <span class="icon icon-download-pdf"></span>
                            </div>
                        </div>
                        </a>
                    </div>
                </div>
            </div>
        </div>