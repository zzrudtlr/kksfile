
<% /* 관리자 로그인 페이지  */%>


<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
        <%@ page import="org.json.simple.JSONArray"%>
<%@ page import="org.json.simple.JSONObject"%>
<%@ page import="org.json.simple.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<!--[if lt IE 9]>
	<script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/IE9.js"></script>
	<![endif]-->
<!--[if lt IE 8]>
	<script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/IE8.js"></script>
	<![endif]-->
<!--[if lt IE 7]>
	<script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/IE7.js"></script>
	<![endif]-->
<title>로그인</title>
<style>
/* Full-width input fields */
input[type=text], input[type=password] {
    width: 100%;
    padding: 12px 20px;
    margin: 8px 0;
    display: inline-block;
    border: 1px solid #ccc;
    box-sizing: border-box;
}

/* Set a style for all buttons */
button {
    background-color: #4CAF50;
    color: white;
    padding: 14px 20px;
    margin: 8px 0;
    border: none;
    cursor: pointer;
    width: 100%;
}

button:hover {
    opacity: 0.8;
}

/* Extra styles for the cancel button */
.cancelbtn {
    width: auto;
    padding: 10px 18px;
    background-color: #f44336;
}

/* Center the image and position the close button */
.imgcontainer {
    text-align: center;
    margin: 24px 0 12px 0;
    position: relative;
}

img.avatar {
    width: 8%;
}

.container {
    padding: 16px;
}

span.psw {
    float: right;
    padding-top: 16px;
}

/* The Modal (background) */
.modal {
    display: block; /* Hidden by default */
    position: fixed; /* Stay in place */
    z-index: 1; /* Sit on top */
    left: 0;
    top: 0;
    width: 100%; /* Full width */
    height: 100%; /* Full height */
    overflow: auto; /* Enable scroll if needed */
    background-color: rgb(0,0,0); /* Fallback color */
    background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
    padding-top: 60px;
}

/* Modal Content/Box */
.modal-content {
    background-color: #fefefe;
    margin: 5% auto 15% auto; /* 5% from the top, 15% from the bottom and centered */
    border: 1px solid #888;
    width: 80%; /* Could be more or less, depending on screen size */
}

/* The Close Button (x) */
.close {
    position: absolute;
    right: 25px;
    top: 0;
    color: #000;
    font-size: 35px;
    font-weight: bold;
}

.close:hover,
.close:focus {
    color: red;
    cursor: pointer;
}

/* Add Zoom Animation */
.animate {
    -webkit-animation: animatezoom 0.6s;
    animation: animatezoom 0.6s
}

@-webkit-keyframes animatezoom {
    from {-webkit-transform: scale(0)} 
    to {-webkit-transform: scale(1)}
}
    
@keyframes animatezoom {
    from {transform: scale(0)} 
    to {transform: scale(1)}
}

/* Change styles for span and cancel button on extra small screens */
@media screen and (max-width: 300px) {
    span.psw {
       display: block;
       float: none;
    }
    .cancelbtn {
       width: 100%;
    }
}
</style>
</head>
<body>
<div id="id01" class="modal">
  
  <form class="modal-content animate" style="width:30%;">
    <div class="imgcontainer">
      <!--  <img src="../images/pabicon.png" alt="Avatar" class="avatar" style="width:10%;">-->
      로그인
    </div>

    <div class="container">
      <label><b>아이디</b></label>
      <input type="text" placeholder="id" id="id" name="id" required value="">

      <label><b>비밀번호</b></label>
      <input type="password" placeholder="pw" id="pw" name="pw" required value="">
        
      <button type="button" onclick="getLoginCheck()">Login</button>
      <!--  <input type="checkbox" checked="checked"> 자동로그인-->
    </div>

  
  </form>
</div>

<script>
	function getLoginCheck(){
		<%System.out.println("getLoginCheck");%>
		var xhttp = new XMLHttpRequest();
		var id = document.getElementById("id").value;
		var pw = document.getElementById("pw").value;
		  xhttp.open("GET", "../process/login/login_check.jsp?"+new Date().getTime()+"&id="+id+"&pw="+pw);
		  xhttp.onreadystatechange = function() {
			if (xhttp.readyState == 4 && xhttp.status == 200) {
				console.log("xhttp.responseText : " + xhttp.responseText);
				var response = JSON.parse(xhttp.responseText);
				var result = response.result;
				console.log("result : " + result);
				if(result == "1"){
					location.href="admin.jsp";
				}else{
					alert("로그인 실패");
				}
			}
		  };
		  xhttp.send();
	}
	
	document.addEventListener('keydown', function(event) { 
		var keycode = event.keyCode;
		if(keycode == 13){
			getLoginCheck();
		}
	});

</script>
<%
String id = (String)session.getAttribute("id");
System.out.println("id : " + id);
%>
</body>
</html>