$(document).ready(function(){
	$('.left-options li ul').hide();
	$('li').hover(function(){
		$('ul:first', this).fadeIn();
	},
		function(){
			$('ul:first', this).fadeOut();
		}
	);
});


$(document).ready(function(){
	$('.fa').on('click', 
		function(){
			$('.responsive-menu-list').toggle('slow')
		});
});