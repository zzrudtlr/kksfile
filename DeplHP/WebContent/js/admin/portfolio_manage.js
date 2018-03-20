/*var value;
function delete_portfo(id){
//	alert("삭제 : " + id);
	var d = new make_dialog({
		id:'dialog',
		title:'정말 삭제하시겠습니까?',
		width:'250',
		height:'100',
		value:id,
		check:function(value){
			console.log("삭제 : " + value);
		},
		cancel:function(){
			d.close();	
			// $('#dialog').dialog("close");
		}
	});
	
	d.show();
}*/

function delete_portfo(id){
	var datalist = new Array();
	var data = new Object();
	data.idx = id;
	datalist.push(data);
	var jsonData = JSON.stringify(datalist);
	
	do_ajax({
		"url" : "../process/portfolio/delete_portfolio.jsp",
		"json" : "json="+jsonData,
		result : function(data){
			console.log("delete result : " + data.result);
			location.reload();
			//b_value.getBoardData(b_value.current_page);
		}
	});
}

function update_porto(id){
	location.href="update_portfolio.jsp?id="+id;
}

function do_ajax(data){
	console.log("data : " + data.json);
	
	  var xhr = new XMLHttpRequest();
	  xhr.open("POST", data.url, true);
	  //Send the proper header information along with the request
	  xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
	  xhr.onreadystatechange = function() {//Call a function when the state changes.
	      if(xhr.readyState == XMLHttpRequest.DONE && xhr.status == 200) {
	    	  data.result(xhr.responseText);
	      }
	  }
	 xhr.send(data.json);
}