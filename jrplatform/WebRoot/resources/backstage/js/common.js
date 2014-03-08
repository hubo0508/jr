function convert(value){
	//uploadfile/
	var f = 'uploadfile/';	
	return "uploadfile/src/"+value.substring(f.length,value.length);
}

function showLoading(opts)
{
	var _padding,_top,_left,_fsize;

	opts            = opts          || {};
	
	if(opts.wintype == undefined)
	{
		_padding    = opts.padding  || "5px";
		_top        = opts.top      || "14px";
		_left       = opts.left     || "285px";
		_fsize      = opts.fontSize || "13px";
	}else
	{
		_top        = opts.top      || "5px";
		_left       = opts.left     || "5px";
		_fsize      = opts.fontSize || "13px";
	}
	
	if(opts.timeout  == undefined){
		opts.timeout = 60000;
	}
	
	var _text        = opts.text        || "正在保存数据，请稍后";
	var _type        = opts.type        || "success";
	var _timeout     = opts.timeout     || 5000;
	var _timeoutmark = opts.timeoutmark || true;
	
	var _bColor   = "#090"; 
	if(_type == "error"){
		_bColor = "#F30"
	}

	var $loading = $("#loading");
	if($loading.length <= 0){
		var _html = '<div id="loading" style="background-color:'+_bColor+';padding:'+_padding+
			'; color:#FFF; position:fixed; top:'+_top+'; left:'+_left+'; display:none; font-size:'+_fsize+'">'+_text+'</div>'
		$("body").append(_html);
		$("#loading").fadeIn();
	}else{
		if(_type == "error"){
			$loading.css("background-color",_bColor);
		}
		$loading.html(opts.text);
		$loading.fadeIn();
	}
	
	$loading = null;
	$loading = $("#loading");
	
	if(_type == "success")
	{
		setTimeout(function(){
			if($loading.css("display") == "block"){
				$loading.html("服务器连接超时！");
				$loading.css("background-color","#F30");
				
				setTimeout(function(){
					$loading.fadeOut();
				},_timeout);
			}
		},_timeout);
		
		return;
	}
	
	if(_timeoutmark == true)
	{
		setTimeout(function(){
			hideLoading();
		},_timeout)
	}
}

function hideLoading()
{
	$("#loading").fadeOut();
}