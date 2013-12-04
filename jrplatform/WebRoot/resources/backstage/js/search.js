//Search=function(){}
jQuery.fn.search = function(opts){
	opts = jQuery.extend({		
		callback:function(){return false;}
	},opts||{});

	
	return this.each(function()
	{
		/*
		$(".search .round").css("display","none");
		$(".search .t_line").css("display","block");
		$(".search .t_i").css("background-image","url(../image/skin/t.png)");
		*/
		
		$(".search .title").click(function()
		{
			var sRound = $(".search .round");
			if(sRound.css("display") == "none"){
				sRound.css("display","block");
				
				$(".search .t_line").css("display","none");
				$(".search .t_i").css("background-image","url(resources/backstage/image/skin/b.png)");
				
			}else{
				sRound.css("display","none");
				
				$(".search .t_line").css("display","block");
				$(".search .t_i").css("background-image","url(resources/backstage/image/skin/t.png)");
			}
			
			opts.callback();
		})
		
	})
}