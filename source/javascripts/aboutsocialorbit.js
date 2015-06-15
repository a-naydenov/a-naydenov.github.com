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