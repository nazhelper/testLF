<#--
Application display templates can be used to modify the look of a
specific application.

Please use the left panel to quickly add commonly used variables.
Autocomplete is also available and can be invoked by typing "${".
-->
<div class="footer">
<#if entries?has_content>
	<#list entries as curPage>
	<div class="span3">
		<ul>${curPage.getName(locale)}
		<#assign listaHijos = curPage.getChildren()>
		<#list listaHijos as curChildren>
		    <li>${curChildren.getName()}</li>
		</#list>
		</ul>
    </div>
	</#list>
</#if>
</div>