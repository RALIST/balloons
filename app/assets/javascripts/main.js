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
	$('.fa-bars').on('click', 
		function(){
			$('.responsive-menu-list').toggle('slide', 'slow');
		});
});

$(document).ready(function(){
	$('.sub').on('click', function(){
		$('ul:first', this).toggle('slow');
	});
});