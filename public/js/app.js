window.requestAnimationFrame(function () {
  $("#events").empty();
  $("#songs").empty();
  $("#movies").empty();

  $("#birthdayInputButton").click(function() {
    var output = $("#birthdayInput").val();
    var split_output = output.split("-");
    output_as_date = split_output[1] + "/" + split_output[2] + "/" + split_output[0];
    $("#events").empty();
    $("#songs").empty();
    $("#movies").empty();
    $.ajax({
      method: "GET",
      url: "/conception_range",
      data: "birthday=" + output_as_date,
    })
    .done(function(data) {
      start_date = data[0];
      end_date = data[1];
      start_date = start_date.split("-");
      start_date = start_date[1] + "/" + start_date[2] + "/" + start_date[0];
      end_date = end_date.split("-");
      end_date = end_date[1] + "/" + end_date[2] + "/" + end_date[0];
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
      });
    });
  });

});
