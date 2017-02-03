// JavaScript Document

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
	
	/**** Wizard Section ****/
	
	$('.nav-tabs > li a[title]').tooltip();
    
    //Wizard
    $('a[data-toggle="tab"]').on('show.bs.tab', function (e) {

        var $target = $(e.target);
    
        if ($target.parent().hasClass('disabled')) {
            return false;
        }
    });

    $(".next-step").click(function (e) {

        var $active = $('.wizard .nav-tabs li.active');
        $active.next().removeClass('disabled');
        nextTab($active);

    });
    $(".prev-step").click(function (e) {

        var $active = $('.wizard .nav-tabs li.active');
        prevTab($active);

    });
	
	function nextTab(elem) {
		$(elem).next().find('a[data-toggle="tab"]').click();
	}
	
	function prevTab(elem) {
		$(elem).prev().find('a[data-toggle="tab"]').click();
	}
	
	
	
});