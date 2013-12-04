package com.jr.util;

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
       public static void main(String[] args) {
    	   for (int i = 0; i < 10; i++) {
    		   System.out.println("-------------:"+getUUIDString());
    	   }
       }
}
