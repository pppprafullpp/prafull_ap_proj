function update_ad_share_url_and_status(id,post_id) {
  $.ajax({
    url:"/advertisments/"+id+"/update_ad_share_url_and_status",
    type:"post",
    data: {
      id:id,
      post_id:post_id
    },
    success:function(response){
      toastr.success("Posted successfully");
    }
  })
}

function open_share_dialog(id) {
  // console.log(id);
  title = $("#"+id+"_title").text();
  description = $("#"+id+"_description").text();
  image = $("#"+id+"_img").attr("src");
    FB.api('/me/feed', 'post', {
     message: title+" "+ description,
     picture: image,
     from: 'me',
     caption:"test",
     link: "http://www.youtube.com",
    description: "tesing"
   }, function(response) {
     console.log(response);
    if (!response || response.error) {
      FB.getLoginStatus();
      toastr.error("Error, please try after some time")
    } else {
      update_ad_share_url_and_status(id,response.id)
    }
  });
}

function LoginFB() {
//   FB.login(function(response) {
//     if (response.authResponse) {
//      console.log('Welcome!  Fetching your information.... ');
//      FB.api('/me', function(response) {
//        console.log('Good to see you, ' + response.name + '.');
//      });
//     } else {
//      console.log('User cancelled login or did not fully authorize.');
//     }
// });

FB.login(function(response) {
  console.log(response);
}, {scope: 'publish_actions',auth_type: 'reauthenticate',});
}
function decline_ad_by_influencer(){
  event.preventDefault();
  ad_id = $("#declined_ad_id").val();
  ad_decline_reason = $("#reason_for_ad_decline").val();
  console.log(ad_id+""+ad_decline_reason);
  $.ajax({
    url:"/advertisments/ad_declined_by_influencer/",
    method:"post",
    data: {
      ad_id:ad_id,
      reason_for_decline:ad_decline_reason
    },
    success:function(response){
      if (response["success"]) {
        toastr.success("updated");
        $("#declinePopup").modal("hide");
      }
      else {
        toastr.info("error");
        $("#declinePopup").modal("hide");
      }
    },
    error:function(response){
      console.log(response);
      if (response["success"]) {
        toastr.success("updated");
      }
      else {
        toastr.info("error");
        $("#declinePopup").modal("hide");
      }
    }
  });
  console.log(ad_decline_reason);
}
