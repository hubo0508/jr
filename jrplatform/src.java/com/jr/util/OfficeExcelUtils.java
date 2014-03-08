package com.jr.util;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFDateUtil;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;


/**
 * 所属类别:读写Excel工具类<br/>
 * 用途: 通过此工具类减少获取Excel文档内容相关代码量提高提高代码重用<br/>
 * Author:<a href="mailto:llnyxxzj@163.com">lilong</a> <br/>
 * Date:2012-11-12<br/>
 * Time:上午10:37:24 <br/>
 * Version:1.0 <br/>
 * 此工具类依赖以下包:<br>
 * <li style='margin-left:20px;'>1、dom4j-1.6.1.jar</li>
 * <li style='margin-left:20px;'>2、poi-3.8-20120326.jar</li>
 * <li style='margin-left:20px;'>3、poi-ooxml-3.8-20120326.jar</li>
 * <li style='margin-left:20px;'>4、poi-ooxml-schemas-3.8-20120326.jar</li>
 * <li style='margin-left:20px;'>5、xmlbeans-2.3.0.jar</li><br>
 * 如报‘java.lang.ClassNotFoundException: org/apache/xerces/parsers/SAXParser’ 请加入‘xercesImpl.jar’
 */
public class OfficeExcelUtils {
	public static void main(String[] args) throws IOException {
		//		String filePath = "F:\\项目资料\\金嵘厨房\\产品模板.xlsx";
		String filePath = "F:\\项目资料\\金嵘厨房\\配件模板.xlsx";
		List<List<Object>> list =readExcel(filePath,true);
		for (int j = 0; j < list.size(); j++) {
			//			if (j == 0) {
			//				continue;
			//			}
			for (int i = 0; i < list.get(j).size(); i++) {
				System.out.println(list.get(j).size()+"==="+ i + "---"+ list.get(j).get(i));
			}
		}
	}

	/** yyyy-MM-dd */
	public static String pattern = "yyyy-MM-dd";
	/** yyyy-MM-dd HH:mm:ss */
	public static String patterns = "yyyy-MM-dd HH:mm:ss";


	/**
	 * <p>
	 * 读取EXCEL文件内容,仅限于文字内容
	 * </P>
	 * Author lilong
	 * Date 2013-7-14 上午10:07:39
	 * @param filePath
	 *            文件路径
	 * @return 结果集为行集合
	 * @throws IOException
	 */
	public static List<List<Object>> readExcel(String filePath)
			throws IOException {
		return	readExcel(filePath, false);
	}
	/**
	 * <p>
	 * 读取EXCEL文件内容,仅限于文字内容
	 * </P>
	 * Author lilong
	 * Date 2013-7-14 上午10:07:39
	 * @param filePath
	 *            文件路径
	 * @param isEmpty
	 *            是否去掉单元格为空的数据
	 * @return 结果集为行集合
	 * @throws IOException
	 */
	public static List<List<Object>> readExcel(String filePath, boolean isEmpty)
			throws IOException {
		List<List<Object>> list = null;
		if (filePath.endsWith("xls")) {
			list = readXlsByRowNum(filePath, isEmpty);
		}
		if (filePath.endsWith("xlsx")) {
			list = readXlsx(filePath);
		}
		return list;
	}

	private static List<List<Object>> readXlsx(String filePath) throws IOException {

		InputStream inputStream = new FileInputStream(filePath);
		XSSFWorkbook xssfWorkbook = new XSSFWorkbook(inputStream);
		List<List<Object>> list = new ArrayList<List<Object>>();
		// 循环工作表Sheet
		for (int numSheet = 0; numSheet < xssfWorkbook.getNumberOfSheets(); numSheet++) {
			XSSFSheet xssfSheet = xssfWorkbook.getSheetAt(numSheet);
			if (xssfSheet == null) {
				continue;
			}
		
			// 循环行Row
			for (int rowNum = 0; rowNum <= xssfSheet.getLastRowNum(); rowNum++) {
				XSSFRow xssfRow = xssfSheet.getRow(rowNum);
				if (xssfRow == null) {
					continue;
				}
				List<Object> listValue = new ArrayList<Object>();
				// 循环列Cell
				for (int cellNum = 0; cellNum <= xssfRow.getLastCellNum(); cellNum++) {
					XSSFCell xssfCell = xssfRow.getCell(cellNum);
					if (xssfCell == null) {
						listValue.add("");
					}else{
					listValue.add(getValue(xssfCell));}
				}
				list.add(listValue);
			}
		}
		return list;
	}

	/**
	 * <p>
	 * 循环行Row,结果集为行集合
	 * </P>
	 * Author lilong
	 * Date 2013-7-13 下午11:42:20
	 * @param filePath
	 * @return
	 * @throws IOException
	 */
	private static	List<List<Object>> readXlsByRowNum(String filePath, boolean isEmpty)
			throws IOException {
		InputStream inputStream = new FileInputStream(filePath);
		HSSFWorkbook hssfWorkbook = new HSSFWorkbook(inputStream);
		List<List<Object>> list = new ArrayList<List<Object>>();
		// 循环工作表Sheet
		for (int numSheet = 0; numSheet < hssfWorkbook.getNumberOfSheets(); numSheet++) {
			HSSFSheet hssfSheet = hssfWorkbook.getSheetAt(numSheet);
			if (hssfSheet == null) {
				continue;
			}
			// 循环行Row
			for (int rowNum = 0; rowNum <= hssfSheet.getLastRowNum(); rowNum++) {
				HSSFRow hssfRow = hssfSheet.getRow(rowNum);
				if (hssfRow == null) {
					continue;
				}
				List<Object> listValue = new ArrayList<Object>();
				// 循环列Cell
				for (int cellNum = 0; cellNum <= hssfRow.getLastCellNum(); cellNum++) {
					HSSFCell hssfCell = hssfRow.getCell(cellNum);
					if (hssfCell == null) {
						continue;
					}else{
					String value = getValue(hssfCell);
					listValue.add(value);
					}//					if (isEmpty) {
					//						if (value != null && !value.equals("")) {
					//							listValue.add(getValue(hssfCell));
					//						}
					//					} else {
					//						listValue.add(getValue(hssfCell));
					//					}
				}
				list.add(listValue);
			}
		}
		inputStream.close();
		return list;
	}

	private static String getValue(HSSFCell hssfCell) {
		String value = "";
		switch (hssfCell.getCellType()) {
		case Cell.CELL_TYPE_BOOLEAN:
			value = String.valueOf(hssfCell.getBooleanCellValue());
			break;
		case Cell.CELL_TYPE_NUMERIC:
			if (HSSFDateUtil.isCellDateFormatted(hssfCell)) { // 读取日期
				Date date = HSSFDateUtil.getJavaDate(hssfCell.getNumericCellValue());
				SimpleDateFormat format = new SimpleDateFormat(patterns);
				value=format.format(date);
			} else {
				value = String.valueOf(hssfCell.getNumericCellValue());
			}
			break;
		default:
			value = String.valueOf(hssfCell.getStringCellValue());
			break;
		}
		return value;
	}

	private static String getValue(XSSFCell xssfCell) {
		String value = "";
		switch (xssfCell.getCellType()) {
		case Cell.CELL_TYPE_BOOLEAN:
			value = String.valueOf(xssfCell.getBooleanCellValue());
			break;
		case Cell.CELL_TYPE_NUMERIC:
			if (HSSFDateUtil.isCellDateFormatted(xssfCell)) { // 读取日期
				double d = xssfCell.getNumericCellValue();
				Date date = HSSFDateUtil.getJavaDate(d);
				SimpleDateFormat format = new SimpleDateFormat(patterns);
				value=format.format(date);
			} else {
				value = String.valueOf(xssfCell.getNumericCellValue());
			}
			break;
		default:
			xssfCell.setCellType(HSSFCell.CELL_TYPE_STRING);//这样得到的内容是显示的手机号
			value = String.valueOf(xssfCell.getStringCellValue());
			break;
		}
		return value;
	}
}
