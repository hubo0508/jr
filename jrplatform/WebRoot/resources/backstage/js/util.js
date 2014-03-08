
	/**
	 * 根据ID删除数据
	 * 
	 * @param url 请求URL
	 * @param id 数据ID
	 */
	function deleteById(url, id, event) {
		stopBubble(event);
		$.ajax({
			type : "post",
			url : url,
			dataType : "json",
			data : "id=" + id,
			contentType : "application/x-www-form-urlencoded; charset=UTF-8",
			success : function(msg) {
				if ((msg.success + "") == "true") {
					alert("删除成功");
					getList(page_size, current_page);
				} else {
					alert("系统繁忙,请稍后再试");
				}
			}
		})
	}
	
	/**
	 * 格式化时间
	 *
	 * @param time 被格式化时间(2012-12-12 22:22:22)
	 * @param format 显示格式。现以实现以下格式转换：yyyy-MM-dd hh:mm:ss  yyyy年MM月dd日 HH时mm分ss秒
	 * 
	 * formattingTime(2012-12-12 22:22:22,yyyy-MM-dd hh);
	 */
	function formattingTime(_time, _format){
		 
		 var ymd = new Array();
		 var hms = new Array(); 
		 
		if("yyyy-MM-dd hh:mm:ss".indexOf(_format) >=0){
		var timeSplit = _time.split(" ");
		ymd = timeSplit[0].split("-");
		hms = timeSplit[1].split(":");
	}else if("yyyy年MM月dd日 hh时mm分ss秒".indexOf(_format) >= 0){
		var timeSplit = _time.split(" ");
		ymd[0] = timeSplit[0].split("年")[0];
		ymd[1] = timeSplit[0].split("月")[0];
		ymd[1] = ymd[1].substring(ymd[1].indexOf("年")+1,ymd[1].length);
		ymd[2] = timeSplit[0].split("日")[0];
		ymd[2] = ymd[2].substring(ymd[2].indexOf("月")+1,ymd[2].length);
		hms[0] = timeSplit[1].split("时")[0];
		hms[1] = timeSplit[1].split("分")[0];
		hms[1] = hms[1].substring(hms[1].indexOf("时")+1,hms[1].length);
		hms[2] = timeSplit[1].split("秒")[0];
		hms[2] = hms[2].substring(hms[2].indexOf("分")+1,hms[2].length);
		}
	
		return new Date(ymd[0],ymd[1],ymd[2],hms[0],hms[1],hms[2]).format(_format);
	}
	
	Date.prototype.format =function(format)
	{
		var o = {
					"M+" : this.getMonth()+1, //month
					"d+" : this.getDate(), //day
					"h+" : this.getHours(), //hour
					"m+" : this.getMinutes(), //minute
					"s+" : this.getSeconds(), //second
					"q+" : Math.floor((this.getMonth()+3)/3), //quarter
					"S" : this.getMilliseconds() //millisecond
			    }
		if(/(y+)/.test(format)) format=format.replace(RegExp.$1,
		(this.getFullYear()+"").substr(4- RegExp.$1.length));
		for(var k in o)if(new RegExp("("+ k +")").test(format))
		format = format.replace(RegExp.$1,
		RegExp.$1.length==1? o[k] :
		("00"+ o[k]).substr((""+ o[k]).length));
			return format;
	}
	
	/**
	 * 停止时间冒泡
	 * 
	 * @param e 事件
	 */
	function stopBubble(e) { 
	    var e = e ? e : window.event;  
	    if (window.event) { // IE  
	        e.cancelBubble = true;   
	    } else { // FF  
	        //e.preventDefault();   
	        e.stopPropagation();   
	    }   
	}  
	
	var specialReg   = new RegExp("[`~!@%#$^&*()=|{}':;',　\\[\\]<>/? \\.；：%……+￥（）【】‘”“'。，、？]"); 
    var numberReg    = /^[0-9]*[1-9][0-9]*$/;
    
    var doubleReg    = /^-?\d+\.?\d{0,2}$/;
	var intReg       = /^[0-9]{1,4}$/;