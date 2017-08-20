$.ajax({
//  url: "https://data.nasa.gov/resource/gymh-eyc2.json",
 url: "https://data.nasa.gov/resource/gymh-eyc2.json?$limit=2&$offset=2",
 data: {},
  success: function(data) {
  //$("pre").text(JSON.stringify(data, null, "\t"));



  var tableData = '<table><tr><td>Category</td><td>Id</td></tr>';
  $.each(text(JSON.stringify(data, null, "\t")), function(index, data) {
  tableData += '<tr><td>'+data.category+'</td><td>'+data.id'</td></tr>';
});

$('div').html(tableData);
  error: function(msg) {
    //todo: handle error gracefully
  }
});

