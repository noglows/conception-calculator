window.requestAnimationFrame(function () {
  if ((window.location.href != "http://localhost:3000/") && (window.location.href != "http://www.xmarksyourstart.com/")) {
    var url = window.location.href;
    url = url.replace("http://localhost:3000/", "");
    url = url.replace("http://www.xmarksyourstart.com/", "");
    var year = url.substring(0,4);
    var month = url.substring(4,6);
    var day = url.substring(6,8);
    var birthday = month + "/" + day + "/" + year;
    $.ajax({
      method: "GET",
      url: "/conception_range",
      data: "birthday=" + birthday
    })
    .done(function(data) {
      start_date = data[0];
      end_date = data[1];
      start_date = start_date.split("-");
      start_date = start_date[1] + "/" + start_date[2] + "/" + start_date[0];
      end_date = end_date.split("-");
      end_date = end_date[1] + "/" + end_date[2] + "/" + end_date[0];
      $("#conceptionRange").append("You were likely conceived between " + start_date + " and " + end_date + ".");
      $.ajax({
        method: "GET",
        url: "/event_range",
        data: "start=" + start_date + "&end=" + end_date,
      })
      .done(function(data) {
        for (i = 0; i < data.length; i++) {
          $("#events").append("<p>" + data[i].info + "</p>");
        }
      });
      $.ajax({
        method: "GET",
        url: "/song_range",
        data: "start=" + start_date + "&end=" + end_date,
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
        url: "/movie_range",
        data: "start=" + start_date + "&end=" + end_date,
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

  } else {
    $("#about-text").hide();
    $(".data-returned").hide();
    $("#events").empty();
    $("#songs").empty();
    $("#movies").empty();
    $("#conceptionRange").empty();
    $("#moreOptions").hide();
    $("#checkUnusual").click(function() {
      $("#moreOptions").toggle();
    });
    $(".about").click(function() {
      $("#about-text").toggle();
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
      var output = $("#birthdayInput").val();
      var split_output = output.split("-");
      var output_as_date = split_output[1] + "/" + split_output[2] + "/" + split_output[0];
      var comb_output = split_output[0] + split_output[1] + split_output[2];

      $(".data-returned").show();

      //href="http://www.facebook.com/sharer.php?s=100&p[title]=YOUR_TITLE&p[summary]=YOUR_SUMMARY&p[url]=YOUR_URL&p[images][0]=YOUR_IMAGE_TO_SHARE_OBJECT"

      var fb_a = '<a href="https://www.facebook.com/sharer/sharer.php?u=www.xmarksyourstart.com/';
      var fb_b = '&p[summary]=YOUR_SUMMARY" onclick="javascript:window.open(this.href,';
      var fb_c =" ''";
      var fb_d = ", 'menubar=no,toolbar=no,resizable=yes,scrollbars=yes,height=300,width=600');return false;";
      var fb_e = '" target="_blank" title="Share on Facebook">Share on Facebook</a> ';

      var facebook_html = fb_a + comb_output + fb_b + fb_c + fb_d + fb_e;

      var tw_a = '<a href="http://twitter.com/share?text=Want%20to%20be%20grossed%20out?%20%20Check%20out%20these%20things%20that%20may%20have%20led%20to%20my%20conception.&url=http://www.xmarksyourstart.com/';
      var tw_b = '" onclick="javascript:window.open(this.href,';
      var tw_e = '" target="_blank" title="Share on Twitter">Share on Twitter</a> ';

      var twitter_html = tw_a + comb_output + tw_b + fb_c + fb_d + tw_e;

      //var twitter_html = '<a target="_blank" href="http://twitter.com/share?text=Want%20to%20be%20grossed%20out?%20%20Check%20out%20these%20things%20that%20may%20have%20led%20to%20my%20conception.&url=http://www.xmarksyourstart.com/'+ comb_output +'">Share This on Twitter</a>';

      $(".facebook").append(facebook_html);
      $(".twitter").append(twitter_html);

      $("#events").empty();
      $("#songs").empty();
      $("#movies").empty();
      $("#conceptionRange").empty();

      var unusual = ($("#checkUnusual:checkbox:checked").length > 0);
      var number = $('#actualBirthInput').val();
      var modifier = $('.success').text();

      $.ajax({
        method: "GET",
        url: "/conception_range",
        data: "birthday=" + output_as_date + "&unusual=" + unusual + "&number=" + number + "&modifier=" + modifier,
      })
      .done(function(data) {
        start_date = data[0];
        end_date = data[1];
        start_date = start_date.split("-");
        start_date = start_date[1] + "/" + start_date[2] + "/" + start_date[0];
        end_date = end_date.split("-");
        end_date = end_date[1] + "/" + end_date[2] + "/" + end_date[0];
        $("#conceptionRange").append("You were likely conceived between " + start_date + " and " + end_date + ".");
        $.ajax({
          method: "GET",
          url: "/event_range",
          data: "start=" + start_date + "&end=" + end_date,
        })
        .done(function(data) {
          for (i = 0; i < data.length; i++) {
            $("#events").append("<p>" + data[i].info + "</p>");
          }
        });
        $.ajax({
          method: "GET",
          url: "/song_range",
          data: "start=" + start_date + "&end=" + end_date,
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
          url: "/movie_range",
          data: "start=" + start_date + "&end=" + end_date,
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
    });
  }
});
