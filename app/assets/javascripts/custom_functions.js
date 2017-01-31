function statusChangeCallback(response) {
  if (response.status === 'connected') {
  } else if (response.status === 'not_authorized') {
    document.getElementById('status').innerHTML = 'Please log ' +
      'into this app.';
  } else {
    document.getElementById('status').innerHTML = 'Please log ' +
      'into Facebook.';
  }
}

function checkLoginState() {
  FB.getLoginStatus(function(response) {
    statusChangeCallback(response);
  });
}

window.fbAsyncInit = function() {
FB.init({
  appId      : '986978254757512',
  cookie     : true,  // enable cookies to allow the server to access
                      // the session
  xfbml      : true,  // parse social plugins on this page
  version    : 'v2.8' // use graph api version 2.8
});

FB.getLoginStatus(function(response) {
  statusChangeCallback(response);
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

function update_ad_share_url_and_status(id, post_id,type) {
   $.ajax({
      url: "/advertisments/" + id + "/update_ad_share_url_and_status",
      type: "post",
      data: {
          id: id,
          post_id: post_id
      },
      success: function(response) {
          toastr.success("Posted successfully on "+type);
          $("#ad_request_"+id).fadeOut(1000);
      }
  })
}

function open_share_dialog_to_profile(id,type) {
  console.log($("#posting_link_"+id).text());

  if (type == 1){
    FB.api('/me/feed', 'post', {
        message: $("#posting_link_"+id).text(),
    }, function(response) {
        if (!response || response.error) {
            LoginFB();
            toastr.error("Error,"+response["error"]["message"]);
        } else {
            update_ad_share_url_and_status(id, response.id,"profile")
        }
    });
  }
  else if(type ==2)
  {
    title = $("#" + id + "_title").text();
    description = $("#" + id + "_description").text();
    caption = $("#" + id + "_caption").text();
    image = $("#" + id + "_img").attr("src");
    photo_click_link = $("#" + id + "_photo_click_link").text();
    FB.api('/me/feed', 'post', {
        message: title + " " + description,
        picture: image,
        from: 'me',
        caption: caption,
        link: photo_click_link,
        description: description
    }, function(response) {
        if (!response || response.error) {
            LoginFB();
            toastr.error("Error,"+response["error"]["message"]);
        } else {
            update_ad_share_url_and_status(id, response.id,"profile")
        }
    });
  }

}

function open_share_dialog_to_page(id,type) {
  console.log(type)
    title = $("#" + id + "_title").text();
    description = $("#" + id + "_description").text();
    caption = $("#" + id + "_caption").text();
    image = $("#" + id + "_img").attr("src");
    photo_click_link = $("#" + id + "_photo_click_link").text();
    page_id= $("#"+id+"_page_id").val();
    FB.api('/'+page_id+"/feed/", 'post', {
        message: title + " " + description,
        picture: image,
        from: 'me',
        caption: caption,
        link: photo_click_link,
        description: description
    }, function(response) {
         if (!response || response.error) {
            LoginFB();
            toastr.error("Error,"+response["error"]["message"]);
        } else {
            update_ad_share_url_and_status(id, response.id,"page");
        }
    });
}

function LoginFB() {
    FB.login(function(response) {
        if(response["status"] ==  "connected"){
          toastr.success("Connected! Please retry now");
        }
    }, {
        scope: 'publish_actions,publish_pages,manage_pages',
        auth_type: 'reauthenticate',
    });
}


function decline_ad_by_influencer() {
    event.preventDefault();
    ad_id = $("#declined_ad_id").val();
    ad_decline_reason = $("#reason_for_ad_decline").val();
    if(ad_decline_reason!=""){
      $.ajax({
          url: "/advertisments/ad_declined_by_influencer/",
          method: "post",
          data: {
              ad_id: ad_id,
              reason_for_decline: ad_decline_reason
          },
          success: function(response) {
              if (response["success"]) {
                  toastr.success("updated");
                  $("#declinePopup").modal("hide");
              } else {
                  toastr.info("error");
                  $("#declinePopup").modal("hide");
              }
          },
          error: function(response) {
              console.log(response);
              if (response["success"]) {
                  toastr.success("updated");
              } else {
                  toastr.info("error");
                  $("#declinePopup").modal("hide");
              }
          }
      });
    }
    else {
       alert("Enter Reason for declining")
    }
}
