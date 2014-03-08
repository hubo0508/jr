package com.jr.util;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.Properties;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;

/* 
 * 从路径中的属性文件中读取单个属性或全部属性及设置属性 
 */
public class PropertiesUtil {

	protected static Log logger = LogFactory.getLog(PropertiesUtil.class);
	
	@Autowired
	private String applicationPath;

	private static Object initLock = new Object();

	private static PropertiesUtil config = null;

	private Properties props = null;

	public static PropertiesUtil getInstance() {
		if (config == null) {
			synchronized (initLock) {
				if (config == null) {
					config = new PropertiesUtil();
				}
			}
		}
		return config;
	}

	private synchronized void loadProperties(String path) throws IOException {
		logger.debug("Load pro file：" + path);
		props = new Properties();
		props.load(new FileInputStream(path));
	}

	public String getProperty(String path, String key) throws IOException {
		try {
			if (props == null) {
				loadProperties(path + applicationPath);
			}
			return props.getProperty(key);
		} catch (IOException e) {
			logger.info(e.getMessage(), e);
			throw new IOException(e.getMessage());
		}
	}

	public void setProperty(String path, String key, String value)
			throws IOException {
		try {
			if (props == null) {
				loadProperties(path + applicationPath);
			}
			props.setProperty(key, value);

			saveConfig(path + applicationPath);
		} catch (Exception e) {
			logger.info(e.getMessage(), e);
			throw new IOException(e.getMessage());
		}
	}

	public void saveConfig(String filePath) throws IOException {
		OutputStream outputStream = new FileOutputStream(filePath);
		props.store(outputStream, "set");
		outputStream.close();

	}

	public static void main(String[] args) throws IOException {
		String path = "D:\\temp\\UUID.properties";
		
		PropertiesUtil.getInstance().setProperty(path, "age", "asdfasdfasdf");

		System.out.println(PropertiesUtil.getInstance()
				.getProperty(path, "age"));

	}

}
