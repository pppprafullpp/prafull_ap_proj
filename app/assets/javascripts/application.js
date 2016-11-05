// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require custom
//= require bootstrap-datetimepicker
//= require toastr
//= require_tree

$(document).ready(function() {


	 toastr.options = {
	                  "closeButton": false,
	                  "debug": false,
	                  "positionClass": "toast-bottom-right",
	                  "onclick": null,
	                  "showDuration": "300",
	                  "hideDuration": "1000",
	                  "timeOut": "5000",
	                  "extendedTimeOut": "1000",
	                  "showEasing": "swing",
	                  "hideEasing": "linear",
	                  "showMethod": "fadeIn",
	                  "hideMethod": "fadeOut"
	              }

	});

// css


jQuery(document).ready(function($) {

    /* checking if text-rotator in page exists */
    if($(".cd-headline").length == 0) return;

    //set animation timing
    var animationDelay = 3000,
        //loading bar effect
        barAnimationDelay = 3800,
        barWaiting = barAnimationDelay - 3000, //3000 is the duration of the transition on the loading bar - set in the scss/css file
        //letters effect
        lettersDelay = 70,
        //type effect
        typeLettersDelay = 150,
        selectionDuration = 500,
        typeAnimationDelay = selectionDuration + 800,
        //clip effect
        revealDuration = 600,
        revealAnimationDelay = 1500;

    initHeadline();

    function initHeadline() {
        //insert <i> element for each letter of a changing word
        singleLetters($('.cd-headline.letters').find('b'));
        //initialise headline animation
        animateHeadline($('.cd-headline'));
    }

    function singleLetters($words) {
        $words.each(function() {
            var word = $(this),
                letters = word.text().split(''),
                selected = word.hasClass('is-visible');
            for (i in letters) {
                if (word.parents('.rotate-2').length > 0) letters[i] = '<em>' + letters[i] + '</em>';
                letters[i] = (selected) ? '<i class="in">' + letters[i] + '</i>' : '<i>' + letters[i] + '</i>';
            }
            var newLetters = letters.join('');
            word.html(newLetters).css('opacity', 1);
        });
    }

    function animateHeadline($headlines) {
        var duration = animationDelay;
        $headlines.each(function() {
            var headline = $(this);

            if (headline.hasClass('loading-bar')) {
                duration = barAnimationDelay;
                setTimeout(function() {
                    headline.find('.cd-words-wrapper').addClass('is-loading')
                }, barWaiting);
            } else if (headline.hasClass('clip')) {
                var spanWrapper = headline.find('.cd-words-wrapper'),
                    newWidth = spanWrapper.width() + 10
                spanWrapper.css('width', newWidth);
            } else if (!headline.hasClass('type')) {
                //assign to .cd-words-wrapper the width of its longest word
                var words = headline.find('.cd-words-wrapper b'),
                    width = 0;
                words.each(function() {
                    var wordWidth = $(this).width();
                    if (wordWidth > width) width = wordWidth;
                });
                headline.find('.cd-words-wrapper').css('width', width + 60);
            };

            //trigger animation
            setTimeout(function() {
                hideWord(headline.find('.is-visible').eq(0))
            }, duration);
        });
    }

    function hideWord($word) {
        var nextWord = takeNext($word);

        if ($word.parents('.cd-headline').hasClass('type')) {
            var parentSpan = $word.parent('.cd-words-wrapper');
            parentSpan.addClass('selected').removeClass('waiting');
            setTimeout(function() {
                parentSpan.removeClass('selected');
                $word.removeClass('is-visible').addClass('is-hidden').children('i').removeClass('in').addClass('out');
            }, selectionDuration);
            setTimeout(function() {
                showWord(nextWord, typeLettersDelay)
            }, typeAnimationDelay);

        } else if ($word.parents('.cd-headline').hasClass('letters')) {
            var bool = ($word.children('i').length >= nextWord.children('i').length) ? true : false;
            hideLetter($word.find('i').eq(0), $word, bool, lettersDelay);
            showLetter(nextWord.find('i').eq(0), nextWord, bool, lettersDelay);

        } else if ($word.parents('.cd-headline').hasClass('clip')) {
            $word.parents('.cd-words-wrapper').animate({
                width: '2px'
            }, revealDuration, function() {
                switchWord($word, nextWord);
                showWord(nextWord);
            });

        } else if ($word.parents('.cd-headline').hasClass('loading-bar')) {
            $word.parents('.cd-words-wrapper').removeClass('is-loading');
            switchWord($word, nextWord);
            setTimeout(function() {
                hideWord(nextWord)
            }, barAnimationDelay);
            setTimeout(function() {
                $word.parents('.cd-words-wrapper').addClass('is-loading')
            }, barWaiting);

        } else {
            switchWord($word, nextWord);
            setTimeout(function() {
                hideWord(nextWord)
            }, animationDelay);
        }
    }

    function showWord($word, $duration) {
        if ($word.parents('.cd-headline').hasClass('type')) {
            showLetter($word.find('i').eq(0), $word, false, $duration);
            $word.addClass('is-visible').removeClass('is-hidden');

        } else if ($word.parents('.cd-headline').hasClass('clip')) {
            $word.parents('.cd-words-wrapper').animate({
                'width': $word.width() + 10
            }, revealDuration, function() {
                setTimeout(function() {
                    hideWord($word)
                }, revealAnimationDelay);
            });
        }
    }

    function hideLetter($letter, $word, $bool, $duration) {
        $letter.removeClass('in').addClass('out');

        if (!$letter.is(':last-child')) {
            setTimeout(function() {
                hideLetter($letter.next(), $word, $bool, $duration);
            }, $duration);
        } else if ($bool) {
            setTimeout(function() {
                hideWord(takeNext($word))
            }, animationDelay);
        }

        if ($letter.is(':last-child') && $('html').hasClass('no-csstransitions')) {
            var nextWord = takeNext($word);
            switchWord($word, nextWord);
        }
    }

    function showLetter($letter, $word, $bool, $duration) {
        $letter.addClass('in').removeClass('out');

        if (!$letter.is(':last-child')) {
            setTimeout(function() {
                showLetter($letter.next(), $word, $bool, $duration);
            }, $duration);
        } else {
            if ($word.parents('.cd-headline').hasClass('type')) {
                setTimeout(function() {
                    $word.parents('.cd-words-wrapper').addClass('waiting');
                }, 200);
            }
            if (!$bool) {
                setTimeout(function() {
                    hideWord($word)
                }, animationDelay)
            }
        }
    }

    function takeNext($word) {
        return (!$word.is(':last-child')) ? $word.next() : $word.parent().children().eq(0);
    }

    function takePrev($word) {
        return (!$word.is(':first-child')) ? $word.prev() : $word.parent().children().last();
    }

    function switchWord($oldWord, $newWord) {
        $oldWord.removeClass('is-visible').addClass('is-hidden');
        $newWord.removeClass('is-hidden').addClass('is-visible');
    }
    $(window).resize(function() {
        headline = $('.cd-headline');
        if (!headline.hasClass('type')) {
            //assign to .cd-words-wrapper the width of its longest word
            var words = headline.find('.cd-words-wrapper b'),
                width = 0;
            words.each(function() {
                var wordWidth = $(this).width();
                if (wordWidth > width) width = wordWidth;
            });
            headline.find('.cd-words-wrapper').css('width', width);
        };
    });
});

/*===================================
    Youtube video background
 ===================================*/

(function(){

    if(!$('.header-video').html()) return;
    $("#videoBackground").mb_YTPlayer();

    $('#video-play').click(function(event) {
        event.preventDefault();
        if ($(this).hasClass('ion-ios-play-outline')) {
            $('#videoBackground').playYTP();
        } else {
            $('#videoBackground').pauseYTP();
        }
        $(this).toggleClass('ion-ios-play-outline ion-ios-pause-outline');
        return false;
    });

    $('#video-volume').click(function(event) {
        event.preventDefault();
        if ($(this).hasClass('ion-android-volume-off')) {
            $('#videoBackground').YTPUnmute();
        } else {
            $('#videoBackground').YTPMute();
        }
        $(this).toggleClass('ion-android-volume-off ion-android-volume-up');
        return false;
    });
})();



/*=====================================================
    Header Owl carousel
========================================================*/
(function(){
    if(!$('#owl-hs-carousel').html()) return;

    $("#owl-hs-carousel").owlCarousel({
        itemElement: 'item',
        animateOut: 'fadeOut',
        animateIn: 'fadeIn',
        items: 1,
        loop:true,
        autoplay: true,
        autoplaySpeed: 1000,
        autoplayTimeout : 5000,
        nav: true,
        // lazyLoad: true,
        // lazyContent: true,
        navText: ["<span class='ion-ios-arrow-left'></span>","<span class='ion-ios-arrow-right'></span>"]
    });

})();


$( document ).ready(function() {

    /*-------------------------------------
        Down Arrow button
    -------------------------------------*/

    $(".down-arrow").click(function(e) {
         e.preventDefault();
        $('html, body').animate({
            scrollTop: $(".down-arrow-dest").offset().top
        },1500,'easeInOutExpo');
    });

    /*-------------------------------------
        Back to Top button
    -------------------------------------*/
    $(".footer-btn").click(function(e) {
         e.preventDefault();
        $('html, body').animate({
            scrollTop: $('main').offset().top
        },1500,'easeOutQuart');
    });


    /*-------------------------------------
        menu single page scroll
    -------------------------------------*/



    // adds solid navbar on scroll

    (function(){

        var $nav = $('.menuzord');

        function navbarAnimation() {
            if ($(window).scrollTop() > 100) {
                // $nav.addClass('navbar-solid');
                //$nav.css("position: fixed");
                return;
            }

            $nav.removeClass('navbar-solid');
            $(".navbar-nav > li > a").blur();
        }

        navbarAnimation();

        $(window).scroll(function() {
            navbarAnimation();
        });

    })();

    //top navbar animation
    (function(){

         var $nav = $('.topbar-menubar');

         function topNavbarAnimation() {
            if ($(window).innerWidth() > 768 && $(window).scrollTop() > 73) {
                $nav.addClass('menubar-fixed');
                return;
            }

            $nav.removeClass('menubar-fixed');
            $(".navbar-nav > li > a").blur();
        }

        $(window).scroll(function() {
                      topNavbarAnimation();
                    });

            $(window).resize(function(){
                //$nav.removeClass('menubar-fixed');
                if($(window).innerWidth() > 768){
                     $(window).scroll(function() {
                      topNavbarAnimation();
                    });
                }
            })
    })();

    (function(){

        var $nav = $('.overlay-menu-wrap');

        function navbarAnimation() {
            if ($(window).scrollTop() > 768) {
                $nav.addClass('solid');
                return;
            }

            $nav.removeClass('solid');
            $(".navbar-nav > li > a").blur();
        }

        navbarAnimation();

        $(window).scroll(function() {
            navbarAnimation();
        });

    })();



    $('.icon-3-col .row:first-child').addClass('m-t-0');

    //fixed bootstrap scroll spy
    $('.menuzord').on('activate.bs.scrollspy', function () {
        $(".menuzord-menu > li[class='active'] > a").focus();
    });

    //menubar

    jQuery("#menuzord").menuzord({
        showDelay: 50,
        effect: "fade",
        indicatorFirstLevel:"&#xf3d0;"
    });


    /*===============================================================
                Working Contact Form
    ================================================================*/

    $("#contactForm").submit(function (e) {

        e.preventDefault();
        var $ = jQuery;

        var postData = $(this).serializeArray(),
            formURL = $(this).attr("action"),
            $cfResponse = $('#contactFormResponse'),
            $cfsubmit = $("#cfsubmit"),
            cfsubmitText = $cfsubmit.text();

        $cfsubmit.text("Sending...");


        $.ajax(
            {
                url: formURL,
                type: "POST",
                data: postData,
                success: function (data) {
                    $cfResponse.html(data);
                    $cfsubmit.text(cfsubmitText);
                    $('#contactForm input[name=name]').val('');
                    $('#contactForm input[name=email]').val('');
                    $('#contactForm textarea[name=message]').val('');
                },
                error: function (data) {
                    alert("Error occurd! Please try again");
                }
            });

        return false;

    });



/*===============================================================
                Working Request Form
    ================================================================*/

    $("#requestForm").submit(function (e) {

        e.preventDefault();
        var $ = jQuery;

        var postData = $(this).serializeArray(),
            formURL = $(this).attr("action"),
            $cfResponse = $('#requestFormResponse'),
            $cfsubmit = $("#rfsubmit"),
            cfsubmitText = $cfsubmit.text();

        $cfsubmit.text("Sending...");


        $.ajax(
            {
                url: formURL,
                type: "POST",
                data: postData,
                success: function (data) {
                    $cfResponse.html(data);
                    $cfsubmit.text(cfsubmitText);
                    $('#requestForm input[name=name]').val('');
                    $('#requestForm input[name=email]').val('');
                    $('#requestForm textarea[name=message]').val('');
                },
                error: function (data) {
                    alert("Error occurd! Please try again");
                }
            });

        return false;

    });


    /*---------------------------------------------------
                Carousel for Testimonial
    ----------------------------------------------------*/

    $('#testimonial-slider').owlCarousel({
        items:1,
        margin:0,
        autoHeight:true,
        dots: true,
    });

    $('#testimonial-slider-2').owlCarousel({
        items:1,
        margin:0,
        autoHeight:true,
        dots: true,
        rtl: true, // turn it on for RTL version
    });

    $('#testimonial-classic-slider').owlCarousel({
        items:1,
        margin:0,
        autoHeight:true,
        dots: true,
        autoplay: true
    });


    /*---------------------------------------------------
                Carousel for Partner Logo
    ----------------------------------------------------*/

    $('#partners-slider').owlCarousel({
        margin: 10,
        loop:true,
        autoPlay : 3000,
        responsive:{
            0:{
                items:2
            },
            600:{
                items:4
            },
            1000:{
                items:5
            }
        },
        autoplay: true,
    });

    $('#partners-slider-2').owlCarousel({
        margin: 10,
        loop:true,
        autoPlay : 3000,
        responsive:{
            0:{
                items:2
            },
            600:{
                items:4
            },
            1000:{
                items:5
            }
        },
        autoplay: true,
        rtl: true, // turn it on for RTL version
    });


    /*---------------------------------------------------
                Carousel for Projects
    ----------------------------------------------------*/

    $('#projects-slider').owlCarousel({
        margin: 10,
        loop:true,
        autoPlay : 3000,
        responsive:{
            0:{
                items:1
            },
            600:{
                items:2
            },
            1000:{
                items:3
            }
        },
        autoplay: true,
        /*nav: true,
        navText: ["\f3d3", "\f3d2"],*/
        dots: true,
        //rtl: true // turn it on for RTL version
    });




    /*---------------------------------------------------
                Google Map
    ----------------------------------------------------*/

    if(0!=$("#map").length){
        var map = new GMaps({
        div: '#map',
        lat: 23.790223,
        lng: 90.414036,
        scrollwheel: false,
        // How you would like to style the map.
        // This is where you would paste any style found on Snazzy Maps.
        styles: [{"featureType":"administrative.locality","elementType":"all","stylers":[{"hue":"#2c2e33"},{"saturation":7},{"lightness":19},{"visibility":"on"}]},{"featureType":"landscape","elementType":"all","stylers":[{"hue":"#ffffff"},{"saturation":-100},{"lightness":100},{"visibility":"simplified"}]},{"featureType":"poi","elementType":"all","stylers":[{"hue":"#ffffff"},{"saturation":-100},{"lightness":100},{"visibility":"off"}]},{"featureType":"road","elementType":"geometry","stylers":[{"hue":"#bbc0c4"},{"saturation":-93},{"lightness":31},{"visibility":"simplified"}]},{"featureType":"road","elementType":"labels","stylers":[{"hue":"#bbc0c4"},{"saturation":-93},{"lightness":31},{"visibility":"on"}]},{"featureType":"road.arterial","elementType":"labels","stylers":[{"hue":"#bbc0c4"},{"saturation":-93},{"lightness":-2},{"visibility":"simplified"}]},{"featureType":"road.local","elementType":"geometry","stylers":[{"hue":"#e9ebed"},{"saturation":-90},{"lightness":-8},{"visibility":"simplified"}]},{"featureType":"transit","elementType":"all","stylers":[{"hue":"#e9ebed"},{"saturation":10},{"lightness":69},{"visibility":"on"}]},{"featureType":"water","elementType":"all","stylers":[{"hue":"#e9ebed"},{"saturation":-78},{"lightness":67},{"visibility":"simplified"}]}]
        })

        map.addMarker({
            lat: 23.790223,
            lng: 90.414036,
            title: 'mountain',
            infoWindow: {
                content: '<span class="map-header"><b>Mountain Headquarter</b><br/></span><span class="map-address">Build-A/6, Mirpur 14 , Dhaka</span'
            },
            icon:'assets/images/map/marker.png'
        });
    }// End Google map



    /*---------------------------------------------------
                Funfact
    ----------------------------------------------------*/

    (function () {
        if(!$('#funfacts').html()) return;
        var inview = new Waypoint.Inview({
            element: $('#funfacts')[0],
            enter: function (direction) {
                $('.count.number').each(function () {
                    $(this).prop('Counter', 0).animate({
                        Counter: $(this).text()
                    }, {
                        duration: 3000,
                        easing: 'swing',
                        step: function (now) {
                            $(this).text(Math.ceil(now));
                        }
                    });
                });
                this.destroy();
            }
        });

    })();





    /*------------------------------------------
                Subscribe form ajax
    ------------------------------------------*/

    $('#subscription-form').submit(function(e) {

        e.preventDefault();
        var $form           = $('#subscription-form');
        var submit          = $('#subscribe-button');
        var ajaxResponse    = $('#subscription-response');
        var email           = $('#subscriber-email').val();

        $.ajax({
            type: 'POST',
            url: 'php/subscribe.php',
            dataType: 'json',
            data: {
                email: email
            },
            cache: false,
            beforeSend: function(result) {
                submit.val("Joining...");
            },
            success: function(result) {
                if(result.sendstatus == 1) {
                    ajaxResponse.html(result.message);
                    $form.fadeOut(500);
                } else {
                    ajaxResponse.html(result.message);
                    submit.val("Join");
                }
            }
        });
    });//End of Subscribe form ajax

/*=====================================================
    Flickr widget
========================================================*/


var flickerAPI = "https://api.flickr.com/services/rest/?api_key=7a2dc9bed9dc21700704f273faaf89d7&format=json&nojsoncallback=1";
  $.get( flickerAPI, {
    method: "flickr.people.findByUsername",
    format: "json",
    username: 'Dullface'
  })
    .done(function(data ) {
         //console.log(data.user.nsid);
      var flickerAPI = "https://api.flickr.com/services/rest/?api_key=7a2dc9bed9dc21700704f273faaf89d7&format=json&nojsoncallback=1";
      $.getJSON( flickerAPI, {
        format: "json",
        user_id : data.user.nsid,
         method: "flickr.people.getPublicPhotos",
         extras : "url_t, url_s, url_q, url_m, url_n, url_z, url_c, url_l, url_o"
      })
    .done(function( data ) {
        //console.log(data);
        var photos = data.photos.photo;
      $.each( photos, function( i, item ) {
        if(item.url_m){
          var singleImgWrap = "<a class='gallery-popup' href="+item.url_o+"><img class='img-responsive' src="+item.url_q+" /></a>";
          $(".flickr-photo-wrap").append(singleImgWrap)
        }
        if ( i === 11 ) {
            //magnific popup
            $('.gallery-popup').magnificPopup({
                type:'image',
                // delegate: 'a',
                removalDelay: 300,
                mainClass: 'mfp-fade',
                 gallery:{
                    enabled:true
                  }
                // callbacks: {
                //     buildControls: function(){
                //         this.$('.img-box').append(this.arrowLeft.add(this.arrowRight));
                //     }
                // }
            });
          return false;
        }
      });
    });
    }).fail(function(error){

    });


    $('.gallery-popup').magnificPopup({
                type:'image',
                removalDelay: 300,
                mainClass: 'mfp-fade',
                 gallery:{
                    enabled:true
                  }
            });

    $('.inline-popup').magnificPopup({
        type:'inline',
        removalDelay: 300,
        mainClass: 'mfp-fade',
         gallery:{
            enabled:true
          }
    });

    $('.popup-youtube').magnificPopup({
        type:'iframe'
    });

/*=====================================================
    twitter widget
========================================================*/

(function(){

    function tweetFormatter(text){
        var urlRegex = /(https?:\/\/[^\s]+)/g;
        return text.replace(urlRegex,function(url){
            return '<a href="'+url+'">'+url+'</a>';
        })
    }

    function atTweetFormatter(atText){
        var atUrlRegex = /@\w+/g;
        return atText.replace(atUrlRegex,function(url){
            return '<a href="https://twitter.com/'+url+'">'+url+'</a>';
        })
    }

    function timeConversion(millisec) {

        var seconds = Math.ceil((millisec / 1000).toFixed(1));

        var minutes = Math.ceil((millisec / (1000 * 60)).toFixed(1));

        var hours = Math.ceil((millisec / (1000 * 60 * 60)).toFixed(1));

        var days = Math.ceil((millisec / (1000 * 60 * 60 * 24)).toFixed(1));

        if (seconds < 60) {
            return seconds + " Sec";
        } else if (minutes < 60) {
            return minutes + " Min";
        } else if (hours < 24) {
            return hours + " Hrs";
        } else {
            return days + " Days"
        }
    }

    var $twitterFeedEl = $('.twitter-feed');
    if( $twitterFeedEl.length > 0 ){
        $twitterFeedEl.each(function() {
            var element = $(this),
                twitterFeedUser = element.attr('data-username'),
                twitterFeedCount = element.attr('data-count');
            if( !twitterFeedUser ) { twitterFeedUser = 'twitter' }
            if( !twitterFeedCount ) { twitterFeedCount = 8 }

            $.getJSON('php/twitter/tweets.php?username='+ twitterFeedUser +'&count='+ twitterFeedCount, function(tweets){
                console.log(tweets);

                $.each(tweets,function(i,item){
                    //console.log(item.text);
                    var twitterText = tweetFormatter(item.text);
                    var formattedTweet = atTweetFormatter(twitterText);
                    var today = new Date();
                    var tweetTime = new Date(item.created_at);
                    var timeAgo = Math.abs(today.getTime() - tweetTime.getTime());
                    //var timeAgo = Math.abs(new Date() - new Date(item.created_at));
                    var diffDays= timeConversion(timeAgo);
                    var singleTweet = "<li class='single-tweet'>"+formattedTweet+"<span>about "+diffDays+" ago</span></li>"
                    $twitterFeedEl.append(singleTweet);
                })
            });
        });//json
    }
})();



});//end document ready









//Masonry portfolio
$(document).ready(function () {

    if($('.portfolio-grid')=='') return;

    var $grid = $('.portfolio-grid').imagesLoaded( function() {
      // init Masonry after all images have loaded
        $grid.masonry({
            itemSelector: '.portfolio-grid-item',
            columnWidth: '.grid-sizer',
            percentPosition: true,
        });
    });

    var elemWidth = $('.portfolio-grid-item').last().width();
    var elemHeight = $('.portfolio-grid-item').last().height();

    $('.load-more-portfolio').css({'height':elemHeight,'width': elemWidth});

    $('.load-more-portfolio').on('click',function(e){
            e.preventDefault();
            $(this).hide();
            jQuery.get('php/portfolio-load-more.php',function(newContent){
                var itemsToLoad = $(newContent).find('img');
                var itemsNum = $(itemsToLoad).length;
                // console.log(itemsToLoad);
                var newContents = $(newContent);
                $grid.append(newContents);
                $grid.masonry( 'appended', newContents );
            });

        })

});


$(document).ready(function () {
    $('.gallery-grid').isotope({
        // options
        itemSelector: '.gallery-grid-item',
        layoutMode: 'fitRows'
    });
});

/*---------  Masonry Gallery  ----------*/

$(window).on('load',  function() {

    var $c = $('.gallery-grid-masonry');
    if(typeof imagesLoaded == 'function') {
        imagesLoaded($c, function () {

            setTimeout(function () {
                var $test = $c.isotope({
                    itemSelector: '.gallery-grid-item',
                    resizesContainer: false,
                    layoutMode: 'masonry',
                    masonry: {
                        // use outer width of grid-sizer for columnWidth
                        columnWidth: '.grid-sizer'
                    },
                    filter: "*"
                });

            }, 100);

        });
    }

});


// portfolio sortable

$(document).ready(function () {
    $('.portfolio-grid-sortable').isotope({
      // options
       itemSelector: '.portfolio-grid-item',
        masonry: {
            // use element for option
            columnWidth: '.grid-sizer'
          }
    });
});


// filter items on button click
$(document).ready(function () {
    $('.filter-button-group').on( 'click', 'button', function() {
        var filterValue = $(this).attr('data-filter');
        $('.portfolio-grid-sortable').isotope({ filter: filterValue });
    });
});



/*===================================
    Youtube video Popup
 ===================================*/
$( document ).ready(function() {
    $('#btn_video_1').click(function(){
        event.preventDefault();
        $(this).hide();
        $('#video_thum_1').hide();
        $('#iframe_video_1').removeClass('hide');
    });
});




/*============================================================
                Video Pop Up
=============================================================*/

$('#btnVideo').magnificPopup({
    disableOn: 700,
    type: 'iframe',
    mainClass: 'mfp-fade',
    removalDelay: 160,
    preloader: false,
    fixedContentPos: false
});

$(window).resize(function(){
   var width = $(window).width();
   if(width < 768){
       $('#videoText').removeClass('p-r-0').addClass('section');
       $('.partial-bg').removeAttr("style");
       $('.lightbox-video img').addClass('center-block');
       $('#btnVideo').attr("target","_blank");
   }
   else{
       $('#videoText').removeClass('section').addClass('p-r-0');
   }
})
.resize();


/*=======================================================
            Coming Soon Countdown
========================================================*/

$(document).ready(function(){
    if($("#countDown").length == 0) return;

    $('#countDown').countdown({
        date: "January 01, 2017 00:00:00",
        render: function(data) {
            var el = $(this.el);
            el.empty()
                .append("<div class='countdown-box'><span class='counter'>" + this.leadingZeros(data.days, 2) + "</span><h6>Days</h6></div>")
                .append("<div class='countdown-box'><span class='counter'>" + this.leadingZeros(data.hours, 2) + "</span><h6>Hours</h6></div>")
                .append("<div class='countdown-box'><span class='counter'>" + this.leadingZeros(data.min, 2) + "</span><h6>Minutes</h6></div>")
                .append("<div class='countdown-box'><span class='counter'>" + this.leadingZeros(data.sec, 2) + "</span><h6>Seconds</h6></div>");
        }
    });
});


/*=======================================================
                Disqus Comment Box
==========================================================*/

(function(){

    /* checking if comments in page exists */
    if($("#disqus_thread").length == 0) return;

    /* discus */
    /* * * CONFIGURATION VARIABLES * * */
    var disqus_shortname = 'reigntemplate';

    /* * * DON'T EDIT BELOW THIS LINE * * */
    (function() {
        var dsq = document.createElement('script'); dsq.type = 'text/javascript'; dsq.async = true;
        dsq.src = '//' + disqus_shortname + '.disqus.com/embed.js';
        (document.getElementsByTagName('head')[0] || document.getElementsByTagName('body')[0]).appendChild(dsq);
    })();
})();

/*=====================================================
    Instagram Feed
========================================================*/

(function(){

    if($("#instafeed").length == 0) return;

    var feed = new Instafeed({
        get: 'user',
        userId: 94764,
        accessToken: '94764.1677ed0.c6256a27eddf41709ddf29af3469a4e5',
        limit: 6
    });
    feed.run();


})();



/*======================================================
                Single Portfolio Featured Carousel
======================================================*/

(function(){
    if(!$('#portfolio-carousel').html()) return;
    $("#portfolio-carousel").owlCarousel({
        items: 1,
        loop:true,
        autoplay: true,
        nav: true,
        autoPlay : 5000,
        navText: ["<span class='ion-ios-arrow-left'></span>","<span class='ion-ios-arrow-right'></span>"]
    });
})();



/*=====================================================
    expertise circle
========================================================*/

$(document).ready(function () {
    /*if(!$("#expertise-circle").html()) return;*/
    $('#expertise-circle-wraper').find('.expertise-circle').each(function(){
        var expertiesCirle='#'+$(this).attr('id');
        $(expertiesCirle).each(function(){
            var $this = $(this);
            var color = ($this.data('color'));
            var bgcolor = ($this.data('bg-color'));
            var circleValue =($this.data('value'))
            var inview = new Waypoint.Inview({
                element: $(this),
                enter: function (direction) {
                   $this.find(".expertise").radialProgress("init", {
                      'size': 150,
                      'fill': 3,
                      'color':color,
                      'background':bgcolor
                    }).radialProgress("to", {'perc': circleValue, 'time': 1000});
                   inview.destroy()
                }
            });
        });
    });

});

/*=====================================================
    menubar overlay
========================================================*/
(function() {
    if(!$('#trigger-overlay').html()) return;
    var triggerBttn = document.getElementById( 'trigger-overlay' ),
        overlay = document.querySelector( 'div.overlay' ),
        closeBttn = overlay.querySelector( 'button.overlay-close' );
        transEndEventNames = {
            'WebkitTransition': 'webkitTransitionEnd',
            'MozTransition': 'transitionend',
            'OTransition': 'oTransitionEnd',
            'msTransition': 'MSTransitionEnd',
            'transition': 'transitionend'
        },
        transEndEventName = transEndEventNames[ Modernizr.prefixed( 'transition' ) ],
        support = { transitions : Modernizr.csstransitions };

    function toggleOverlay() {
        if( classie.has( overlay, 'open' ) ) {
            classie.remove( overlay, 'open' );
            // classie.add( overlay, 'close' );
            // var onEndTransitionFn = function( ev ) {
            //     if( support.transitions ) {
            //         if( ev.propertyName !== 'visibility' ) return;
            //         this.removeEventListener( transEndEventName, onEndTransitionFn );
            //     }
            //     classie.remove( overlay, 'close' );
            // };
            // if( support.transitions ) {
            //     overlay.addEventListener( transEndEventName, onEndTransitionFn );
            // }
            // else {
            //     onEndTransitionFn();
            // }
        }
        else if( !classie.has( overlay, 'close' ) ) {
            classie.add( overlay, 'open' );
        }
    }

    triggerBttn.addEventListener( 'click', toggleOverlay );
    closeBttn.addEventListener( 'click', toggleOverlay );
})();



// Tabs

var mtnTab = function() {
    var width = $( window ).width();
    // alert(width);
    if(!$(".tab1")){
        return;
    }else{
        if( width < 768){
            $(".tab1 ul.nav.nav-pills").removeClass("nav-stacked");
        }else{
            $(".tab1 ul.nav.nav-pills").addClass("nav-stacked");
        }
    }
};

//$(document).ready(function(){
//    mountainLogo($( window ).width());
//});
//var mountainLogo = function(width){
//    $(".default-logo").css('display', 'block');
//    $(".dark-logo").css('display', 'none');
//}

//mtnTab();

//window.onresize = function(event) {
//    mtnTab();
//    mountainLogo($( window ).width());
//};


/*---------------------------------------------------
    WOW Initialization when pace loader is done
----------------------------------------------------*/
Pace.on('done', function(event){
    new WOW().init();
});


// Navigation bar animation
$(".menuzord").css({
    marginBottom: -($(".menuzord").height() + 1)
});

//$(window).scroll(function() {
//    var scroll = $(window).scrollTop();

//    if (scroll >= 600) {
//        $(".navigationbar-animation").addClass("navigationbar--fixed--top--animate");
//    }else{
//       $(".navigationbar-animation").removeClass("navigationbar--fixed--top--animate");
//   }
//   if (scroll >= 350) {
//        $(".navigationbar-animation").addClass("navigationbar--fixed--top--transition");
//    }else{
//        $(".navigationbar-animation").removeClass("navigationbar--fixed--top--transition");
//    }
//    if (scroll >= 200) {
//        $(".default-logo").css('display', 'none');
//        $(".dark-logo").css('display', 'block');
//        $(".navigationbar-animation").addClass("navigationbar--fixed--top menuzord--light");
//    }else{

//        $(".default-logo").css('display', 'block');
//        $(".dark-logo").css('display', 'none');
//        $(".navigationbar-animation").removeClass("navigationbar--fixed--top menuzord--light");
//    }
//});



/*Dot Navigation*/

$(document).ready(function(){
    $('.awesome-tooltip').tooltip({
        placement: 'left'
    });

    $(window).bind('scroll',function(e){
      dotnavigation();
    });

    function dotnavigation(){

        var numSections = $('section').length;

        $('#dot-nav li a').removeClass('active').parent('li').removeClass('active');
        $('section').each(function(i,item){
          var ele = $(item), nextTop;

          // console.log(ele.next().html());

          if (typeof ele.next().offset() != "undefined") {
            nextTop = ele.next().offset().top;
          }
          else {
            nextTop = $(document).height();
          }

          if (ele.offset() !== null) {
            thisTop = ele.offset().top - ((nextTop - ele.offset().top) / numSections);
          }
          else {
            thisTop = 0;
          }

          var docTop = $(document).scrollTop();

          /*if(docTop >= thisTop && (docTop < nextTop)){
            $('#dot-nav li').eq(i).addClass('active');
          }*/
        });
    }

    /* get clicks working */
    $('#dot-nav li').click(function(){

        var id = $(this).find('a').attr("href"),
          posi,
          ele,
          padding = 0;

        ele = $(id);
        posi = ($(ele).offset()||0).top - padding;

        $('html, body').animate({scrollTop:posi}, 'slow');

        return false;

        $('#dot-nav ul li.active').removeClass('active');
        $(this).addClass("active");
    });

/* end dot nav */
});

    window.fbAsyncInit = function() {
      FB.init({
        appId      : '986978254757512',
        cookie     : true,  // enable cookies to allow the server to access
                            // the session
        xfbml      : true,  // parse social plugins on this page
        version    : 'v2.8' // use graph api version 2.8
      });
    };

    // Load the SDK asynchronously
    (function(d, s, id) {
      var js, fjs = d.getElementsByTagName(s)[0];
      if (d.getElementById(id)) return;
      js = d.createElement(s); js.id = id;
      js.src = "https://connect.facebook.net/en_US/sdk.js";
      fjs.parentNode.insertBefore(js, fjs);
    }(document, 'script', 'facebook-jssdk'));
