(function(){
	
	var setting = {
		width: 1000,
		height: 500
	}
	
	var lightbox = {
		init : function(){
			//alert("lightbox init");
			//document.body.appendChild(div);
			//document.body.append("<div id='ligthbox' style='position:fixed; width:100%; height:100%; background: rgba(0, 0, 0, 0.7); top:0; left:0;'> <img src='../img/1.jpg' style='opacity:1;'></img></div>");
			var light_div = document.createElement('div');
			light_div.id="ligthbox";
			light_div.className = "lightbox_div";
			light_div.addEventListener('keydown', function(event) { 
				lightbox.on_keyEvent(event);
			});
			/*light_div.style.position = "fixed";
			light_div.style.width = "100%";
			light_div.style.height = "100%";
			//light_div.style.textAlign="center";
			light_div.style.background = "rgba(0, 0, 0, 0.7)";
			light_div.style.top = "0";
			light_div.style.left = "0";
			light_div.style.display = "block";*/
			document.body.appendChild(light_div);
			console.log("offsetWidth/2 : " + (light_div.offsetHeight-setting.height)/2 + "  light_div.offsetWidth/2 : " + (light_div.offsetWidth-setting.width)/2);
			
			//var html = "<img id='lightbox_img' style='opacity:1; position:absolute; width:"+setting.width+"px; height:"+setting.height+"px; margin-top:"+(light_div.offsetHeight-setting.height)/2+"px; margin-left:"+(light_div.offsetWidth-setting.width)/2+"px;'></img>";
			//html = html + "<a onClick='unshowLightBox();' class='lightbox_close' style='margin-left:"+(light_div.offsetWidth-50)+"px; margin-top:50px;'><img src='../img/close.png'></img></a>"
			var html = "<div class='close_div'>"
				html = html + "<a onClick='unshowLightBox();'><img src='../img/close.png'></img></a>";
				html = html + "</div>";
				html = html + "<div class='img_div'>";
				html = html + "<table class='lightbox_imgtable'>";
				html = html + "<tbody>";
				html = html + "<tr>";
				html = html + "<td class='lightbox_img_btn'><button type='button'>왼쪽</button></td>";
				html = html + "<td class='lightbox_img'><img id='lightbox_img' src='../img/1.jpg'></img></td>";
				html = html + "<td class='lightbox_img_btn'><button type='button'>오른쪽</button></td>";
				html = html + "</tr>";
				html = html + "</tbody>";
				html = html + "</table>";
				html = html + "</div>";
			light_div.innerHTML = html;
		},
		on_keyEvent : function(event){
			var keycode = event.keyCode;
			if(keycode == 27){
				unshowLightBox();
			}
		}
	}
	
	lightbox.init();
	unshowLightBox();
}());

function showLightBox(imgidx){
	var data = selectImgPath(imgidx);
	document.getElementById("lightbox_img").src=imgPath+data.img;
	document.getElementById("ligthbox").style.display = 'block';
}
function unshowLightBox(){
	document.getElementById("ligthbox").style.display = 'none';
}