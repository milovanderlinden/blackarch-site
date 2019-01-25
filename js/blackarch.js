/*$(document).off('click', '.act-bitcoin');
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
});*/

document.addEventListener('DOMContentLoaded', function () {
  var options;
  var elem = document.querySelector('.sidenav');
  var instance = M.Sidenav.init(elem, options);
  // Get all "navbar-burger" elements
  var $navbarBurgers = Array.prototype.slice.call(document.querySelectorAll('.navbar-burger'), 0);
  //var elem = document.querySelector('.dropdown-trigger');
  //var options = {};
  //var instance = M.Dropdown.init(elem, options);

  // Check if there are any navbar burgers
  if ($navbarBurgers.length > 0) {

    // Add a click event on each of them
    $navbarBurgers.forEach(function ($el) {
      $el.addEventListener('click', function () {

        // Get the target from the "data-target" attribute
        var target = $el.dataset.target;
        var $target = document.getElementById(target);

        // Toggle the class on both the "navbar-burger" and the "navbar-menu"
        $el.classList.toggle('is-active');
        $target.classList.toggle('is-active');

      });
    });
  }
  // Carousel
  var carousel = document.getElementById('header-carousel');
  M.Carousel.init(carousel, {
    fullWidth: true,
    indicators: true
  });
  setInterval(function(){
    var instance = M.Carousel.getInstance(carousel);
    instance.next()
  },5000);

});