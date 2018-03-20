var b_value;
var table_data;
function Ss(i){return document.getElementById(i)}
function St(e,p){return p.getElementsByTagName(e)}

(function(){
	
	function init(){
		var xhr = new XMLHttpRequest();
		  xhr.open("POST", "../process/request/get_total_message_count.jsp", true);
		  //Send the proper header information along with the request
		  xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");

		  xhr.onreadystatechange = function() {//Call a function when the state changes.
		      if(xhr.readyState == XMLHttpRequest.DONE && xhr.status == 200) {
		    	  
		    	 console.log(xhr.responseText);
		    	 var obj = JSON.parse(xhr.responseText);
		    	 console.log("result : " + obj.result + " message : " + obj.message + " data : " + obj.data);  
		    	 var dataObj = JSON.parse(obj.data);	
		    	 console.log("count : " + dataObj);  
		    	 if(obj.result == "1"){
			    	 boardSetting({
		    				"total_count" : dataObj.count,//전체 갯수
		    				"show_count" : 6,//한페이지당 보여지는 글수
		    				"under_count" : 5,//밑에 보여지는 페이지수
		    				"current_count" : 1,//현재 보여지는 글
		    				"current_page" : 1,//현재 페이지갯수
		    				"under_ul" : document.getElementById("under_count"),//넣을 ul
		    				"board_data_url" : "../process/request/get_message.jsp",// 게시판 글 가져올 url
		    				"current_page_doing" : function(data){
		    				//	alert("current_page_doing : " + page);
		    					console.log("current_page_doing : " + data);
		    					var obj = JSON.parse(data.jsonData);
		    		    		console.log("result : " + obj.result + " message : " + obj.message + " data : " + obj.data);  
		    		    		var dataObj = JSON.parse(obj.data);	
		    		    		var htmlData = "";
		    		    		
		    		    		for(var i=0;i<dataObj.length;i++){
		    		    			//htmlData = htmlData+"<div class='col-md-4 col-sm-6'>";
		    		    			htmlData = htmlData+"<tr onClick='board_td_click("+dataObj[i].idx+")'>";
		    		    			htmlData = htmlData+"<td class='t_num'>"+(data.write_count+(i+1))+"</td>";
		    		    			htmlData = htmlData+"<td class='t_name'>"+dataObj[i].name+"</td>";
		    		    			htmlData = htmlData+"<td class='t_title'>"+dataObj[i].title+"</td>";
		    		    			htmlData = htmlData+"<td class='t_mail'>"+dataObj[i].email+"</td>";
		    		    			htmlData = htmlData+"<td class='t_reg'>"+dataObj[i].regdate+"</td>";
		    		    			
		    		    			htmlData = htmlData+"</tr>";
		    		    		}
		    					document.getElementById("board_data").innerHTML = htmlData;
		    				}
		    		});
		    	 }
		      } 
		  }
		  xhr.send();
	}
	init();
}());


function boardSetting(value){
	
	b_value = {
		total_count : value.total_count,
		show_count : value.show_count,
		under_count : value.under_count,
		current_count : value.current_count,//페이지들 중 첫번째 부분
		current_page : value.current_page,//현재 페이지
		under_ul : value.under_ul,
		current_page_doing:value.current_page_doing,
		under_setting:function(){
			var li_html = "";
		//	console.log("under_endPage : " + Number(b_value.under_endPage()));
			for(var i=0;i<b_value.under_count;i++){
				if(b_value.current_count+i > Number(b_value.under_endPage())){break;}
				else{
					li_html = li_html + "<li id='"+(b_value.current_count+i)+"'><a onClick='page_Click("+(b_value.current_count+i)+")'>" + (b_value.current_count+i) + "</a></li>";
				}
			}
			//console.log("li_html : " + li_html);
			return li_html;
		},
		under_endPage:function(){
		//	console.log("b_value.total_count : " + b_value.total_count+"  b_value.show_count : " + b_value.show_count);
			if((b_value.total_count%b_value.show_count) != 0){
				//console.log("0 아님 " + b_value.total_count%b_value.show_count);
				return Math.ceil(b_value.total_count/b_value.show_count);
			}else{
				//console.log("0임 " +b_value.total_count%b_value.show_count);
				return b_value.total_count/b_value.show_count;
			}	
		},
		getBoardData : function(page){
			var xhr = new XMLHttpRequest();
			  xhr.open("POST", value.board_data_url, true);

			  //Send the proper header information along with the request
			  xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");

			  xhr.onreadystatechange = function() {//Call a function when the state changes.
			      if(xhr.readyState == XMLHttpRequest.DONE && xhr.status == 200) {
			    	  
			    	 // console.log(xhr.responseText);
			    	  if(b_value.current_page_doing != null){
			    			//b_value.current_page_doing(b_value.current_page);
			    		  
			    		  b_value.current_page_doing({
			    			  jsonData : xhr.responseText,
			    			  write_count : (b_value.current_page * b_value.show_count)-b_value.show_count
			    		  });
			    	  }
			      }
			      
			  }
			  var jsonArray = new Array();
			  var jsonObject = new Object();
			  jsonObject.l_to = (b_value.current_page * b_value.show_count)-b_value.show_count;
			  jsonObject.l_count = b_value.show_count;
			  jsonArray.push(jsonObject);
			  var jsonData = JSON.stringify(jsonArray);
			 xhr.send("json="+jsonData);
		}
	}
	//console.log("end Page : " + b_value.under_endPage());
	b_value.under_ul.innerHTML = b_value.under_setting();
	page_Click(1);
}

function page_Click(cp){
	//alert(cp);
	b_value.current_page = cp;
	change_color(cp);
	b_value.getBoardData(cp);
}

function b_nextPage(){
	if(b_value.current_page < b_value.under_endPage()){
		b_value.current_page = b_value.current_page+1;
		//console.log("next current_page : " + b_value.current_page);
		if((b_value.current_count + b_value.under_count) <= b_value.current_page){
			b_value.current_count = b_value.current_count + b_value.under_count;
			b_value.under_ul.innerHTML = b_value.under_setting();
		}
		change_color(b_value.current_page);
		b_value.getBoardData(b_value.current_page);
	}else{
		alert("더이상 존재하지 않습니다.");
	}
}

function b_previousPage(){
	if(b_value.current_page > 1){
		b_value.current_page = b_value.current_page-1;
		//console.log("before current_page : " + b_value.current_page);
		if(b_value.current_page < b_value.current_count){
			b_value.current_count = b_value.current_count - b_value.under_count;
			b_value.under_ul.innerHTML = b_value.under_setting();
		}
		change_color(b_value.current_page);
		b_value.getBoardData(b_value.current_page);
	}else{
		alert("더이상 존재하지 않습니다.");
	}
}

function change_color(cp){
	var li_list = St('li',b_value.under_ul);
	//console.log("li_list length : " + li_list.length);
	for(var i=0;i<li_list.length;i++){
		li_list[i].style.backgroundColor="#ffffff";
	}
	document.getElementById(cp).style.backgroundColor = "#5CD1E5";
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////

function board_td_click(num){
	
	location.href="board_detail.jsp?id="+num;
}
