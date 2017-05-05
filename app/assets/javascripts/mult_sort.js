$(function() {
  function sortByColumn3(row1, row2) {
    var v1, v2;
    v1 = $(row1).find("td:eq(2)").text();
    v2 = $(row2).find("td:eq(2)").text();
    // for numbers you can simply return a-b instead of checking greater/smaller/equal
    return v1 - v2;
  }

  function sortByColumn3And5(row1, row2) {
    var v1, v2, r;
    v1 = $(row1).find("td:eq(2)").text();
    v2 = $(row2).find("td:eq(2)").text();
    r = v1 - v2;
    if (r === 0) {
      // we have a tie in column 1 values, compare column 2 instead
      v1 = $(row1).find("td:eq(4)").text();
      v2 = $(row2).find("td:eq(4)").text();
      if (v1 < v2) {
        r = -1;
      } else if (v1 > v2) {
        r = 1;
      } else {
        r = 0;
      }
    }
    return r;
  }
  $("#button1, #button2").on("click", function() {
    var rows = $("#table1 tbody tr").detach().get();
		alert(this.id);
    switch (this.id) {
      case "button1":
        rows.sort(sortByColumn3);
        break;
      case "button2":
        rows.sort(sortByColumn3And5);
        break;
    }
    $("#table1 tbody").append(rows);
  });
});
