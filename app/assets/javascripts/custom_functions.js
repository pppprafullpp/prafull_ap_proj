function update_ad_share_url(id,post_id) {
  $.ajax({
    url:"/advertisments/"+id+"/update_ad_share_url",
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
      // console.log(response);
      FB.getLoginStatus();
      toastr.error("Error, please try after some time")
    } else {
      // alert('Post ID: ' + response.id );
      update_ad_share_url(id,response.id)
    }
  });
}
