<%@ taglib uri="http://java.sun.com/portlet_2_0" prefix="portlet"%>
<%@ taglib uri="http://alloy.liferay.com/tld/aui" prefix="aui" %>

<portlet:defineObjects />

<div class="panel panel-default clearfix">
<aui:fieldset >
	<aui:layout>
	<aui:row>
	<aui:column columnWidth="65" first="true">
			<div class="panel-body">
				<div class="boxform">
					<aui:input name="search" label="News Search" cssClass="form-control input-search" placeholder="Keywords" type="text"></aui:input>
				</div>
			</div>
			<div class="panel-body">
				
				<div class="boxform">
					<label>Date range</label>
					<div class="input-daterange input-group" id="datepicker">
						<aui:row>
							<aui:input name="start" type="text" inlineField="true" label=""></aui:input>
							<span class="input-group-addon">to</span> 
							<aui:input name="end" type="text" inlineField="true" label=""></aui:input>
						</aui:row>
						
					</div>
				</div>
			</div>
	</aui:column>
	<aui:column columnWidth="35" last="true" cssClass="border-l">
			<div class="panel-body">
				<div class="boxform">
					<label>Select news type</label>
					<div class="checkbox  inline">
						<label> <input id="" name="EventTypes" checked=""
							value="Internal Events" type="checkbox"> <span></span>Allfunds
							Bank News
						</label>
					</div>
					<div class="checkbox  inline">
						<label> <input id="" name="EventTypes" checked="checked"
							value="Fund Industrial Events" type="checkbox"> <span></span>Fund
							Industrial News
						</label>
					</div>
					<div class="checkbox  inline">
						<label> <input id="" name="EventTypes" checked="checked"
							value="Fund Industrial Events" type="checkbox"> <span></span>Press
							Clipping
						</label>
					</div>
				</div>
			</div>
			<div class="panel-body clearfix">
			<aui:button-row cssClass="btn-group pull-right" role="group" style="margin: 0;">
				<aui:button icon="glyphicon glyphicon-send" cssClass="btn btn-info" name="saveButton" type="submit" class="btn btn-info" value="search" role="button" />
		
				<aui:button icon="flaticon-paint reducido" cssClass="btn btn-danger" name="cancelButton" type="button" value="cleaner" role="button" />
			</aui:button-row>
			</div>
	</aui:column>
	</aui:row>
	</aui:layout>
	</aui:fieldset>
</div>
<script>
$('.input-daterange').datepicker({
});
</script>