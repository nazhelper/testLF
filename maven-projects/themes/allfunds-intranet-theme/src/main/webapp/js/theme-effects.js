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
	
});
