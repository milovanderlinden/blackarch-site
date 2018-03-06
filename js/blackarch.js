//Slider
$('.carousel').carousel({
    interval: 5000 //changes the speed
})

$(document).off('click', '.act-bitcoin');
$(document).on('click', '.act-bitcoin', function() {
	$('.act-display').hide().empty();
	$('.act-display').html('151ZXUgyVRRtzBeUEEJuksMiw5BD585eQL').fadeIn();
});

$(document).off('click', '.act-cash');
$(document).on('click', '.act-cash', function() {
	$('.act-display').hide().empty();
	$('.act-display').html('Available soon').fadeIn();
});

$(document).off('click', '.act-cc');
$(document).on('click', '.act-cc', function() {
	$('.act-display').hide().empty();
	$('.act-display').html('Available soon').fadeIn();
});
