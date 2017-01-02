// JavaScript Document
function makeid()
{
    var text = "";
    var possible = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";

    for( var i=0; i < 5; i++ )
        text += possible.charAt(Math.floor(Math.random() * possible.length));

    return text;
}

function isValidEmailAddress(emailAddress) {
  if (emailAddress!="" && emailAddress.length>3){
    var pattern = /^([a-z\d!#$%&'*+\-\/=?^_`{|}~\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]+(\.[a-z\d!#$%&'*+\-\/=?^_`{|}~\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]+)*|"((([ \t]*\r\n)?[ \t]+)?([\x01-\x08\x0b\x0c\x0e-\x1f\x7f\x21\x23-\x5b\x5d-\x7e\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]|\\[\x01-\x09\x0b\x0c\x0d-\x7f\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))*(([ \t]*\r\n)?[ \t]+)?")@(([a-z\d\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]|[a-z\d\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF][a-z\d\-._~\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]*[a-z\d\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])\.)+([a-z\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]|[a-z\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF][a-z\d\-._~\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]*[a-z\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])\.?$/i;
    return pattern.test(emailAddress);
}
}

$(document).ready(function() {

	$(".advertiser-btn").click(function(){
		$(".advetiser-singup").show();
 		$(".influencer-singup").hide();
	});

	$(".influencer-btn").click(function(){
		$(".influencer-singup").show();
 		$(".advetiser-singup").hide();
	});

	/********/

	$(".navIcon1").click(function(){
		$("#menuzord").hide();
		$(".navIcon2").show();
		$(".navIcon1").hide();
		$(".content-wrapper").css({
			"margin-left" : "0px"
		});
	});

	$(".navIcon2").click(function(){
		$("#menuzord").show();
		$(".navIcon1").show();
		$(".navIcon2").hide();
		$(".content-wrapper").css({
			"margin-left" : "230px"
		});
	});

	/**** Custom Select Menu ****/

	$(".custom-select").each(function(){
            $(this).wrap("<span class='select-wrapper'></span>");
            $(this).after("<span class='holder'></span>");
        });
        $(".custom-select").change(function(){
            var selectedOption = $(this).find(":selected").text();
            $(this).next(".holder").text(selectedOption);
        }).trigger('change');

	/**** Popup Center ****/

	function centerModals(){
	  $('.modal').each(function(i){
		var $clone = $(this).clone().css('display', 'block').appendTo('body');
		var top = Math.round(($clone.height() - $clone.find('.modal-content').height()) / 2);
		top = top > 0 ? top : 0;
		$clone.remove();
		$(this).find('.modal-content').css("margin-top", top);
	  });
	}
	$('.modal').on('show.bs.modal', centerModals);
	$(window).on('resize', centerModals);

	/**** Report Options ****/

	$(".title1").click(function(){
		$(".option1").toggle();
	});

	$(".title2").click(function(){
		$(".option2").toggle();
	});

	$(".title3").click(function(){
		$(".option3").toggle();
	});


	/**** Change Account ****/

	$(function() {
	  $('#paymentInfo').change(function(){
		$('.colors').hide();
		$('#' + $(this).val()).show();
	  });
	});



});

// JavaScript Document
