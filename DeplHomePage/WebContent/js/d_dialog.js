

var make_dialog = function(action){
	this.id = action.id;
	this.title= action.title;
	this.modal = true;
	this.width = action.width;
	this.height = action.height;

	
	this.init(action);
	
};
make_dialog.prototype.init = function(action){
	var d_div = document.createElement('div');
	d_div.setAttribute("id", action.id);
	d_div.style.cssText="text-align:center;";
	
	var check = document.createElement('button');
	var checkText = document.createTextNode( '확인' );
	check.appendChild(checkText);
	//check.onclick = action.check(action.value);
	
	var cancel = document.createElement('button');
	var cancelText = document.createTextNode( '취소' );
	cancel.appendChild(cancelText);
	cancel.onclick = function(){
		
		action.cancel();
		$('#'+this.id).remove();
	};
	
	d_div.appendChild(check);
	d_div.appendChild(cancel);
	
	document.body.appendChild(d_div);
	//action.modal();
	
};
make_dialog.prototype.close = function(){
	 $('#'+this.id).dialog("close");
};
make_dialog.prototype.show = function(action){
	$('#'+this.id).dialog({
	     title: this.title,
	     modal: this.modal,
	     width: this.width,
	     height: this.height
	});
};



