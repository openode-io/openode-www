import Typed from 'typed.js'

export  var customizeTweetMedia = function () {
  // CSS Overrides
  $('.twitter-feed').find('.twitter-timeline').contents().find('.timeline-Tweet-media').css('display', 'none');
  $('.twitter-feed').find('.twitter-timeline').contents().find('span.TweetAuthor-screenName').css('font-size', '16px');
  $('.twitter-feed').find('.twitter-timeline').contents().find('p.timeline-tweet-text').css('font-size', '20px');
  $('.twitter-feed').find('.twitter-timeline').contents().find('p.timeline-tweet-text').css('line-height', '1.6');
  $('.twitter-feed').find('.twitter-timeline').contents().find('.timeline-TweetList-tweet').css({'border-bottom':'1px solid #252829','padding-bottom':'20px','margin-bottom':'20px'});

  // Call the function on dynamic updates in addition to page load
  $('.twitter-feed').find('.twitter-timeline').contents().find('.timeline-TweetList').bind('DOMSubtreeModified propertychange', function () {
      customizeTweetMedia(this);
  });
}

document.addEventListener("turbolinks:load", function() {
  const el = document.querySelector('.typed');

  if (el){
    new Typed('.typed', {
      strings: ["Fast","^1500 Open","^1500 Advanced", "^1500 Frictionless"],
      typeSpeed: 80
    });
  }

  // Twitter Overrides -----------------------------------------------------------------------------
  $('.twitter-feed').delegate('#twitter-widget-0', 'DOMSubtreeModified propertychange', function () {
    customizeTweetMedia();
  });  
})
