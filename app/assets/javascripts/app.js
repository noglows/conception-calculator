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
  $("#about-text").hide();
  $(".data-returned").hide();
  $("#moreOptions").hide();
  $("#emailInput").hide();
  $("#senderInput").hide();
  $("#emailSubmitButton").hide();
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

// function getYoutubeId(type, search) {
//   var title = "";
//   var artist = "";
//   if (type === "movie") {
//     title = search;
//     artist = "";
//   } else {
//     title = search[0];
//     artist = search[1];
//   }
//   $.ajax({
//     method: "GET",
//     url: "/get_youtube_id",
//     data: "title=" + title + "&type=" + type + "&artist=" + artist
//   })
//   .done(function(data) {
//     var start = '<iframe id="player" type="text/html" class="four youtube-video" src="https://www.youtube.com/embed/';
//     var end = '?enablejsapi=1&origin=https://www.xmarksyourstart.com" frameborder="0"></iframe>';
//
//     $("#" + type + "s").append(start + data + end);
//   });
// }

function addYoutubeVideo(type, id) {
  var start = '<iframe id="player" type="text/html" class="four youtube-video" src="https://www.youtube.com/embed/';
  var end = '?enablejsapi=1&origin=https://www.xmarksyourstart.com" frameborder="0"></iframe>';

  $("#" + type + "s").append(start + id + end);

}

function getAllOTDTypes(startDate, endDate) {
  var types = ["event", "song", "movie"];
  for(var i = 0; i < types.length; i++) {
    $.ajax({
      method: "GET",
      url: "/on_this_day_range",
      data: "start=" + startDate + "&end=" + endDate + "&type=" + types[i]
    })
    .done(function(data) {
      for (var j = 0; j < data.length; j++) {
        if (data[0].info !== undefined) {
          $("#events").append("<p>" + data[j].info + "</p>");
        } else if (data[0].artist !== undefined) {
          $("#songs").append("<p>" + data[j].title + " by " + data[j].artist + "</p>");
          //getYoutubeId("song", [data[0].title, data[0].artist]);

          addYoutubeVideo("song", data[0].link);
        } else {
          $("#movies").append("<p>" + data[j].title + "</p>");
          //getYoutubeId("movie", data[0].title);
          addYoutubeVideo("movie", data[0].link);
        }
      }
    });
  }
}

function getAllData(birthday, unusual, number, modifier) {
  $.ajax({
    method: "GET",
    url: "/conception_range",
    data: "birthday=" + birthday + "&unusual=" + unusual + "&number=" + number + "&modifier=" + modifier
  })
  .done(function(data) {
    if (data[0].error === false) {
      $(".birthdayError").append("<p> This is not a valid birthday. </p>");
    } else {
      $(".birthdayError").empty();
      var startDate = dateSplitter(data[0]);
      var endDate   = dateSplitter(data[1]);

      $("#conceptionRange").append("You were likely conceived between " + startDate + " and " + endDate + ".");
      getAllOTDTypes(startDate, endDate);
    }
  });
}

function sendEmail(person, sender, message) {
  $.ajax({
    method: "GET",
    url: "/send_email",
    data: "person=" + person + "&sender=" + sender + "&message=" + message
  })
  .done(function(data) {
    $(".error").append('<p>' + data[0].flash + '</p>');
  });
}

window.requestAnimationFrame(function () {
  var response = checkUrl(window.location.href);
  if (response === true) {
    emptyDivs();
    $("#checkUnusual").click(function() {
      $("#moreOptions").toggle();
    });
    $(".about").click(function() {
      $("#about-text").toggle();
    });
    $(".emailInputButton").click(function() {
      $("#emailInput").toggle();
      $("#senderInput").toggle();
      $("#emailSubmitButton").toggle();
      $(".emailInputButton").hide();
    });

    $(".toggle-btn:not('.noscript') input[type=radio]").addClass("visuallyhidden");
    $(".toggle-btn:not('.noscript') input[type=radio]").change(function() {
      if( $(this).attr("name") ) {
          $(this).parent().addClass("success").siblings().removeClass("success");
      } else {
          $(this).parent().toggleClass("success");
      }
    });
    $("#birthdayInputButton").click(function() {
      emptyDivs();
      var output = $("#birthdayInput").val();
      var birthday = dateSplitter(output);
      var splitOutput = output.split("-");
      var combOutput = splitOutput[0] + splitOutput[1] + splitOutput[2];
      var unusual = ($("#checkUnusual:checkbox:checked").length > 0);
      var number = $('#actualBirthInput').val();
      var modifier = $('.success').text();
      getAllData(birthday, unusual, number, modifier);
      $(".data-returned").show();
      var fb_a = '<a class="button" href="https://www.facebook.com/sharer/sharer.php?u=www.xmarksyourstart.com/';
      var fb_b = '&p[summary]=YOUR_SUMMARY" onclick="javascript:window.open(this.href,';
      var fb_c =" ''";
      var fb_d = ", 'menubar=no,toolbar=no,resizable=yes,scrollbars=yes,height=300,width=600');return false;";
      var fb_e = '" target="_blank" title="Share on Facebook">Share on Facebook</a> ';

      var facebook_html = fb_a + combOutput + fb_b + fb_c + fb_d + fb_e;

      var tw_a = '<a class="button" href="http://twitter.com/share?text=Want%20to%20be%20grossed%20out?%20%20Check%20out%20these%20things%20that%20may%20have%20led%20to%20my%20conception.&url=http://www.xmarksyourstart.com/';
      var tw_b = '" onclick="javascript:window.open(this.href,';
      var tw_e = '" target="_blank" title="Share on Twitter">Share on Twitter</a> ';

      var twitter_html = tw_a + combOutput + tw_b + fb_c + fb_d + tw_e;

      //var twitter_html = '<a target="_blank" href="http://twitter.com/share?text=Want%20to%20be%20grossed%20out?%20%20Check%20out%20these%20things%20that%20may%20have%20led%20to%20my%20conception.&url=http://www.xmarksyourstart.com/'+ comb_output +'">Share This on Twitter</a>';

      $(".facebook").append(facebook_html);
      $(".twitter").append(twitter_html);

    });
    $("#emailSubmitButton").click(function() {
      var person = $("#emailInput").val();
      var sender = $("#senderInput").val();
      var output = $("#birthdayInput").val();
      var splitOutput = output.split("-");
      var combOutput = splitOutput[0] + splitOutput[1] + splitOutput[2];
      sendEmail(person, sender, combOutput);
    });

  } else {
    var year = response.substring(0,4);
    var month = response.substring(4,6);
    var day = response.substring(6,8);
    var birthday = month + "/" + day + "/" + year;
    var unusual = false;
    var number = 0;
    var modifier = "early";
    getAllData(birthday, unusual, number, modifier);
  }
});
