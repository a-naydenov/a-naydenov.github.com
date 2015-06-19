// sequence photo panorama
(function() {
  $(document).ready(function() {
    $('.photo').on('mouseover', function() {
      return $('.sequence').fadeIn();
    });
    $('.sequence').on('mouseleave', function() {
      return $('.sequence').fadeOut();
    });
    $('.sequence').on('mousemove', function(e) {
      var parentOffset, step, x;
      parentOffset = $(this).parent().offset();
      x = e.pageX - parentOffset.left;
      step = Math.round((x - 300) / (300 / 8)) * 300;
      return $('.sequence').css('background-position', step + 'px 0px');
    });
  });
}).call(this);

// hover link
      $(function() {
        EL.grafotarHover('.grafotar li a');
      });(function () {
    var e, t, n;
    window.EL = {
        grafotarHover: function (e) {
            return $(e).on("hover", function (e) {
                return $(this).siblings("a").toggleClass("inactive")
            })
        }
    };
}).call(this);

// Slow scroolTo #blog
      $(function() {
    $('a[href^="#"]').bind('click.smoothscroll',function (e) {
        e.preventDefault();
        var target = this.hash,
        $target = $(target);
        // $('html, body').stop().animate( {
        $('html, body').animate({
            'scrollTop': $target.offset().top
        },400);
    } );
} );