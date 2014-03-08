/**
 * 系统菜单插件
 * 
 * @params defaultmenu 默认菜单值
 * @params iframe 显示内容顶级容器ID
 * @params opts 参数
 */
jQuery.fn.navigationmenu = function(defaultmenu, opts){
	opts = jQuery.extend({
		selectcolor  : "#339E35",
		overcolor    : "#BAD80A",
		outcolor     : "#F3F3F3",
		one_menu_mleft : 30,
		two_menu_mleft : 0,
		child_menu    : "#child_menu",
		child_content : "#child_iframe",
		menu         : [],
		/*child_overcolor   : "#F3F3F3",
		child_selectcolor : "#BAD80A",
		child_outcolor    : "#FFFFFF",*/
		child_overcolor   : "#FFA900",
		child_selectcolor : "#BAD80A",
		child_outcolor    : "#FFFFFF",
		projectname    : "_",
		callback:function(){return false;}
	},opts||{});
	
	return this.each(function()
	{
	
		var child_opts = [];
		
		var panel = jQuery(this);
		
		drawLinks(opts.menu);
	
		initialSettings(defaultmenu);
		
		initialLoading();
		child_iframe
		function currentMenu(){
			return last_menu_text;	
		}
		
		function childMenu(text){
			return child_opts[text];
		}
		
		function initialLoading(){	
			$(opts.child_content).load(function(){
				opts.loading.css("display","none");
			})
		}
		
		function drawLinks(m)
		{
			panel.empty();			
		
			for(var i=0; i<m.length; i++)
			{
				child_opts[m[i].text] = m[i].child;
				
				var lnk = jQuery('<div href="' + m[i].href + '">' + m[i].text + '</div>')				
						  .bind("click", function clickHandler()
						  {
								panel.find("div").each(function(){					  
									if($(this).attr("m") == "selected"){
										restoreStyle(this);return;
									}
								})	
								
								selectStyle(this);
								
								//opts.callback({"href":$(this).attr("href"),"text":$(this).text()});		

								setIframeSrc(opts.child_content,$(this).attr("href"));
								
								drawChildLinks($(this).text());
						   })						   
						   .bind("mouseover",function mouseoverHandler()
						   {
								$(this).css("background-color",opts.overcolor);
						   })					   
						   .bind("mouseout",function mouseoutHandler()
						   {
								var mark = $(this).attr("m");
								if(mark == "cancel"){
									$(this).css("background-color",opts.outcolor);
									return;
								}
								if(mark == "selected"){
									selectStyle(this);
								}
						   })
				
				panel.append(lnk);
				delete lnk;
			}
		}
		
		function initialSettings(defaultmenu)
		{
			var count = 0;
			panel.find("div").each(function(){
											  
				if(count == 0){
					$(this).css("margin-left",opts.one_menu_mleft);
				}
				
				if(defaultmenu == $(this).text()){
					selectStyle(this);
					drawChildLinks($(this).text());
					setIframeSrc(opts.child_content,$(this).attr("href"));
				}else{
					$(this).attr("m","cancel");
				}
				
				count ++;
			})
			
			panel.after('<div style="height:4px; background-color:'+opts.selectcolor+'"></div><div style="background-image:url(resources/backstage/image/skin/nav-line.png); width:100%; height:3px;"></div>');
		}

		function selectStyle(obj,_selectcolor)
		{
			$(obj).css("background-color",_selectcolor || opts.selectcolor);
			$(obj).attr("m","selected");
		}
		
		function restoreStyle(obj,_outcolor)
		{
			$(obj).css("background-color", _outcolor || opts.outcolor);
			$(obj).attr("m","cancel");
		}
		
		function drawChildLinks(text)
		{
			var child_panel = $(opts.child_menu);
			child_panel.empty();

			var c_opt = child_opts[text];			
			if(!(c_opt instanceof Array) || c_opt instanceof String){
				return ;
			}
			
			var count = 0;
			for(var i=0; i<c_opt.length; i++)
			{
				var href = c_opt[i].href == (undefined || "" || null) ? "" : c_opt[i].href;
				var icon = c_opt[i].icon;
				var text = c_opt[i].text;
				
				var html = "";
				if(text == "/"){
					html = '<dt class="g_gray_line" style="margin-top:8px; margin-bottom:8px;"></dt>';
				}else{
				
					if(count == 0){
						html = '<div m="cancel" style="margin-top:15px" href="' + href + '">';
					}else{
						html = '<div m="cancel" href="' + href + '">';
					}
					count ++;
					
					if(icon != undefined){
						html += '<span style="padding-left:'+opts.two_menu_mleft+'px;background-image:url(resources/backstage/image/menu/' + icon + '.png)">' + text + '</span></div>';
					}else{
						html += '<span style="padding-left:'+opts.two_menu_mleft+'px;">' + text + '</span></div>';
					}
					
					var lnk = jQuery(html)		
						.bind("click",function clickHandler(){
							
							child_panel.find("div").each(function(){
								if($(this).attr("m") == "selected"){
									restoreStyle(this,opts.child_outcolor);return;
								}
							})
							
							selectStyle(this,opts.child_selectcolor);
						
							//$(opts.child_content).attr("src",$(this).attr("href"));
							setIframeSrc(opts.child_content,$(this).attr("href"));
						})

						.bind("mouseover",function mouseoverHandler()
						{
							$(this).css("background-color",opts.child_overcolor);
						})		

						.bind("mouseout",function mouseoutHandler()
						{
							var mark = $(this).attr("m");
							if(mark == "cancel"){
								$(this).css("background-color",opts.child_outcolor);
								return;
							}
							if(mark == "selected"){
								selectStyle(this,opts.child_selectcolor);
							}
						})
				}
						
				child_panel.append(lnk || html);				
				lnk = null;
			}
		}
		
		function setIframeSrc(id,src){
		
			opts.loading.css("display","table");
			
			if(src != undefined && opts.projectname != "_"){
				$(id).attr("src",opts.projectname+src);
			}
			
			/*
			src == undefined ? "" : src;		
			
			if(opts.projectname == "_"){
				$(id).attr("src",src);
			}else{
				$(id).attr("src",opts.projectname+src);
			}*/
		}

		/*
		function isArray(obj) {   
		  return Object.prototype.toString.call(obj) === '[object Array]';    
		} 		
		*/
	})
}