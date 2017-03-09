/**
 * 
 */
	$(function () {
		$(window).scroll(function () {
			if (jQuery(this).scrollTop() > 200) {
				$('.irarriba').removeClass('oculto').fadeIn();
				} else {
				$('.irarriba').fadeOut()
			}
		});
		
		$('.irarriba').click(function () {
			$('body,html').animate({
			scrollTop: 0
			}, 800);
			return false;
		});
	});