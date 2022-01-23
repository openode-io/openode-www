import Typed from 'typed.js'
import Termynal from './termynal.js'
import {Terminal} from './terminal.js'

require('jvectormap')
require('./jvectormap_world_mill')

document.addEventListener('turbolinks:load', function () {
  const el = document.querySelector('.typed')

  if ($('#termynal').length > 0) {
    let termynalActive = false
    const termynal = new Termynal('#termynal', { startDelay: 1000, lineDelay: 1500, noInit: true })
    const termynalOffsetTop = $('#termynal-breakpoint').offset().top

    $(window).scroll(function () {
      const termynalScrollTop = ($(window).scrollTop() + 300)

      if (termynalScrollTop > termynalOffsetTop && !termynalActive) {
        termynal.init()
        termynalActive = true
      }
    })
  }

  if (el) {
    new Typed('.typed', {
      strings: ['Stateless', '^1500 Fast', '^1500 Open', '^1500 Frictionless'],
      typeSpeed: 80
    })
  }

  if ($('.twitter-timeline')) {
    // Twitter Overrides ------------------------------------------------------------------------
    $('.twitter-feed')
      .delegate('iframe[data-widget-id="profile:opeNodeio"]', 'DOMSubtreeModified propertychange',
        function () {
          $('.twitter-feed')
            .find('.twitter-timeline')
            .contents()
            .find('.timeline-Tweet-media')
            .css('display', 'none')

          $('.twitter-feed')
            .find('.twitter-timeline')
            .contents()
            .find('span.TweetAuthor-screenName')
            .css('font-size', '16px')

          $('.twitter-feed')
            .find('.twitter-timeline')
            .contents()
            .find('p.timeline-tweet-text')
            .css('font-size', '20px')

          $('.twitter-feed')
            .find('.twitter-timeline')
            .contents()
            .find('p.timeline-tweet-text')
            .css('line-height', '1.6')

          $('.twitter-feed')
            .find('.twitter-timeline')
            .contents()
            .find('.timeline-Tweet')
            .css(
              {
                'border-bottom': '1px solid #252829',
                'padding-bottom': '20px',
                'margin-bottom': '20px'
              }
            )
        })
  }

  $('.show_hide_password a.password-toggler').on('click', function (event) {
    event.preventDefault()

    if ($(this).parents('.input-group').find('input').attr('type') == 'text') {
      $(this).parents('.input-group').find('input').attr('type', 'password')
      $(this).parents('.input-group').find('i.password-toggler').addClass('fa-eye-slash')
      $(this).parents('.input-group').find('i.password-toggler').removeClass('fa-eye')
    } else if ($(this).parents('.input-group').find('input').attr('type') == 'password') {
      $(this).parents('.input-group').find('input').attr('type', 'text')
      $(this).parents('.input-group').find('i.password-toggler').removeClass('fa-eye-slash')
      $(this).parents('.input-group').find('i.password-toggler').addClass('fa-eye')
    }
  })

  const alert = $('div.alert.auto-close')

  alert.each(function () {
    var that = $(this)
    setTimeout(function () {
      that.alert('close')
    }, 3000)
  })

  // Toggle the side navigation
  $('#sidebarToggle, #sidebarToggleTop').on('click', function (e) {
    $('body').toggleClass('sidebar-toggled')
    $('.sidebar').toggleClass('toggled')
    if ($('.sidebar').hasClass('toggled')) {
      $('.sidebar .collapse').collapse('hide')
    };
  })

  // Close any open menu accordions when window is resized below 768px
  $(window).resize(function () {
    if ($(window).width() < 768) {
      $('.sidebar .collapse').collapse('hide')
    };

    // Toggle the side navigation when window is resized below 480px
    if ($(window).width() < 480 && !$('.sidebar').hasClass('toggled')) {
      $('body').addClass('sidebar-toggled')
      $('.sidebar').addClass('toggled')
      $('.sidebar .collapse').collapse('hide')
      $('.nav-link .fas').addClass('fa-2x')
    };
  })

  // Prevent the content wrapper from scrolling when the fixed side navigation hovered over
  $('body.fixed-nav .sidebar').on('mousewheel DOMMouseScroll wheel', function (e) {
    if ($(window).width() > 768) {
      var e0 = e.originalEvent
      var delta = e0.wheelDelta || -e0.detail
      this.scrollTop += (delta < 0 ? 1 : -1) * 30
      e.preventDefault()
    }
  })

  // Scroll to top button appear
  $(document).on('scroll', function () {
    var scrollDistance = $(this).scrollTop()
    if (scrollDistance > 100) {
      $('.scroll-to-top').fadeIn()
    } else {
      $('.scroll-to-top').fadeOut()
    }
  })

  // Smooth scrolling using jQuery easing
  $(document).on('click', 'a.scroll-to-top', function (e) {
    var $anchor = $(this)
    $('html, body').stop().animate({
      scrollTop: ($($anchor.attr('href')).offset().top)
    }, 1000, 'easeInOutExpo')
    e.preventDefault()
  })

  if ($('#world-map').length > 0){
    $('#world-map').vectorMap({
      map: 'world_mill',
      scaleColors: ['#C8EEFF', '#0071A4'],
      normalizeFunction: 'polynomial',
      hoverOpacity: 0.7,
      hoverColor: false,
      zoomOnScroll: false,
      markerStyle: {
        initial: {
          fill: '#F8E23B',
          stroke: '#383f47'
        }
      },
      backgroundColor: '#1a1a1a',
      markers: JSON.parse($('#world-map').attr('data-locations'))
    });
  }

  $('#website_plan').on('change', function(e){
    if($(this).val() == 'open_source'){
      $('#instance-plan-opensource-field').removeClass('d-none')
    }else{
      $('#instance-plan-opensource-field').addClass('d-none')
    }
  })

  $('.copy-to-clipboard').on('click', function(e){
    e.preventDefault();

    copyToClipboard($(this).parent().parent().find('input').val())

    $(this).find('i').addClass('text-success')
  })

  const copyToClipboard = str => {
    const el = document.createElement('textarea');  // Create a <textarea> element
    el.value = str;                                 // Set its value to the string that you want copied
    el.setAttribute('readonly', '');                // Make it readonly to be tamper-proof
    el.style.position = 'absolute';                 
    el.style.left = '-9999px';                      // Move outside the screen to make it invisible
    document.body.appendChild(el);                  // Append the <textarea> element to the HTML document
    const selected =            
      document.getSelection().rangeCount > 0        // Check if there is any content selected previously
        ? document.getSelection().getRangeAt(0)     // Store selection if found
        : false;                                    // Mark as false to know no selection existed before
    el.select();                                    // Select the <textarea> content
    document.execCommand('copy');                   // Copy - only works as a result of a user action (e.g. click events)
    document.body.removeChild(el);                  // Remove the <textarea> element
    if (selected) {                                 // If a selection existed before copying
      document.getSelection().removeAllRanges();    // Unselect everything on the HTML document
      document.getSelection().addRange(selected);   // Restore the original selection
    }
  };  

  if($('#terminal-container').length > 0){
    $('.prompt').html('openode# ');

    var term = new Terminal('#input-line .cmdline', '#terminal-container output');
    
    term.init();
  }
})