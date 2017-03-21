<#--
Web content templates are used to lay out the fields defined in a web
content structure.

Please use the left panel to quickly add commonly used variables.
Autocomplete is also available and can be invoked by typing "${".
-->

<div class="span3">
    <div class="thumbnail">
        <div class="caption" style="display: none;">
            <h4>${.vars['reserved-article-title'].data}</h4>
            <p>${descriptionBox.getData()}</p>
            <div class="divider"></div>
            <h4><@liferay.language key="allfunds.template.price" /></h4>
            <h4>${priceArticle.getData()}<@liferay.language key="allfunds.template.priceSim" /></h4>
        </div>
        <img src="${imageArticle.getData()}" alt="${.vars['reserved-article-title'].data}"> 
    </div>
</div>