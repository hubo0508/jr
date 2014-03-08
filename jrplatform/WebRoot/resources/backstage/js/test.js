
	var helper=function(jo){ 
	   this.init=function(){
		   
		   }    
	   this.open=function(){
		   
		   }          
	   this.close=function(){
		   
		   }
	}
	
	return this.each(function(){
		$(this).data("helper",new helper($(this)));
	});
	
	//$(this).data("helper").init();