/**
 * 
 */

var modal = document.getElementById('myModal');

var img = document.getElementById('myImg');
var modalImg = document.getElementById("img01");
var captionText = document.getElementById("caption");
img.onclick = function(){
    modal.style.display = "block";
    modalImg.src = this.src;
    captionText.innerHTML = this.alt;
}

var span = document.getElementsByClassName("close")[0];

span.onclick = function() { 
    modal.style.display = "none";
}

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
