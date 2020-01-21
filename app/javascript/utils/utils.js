import Typed from 'typed.js'
import Termynal from './termynal.js';

document.addEventListener("turbolinks:load", function() {

  const el = document.querySelector('.typed');  

  if ($("#termynal").length > 0){
    let termynalActive = false;
    const termynal = new Termynal('#termynal', { startDelay: 1000, lineDelay: 1500, noInit: true });
    const termynalOffsetTop = $("#termynal-breakpoint").offset().top;

    $(window).scroll(function(){
      const termynalScrollTop = ($(window).scrollTop() + 300);

      if(termynalScrollTop > termynalOffsetTop && !termynalActive){
        termynal.init();
        termynalActive = true;
      }
    });    
  }

  if (el){
    new Typed('.typed', {
      strings: ["Fast","^1500 Open","^1500 Advanced", "^1500 Frictionless"],
      typeSpeed: 80
    });
  }

  if ($(".twitter-timeline")) {
    // Twitter Overrides ------------------------------------------------------------------------
    $('.twitter-feed')
      .delegate('iframe[data-widget-id="profile:opeNodeio"]', 'DOMSubtreeModified propertychange',
        function () {
          $('.twitter-feed')
            .find('.twitter-timeline')
            .contents()
            .find('.timeline-Tweet-media')
            .css('display', 'none');

          $('.twitter-feed')
            .find('.twitter-timeline')
            .contents()
            .find('span.TweetAuthor-screenName')
            .css('font-size', '16px');

          $('.twitter-feed')
            .find('.twitter-timeline')
            .contents()
            .find('p.timeline-tweet-text')
            .css('font-size', '20px');

          $('.twitter-feed')
            .find('.twitter-timeline')
            .contents()
            .find('p.timeline-tweet-text')
            .css('line-height', '1.6');

          $('.twitter-feed')
            .find('.twitter-timeline')
            .contents()
            .find('.timeline-Tweet')
            .css(
                  {
                    'border-bottom':'1px solid #252829',
                    'padding-bottom':'20px',
                    'margin-bottom':'20px'
                  }
                );
      });

  }

  $(".show_hide_password a").on('click', function(event) {
    event.preventDefault();

    if($(this).parents('.input-group').find('input').attr("type") == "text"){
      $(this).parents('.input-group').find('input').attr('type', 'password');
      $(this).parents('.input-group').find('i').addClass( "fa-eye-slash" );
      $(this).parents('.input-group').find('i').removeClass( "fa-eye" );
    }else if($(this).parents('.input-group').find('input').attr("type") == "password"){
      $(this).parents('.input-group').find('input').attr('type', 'text');
      $(this).parents('.input-group').find('i').removeClass( "fa-eye-slash" );
      $(this).parents('.input-group').find('i').addClass( "fa-eye" );
    }
  });      

  const alert = $('div.alert.auto-close');

  alert.each(function() {
    var that = $(this);
    setTimeout(function() {
      that.alert('close');
    }, 3000);
  });

  // Toggle the side navigation
  $("#sidebarToggle, #sidebarToggleTop").on('click', function(e) {
    $("body").toggleClass("sidebar-toggled");
    $(".sidebar").toggleClass("toggled");
    if ($(".sidebar").hasClass("toggled")) {
      $('.sidebar .collapse').collapse('hide');
    };
  });

  // Close any open menu accordions when window is resized below 768px
  $(window).resize(function() {
    if ($(window).width() < 768) {
      $('.sidebar .collapse').collapse('hide');
    };
    
    // Toggle the side navigation when window is resized below 480px
    if ($(window).width() < 480 && !$(".sidebar").hasClass("toggled")) {
      $("body").addClass("sidebar-toggled");
      $(".sidebar").addClass("toggled");
      $('.sidebar .collapse').collapse('hide');
      $('.nav-link .fas').addClass('fa-2x');
    };
  });

  // Prevent the content wrapper from scrolling when the fixed side navigation hovered over
  $('body.fixed-nav .sidebar').on('mousewheel DOMMouseScroll wheel', function(e) {
    if ($(window).width() > 768) {
      var e0 = e.originalEvent,
        delta = e0.wheelDelta || -e0.detail;
      this.scrollTop += (delta < 0 ? 1 : -1) * 30;
      e.preventDefault();
    }
  });

  // Scroll to top button appear
  $(document).on('scroll', function() {
    var scrollDistance = $(this).scrollTop();
    if (scrollDistance > 100) {
      $('.scroll-to-top').fadeIn();
    } else {
      $('.scroll-to-top').fadeOut();
    }
  });

  // Smooth scrolling using jQuery easing
  $(document).on('click', 'a.scroll-to-top', function(e) {
    var $anchor = $(this);
    $('html, body').stop().animate({
      scrollTop: ($($anchor.attr('href')).offset().top)
    }, 1000, 'easeInOutExpo');
    e.preventDefault();
  });  
});
