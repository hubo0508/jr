/**
 * 系统菜单插件
 * 
 * @params overcolor    默认菜单值
 * @params defaultcolor 显示内容顶级容器ID
 * @params opts 参数
 */
jQuery.fn.navigationbutton = function(overcolor, defaultcolor, opts){
	opts = jQuery.extend({		
		callback:function(){return false;}
	},opts||{});
	
	return this.each(function()
	{
		var fobj = jQuery(this);	
		//buttonCompatibleStyles(fobj);
		linksButton(fobj);
	})
	
	function linksButton(fobj)
	{
		fobj.find(".btn").hover(
			function(){
				$($(this).find(".hline")[0]).css("background-color",overcolor);
			},
			function(){
				$($(this).find(".hline")[0]).css("background-color",defaultcolor);
			}						 
		);
		
		fobj.find(".btn").click(function (){
			var text = $(this).find(".text")[0]
			opts.callback($(text).text());								 
		})
		
	}
}