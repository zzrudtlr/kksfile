(function(){
	
	var setting = {
		width: 500,
		height: 500
	}
	
	var lightbox = {
		init : function(){
			//alert("lightbox init");
			//document.body.appendChild(div);
			//document.body.append("<div id='ligthbox' style='position:fixed; width:100%; height:100%; background: rgba(0, 0, 0, 0.7); top:0; left:0;'> <img src='../img/1.jpg' style='opacity:1;'></img></div>");
			var light_div = document.createElement('div');
			light_div.id="ligthbox";
			light_div.style.position = "fixed";
			light_div.style.width = "100%";
			light_div.style.height = "100%";
			//light_div.style.textAlign="center";
			light_div.style.background = "rgba(0, 0, 0, 0.7)";
			light_div.style.top = "0";
			light_div.style.left = "0";
			light_div.style.display = "block";
			document.body.appendChild(light_div);
			console.log("offsetWidth/2 : " + (light_div.offsetHeight-setting.height)/2 + "  light_div.offsetWidth/2 : " + (light_div.offsetWidth-setting.width)/2);
			
			var html = "<img id='lightbox_img' src='../img/1.jpg' style='opacity:1; width:"+setting.width+"px; height:"+setting.height+"px; margin-top:"+(light_div.offsetHeight-setting.height)/2+"px; margin-left:"+(light_div.offsetWidth-setting.width)/2+"px;'></img>";
			html = html + "<a onClick='unshowLightBox();' style='postion:relative; top:0; left:0; cursor:pointer;'><img src='../img/close.png'></img></a>"
			light_div.innerHTML = html;
		},
		light_div : function(){
			
			/*var light_img = document.createElement('img');
			light_img.style.opacity="1";
			light_div.appendChild(light_img);*/
			//return light_div;
		}
	}
	


	lightbox.init();
	unshowLightBox();
}());

function showLightBox(imgidx){
	var data = selectImgPath(imgidx);
	document.getElementById("lightbox_img").src=data.img;
	document.getElementById("ligthbox").style.display = 'block';
}
function unshowLightBox(){
	document.getElementById("ligthbox").style.display = 'none';
}