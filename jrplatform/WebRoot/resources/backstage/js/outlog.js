$(function(){				   
	$("body").append('<div id="outlog" style="top:0px; left:0px;height:100%; width:200px; position:absolute; background-color:#999;"></div>');	
});

function outlog(html){
	$("#outlog").append($("#outlog").html()+html+"<br/>")	
}