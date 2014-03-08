var PopupWindowScrollbar = function(iframeid, scrollbar)
{
	
	if(iframeid != null && scrollbar != undefined){
		var cIframeHeight = window.parent.targetWH("#"+iframeid+"_iframe").h;		
		$(scrollbar).css("height",cIframeHeight-50);
	}
		
	if(iframeid != null){
		//出现滚动条时，对按钮栏位置进行调整
		if(window.parent.targetWH("#"+iframeid+"_iframe").h < $("body").height()){
			$(".pc_win_nav").css("top", ($("body").height() + 30));	
		}
	}
}