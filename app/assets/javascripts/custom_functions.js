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
