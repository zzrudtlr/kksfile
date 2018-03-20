send_form = {
		 data : function(){
			 var formdata = new Object();
			 formdata.name = document.getElementById("your-name").value;
			 formdata.email = document.getElementById("email").value;
			 formdata.title = document.getElementById("your-subject").value;
			 formdata.message = document.getElementById("message").value;
			 formdata.message = formdata.message.replace(/(?:\r\n|\r|\n)/g, '<br />');
			 return formdata;
		 },
		 formCheck : function(){
			 var check = 1;
			 var email_check = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i; 
			 var form_data = send_form.data();
			 console.log("name : " + form_data.name + " email : " + form_data.email + " title : " + form_data.title +" message : " + form_data.message);
			 if(form_data.name == "" || form_data.name == "undefiend" || form_data.name == null){
				 alert("이름을 입력해 주세요.");
				 return false;
			 }else if(form_data.email == "" || form_data.email == "undefiend" || form_data.email == null){
				 alert("이메일을 입력해 주세요.");
				 return false;
			 }else if(!email_check.test(form_data.email)){
				 alert("이메일형식에 맞지 않습니다.");
				 return false;
			 }else if(form_data.title == "" || form_data.title == "undefiend" || form_data.title == null){
				 alert("제목을 입력해 주세요.");
				 return false;
			 }else if(form_data.message == "" || form_data.message == "undefiend" || form_data.message == null){
				 alert("메세지를 입력해 주세요.");
				 return false;
			 }
			 return true;
		 },
		 sendData : function(){
			 var datalist = new Array();
			 datalist.push(this.data());
			 var jsonData = JSON.stringify(datalist);
		  	  var xhr = new XMLHttpRequest();
			  xhr.open("POST", "../process/request/send_message.jsp", true);

			  //Send the proper header information along with the request
			  xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");

			  xhr.onreadystatechange = function() {//Call a function when the state changes.
			      if(xhr.readyState == XMLHttpRequest.DONE && xhr.status == 200) {
			    	  var obj = JSON.parse(xhr.responseText);
			    	  console.log(obj);
			    	  if(obj.result == 1){
			    		  alert("제출을 완료 하였습니다.");
			    	  }else{
			    		  alert("제출을 실패 하였습니다.");
			    	  }
			      }
			  }
			 xhr.send("json="+jsonData);
		 },send_request_data : function(){
			 if(send_form.formCheck()){
				send_form.sendData();
			 }
		 }
		 
	};
	
