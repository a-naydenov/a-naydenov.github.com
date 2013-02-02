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