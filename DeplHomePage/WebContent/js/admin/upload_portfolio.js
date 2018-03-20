(function(){
	$('#serverInfoForm').ajaxForm({    
	        dataType : 'text', 
	        beforeSerialize: function(){	
	             // form을 직렬화하기전 엘레먼트의 속성을 수정할 수도 있다.            
	        },
	        beforeSubmit : function() {
	        //action에 걸어주었던 링크로 가기전에 실행 ex)로딩중 표시를 넣을수도 있다.
	        },
	        success : function(data) {
	             //컨트롤러 실행 후 성공시 넘어옴
	        	var obj = JSON.parse(data);
	        	if(obj.result == "1"){
	        		var pageName = getPageName();
	        		if(pageName == "upload_portfolio.jsp")
	        			upload.send_portf_data(obj.img_path);
	        		else if(pageName == "update_portfolio.jsp")
	        			upload.update_portfo_data(obj.img_path,id);
	       		}else{
	       			alert("업로드에 실패하였습니다.");
	       		}
	        }
	    });
	
	upload = {
			send_portf_data : function(img_path){
				var datalist = new Array();
				var data = new Object();
				data.p_type = document.getElementById("p_type").value;
				data.img_path = img_path;
				data.contents = document.getElementById("contents").value;
				data.contents = data.contents.replace(/(?:\r\n|\r|\n)/g, '<br />');
				datalist.push(data);
				var jsonData = JSON.stringify(datalist);
				console.log("jsonData : " + jsonData);
				do_ajax({
					"url" : "../process/portfolio/send_portfolio_data.jsp",
					"json" : "json="+jsonData,
					"result" : function(result){
						console.log("result : " + result);
						var obj = JSON.parse(result);
						if(obj.result == "1"){
							alert("제출을 완료하였습니다.");
							location.reload();
						}else{
							alert("제출을 실패하였습니다.");
						}
						
					}
				});
			},
			get_portfo_type : function(){
				do_ajax({
					"url" : "../process/portfolio/get_portfo_type.jsp",
					"json" : "",
					"result" : function(result){
						console.log(result);
						var obj = JSON.parse(result);
						var obj_data = JSON.parse(obj.data);
						var html = "";
						for(var i=0;i<obj_data.length;i++){
							html = html + "<option value='"+obj_data[i].idx+"'>"+obj_data[i].name;
						}
						document.getElementById("p_type").innerHTML = html;
					}
						
				});
			},
			update_portfo_data : function(img_path,id){
				var datalist = new Array();
				var data = new Object();
				data.id= id;
				data.p_type = document.getElementById("p_type").value;
				data.img_path = img_path;
				data.contents = document.getElementById("contents").value;
				data.contents = data.contents.replace(/(?:\r\n|\r|\n)/g, '<br />');
				datalist.push(data);
				var jsonData = JSON.stringify(datalist);
				console.log("jsonData : " + jsonData);
				do_ajax({
					"url" : "../process/portfolio/send_portfolio_data.jsp",
					"json" : "json="+jsonData,
					"result" : function(result){
						console.log("result : " + result);
						var obj = JSON.parse(result);
						if(obj.result == "1"){
							alert("제출을 완료하였습니다.");
							location.reload();
						}else{
							alert("제출을 실패하였습니다.");
						}
						
					}
				});
			}
	}
	upload.get_portfo_type();
}());


var openFile = function(event) {
   var input = event.target;
   var reader = new FileReader();
    reader.onload = function(){
      var dataURL = reader.result;
      var show_img = document.getElementById("show_img");
      show_img.src = dataURL;
   };
    reader.readAsDataURL(input.files[0]);  
};
function do_ajax(data){
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

function check_img(){
	var thumbext = document.getElementById('file').value; //파일을 추가한 input 박스의 값

	thumbext = thumbext.slice(thumbext.indexOf(".") + 1).toLowerCase(); //파일 확장자를 잘라내고, 비교를 위해 소문자로 만듭니다.

	if(thumbext != "jpg" && thumbext != "png" &&  thumbext != "gif" &&  thumbext != "bmp"){ //확장자를 확인합니다.

		alert('썸네일은 이미지 파일(jpg, png, gif, bmp)만 등록 가능합니다.');

		return;

	}
}

function getPageName(){
    var pageName = "";
    var tempPageName = window.location.href;
    var strPageName = tempPageName.split("/");
    pageName = strPageName[strPageName.length-1].split("?")[0];
    return pageName;

}