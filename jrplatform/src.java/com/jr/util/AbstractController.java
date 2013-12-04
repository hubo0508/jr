package com.jr.util;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 * <p>
 * 设置常用数据属性
 * </p>
 * 
 * @User: HUBO
 * @Date Oct 16, 2011
 * @Time 9:45:47 PM
 * 
 * <p>
 * Write a detailed description
 * </p>
 */
public class AbstractController {

	protected static Log log = LogFactory.getLog(AbstractController.class);

	protected static String PAGE_START = "start";

	protected static String PAGE_LIMIT = "limit";

	protected static int PAGE_SIZE = 10;

}
