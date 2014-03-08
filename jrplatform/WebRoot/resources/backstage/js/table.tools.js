;(function($) {
	
	$.cloneTableHead          = function(opts){ cloneTableHeadFunc(window, opts); }	
	$.changeTableHead         = function(opts){ changeTableHeadFunc(window, opts)}
	$.installTable            = function(opts){ installTableFunc(window, opts); }
	$.tableAutoScroll         = function(opts){ tableAutoScrollFunc(window, opts); }
	
	$.cloneTableHead.version  = 2.1;
	$.installTable.version    = 2.0;
	$.changeTableHead.version = 1.0;
	$.tableAutoScroll.version = 2.0
	
	var nClass;

	function changeTableHeadFunc(window,opts)
	{
		opts = jQuery.extend({
				scrollContainer         : ".scrollbar",
				cloneValue              : 1,
				cloneTable              : ".table",
				scrollBorder            : 37,
				auto                    : false
		},opts||{});
		
		updateScrollbar($(opts.scrollContainer),opts);
	
	}
	
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// 表格滚动条控制
	// 1、当表格高度超过页面高度时，根据页面高自动调整滚动显示
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
	var tableAutoScrollOpts;	
	function tableAutoScrollFunc(window,opts)
	{
		try{
		
			
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
			$(opts.scrollContainer).css("height",cBodyH - fHeight - 37);
		}catch(e){}
	}
	
	$(window).resize(function(){$.tableAutoScroll(tableAutoScrollOpts)})
	
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// 表格头复制
	// 1、当表格出现滚动条，滚动内容后将表格头遮挡后，插件自动克隆表格头
	// 
	// 
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
	
	function cloneTableHeadFunc(window, opts)
	{
		opts = jQuery.extend({
				scrollContainer         : ".scrollbar",
				cloneValue              : 1,
				cloneTable              : ".table",
				scrollBorder            : 37,
				auto                    : true
		},opts||{});
		
		nClass = opts.cloneTable.substring(1,opts.cloneTable.length)+"_cloneTable";
		
		$(opts.scrollContainer).scroll(function(event)
		{
			updateScrollbar(this,opts);
		})
	}

	var updateScrollbar = function(scrollContainer, opts)
	{
		var $nClass = $("."+nClass);
		
		// top 
		if(scrollContainer.scrollTop >= opts.cloneValue && $nClass.length == 0)
		{
			var jScroll      = $(scrollContainer);
			var tOffset      = jScroll.offset();
			var _width       = jScroll[0].clientWidth;
			
			var $table = $(opts.cloneTable);				
			var $tr    = $table.find("tr:first");
			
			var _height      = $tr[0].clientHeight;
			
			var cloneTable   = $table.clone(true).empty().append($tr.clone(true));			
			var sDiv         = jQuery('<div style="position:fixed; overflow:hidden;"></div>');
				sDiv.css("width",_width).css("height",_height).css("top",tOffset.top).css("left",tOffset.left).addClass(nClass);
				sDiv.append(cloneTable);
			
			$("body").append(sDiv);				
		}else{
			
			if(opts.auto == false)
			{
				$nClass.css("top",scrollContainer.offset().top);
			}
			
			if(scrollContainer.scrollTop < opts.cloneValue)
			{
				$nClass.remove();
			}
		}
		
		//left
		if(scrollContainer.scrollLeft >= 0 && scrollContainer.scrollTop > opts.cloneValue)
		{
			$("."+nClass)[0].scrollLeft = scrollContainer.scrollLeft;
		}
	}
	
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// 表格相关设置初始化
	// 1、鼠标移入、移出颜色的改变；
	// 2、全选；
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
	
	function installTableFunc(window,opts)
	{
		opts = jQuery.extend({
				rowTitleBordercolor     : "#339E35",
				rowContentBordercolor   : "#9DD29E",
				rowSelectedcolor        : "#FFFFCC",
				rowOvercolor            : "#F3F3F3",
				rowDefaultcolor         : "#FFFFFF",
				checkboxIndex           : 1,
				cloneTable              : ".table"             
		},opts||{});
		
		var tablePanel = jQuery(opts.cloneTable);	
				
		setLastBorderStyle();		
		
		if(opts.checkboxIndex >= 1){
			checkboxHandler();
		}		
		
		mouseColorHandler();
		
		function mouseColorHandler()
		{
			var count = 0;
			var allTr = tablePanel.find("tr").each(function()
			{
				if(count > 0){
					this.onmouseout=function()
					{
						if(opts.checkboxIndex >= 1 && getCheckbox(this).checked){
							setRowBgColor(this,true);
						}else{
							setRowBgColor(this,false,opts.rowOvercolor,opts.rowDefaultcolor);
						}
					}
					
					this.onmouseover=function()
					{
						setRowBgColor(this,true,opts.rowOvercolor,opts.rowDefaultcolor);
					}
				}	
				count ++;
			});			
		}
		
		function checkboxHandler()
		{
			try{
			
				var titleTh = tablePanel.find("tr th")[opts.checkboxIndex-1];
				$(titleTh).attr("checked",false);
				$(titleTh).css("cursor","pointer");
				
				titleTh.onclick=function(event)
				{
					var nValue = !Boolean($(titleTh).attr("checked"));
					
					tablePanel.find("tr").each(function()
					{
						var allTd = $(this).find("td");						
						if(allTd.length >= 1)
						{
							var checkbox = $(allTd[opts.checkboxIndex-1]).find(":checkbox");
							
							$(checkbox).attr("checked",nValue);    
							$(titleTh).attr("checked",nValue);	
							
							setRowBgColor(this,nValue);
						}
					});
				}
				
				tablePanel.find("tr").each(function()
				{
					var cTr = this;
					var targetTd = $(cTr).find("td")[opts.checkboxIndex-1];
					if(targetTd != undefined)
					{
						$(targetTd).click(function(event)
						{
							var checkboxInput = $(this).find("input")[0];						
							if(event.target.tagName == "TD"){							
								$(checkboxInput).attr("checked",!checkboxInput.checked);							
							}
							
							setRowBgColor(cTr,checkboxInput.checked);
						})						
					}
				})
			}catch(e){
				
			}
		}
		
		function setRowBgColor(row, checked, selectedcolor, defaultcolor)
		{
			selectedcolor = selectedcolor || opts.rowSelectedcolor;
			defaultcolor  = defaultcolor  || opts.rowDefaultcolor;
			
			if(checked){
				$(row).attr("bgcolor", selectedcolor);		
			}else{
				$(row).attr("bgcolor", defaultcolor);		
			}
		}
		
		function getCheckbox(cTr)
		{
			if(cTr == null || cTr == "" || cTr == undefined){
				
			}else{
				return $($(cTr).find("td")[opts.checkboxIndex-1]).find(":checkbox")[0];
			}			
		}

		function setLastBorderStyle()
		{
			var allTh = tablePanel.find("tr th");
			$(allTh[allTh.length-1]).css("border-right","1px solid "+opts.rowTitleBordercolor);
			
			tablePanel.find("tr").each(function()
			{
				var lastTd = $(this).find("td:last");		
				if(lastTd != "")
				{
					$(lastTd).css("border-right","1px solid "+opts.rowContentBordercolor);
				}
			})
		}
	}
	
	
	function clearUnit(value)
    {
		if(value == undefined){
			return 0;
		}
		
		value = value.toUpperCase();
		if(value == "AUTO" || value == "0PX"){
			return 0;
		}else if(value.indexOf("PX")>=0){
			return parseInt(value.substring(0,value.indexOf("PX")));
		}
		
		return 0;
    }    
})(jQuery);