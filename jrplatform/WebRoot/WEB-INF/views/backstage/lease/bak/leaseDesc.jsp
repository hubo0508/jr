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
    <!-- <script src="<%=request.getContextPath()%>/resources/backstage/ckeditor.js" type="text/javascript"></script> -->
    <link href="<%=request.getContextPath()%>/resources/backstage/css/shared.css" rel="stylesheet" type="text/css" />
    <script src="<%=request.getContextPath()%>/resources/backstage/js/navigation.button.js" type="text/javascript"></script>
    <link href="<%=request.getContextPath()%>/resources/backstage/css/linksButton.css" rel="stylesheet" type="text/css" />
	
	<script type="text/javascript" charset="utf-8" src="<%=request.getContextPath()%>/resources/ueditor1_3_5/ueditor.config.js"></script>
    <script type="text/javascript" charset="utf-8" src="<%=request.getContextPath()%>/resources/ueditor1_3_5/ueditor.all.min.js"></script>
    <script type="text/javascript" charset="utf-8" src="<%=request.getContextPath()%>/resources/ueditor1_3_5/lang/zh-cn/zh-cn.js"></script>
    
</head>

<style>
	body{height:100%}
	.zp{ text-decoration:none; color:#09F}
	.zp:hover{ color:#FF4400}
</style>

<body sroll="no">

    <table cellpadding="0" cellspacing="0" border="0" width="100%" class="title_t" height="100%"  >
    	<tr>
        	<td colspan="5">
            	<div class="labelDiv">    	
                    <div class="labelTitle">租赁服务简介</div>
                    <div class="g_gray_line workTitleLine"></div>
                    
                    <div class="linksButton">
                       <div class="btn"><span class="hline"></span><div class="c">
                       		<span class="icon check">&nbsp;</span><span class="text">保存</span>
                       </div></div> 
                       <div class="btn"><span class="hline"></span><div class="c">
                       	<span class="icon refresh">&nbsp;</span><span class="text">刷新/查询</span>
                    	</div></div> 
                    </div> 
                </div>
            </td>
        </tr>
        <tr style="font-size:12px">
        	<td align="right" width="150">租赁合同</td>
            <td width="20"></td>
        	<td width="250" align="left">
            	<input type="file" name="doc" id="doc"/>
            </td>
            <td width="24">&nbsp;</td>
            <td align="left" id="doc_td"></td>
        </tr>
         <tr height="20"><td colspan="5">&nbsp;</td></tr>
         <tr style="font-size:12px">
        	<td align="right"  valign="top">租凭简介</td>
            <td></td>
        	<td align="left" valign="top" colspan="3"><!-- <textarea class="ckeditor" name="description">${p.description }</textarea> -->
            	<script id="editor" type="text/plain" style="width:100%;height:100%;">${p.description }</script>
            </td>
        </tr>
    </table>
    
      <div id="loading" style="padding:5px; color:#FFF; position:fixed; top:10px; left:285px; display:none; font-size:14px"></div>
   
</body>
<script type="text/javascript">
	
	var ue = UE.getEditor('editor');
	
	$(function(){				   
		$(".linksButton").navigationbutton("#FF002B", "#339E35",{callback: clickButtonCallback});
		
		if("${p.contract_url }".length > 0){
			$("#doc_td").html('已上传：<a class="zp" href="${p.contract_url }">${p.contract_name }</a>');
		}
		
		$("#editor").css("height",$(window).height()-250);
		$("#editor").css("width",$(window).width()-100);
	});
	
	
	function clickButtonCallback(text){
		if(text == "刷新/查询")
		{
			window.parent.loading("${pageContext.servletContext.contextPath}/lease/leaseDescJump");
			return;
		}
		
		if((text+"") == "保存")
		{
			saveAllHandler();
			return;
		}
	}
	
	function saveAllHandler(){
	
		$("#loading").css("display","block").css("background-color","#090").html("正在保存，请稍后！");
		
		var _img_ = $("#doc").attr("value");
		if(_img_ == ""){
			saveHandler("${p.contract_url }","","${p.contract_name }");
			return;
		}
		
		$.ajaxFileUpload({ 
		    url:"${pageContext.servletContext.contextPath}/file/uploadFile?file=doc",  
		    secureuri:false,  
		    fileElementId:'doc',  
		    dataType: 'json', 
		    success: function (data, status)
		    {
		    	var j = eval('(' + data.replace(/<[^>]+>/g,"")+ ')');
             	if((j.success+"") == "true"){
             		saveHandler(j.message,"${p.contract_url}",$("#doc").attr("value"));
             	}else{
             		$("#loading").fadeOut();
             		window.parent.alert(j.message);
             	}
		    },
		    error: function (data, status, e)
            {
            	window.parent.alert(eval('(' + data.replace(/<[^>]+>/g,"")+ ')').message);
            }
		});  
	}

	function saveHandler(contract_url,historyurl,contract_name){
		//encodeURIComponent(CKEDITOR.instances.description.getData());
		var _description = encodeURIComponent(UE.getEditor('editor').getContent());
		if(_description.length > 65535){alert("描述长度应小于65535字符！");return false;}
		
		$.ajax({
			type : "post",
			url : "${pageContext.servletContext.contextPath}/lease/descSave",
			dataType:"json",
			data:"id=${p.id}&contract_name="+contract_name+"&description="+_description+"&contract_url="+contract_url+"&historydoc="+historyurl,
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			success : function(msg) {
				
				if(msg == null){$("#loading").fadeOut();return;}
			
				if((msg.success+"") == "true"){
					$("#loading").css("display","block").css("background-color","#090").html("保存成功！");
					window.parent.loading("${pageContext.servletContext.contextPath}/lease/leaseDescJump");
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
			}
		});
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
