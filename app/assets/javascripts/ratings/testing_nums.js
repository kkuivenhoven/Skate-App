/* http://stackoverflow.com/questions/9094299/issue-with-comparing-two-numbers-in-javascript*/
function testingnums(n) {
  var table, rows, switching, i, x, y, shouldSwitch, dir, switchcount = 0;
  table = document.getElementById("testingrateTable");
  switching = true;
  dir = "asc"; 
  while (switching) {
    switching = false;
    rows = table.getElementsByTagName("TR");
    for (i = 1; i < (rows.length - 1); i++) {
      shouldSwitch = false;
      x = rows[i].getElementsByTagName("TD")[n];
      y = rows[i + 1].getElementsByTagName("TD")[n];
			var x_num = x.innerHTML;
			var y_num = y.innerHTML;
			//alert(x.innerHTML);
      if (dir == "asc") {
        //if (x.innerHTML.toLowerCase() > y.innerHTML.toLowerCase()) {
        if (parseInt(x_num,10) > parseInt(y_num,10)) {
          shouldSwitch= true;
          break;
        }
      } else if (dir == "desc") {
        //if (x.innerHTML.toLowerCase() < y.innerHTML.toLowerCase()) {
        //if (x.innerHTML < y.innerHTML) {
        if (parseInt(x_num,10) < parseInt(y_num,10)) {
          shouldSwitch= true;
          break;
        }
      }
    }
    if (shouldSwitch) {
      rows[i].parentNode.insertBefore(rows[i + 1], rows[i]);
      switching = true;
      switchcount ++;      
    } else {
      if (switchcount == 0 && dir == "asc") {
        dir = "desc";
        switching = true;
      }
    }
  }
}

var col_array = [];
function okay(n){
	var table, rows, x, i;
  table = document.getElementById("testingrateTable");
  rows = table.getElementsByTagName("TR");
  x = rows[1].getElementsByTagName("TD")[n];
	console.log(x);
	console.log(rows[1]);
	console.log(rows.length);
	for(i=1; i < (rows.length); i++){
			col_array.push(rows[i].getElementsByTagName("TD")[n]);
	}
	console.log(col_array);
}
		
