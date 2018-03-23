var portfo_data;
var imgPath = "../img/";
(function() {
    console.log('함수 호출'); // "함수 호출" 출력
    
    portfolio = {
    	getItem : function(){
		  	  var xhr = new XMLHttpRequest();
			  xhr.open("POST", "../process/portfolio/get_portfolio.jsp", true);

			  //Send the proper header information along with the request
			  xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");

			  xhr.onreadystatechange = function() {//Call a function when the state changes.
			      if(xhr.readyState == XMLHttpRequest.DONE && xhr.status == 200) {
			    	  
			    	  console.log(xhr.responseText);
			    	  document.getElementById("proto_projects").innerHTML =  portfolio.writeHTML(xhr.responseText);
			      }
			  }
			 xhr.send();
    	},
    	writeHTML : function(json){
    		var obj = JSON.parse(json);
    		console.log("result : " + obj.result + " message : " + obj.message + " data : " + obj.data);  
    		var dataObj = JSON.parse(obj.data);	
    		var htmlData = "";
    		portfo_data = new Array();
    		
    		for(var i=0;i<dataObj.length;i++){
    			htmlData = htmlData+"<div class='col-md-4 col-sm-6'>";
        		htmlData = htmlData+"<div class='project-item'>";
        		htmlData = htmlData+"<img src='"+imgPath+dataObj[i].img+"' alt=''>";
        		//htmlData = htmlData+"<img src='../img/1.jpg' alt=''>";
        		htmlData = htmlData+"<div class='project-hover'>";
        		htmlData = htmlData+"<div class='inside'>";
        		htmlData = htmlData+"<h5 style='cursor:pointer;' onClick='showLightBox("+dataObj[i].idx+");'>"+dataObj[i].name+"</h5>";
        		htmlData = htmlData+"<p>"+dataObj[i].contents+"</p>";
        		htmlData = htmlData+"</div>";
        		htmlData = htmlData+"</div>";
        		htmlData = htmlData+"</div>";
        		htmlData = htmlData+"</div>";
        		
        		var data = new Object();
        		data.idx = dataObj[i].idx;
        		data.img = dataObj[i].img;
        		data.name = dataObj[i].name;
        		data.contents = dataObj[i].contents;
        		portfo_data.push(data);
    		}
    		return htmlData;
    	},
    	potoclick : function(){}
    	
    };
    
    portfolio.getItem();
}());

function selectImgPath(idx){
	for(var i=0;i<portfo_data.length;i++){
		if(idx == portfo_data[i].idx) return portfo_data[i];
	}
}
