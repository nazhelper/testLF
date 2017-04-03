<%@ taglib uri="http://java.sun.com/portlet_2_0" prefix="portlet"%>
<%@ taglib uri="http://alloy.liferay.com/tld/aui" prefix="aui" %>
<portlet:defineObjects />

<div class="card hovercard">
	<div class="cardheader contact"></div>
	<div class=" text-left">
		<div class="panel-body">
			<h4><%//TODO leer variable título %></h4>
			<p><%//TODO leer variable texto introducción %></p>
		</div>
		<div class="panel-body">
			<aui:fieldset >
				<aui:layout>
	      			<aui:column columnWidth="50" first="true">
						<aui:input name="username" label="Your name" placeholder="name"  />
					</aui:column>
					<aui:column columnWidth="50" last="true">
						<%//TODO leer opciones de la config %>
						<aui:select name="areaSelect" label="Area">
							<aui:option value="human-resources">Human Resources</aui:option>
							<aui:option value="marketing">Marketing Department</aui:option>
						</aui:select>
					</aui:column>
				</aui:layout>
			</aui:fieldset>
			<aui:fieldset>
				<aui:column columnWidth="100" first="true" last="true">
					<aui:input name="comment" type="textarea" label="Your comment" rows="5" cols="5" placeholder="comment"></aui:input>
				</aui:column>
			</aui:fieldset>
		</div>
		<div class="panel-footer clearfix">
			<aui:button-row cssClass="btn-group pull-right" role="group">
				<aui:button icon="glyphicon glyphicon-send" cssClass="btn btn-info" name="saveButton" type="submit" class="btn btn-info" value="send" role="button" />
		
				<aui:button icon="flaticon-paint reducido" cssClass="btn btn-danger" name="cancelButton" type="button" value="cleaner" role="button" />
			</aui:button-row>
		</div>
	</div>
</div>
