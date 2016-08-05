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
      step = Math.round((x - 232) / (232 / 8)) * 232;
      return $('.sequence').css('background-position', step + 'px 0px');
    });
  });
}).call(this);