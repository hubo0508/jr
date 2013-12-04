;(function($) {

	$.tableAutoScroll         = function(opts){ tableAutoScrollFunc(window, opts);     }
	
	$.tableAutoScroll.version = 2.0
	
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// 表格滚动条控制
	// 1、当表格高度超过页面高度时，根据页面高自动调整滚动显示
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
	var tableAutoScrollOpts;	
	function tableAutoScrollFunc(window,opts)
	{
		if(opts == undefined){
			opts = tableAutoScrollOpts;
		}else{
			opts = jQuery.extend({
				fixed_height     : 0,
				fixed_target     : [],
				fixed_type       : "",
				popup_win        : "",
				scrollContainer  :".scrollbar",
				scrollContent    :".table-bordered"
			},opts||{});
			
			tableAutoScrollOpts = opts;
		}

		var cBodyH = 0;
		if(opts.popup_win != "" && opts.popup_win != null && opts.popup_win != undefined){
			cBodyH = window.parent.targetWH("#"+opts.popup_win+"_iframe").h;
		}else{
			cBodyH = document.body.clientHeight;
		}

		var fHeight = 0;
		for(var i=0; i<opts.fixed_target.length; i++)
		{
			
			var cTargetStr = opts.fixed_target[i];
			
			if(!isNaN(cTargetStr)){
				fHeight += cTargetStr;
			}else{
				var cTargetObj = cTargetStr.indexOf(":height")>0 ? $(cTargetStr.split(":")[0]) : $(cTargetStr);
				if(cTargetObj.length >= 2){
					for(var j=0; j<cTargetObj.length; j++){
						if(cTargetStr.indexOf(":height")>0){
							fHeight += clearUnit($(cTargetObj[j]).css("height"));
						}else{
							fHeight += clearUnit($(cTargetObj[j]).css("height"))
									+  clearUnit($(cTargetObj[j]).css("margin-top")) 
									+  clearUnit($(cTargetObj[j]).css("margin-bottom")) 
									+  clearUnit($(cTargetObj[j]).css("padding-top")) 
									+  clearUnit($(cTargetObj[j]).css("padding-bottom"));
						}							
					}
				}else{
					if(cTargetStr.indexOf(":height")>0){
						fHeight += clearUnit($(cTargetObj).css("height"));
					}else{
						fHeight += clearUnit($(cTargetObj).css("height"))
								+  clearUnit($(cTargetObj).css("margin-top")) 
								+  clearUnit($(cTargetObj).css("margin-bottom")) 
								+  clearUnit($(cTargetObj).css("padding-top")) 
								+  clearUnit($(cTargetObj).css("padding-bottom"));
					}	
				}
			}					
		}
		$(opts.scrollContainer).css("height",cBodyH - fHeight -37);
	}
	
	function clearUnit(value)
    {
		if(value == undefined){
			return 0;
		}
		
		value = value.toUpperCase();
		if(value == "AUTO" || value == "0PX"){
			return 0;
		}else if(value.indexOf("PX")>0){
			return parseInt(value.substring(0,value.indexOf("PX")));
		}
		
		return 0;
    }      
    
	
	$(window).resize(function(){$.tableAutoScroll(tableAutoScrollOpts)})
	
})(jQuery);