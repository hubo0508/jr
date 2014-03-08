package com.ms.simple.core;

import org.apache.log4j.Logger;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

/**
 * 测试用例基类
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "classpath*:applicationContext.xml" })
public class BaseJunit {
	
	protected Logger logger = Logger.getLogger(BaseJunit.class);
	
//	@Autowired
//	private UserService userService;
	
	@Test
	public void test(){
		//userService.println();
	}
}
