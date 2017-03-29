	$(function () { 
		$("[rel='tooltip']").tooltip();
		$("[rel]").tooltip();        
	 
		$('.thumbnail').hover(
			function(){
				$(this).find('.caption').slideDown(250); //.fadeIn(250)
			},
			function(){
				$(this).find('.caption').slideUp(250); //.fadeOut(205)
			}
		); 
	});
	
$(function() {
	$(window).scroll(function() {
		if (jQuery(this).scrollTop() > 200) {
			$('.irarriba').removeClass('oculto').fadeIn();
		} else {
			$('.irarriba').fadeOut()
		}
	});

	$('.irarriba').click(function() {
		$('body,html').animate({
			scrollTop : 0
		}, 800);
		return false;
	});
});

$(function() {
	var accordion = $(".panel-accordion").parent();
	
	accordion.accordion({
		active: 1,
		collapsible : true,
		animate: 200
	});
});

$(document).ready(function(){

	$('.linkToVideoJquery').click(function(){
		var index = $('.linkToVideoJquery').index(this);
		  $('.videoCommunicationJquery').get(index).play();
	});
	
	$('.closeButtonJquery').click(function(){
		var index = $('.closeButtonJquery').index(this);
		  $('.videoCommunicationJquery').get(index).pause();
	});
	
	$.fn.extend({
		treed: function (o) {
		  
		  var openedClass = 'glyphicon-minus-sign';
		  var closedClass = 'glyphicon-plus-sign';
		  
		  if (typeof o != 'undefined'){
			if (typeof o.openedClass != 'undefined'){
			openedClass = o.openedClass;
			}
			if (typeof o.closedClass != 'undefined'){
			closedClass = o.closedClass;
			}
		  };
		  
			//initialize each of the top levels
			var tree = $(this);
			var len = tree.find('li').has("ul").length;
			tree.addClass("tree");
			tree.find('li').has("ul").each(function () {
				var branch = $(this); //li with children ul
				branch.prepend("<i class='indicator glyphicon " + closedClass + "'></i>");
				branch.addClass('branch');
				branch.on('click', function (e) {
					if (this == e.target) {
						var icon = $(this).children('i:first');
						icon.toggleClass(openedClass + " " + closedClass);
						$(this).children().children().toggle();
					}
				})
				branch.children().children().toggle();
			});
			//fire event from the dynamically added icon
		  tree.find('.branch .indicator').each(function(){
			$(this).on('click', function () {
				$(this).closest('li').click();
			});
		  });
			//fire event to open branch if the li contains an anchor instead of text
			tree.find('.branch>a').each(function () {
				$(this).on('click', function (e) {
					$(this).closest('li').click();
					e.preventDefault();
				});
			});
			//fire event to open branch if the li contains a button instead of text
			tree.find('.branch>button').each(function () {
				$(this).on('click', function (e) {
					$(this).closest('li').click();
					e.preventDefault();
				});
			});
		}
	});
	
	$('').treed();
	
	$('#tree1').treed({openedClass:'glyphicon-folder-open', closedClass:'glyphicon-folder-close'});
	
	$('').treed({openedClass:'glyphicon-chevron-right', closedClass:'glyphicon-chevron-down'});
	
	
	
	
	
});
