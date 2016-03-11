function dateSplitter(date) {
  var dateArray = date.split("-");
  return dateArray[1] + "/" + dateArray[2] + "/" + dateArray[0];
}

function emptyDivs() {
  $("#events").empty();
  $("#songs").empty();
  $("#movies").empty();
  $(".facebook").empty();
  $(".twitter").empty();
  $("#conceptionRange").empty();
}

function checkUrl(url) {
  url = url.replace("http://localhost:3002/", "");
  url = url.replace("http://www.xmarksyourstart.com/", "");
  url = url.replace("https://www.xmarksyourstart.com/", "");
  if (url === ""){
    return true;
  } else {
    return url;
  }
}

function getAllData(birthday, unusual, number, modifier) {
  $.ajax({
    method: "GET",
    url: "/conception_range",
    data: "birthday=" + birthday + "&unusual=" + unusual + "&number=" + number + "&modifier=" + modifier
  })
  .done(function(data) {
    var startDate = dateSplitter(data[0]);
    var endDate   = dateSplitter(data[1]);

    $("#conceptionRange").append("You were likely conceived between " + startDate + " and " + endDate + ".");
    $.ajax({
      method: "GET",
      url: "/on_this_day_range",
      data: "start=" + startDate + "&end=" + endDate + "&type=Event"
    })
    .done(function(data) {
      for (i = 0; i < data.length; i++) {
        $("#events").append("<p>" + data[i].info + "</p>");
      }
    });
    $.ajax({
      method: "GET",
      url: "/on_this_day_range",
      data: "start=" + startDate + "&end=" + endDate + "&type=Song"
    })
    .done(function(data) {
      for (i = 0; i < data.length; i++) {
        $("#songs").append("<p>" + data[i].title + " by " + data[i].artist + "</p>");
      }
      $.ajax({
        method: "GET",
        url: "/get_youtube_id",
        data: "title=" + data[0].title + "&artist=" + data[0].artist + "&type=song"
      })
      .done(function(data) {
        var start = '<iframe id="player" type="text/html" class="four youtube-video" src="http://www.youtube.com/embed/';
        var end = '?enablejsapi=1&origin=http://example.com" frameborder="0"></iframe>';

        $("#songs").append(start + data + end);
      });
    });
    $.ajax({
      method: "GET",
      url: "/on_this_day_range",
      data: "start=" + startDate + "&end=" + endDate + "&type=Movie"
    })
    .done(function(data) {
      for (i = 0; i < data.length; i++) {
        $("#movies").append("<p>" + data[i].title + "</p>");
      }
      $.ajax({
        method: "GET",
        url: "/get_youtube_id",
        data: "title=" + data[0].title + "&type=movie"
      })
      .done(function(data) {
        var start = '<iframe id="player" type="text/html" class="four youtube-video" src="http://www.youtube.com/embed/';
        var end = '?enablejsapi=1&origin=http://example.com" frameborder="0"></iframe>';

        $("#movies").append(start + data + end);
      });
    });
  });
}

window.requestAnimationFrame(function () {
  var response = checkUrl(window.location.href);
  if (response === true) {
    $("#birthdayInputButton").click(function() {
      var output = $("#birthdayInput").val();
      var birthday = dateSplitter(output);
      var splitOutput = output.split("-");
      var combOutput = splitOutput[0] + splitOutput[1] + splitOutput[2];
      var unusual = ($("#checkUnusual:checkbox:checked").length > 0);
      var number = $('#actualBirthInput').val();
      var modifier = $('.success').text();
      getAllData(birthday, unusual, number, modifier);
    });
  } else {
    var year = response.substring(0,4);
    var month = response.substring(4,6);
    var day = response.substring(6,8);
    var birthday = month + "/" + day + "/" + year;
    var unusual = false
    var number = 0
    var modifier = "early"
    getAllData(birthday, unusual, number, modifier);
  }
});
//
//
//
//   if ((window.location.href !== "http://localhost:3002/") && (window.location.href !== "http://www.xmarksyourstart.com/") && (window.location.href !== "https://www.xmarksyourstart.com/") && (window.location.href !== "http://localhost:3002/test")) {
//     var url = window.location.href;
//     url = url.replace("http://localhost:3002/", "");
//     url = url.replace("http://www.xmarksyourstart.com/", "");
//     var year = url.substring(0,4);
//     var month = url.substring(4,6);
//     var day = url.substring(6,8);
//     var birthday = month + "/" + day + "/" + year;
//     $.ajax({
//       method: "GET",
//       url: "/conception_range",
//       data: "birthday=" + birthday
//     })
//     .done(function(data) {
//       var startDate = dateSplitter(data[0]);
//       var endDate   = dateSplitter(data[1]);
//
//       $("#conceptionRange").append("You were likely conceived between " + start_date + " and " + end_date + ".");
//       $.ajax({
//         method: "GET",
//         url: "/on_this_day_range",
//         data: "start=" + start_date + "&end=" + end_date + "&type=Event"
//       })
//       .done(function(data) {
//         for (i = 0; i < data.length; i++) {
//           $("#events").append("<p>" + data[i].info + "</p>");
//         }
//       });
//       $.ajax({
//         method: "GET",
//         url: "/on_this_day_range",
//         data: "start=" + start_date + "&end=" + end_date + "&type=Song"
//       })
//       .done(function(data) {
//         for (i = 0; i < data.length; i++) {
//           $("#songs").append("<p>" + data[i].title + " by " + data[i].artist + "</p>");
//         }
//         $.ajax({
//           method: "GET",
//           url: "/get_youtube_id",
//           data: "title=" + data[0].title + "&artist=" + data[0].artist + "&type=song"
//         })
//         .done(function(data) {
//           var start = '<iframe id="player" type="text/html" class="four youtube-video" src="http://www.youtube.com/embed/';
//           var end = '?enablejsapi=1&origin=http://example.com" frameborder="0"></iframe>';
//
//           $("#songs").append(start + data + end);
//         });
//       });
//       $.ajax({
//         method: "GET",
//         url: "/on_this_day_range",
//         data: "start=" + start_date + "&end=" + end_date + "&type=Movie"
//       })
//       .done(function(data) {
//         for (i = 0; i < data.length; i++) {
//           $("#movies").append("<p>" + data[i].title + "</p>");
//         }
//         $.ajax({
//           method: "GET",
//           url: "/get_youtube_id",
//           data: "title=" + data[0].title + "&type=movie"
//         })
//         .done(function(data) {
//           var start = '<iframe id="player" type="text/html" class="four youtube-video" src="http://www.youtube.com/embed/';
//           var end = '?enablejsapi=1&origin=http://example.com" frameborder="0"></iframe>';
//
//           $("#movies").append(start + data + end);
//         });
//       });
//     });
//
//   } else if ((window.location.href === "http://localhost:3002/") || (window.location.href === "http://www.xmarksyourstart.com/") || (window.location.href === "https://www.xmarksyourstart.com/")) {
//     $("#about-text").hide();
//     $(".data-returned").hide();
//     emptyDivs();
//     // $("#events").empty();
//     // $("#songs").empty();
//     // $("#movies").empty();
//     // $(".facebook").empty();
//     // $(".twitter").empty();
//     // $("#conceptionRange").empty();
//     $("#moreOptions").hide();
//     $("#checkUnusual").click(function() {
//       $("#moreOptions").toggle();
//     });
//     $(".about").click(function() {
//       $("#about-text").toggle();
//     });
//
//     $(".toggle-btn:not('.noscript') input[type=radio]").addClass("visuallyhidden");
//     $(".toggle-btn:not('.noscript') input[type=radio]").change(function() {
//       if( $(this).attr("name") ) {
//           $(this).parent().addClass("success").siblings().removeClass("success");
//       } else {
//           $(this).parent().toggleClass("success");
//       }
//     });
//
//     $("#birthdayInputButton").click(function() {
//       var output = $("#birthdayInput").val();
//       var outputAsDate = dateSplitter(output);
//       var splitOutput = output.split("-");
//       var combOutput = splitOutput[0] + splitOutput[1] + splitOutput[2];
//
//       $(".data-returned").show();
//
//       //href="http://www.facebook.com/sharer.php?s=100&p[title]=YOUR_TITLE&p[summary]=YOUR_SUMMARY&p[url]=YOUR_URL&p[images][0]=YOUR_IMAGE_TO_SHARE_OBJECT"
//
//       var fb_a = '<a href="https://www.facebook.com/sharer/sharer.php?u=www.xmarksyourstart.com/';
//       var fb_b = '&p[summary]=YOUR_SUMMARY" onclick="javascript:window.open(this.href,';
//       var fb_c =" ''";
//       var fb_d = ", 'menubar=no,toolbar=no,resizable=yes,scrollbars=yes,height=300,width=600');return false;";
//       var fb_e = '" target="_blank" title="Share on Facebook">Share on Facebook</a> ';
//
//       var facebook_html = fb_a + combOutput + fb_b + fb_c + fb_d + fb_e;
//
//       var tw_a = '<a href="http://twitter.com/share?text=Want%20to%20be%20grossed%20out?%20%20Check%20out%20these%20things%20that%20may%20have%20led%20to%20my%20conception.&url=http://www.xmarksyourstart.com/';
//       var tw_b = '" onclick="javascript:window.open(this.href,';
//       var tw_e = '" target="_blank" title="Share on Twitter">Share on Twitter</a> ';
//
//       var twitter_html = tw_a + combOutput + tw_b + fb_c + fb_d + tw_e;
//
//       //var twitter_html = '<a target="_blank" href="http://twitter.com/share?text=Want%20to%20be%20grossed%20out?%20%20Check%20out%20these%20things%20that%20may%20have%20led%20to%20my%20conception.&url=http://www.xmarksyourstart.com/'+ comb_output +'">Share This on Twitter</a>';
//
//       $(".facebook").append(facebook_html);
//       $(".twitter").append(twitter_html);
//
//       $("#events").empty();
//       $("#songs").empty();
//       $("#movies").empty();
//       $("#conceptionRange").empty();
//
//       var unusual = ($("#checkUnusual:checkbox:checked").length > 0);
//       var number = $('#actualBirthInput').val();
//       var modifier = $('.success').text();
//
//       $.ajax({
//         method: "GET",
//         url: "/conception_range",
//         data: "birthday=" + outputAsDate + "&unusual=" + unusual + "&number=" + number + "&modifier=" + modifier
//       })
//       .done(function(data) {
//         startDate = dateSplitter(data[0]);
//         endDate   = dateSplitter(data[1]);
//         $("#conceptionRange").append("You were likely conceived between " + startDate + " and " + endDate + ".");
//         $.ajax({
//           method: "GET",
//           url: "/on_this_day_range",
//           data: "start=" + startDate + "&end=" + endDate + "&type=Event"
//         })
//         .done(function(data) {
//           for (i = 0; i < data.length; i++) {
//             $("#events").append("<p>" + data[i].info + "</p>");
//           }
//         });
//         $.ajax({
//           method: "GET",
//           url: "/on_this_day_range",
//           data: "start=" + startDate + "&end=" + endDate + "&type=Song"
//         })
//         .done(function(data) {
//           for (i = 0; i < data.length; i++) {
//             $("#songs").append("<p>" + data[i].title + " by " + data[i].artist + "</p>");
//           }
//           $.ajax({
//             method: "GET",
//             url: "/get_youtube_id",
//             data: "title=" + data[0].title + "&artist=" + data[0].artist + "&type=song"
//           })
//           .done(function(data) {
//             var start = '<iframe id="player" type="text/html" class="four youtube-video" src="http://www.youtube.com/embed/';
//             var end = '?enablejsapi=1&origin=http://example.com" frameborder="0"></iframe>';
//
//             $("#songs").append(start + data + end);
//           });
//         });
//         $.ajax({
//           method: "GET",
//           url: "/on_this_day_range",
//           data: "start=" + startDate + "&end=" + endDate + "&type=Movie"
//         })
//         .done(function(data) {
//           for (i = 0; i < data.length; i++) {
//             $("#movies").append("<p>" + data[i].title + "</p>");
//           }
//           $.ajax({
//             method: "GET",
//             url: "/get_youtube_id",
//             data: "title=" + data[0].title + "&type=movie"
//           })
//           .done(function(data) {
//             var start = '<iframe id="player" type="text/html" class="four youtube-video" src="http://www.youtube.com/embed/';
//             var end = '?enablejsapi=1&origin=http://example.com" frameborder="0"></iframe>';
//
//             $("#movies").append(start + data + end);
//           });
//         });
//       });
//     });
//   }
// });
