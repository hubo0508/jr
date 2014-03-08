<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String filedir = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort() + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=8" />
	
     <script src="<%=request.getContextPath()%>/resources/backstage/js/jquery-1.7.js" type="text/javascript"></script> 
    
    <script src="<%=request.getContextPath()%>/resources/backstage/js/popwin_scrollbar.js" type="text/javascript"></script> 
    <!-- <script src="<%=request.getContextPath()%>/resources/backstage/ckeditor.js" type="text/javascript"></script> -->
    
    <link href="<%=request.getContextPath()%>/resources/backstage/css/shared.css" rel="stylesheet" type="text/css" />
    
    <script src="<%=request.getContextPath()%>/resources/backstage/js/popwin_scrollbar.js" type="text/javascript"></script> 
    <script src="<%=request.getContextPath()%>/resources/backstage/ckeditor.js" type="text/javascript"></script>
    
    <link href="<%=request.getContextPath()%>/resources/backstage/css/shared.css" rel="stylesheet" type="text/css" />
    
    <script src="<%=request.getContextPath()%>/resources/backstage/js/ajaxfileupload.min.js" type="text/javascript"></script>
     
    <script type="text/javascript" charset="utf-8" src="<%=request.getContextPath()%>/resources/ueditor1_3_5/ueditor.config.js"></script>
	<script type="text/javascript" charset="utf-8" src="<%=request.getContextPath()%>/resources/ueditor1_3_5/ueditor.all.min.js"></script>
	<script type="text/javascript" charset="utf-8" src="<%=request.getContextPath()%>/resources/ueditor1_3_5/lang/zh-cn/zh-cn.js"></script>
     
   <style>
   	
	*{font-size:12px; font-family:"宋体"}
	
	.base_title_table{margin-top:15px; margin-left:15px;}
	.base_title_table  tr td{padding:0.7em 0.4em}
	
	.add_edit_table { margin-left:15px; margin-bottom:15px;}
	.add_edit_table tr td{padding:0.5em 0.4em}
	.add_edit_table select{ width:200px;}
	.add_edit_table .txt{width:200px;}
	
	.text_line{ width:150px; text-align:left}

   </style>
   
</head>

<body sroll="no">
	
    <div class="scrollbar">
   
	    <table cellpadding="0" cellspacing="0" border="0"  width="800" class="base_title_table">
	    	<tr>
	        	<td width="110" align="right">库存：</td>
	            <td width="72" align="left"><input id="stock" name="stock" value="${p.stock }" type="text"  class="txt" style="width:50px"/></td>
	            <td width="76" align="right">淘宝链接：</td>
	            <td width="582" align="left"><input id="taobao_links" value="${p.taobao_links }" name="taobao_links" type="text"  class="txt" style="width:87.5%"/></td>
	        </tr>
	    </table>
	    
		<div class="g_light_green_line" style="margin-top:10px; margin-bottom:10px;"></div>
	    
	    <table cellpadding="0" cellspacing="0" border="0" width="800" class="add_edit_table">
	    	<tr>
	        	<td width="98" align="right">配件名称：</td>
	            <td align="left"><input id="fitting_name" value="${p.fitting_name }" name="fitting_name" type="text" class="txt" /></td>
	            <td width="171" align="right">自定义类别：</td>
	            <td width="269" align="left"><select id="device_type_use_id" name="device_type_use_id" class="txt" style="width:200px"></select>
	            </td>
	        </tr>
	        <tr>
	        	<td align="right">品牌：</td>
	            <td width="262" align="left"><input id="brand" value="${p.brand }" name="brand" type="text" class="txt" /></td>
	            <td width="171" align="right">专业类别：</td>
	            <td width="269" align="left"><select id="device_type_sort_id" name="device_type_sort_id" class="txt" style="width: 200px;"></select></td>
	        </tr>
	        <tr>
	        	<td align="right">配件编号：</td>
	            <td width="262" align="left"><input id="fitting_number" value="${p.fitting_number }" type="text" class="txt" /></td>
	            <td width="171" align="right">规格描述：</td>
	            <td width="269" align="left"><input id="specification_desc" value="${p.specification_desc }" type="text" class="txt" /></td>
	        </tr>
	        <tr>
	        	<td align="right">适用型号：</td>
	            <td width="171" align="left" colspan="3">
	            	<textarea style="width:91%; height:80px;" id="models" class="txt">${p.models }</textarea>
	            	<br/>
	            	<span style="font-size:12px; color:#F00;">多个型号使用符号;分隔，例如：FAM-DS199HM;FAM-DS199HM;</span>
	            </td>
	        </tr>
	        <tr>
	        	<td align="right">配件图片：</td>
	            <td align="left">
	            	<input id="select_document" name="select_document" type="file" required="true" class="txt"/>
	            	<span id="image_url" style="display:none"></span>
	            	<br />
                    <span style="font-size:12px; color:#F00; float:left">上传图片尺寸为400*400、类型为：jpg、png、gif</span>
	            </td>
	            <td align="left" colspan="2" id="img_td"></td>
	        </tr>
	        <tr>
	        	<td align="right" valign="top">配件特性：</td>
	            <td align="left" colspan="3" >
	            	<!-- <textarea class="ckeditor" name="fitting_desc">${p.fitting_desc }</textarea> -->
	            	<script id="fitting_desc" type="text/plain" style="width:700px;height:400px;">${p.fitting_desc }</script>
	            </td>
	        </tr>
	        <tr>
	        	<td align="right" valign="top">服务承诺：</td>
	            <td align="left" colspan="3" valign="top">
	            	<!-- <textarea class="ckeditor" name="sale_protection">${p.sale_protection }</textarea> -->
	            	<script id="sale_protection" type="text/plain" style="width:700px;height:400px;">${p.sale_protection }</script>
	            </td>
	        </tr>
	    </table>
</div>
    
    <div class="pc_win_nav">
        <div class="g_green_line"></div>
        <div class="bottom_navigation">
            <div id="close" onclick="closeHandler()">关闭</div>
            <div id="save" onclick="saveAllHandler()">保存</div>
        </div>
        <div class="g_green_line"></div>
    </div>
    
    <div id="loading" style="padding:5px; color:#FFF; position:fixed; top:5px; left:5px; display:none;"></div>
    
    <div id="loading" style="padding:5px; color:#FFF; position:fixed; top:5px; left:5px; display:none;">${c.error }</div>
    
</body>
<script type="text/javascript">

	var ue = UE.getEditor('fitting_desc');
	var ue2 = UE.getEditor('sale_protection');

	$(function(){		

		queryCategoryList();
		querySpecialtyCategoryList();
		
		PopupWindowScrollbar("fittingAdd_Edit_JUMP",".scrollbar");
		
		if("${p.image_url }".length > 0){
			$("#img_td").html('<img id="img_" width="200" height="200" src="${p.image_url }"/>');
		}
		
	})
	
	function saveAllHandler(){
	
		$("#loading").css("display","block").css("background-color","#090").html("正在保存，请稍后！");
		
		var _img_ = $("#select_document").attr("value");
		if(_img_ == ""){
			saveHandler("${p.image_url }");
			return;
		}
		
		$.ajaxFileUpload({ 
		    url:"${pageContext.servletContext.contextPath}/file/uploadImage?image=select_document",  
		    secureuri:false,  
		    fileElementId:'select_document',  
		    dataType: 'json', 
		    success: function (data, status)
		    {
		    	var j = eval('(' + data.replace(/<[^>]+>/g,"")+ ')');
             	if((j.success+"") == "true"){
             		saveHandler(j.message,"${p.image_url}");
             	}else{
             		$("#loading").fadeOut();
             		window.parent.alert("请上传png、gif或jpg格式的图片！");
             	}
		    },
		    error: function (data, status, e)
            {
            	window.parent.alert(eval('(' + data.replace(/<[^>]+>/g,"")+ ')').message);
            }
		});  
	}

	function querySpecialtyCategoryList(){
		$.ajax({
			type : "post",
			url : "${pageContext.servletContext.contextPath}/fittingSpecialtyCate/list",
			dataType:"json",
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			success : function(msg) {
				if(msg && (msg.success+"") == "true"){
					var _option = '<option value="-1">--请选择--</option>';
					$.each(msg.object,function(idx,item){
						var _id  = item.id;var _fitting_category = item.fitting_category || '&nbsp';
						if(_id == "${p.device_type_sort_id}"){
							_option += '<option value="'+_id+'" selected="true">'+_fitting_category+'</option>';
						}else{
							_option += '<option value="'+_id+'">'+_fitting_category+'</option>';
						}
					});
					$("#device_type_sort_id").html(_option);
				}
			},
			complete: function(XMLHttpRequest, textStatus){
				if(XMLHttpRequest.getResponseHeader("sessionstatus")=="timeout"){
					window.top.location.href="${pageContext.servletContext.contextPath}/login";
				}
				if(XMLHttpRequest.getResponseHeader("sessionstatus")=="no_w"){
					alert("您的权限级别无法进行保存或修改数据操作！");
				}
			}
		});
	}
	
	function queryCategoryList(){
		$.ajax({
			type : "post",
			url : "${pageContext.servletContext.contextPath}/productCategory/list",
			dataType:"json",
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			success : function(msg) {
				if(msg && (msg.success+"") == "true"){
					var _option = '<option value="-1">--请选择--</option>';
					$.each(msg.object,function(idx,item){
						var _id  = item.id;var _product_use = item.product_use || '&nbsp';
						if(_id == "${p.device_type_use_id}"){
							_option += '<option value="'+_id+'" selected="true">'+_product_use+'</option>';
						}else{
							_option += '<option value="'+_id+'">'+_product_use+'</option>';
						}
					});
					$("#device_type_use_id").html(_option);
				}
			},
			complete: function(XMLHttpRequest, textStatus){
				if(XMLHttpRequest.getResponseHeader("sessionstatus")=="timeout"){
					window.top.location.href="${pageContext.servletContext.contextPath}/login";
				}
				if(XMLHttpRequest.getResponseHeader("sessionstatus")=="no_w"){
					alert("您的权限级别无法进行保存或修改数据操作！");
				}
			}
		});
	}

	function hideLoading(){
		$("#loading").fadeOut();
	}

	function saveHandler(image_url,historyimage){
	
		var _id               = "${p.id }";
		
		var _stock         = $("#stock").attr("value");//库存
		if(_stock.length <=0){alert("库存不能为空！");hideLoading();return;}
		if(isNaN(_stock)){alert("库存只能为数字！");hideLoading();return;}
		var _taobao_links  = $("#taobao_links").attr("value");//淘宝链接
		
		var _fitting_name       = $("#fitting_name").attr("value");//配件名称
		if(_fitting_name.length > 50){alert("配件名称字符长度应小于50字符！");hideLoading();return false;}
		if(_fitting_name.length <= 0){alert("配件名称不能为空");hideLoading();return false;}
		
		var _brand = $("#brand").attr("value");
		if(_brand.length > 50){alert("品牌字符长度应小于50字符！");hideLoading();return false;}
		
		var _device_type_use_id      = $("#device_type_use_id").val();//设备用途ID
		if(_device_type_use_id == null || _device_type_use_id == "-1" || _device_type_use_id.length < 0){alert("配件自定义类别不能为空！");hideLoading();return false;}
		var _device_type_sort_id      = $("#device_type_sort_id").val();//专业
		if(_device_type_sort_id == null || _device_type_sort_id == "-1" || _device_type_sort_id.length < 0){alert("配件专业类别不能为空！");hideLoading();return false;}
		
		var _fitting_number = $("#fitting_number").attr("value");
		if(_fitting_number.length > 50){alert("配件编号字符长度应小于50字符！");hideLoading();return false;}
		
		var _specification_desc = $("#specification_desc").attr("value");
		if(_specification_desc.length > 255){alert("规格描述字符长度应小于255字符！");hideLoading();return false;}
			
		var _models = $("#models").attr("value");
		if(_models.length > 255){alert("适用型号字符长度应小于255字符！");hideLoading();return false;}
				
		var _fitting_desc = encodeURIComponent(UE.getEditor('fitting_desc').getContent());
		if(_fitting_desc.length > 65535){alert("配件特性长度应小于65535字符！");hideLoading();return false;}
		
		var _sale_protection = encodeURIComponent(UE.getEditor('sale_protection').getContent());
		if(_sale_protection.length > 65535){alert("售后保障字符长度应小于65535字符！");hideLoading();return false;}
		
		$.ajax({
			type : "post",
			url : "${pageContext.servletContext.contextPath}/fitting/save",
			dataType:"json",
			data:"id="+_id+"&fitting_name="+_fitting_name+"&stock="+_stock+"&taobao_links="+_taobao_links+"&brand="+_brand+"&device_type_use_id="+_device_type_use_id+"&device_type_sort_id="+_device_type_sort_id+"&fitting_number="+_fitting_number+"&specification_desc="+_specification_desc+"&models="+_models+"&fitting_desc="+_fitting_desc+"&sale_protection="+_sale_protection+"&image_url="+image_url+"&historyimage="+historyimage,
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			success : function(msg) {
				if((msg.success+"") == "true"){
					$("#loading").css("display","block").css("background-color","#090").html("保存成功！");
					closeHandler();
					window.parent.loading("${pageContext.servletContext.contextPath}/fitting/fittingJump");
				}else{
					$("#loading").css("display","block").css("background-color","#F30").html(msg.message);
					setTimeout(function(){
						$("#loading").fadeOut();
					},5000)
				}
			},
			complete: function(XMLHttpRequest, textStatus){
				if(XMLHttpRequest.getResponseHeader("sessionstatus")=="timeout"){
					window.top.location.href="${pageContext.servletContext.contextPath}/login";
				}
				if(XMLHttpRequest.getResponseHeader("sessionstatus")=="no_w"){
					alert("您的权限级别无法进行保存或修改数据操作！");
				}
			}
		});
	}
	
	function closeHandler(){
		window.parent.remove("fittingAdd_Edit_JUMP");
	}
</script>
</html>

<script type="text/javascript">

jQuery.extend({

    createUploadIframe: function(id, uri)
	{
			//create frame
            var frameId = 'jUploadFrame' + id;
            var iframeHtml = '<iframe id="' + frameId + '" name="' + frameId + '" style="position:absolute; top:-9999px; left:-9999px"';
			if(window.ActiveXObject)
			{
                if(typeof uri== 'boolean'){
					iframeHtml += ' src="' + 'javascript:false' + '"';
                }
                else if(typeof uri== 'string'){
					iframeHtml += ' src="' + uri + '"';

                }	
			}
			iframeHtml += ' />';
			jQuery(iframeHtml).appendTo(document.body);

            return jQuery('#' + frameId).get(0);			
    },
    createUploadForm: function(id, fileElementId, data)
	{
		//create form	
		var formId = 'jUploadForm' + id;
		var fileId = 'jUploadFile' + id;
		var form = jQuery('<form  action="" method="POST" name="' + formId + '" id="' + formId + '" enctype="multipart/form-data"></form>');	
		if(data)
		{
			for(var i in data)
			{
				jQuery('<input type="hidden" name="' + i + '" value="' + data[i] + '" />').appendTo(form);
			}			
		}		
		var oldElement = jQuery('#' + fileElementId);
		var newElement = jQuery(oldElement).clone();
		jQuery(oldElement).attr('id', fileId);
		jQuery(oldElement).before(newElement);
		jQuery(oldElement).appendTo(form);

		//set attributes
		jQuery(form).css('position', 'absolute');
		jQuery(form).css('top', '-1200px');
		jQuery(form).css('left', '-1200px');
		jQuery(form).appendTo('body');		
		return form;
    },

    ajaxFileUpload: function(s) {
        s = jQuery.extend({}, jQuery.ajaxSettings, s);
        var id = new Date().getTime()        
		var form = jQuery.createUploadForm(id, s.fileElementId, (typeof(s.data)=='undefined'?false:s.data));
		var io = jQuery.createUploadIframe(id, s.secureuri);
		var frameId = 'jUploadFrame' + id;
		var formId = 'jUploadForm' + id;		
        if ( s.global && ! jQuery.active++ )
		{
			jQuery.event.trigger( "ajaxStart" );
		}            
        var requestDone = false;
        var xml = {}   
        if ( s.global )
            jQuery.event.trigger("ajaxSend", [xml, s]);
        var uploadCallback = function(isTimeout)
		{			
			var io = document.getElementById(frameId);
            try 
			{				
				if(io.contentWindow)
				{
					 xml.responseText = io.contentWindow.document.body?io.contentWindow.document.body.innerHTML:null;
                	 xml.responseXML = io.contentWindow.document.XMLDocument?io.contentWindow.document.XMLDocument:io.contentWindow.document;
					 
				}else if(io.contentDocument)
				{
					 xml.responseText = io.contentDocument.document.body?io.contentDocument.document.body.innerHTML:null;
                	xml.responseXML = io.contentDocument.document.XMLDocument?io.contentDocument.document.XMLDocument:io.contentDocument.document;
				}						
            }catch(e)
			{
				jQuery.handleError(s, xml, null, e);
			}
            if ( xml || isTimeout == "timeout") 
			{				
                requestDone = true;
                var status;
                try {
                    status = isTimeout != "timeout" ? "success" : "error";
                    if ( status != "error" )
					{
                        var data = jQuery.uploadHttpData( xml, s.dataType );    
                        if ( s.success )
                            s.success( data, status );
    
                        if( s.global )
                            jQuery.event.trigger( "ajaxSuccess", [xml, s] );
                    } else
                        jQuery.handleError(s, xml, status);
                } catch(e) 
				{
                    status = "error";
                    jQuery.handleError(s, xml, status, e);
                }

                if( s.global )
                    jQuery.event.trigger( "ajaxComplete", [xml, s] );

                if ( s.global && ! --jQuery.active )
                    jQuery.event.trigger( "ajaxStop" );

                if ( s.complete )
                    s.complete(xml, status);

                jQuery(io).unbind()

                setTimeout(function()
					{	try 
						{
							jQuery(io).remove();
							jQuery(form).remove();	
						} catch(e) 
						{
							jQuery.handleError(s, xml, null, e);
						}									

					}, 100)

                xml = null

            }
        }
        // Timeout checker
        if ( s.timeout > 0 ) 
		{
            setTimeout(function(){
                // Check to see if the request is still happening
                if( !requestDone ) uploadCallback( "timeout" );
            }, s.timeout);
        }
        try 
		{

			var form = jQuery('#' + formId);
			jQuery(form).attr('action', s.url);
			jQuery(form).attr('method', 'POST');
			jQuery(form).attr('target', frameId);
            if(form.encoding)
			{
				jQuery(form).attr('encoding', 'multipart/form-data');      			
            }
            else
			{	
				jQuery(form).attr('enctype', 'multipart/form-data');			
            }			
            jQuery(form).submit();

        } catch(e) 
		{			
            jQuery.handleError(s, xml, null, e);
        }
		
		jQuery('#' + frameId).load(uploadCallback	);
        return {abort: function () {}};	

    },

    uploadHttpData: function( r, type ) {
        var data = !type;
        data = type == "xml" || data ? r.responseXML : r.responseText;
        // If the type is "script", eval it in global context
        if ( type == "script" ){jQuery.globalEval( data );}
        // Get the JavaScript object, if JSON is used.
        if ( type == "json" )
            //eval( "data = " + data );
			eval("data = '"+data+"' ");
        // evaluate scripts within html
        if ( type == "html" )
            jQuery("<div>").html(data).evalScripts();

		//最后改为 eval("data = \" "+data+" \" ");
        return data;
    },
	
	handleError: function( s, xhr, status, e ) {
		if ( s.error ) {
			s.error.call( s.context || s, xhr, status, e );
		}
		if ( s.global ) {
			(s.context ? jQuery(s.context) : jQuery.event).trigger( "ajaxError", [xhr, s, e] );
		}
	}
})
</script>