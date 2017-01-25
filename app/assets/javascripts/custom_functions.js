function statusChangeCallback(response) {
  if (response.status === 'connected') {
    // Logged into your app and Facebook.
    testAPI();
  } else if (response.status === 'not_authorized') {
    // The person is logged into Facebook, but not your app.
    document.getElementById('status').innerHTML = 'Please log ' +
      'into this app.';
  } else {
    // The person is not logged into Facebook, so we're not sure if
    // they are logged into this app or not.
    document.getElementById('status').innerHTML = 'Please log ' +
      'into Facebook.';
  }
}

// This function is called when someone finishes with the Login
// Button.  See the onlogin handler attached to it in the sample
// code below.
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

// Here we run a very simple test of the Graph API after login is
// successful.  See statusChangeCallback() for when this call is made.
function testAPI() {
  FB.login();
  // console.log('Welcome!  Fetching your information.... ');
  FB.api('/me', function(response) {
    // console.log('Successful login for: ' + response.name);
    // document.getElementById('status').innerHTML =
    //   'Thanks for logging in, ' + response.name + '!';
  });
  FB.api("/1115405461908086/comments",function(response){
    // console.log(response);
  })
}


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

function open_share_dialog_to_profile(id) {
    title = $("#" + id + "_title").text();
    description = $("#" + id + "_description").text();
    caption = $("#" + id + "_caption").text();
    image = $("#" + id + "_img").attr("src");
    photo_click_link = $("#" + id + "_photo_click_link").text();
    // console.log(photo_click_link);
    FB.api('/me/feed', 'post', {
        message: title + " " + description,
        picture: image,
        from: 'me',
        caption: caption,
        link: photo_click_link,
        description: description
    }, function(response) {
        console.log(response);
        if (!response || response.error) {
            // LoginFB();
            toastr.error("Error,"+response["error"]["message"]);
            // toastr.error("Error, please click on facebook login and try again")
        } else {
            update_ad_share_url_and_status(id, response.id,"profile")
        }
    });
}

function open_share_dialog_to_page(id) {
    title = $("#" + id + "_title").text();
    description = $("#" + id + "_description").text();
    caption = $("#" + id + "_caption").text();
    image = $("#" + id + "_img").attr("src");
    photo_click_link = $("#" + id + "_photo_click_link").text();
    page_id= $("#"+id+"_page_id").val();
    console.log(page_id);

    console.log(image);
    console.log(caption);
    console.log(photo_click_link);
    console.log(description);
    console.log(title);

    FB.api('/'+page_id+"/feed/", 'post', {
        message: title + " " + description,
        picture: image,
        from: 'me',
        caption: caption,
        link: photo_click_link,
        description: description
    }, function(response) {
         if (!response || response.error) {
            console.log(response["error"]["message"]);
            toastr.error("Error,"+response["error"]["message"]);
        } else {
            update_ad_share_url_and_status(id, response.id,"page");
        }
    });
}

function LoginFB() {
  console.log("Dd");
    FB.login(function(response) {
        console.log(response);
    }, {
        scope: 'publish_actions,publish_pages,manage_pages',
        auth_type: 'reauthenticate',
    });
}


function decline_ad_by_influencer() {
    event.preventDefault();
    ad_id = $("#declined_ad_id").val();
    ad_decline_reason = $("#reason_for_ad_decline").val();
    // console.log(ad_id + "" + ad_decline_reason);
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
    // console.log(ad_decline_reason);
}

function instagram_login(){
  window.open("https://api.instagram.com/oauth/authorize/?client_id=6b7aae8b938642eeb242a76096727fdf&redirect_uri=http://localhost:3000&response_type=code","_self")
}
