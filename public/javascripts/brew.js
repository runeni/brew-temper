$(document).ready(function() {
  $("a.templink")
    .on("ajax:before", function(evt) {
      $("#ajax-loader").show();
    })
    .on("ajax:success", function(evt, data, status, xhr) {
      $("#placeholder").show();
      plotTemperatures(data);
      fillTable(data);
    })
    .on("ajax:complete", function() {
      $("#ajax-loader").hide();
    });
});

var plotTemperatures = function(data) {
  var plotArray = [];
  $.each(data, function(i,t) {
    plotArray.push([i, t.measure.temp]);
  });

  var container = $("#placeholder");
  $.plot(container, [ plotArray ], { yaxis: { min: 0, max: 35 } });
  var yaxisLabel = $("<div class='axisLabel yaxisLabel'></div>")
    .text("Temp (C)")
    .appendTo(container);
  // Since CSS transforms use the top-left corner of the label as the transform origin,
  // we need to center the y-axis label by shifting it down by half its width.
  // Subtract 20 to factor the chart's bottom margin into the centering.
  //
  yaxisLabel.css("margin-top", yaxisLabel.width() / 2 - 20);

  // Update the random dataset at 25FPS for a smoothly-animating chart
  setInterval(function updateRandom() {
    series[0].data = getRandomData();
    plot.setData(series);
    plot.draw();
  }, 40);
}

var fillTable = function(data) {
  var table_html = "<table>";
  $.each(data, function(i,t) {
    table_html += "<tr><td>"+t.measure.created_at+"</td><td>"+t.measure.temp+"</td></tr>";
  });
  table_html += "</table>";
  $("#tempcontainer").html( table_html );
}
