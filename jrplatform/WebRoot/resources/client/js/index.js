;(function($) {
	
	$.searchList         = function(opts){ searchListFunc(window, opts); }	
	$.searchTxt          = function(opts){ searchTxtFunc(window, opts); }	
	$.menu               = function(opts){ menuFunc(window, opts);}
	
	$.tootip             = function(opts){ tootipFunc(window, opts)}
	
	$.onlineCustomers    = function(opts){onlineCustomersFunc(window,opts)}
	
	$.onlineService    = function(opts){onlineServiceFunc(window,opts)}
	
	function onlineServiceFunc(window,opts)
	{
		$.ajax({
			type : "post",
			url : opts.url+"/client/onlineService",
			dataType:"json",
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			success : function(msg) {
				if(msg != null)
				{
					var _html = '<img src="'+opts.img+'"  style="margin-left:-18px;"/>';
					
					$.each(msg,function(idx,item){
						_html +=
						'<p class="ptitle">'+item.area_name+'</p>'+
						'<p class="pconti">'+item.caddress+'</p>'+
						'<p class="pconti">'+item.cphone+'</p>';
					});
					
				    $(opts.target).html(_html);
				}else
				{
					
				}
			}
		});
	}
	
	function onlineCustomersFunc(window,opts)
	{
		$.ajax({
			type : "post",
			url : opts.url+"/client/onlineCustomers",
			dataType:"json",
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			success : function(msg) {
				if(msg != null)
				{
					var _html = '<div class="kehu"><ul>';
					
					var phone = "";
					var count = 1;
					$.each(msg,function(idx,item){ 
						if(count <= 4){
							_html += '<li><a href="tencent://message/?uin='+item.number+'&Site=http://www.baidu.com/&Menu=yes">'+item.text+'</a></li>';
						}else{
							phone = item.phone;
						}
						count ++;
					});
					
					_html += '</ul>';
					_html += '<span style="position:absolute; bottom:40px; width:100%; left:0px; font-size:16px;">'+phone+'</span>';
					_html += '</div>';
					
				    $("body").append(_html);
				}else
				{
					
				}
			}
		});
	}
	
	
	
	function tootipFunc(window, opts)
	{
		//var _img = opts.IMG + "/phone.jpg";
		var tootipstr = '<div style="position:fixed; right:0px; bottom:100px;">' +
						'	<img class="goPhone" src="'+opts.IMG+'/phone.jpg" title="联系我们" style="cursor:pointer"/> ' +
						'	<br /> '+
						'	<img class="goTop" style="display:none;cursor:pointer" src="'+opts.IMG+'/up.jpg" title="回到顶部"/>' +
						'</div>';
		$("body").append($(tootipstr));
		
		var body = $.browser.webkit ? $("body")[0] : $("html")[0];
			if($.browser.mozilla == true && opts.type == undefined){
				body = document.body;
			}
						
		var $goTop = $(".goTop");
		
		$goTop.click(function(){
			$(body).animate({scrollTop:0},1000);
		});
		
		$(".goPhone").click(function(){
			window.location = opts.about;
		})
		
		//var body = $.browser.webkit ? $("body")[0] : $("html")[0];
		window.onscroll = function(){
						
			if(Number(body.scrollTop) > 0){
				$goTop.fadeIn();
			}else{
				$goTop.fadeOut();
			}
		};
		
	}
	
	function menuFunc(win,opts)
	{
		$(".container .menu div").click(function(){
			/*$(".container .menu div").each(function(){
				$(this).removeClass("selected");										
			})			
			$(this).addClass("selected");*/

			win.location = $(this).attr("src");
		})
	}	
	
	function searchTxtFunc()
	{
		var updateSTxt = function(event){			
			if(jSTxt.attr("value") == "输入您所关心的内容！" ){
				jSTxt.css("color","#9E9E9E");
			}else if(jSTxt.attr("value") == "" ){
				jSTxt.attr("value","输入您所关心的内容！").css("color","#9E9E9E");
			}else{
				jSTxt.css("color","#000000");
			}
		}
		
		var jSTxt = $(".search .txt");
		jSTxt.css("color","#000000");
//		jSTxt.attr("value","输入您所关心的内容！").css("color","#9E9E9E");
//		jSTxt.focus(updateSTxt);
//		jSTxt.blur(updateSTxt);
//		jSTxt.keyup(updateSTxt);
//		jSTxt.click(function(){
//			if(jSTxt.attr("value") == "输入您所关心的内容！" ){
//				jSTxt.attr("value","");
//			}
//		});
	}
	

	function searchListFunc()
	{
		$(".search .txt").click(function(){
										 
			var jTxtDiv = $(this).parent();
			var txtDiv_oLeft = jTxtDiv.offset().left;
			var txtDiv_oTop  = jTxtDiv.offset().top + jTxtDiv.height();	
			
			var selectedCondition=$("input[name='selectedCondition']").val();
			var a="";
			var b="";
			var c="";
			var d="";
			var e="";
			var f="";
			
			if(selectedCondition=='设备名称'){
				a='class="selected"';
			}
			if(selectedCondition=='设备品牌'){
				b='class="selected"';
			}
			if(selectedCondition=='设备型号'){
				c='class="selected"';
			}
			if(selectedCondition=='配件名称'){
				d='class="selected"';
			}
			if(selectedCondition=='配件型号'){
				e='class="selected"';
			}
			if(selectedCondition=='配件编号'){
				f='selected';
			}
			
			var $search = $(".search_list");
			if($search.length == 0){
				var jSearch = $('<div class="search_list">'+
							'	<div '+a+'>设备名称</div>'+        
							'	<div '+b+'>设备品牌</div>'+
							'	<div '+c+'>设备型号</div>'+
							'	<div '+d+'>配件名称</div>'+
							'	<div '+e+'>配件型号</div>'+
							'	<div class="last  '+f+'">配件编号</div>'+
							'</div>');
/*				var jSearch = $('<div class="search_list">'+
						'	<div class="selected">设备名称</div>'+        
						'	<div>设备品牌</div>'+
						'	<div>设备型号</div>'+
						'	<div>配件名称</div>'+
						'	<div>配件型号</div>'+
						'	<div class="last">配件编号</div>'+
						'</div>');
						*/
				$("body").append(jSearch);
				$search = jSearch;
			}
			
			//设置默认值-----搜索框条件
			//$("input[name='selectedCondition']").attr("value","");
			
			$search.css("left",txtDiv_oLeft).css("top",txtDiv_oTop).css("width",jTxtDiv.width());
			$search.fadeIn();
			
			var jWin = $(window);			
			var mask = $('<div class="search_list_mask" style="width:'+jWin.width()+'px; height:'+jWin.height()+'px"></div>');
			mask.bind("click",function(){
				$(".search_list_mask").remove();
				$search.fadeOut();
				//$(".search_list").remove();
			})
			
			$search.before(mask);
			
			$(".search_list div").click(function(){
				$(".search_list div").each(function(){
					$(this).removeClass("selected");
				});
				$(this).addClass("selected");

				$("input[name='selectedCondition']").attr("value",$(this).text());
				
			});
			
		})	
			
	}
	
	
})(jQuery);