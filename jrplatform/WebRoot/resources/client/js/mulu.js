;(function($) {
	
	$.cloneNavigation        = function(opts){ cloneNavigationFunc(window, opts); }	
	$.clickNavigation        = function(opts){ clickNavigationFunc(window, opts); }
	
	function clickNavigationFunc(window,opts)
	{
		opts = jQuery.extend({
			target                   : ".mulu li",
			match                    : "._title",
			selected_class           : "selected",
			pagetype  : "type"
		},opts||{});
		
		var body = $.browser.webkit ? $("body")[0] : $("html")[0];
		if($.browser.mozilla == true && opts.pagetype == "type"){
			body = document.body;
		}
		
	
		$(opts.target).click(function()
		{
			var $this = $(this);
			
			$(opts.target).each(function(){
				$(this).removeClass(opts.selected_class);
			})
			
			$this.addClass(opts.selected_class);
			
			var thisText = $this.text();
			
			if(opts.pagetype == "learn"){
				var $thisChildrenMC = $this.children(".mc");
				thisText = $thisChildrenMC.text();
				
				if(opts.callback != undefined){
					opts.callback($thisChildrenMC.attr("id"));
				}
			}

			$("body").find(opts.match).each(function(){
				var $match = $(this);
				var matchText = $match .text();
				
				if(matchText == thisText)
				{
					$(body).animate({scrollTop:$match .offset().top-5},1000);
				}
			});
		
		})
	}

	
	function cloneNavigationFunc(window, opts)
	{
		opts = jQuery.extend({
			clone                   : ".mulu",
			clone_right             : 40,
			top_range               : 430,
			pagetype  : "type"
		},opts||{});
		
		var nClass = opts.clone.substring(1,opts.clone.length)+"_cloneNavigation";

		//var t = document.documentElement.scrollTop || document.body.scrollTop;  
		
		$(window).scroll(function()
		{
			
			var body = $.browser.webkit ? $("body")[0] : $("html")[0];
			if($.browser.mozilla == true && opts.pagetype == "type"){
				body = document.body;
			}
			var $thisScrollTop  = Number(body.scrollTop);
			
			var cNav = $("."+nClass);
			if($thisScrollTop > opts.top_range){
				
				if(cNav.length == 0){
					var oMulu = $(opts.clone);
					var jMulu = oMulu.clone(true).addClass(nClass).css("z-index",100).css("position","fixed");
						jMulu.css("top",5).css("left",(oMulu.offset().left+opts.clone_right));

						oMulu.css("display","none");
						
					$("body").append(jMulu);
				}
				
			}else{
				cNav.remove();
				$(opts.clone).css("display","block");
			}
		})

	}	

})(jQuery);