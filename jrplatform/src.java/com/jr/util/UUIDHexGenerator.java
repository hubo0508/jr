package com.jr.util;

import java.io.IOException;
import java.util.UUID;

/**
 * 生成唯一主键
 * @author ly
 *
 */
public class UUIDHexGenerator {
       public synchronized static long getUUID(){
    	   return UUID.randomUUID().getMostSignificantBits();
       }
       public synchronized static String getUUIDString(){  	   
    	   return UUID.randomUUID().toString();
       }
       public static void main(String[] args) throws IOException {
//    	   for (int i = 0; i < 10; i++) {
//    		   System.out.println("-------------:"+getUUIDString());
//    	   }
    	   
    	   //获取文件所在目录  
    	   //String path=request.getRealPath("/");  
    	  //使用pdf2swf转换命令  
    	   String command= "E:/WorkCoding/javawork/jrplatform1158/src.swf/pdf2swf.exe  -t \"D:/jr/x.pdf\" -o  \"D:/jr/x.swf\" -s flashversion=9 ";  
    	  //执行cmd命令  
    	  Runtime.getRuntime().exec("cmd /c "+command);  
    	   
       }
}
