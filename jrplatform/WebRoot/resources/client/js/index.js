;(function($) {
	
	$.searchList         = function(opts){ searchListFunc(window, opts); }	
	$.searchTxt          = function(opts){ searchTxtFunc(window, opts); }	
	$.menu               = function(opts){ menuFunc(window, opts);}
	
	$.tootip             = function(opts){ tootipFunc(window, opts)}
	
	
	
	function tootipFunc(window, opts)
	{
		var tootipstr = '<div style="position:fixed; right:0px; bottom:100px;">' +
						'	<img class="goPhone" src="img/phone.jpg" title="联系我们" style="cursor:pointer"/> ' +
						'	<br /> '+
						'	<img class="goTop" style="display:none;cursor:pointer" src="img/up.jpg" title="回到顶部"/>' +
						'</div>';
		$("body").append($(tootipstr));
		
		var $goTop = $(".goTop");
		
		$goTop.click(function(){
			$(body).animate({scrollTop:0},1000);
		});
		
		$(".goPhone").click(function(){
			window.location = "./about.html";
		})
		
		var body = $.browser.webkit ? $("body")[0] : $("html")[0];
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
		jSTxt.attr("value","输入您所关心的内容！").css("color","#9E9E9E");
		jSTxt.focus(updateSTxt);
		jSTxt.blur(updateSTxt);
		jSTxt.keyup(updateSTxt);
		jSTxt.click(function(){
			if(jSTxt.attr("value") == "输入您所关心的内容！" ){
				jSTxt.attr("value","");
			}
		})
	}
	

	function searchListFunc()
	{
		$(".search .txt").click(function(){
										 
			var jTxtDiv = $(this).parent();
			var txtDiv_oLeft = jTxtDiv.offset().left;
			var txtDiv_oTop  = jTxtDiv.offset().top + jTxtDiv.height();	
					
			//var jSearch = $(".search_list");
			var jSearch = $('<div class="search_list">'+
							'	<div class="selected">设备类型</div>'+        
							'	<div>设备品牌</div>'+
							'	<div>设备型号</div>'+
							'	<div>配件名称</div>'+
							'	<div>配件型号</div>'+
							'	<div class="last">配件编号</div>'+
							'</div>');
			$("body").append(jSearch);
			
			jSearch.css("left",txtDiv_oLeft).css("top",txtDiv_oTop).css("width",jTxtDiv.width());
			jSearch.fadeIn();
			
			var jWin = $(window);			
			var mask = $('<div class="search_list_mask" style="width:'+jWin.width()+'px; height:'+jWin.height()+'px"></div>');
			mask.bind("click",function(){
				$(".search_list_mask").remove();
				jSearch.fadeOut();
				$(".search_list").remove();
			})
			
			jSearch.before(mask);
			
			$(".search_list div").click(function(){
				$(".search_list div").each(function(){
					$(this).removeClass("selected");
				})
				$(this).addClass("selected");
			})
			
		})	
			
	}
	
	
})(jQuery);