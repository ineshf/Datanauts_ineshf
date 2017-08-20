$.ajax({
  url: "https://data.nasa.gov/resource/gymh-eyc2.json?$limit=2",
  data: {},
  success: function(data) {
    $("div").text(JSON.stringify(data, null, "\t"));

    var tableData = '<table><tr><td>Category</td><td>cvcm</td><td>material_usage</td><td>mfr</td></tr>';
    $.each(data, function(index, data) {
    tableData += '<tr><td>'+data.category+'</td> <td>'+data.cvcm+'</td> <td>'+data.material_usage+'</td> <td>'+data.mfr+'</td></tr>';
    });

$('pre').html(tableData);



  },
  error: function(msg) {
    //todo: handle error gracefully
  }
});
