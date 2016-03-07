window.requestAnimationFrame(function () {
  $("#events").empty();
  $("#songs").empty();
  $("#movies").empty();
  $("#conceptionRange").empty();
  $("#moreOptions").hide();
  $("#checkUnusual").click(function() {
    $("#moreOptions").toggle();
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
    output_as_date = split_output[1] + "/" + split_output[2] + "/" + split_output[0];

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
          console.log(data);
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
          console.log(data);
          var start = '<iframe id="player" type="text/html" class="four youtube-video" src="http://www.youtube.com/embed/';
          var end = '?enablejsapi=1&origin=http://example.com" frameborder="0"></iframe>';

          $("#movies").append(start + data + end);
        });
      });
    });
  });

});
