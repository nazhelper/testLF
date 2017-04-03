<div class="allfundstabsx3" id="main-content" role="main">
	<div class="portlet-layout row-fluid panel panel-default pad-bottom ">
		<ul class="nav nav-tabs nav-justified">
			<li role="presentation" class="active">
				#set( $column1tab = "#_" + $themeDisplay.getPortletDisplay().getId() + "_column-1")
				<a  href="${column1tab}" data-toggle="tab">
					<span class="flaticon-arms" aria-hidden="true"></span>
					<span class="hidden-xs block">ALL FOR YOU</span>
				</a>
			</li>
			<li role="presentation">
				#set( $column2tab = "#_" + $themeDisplay.getPortletDisplay().getId() + "_column-2")
				<a  href="${column2tab}" data-toggle="tab">
					<span class="flaticon-familiar-insurance-symbol" aria-hidden="true"></span>
                  	<span class="hidden-xs block"> ALL LIFE &amp; FAMILY </span>
                </a>
			</li>
			<li role="presentation">
				#set( $column3tab = "#_" + $themeDisplay.getPortletDisplay().getId() + "_column-3")
				<a  href="${column3tab}" data-toggle="tab">
                  	<span class="flaticon-first-place-medal" aria-hidden="true"></span>
                  	<span class="hidden-xs block"> ALL TO KNOW</span>
                </a>
			</li>
		</ul>
		<div class="tab-content">
			<div class="portlet-column portlet-column-first tab-pane fade active in" id="column-1">
				$processor.processColumn("column-1", "portlet-column-content portlet-column-content-first")
			</div>
			<div class="portlet-column tab-pane fade " id="column-2">
				$processor.processColumn("column-2", "portlet-column-content")
			</div>
			<div class="portlet-column portlet-column-last tab-pane fade " id="column-3">
				$processor.processColumn("column-3", "portlet-column-content portlet-column-content-last")
			</div>
		</div>
	</div>
</div>
