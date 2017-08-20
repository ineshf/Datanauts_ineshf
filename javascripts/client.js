$.ajax({
//  url: "https://data.nasa.gov/resource/gymh-eyc2.json",
 url: "https://data.nasa.gov/resource/gymh-eyc2.json?$limit=2&$offset=2",
 data: {},
  success: function(data) {
    $("pre").text(JSON.stringify(data, null, "\t"));
  },
  error: function(msg) {
    //todo: handle error gracefully
  }
});
