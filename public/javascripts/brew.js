$(document).ready(function() {
  $("a.templink")
    .on("ajax:before", function(evt) {
      $("#ajax-loader").show();
    })
    .on("ajax:success", function(evt, data, status, xhr) {
      $("#placeholder").show();
      plotTemperatures(data);
    })
    .on("ajax:complete", function() {
      $("#ajax-loader").hide();
    });
});
