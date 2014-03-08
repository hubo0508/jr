package com.jr.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.zip.ZipEntry;
import java.util.zip.ZipException;
import java.util.zip.ZipFile;
import java.util.zip.ZipInputStream;
import java.util.zip.ZipOutputStream;
import org.apache.log4j.Logger;

/**
 * 类名:FileCompressUtils.java<br/>
 * 所属类别:读写压缩、解压工具类 <br/>
 * 用途: 通过此工具类减少读写压缩、解压相关代码量提高提高代码重用<br/>
 * author:<a href="mailto:llnyxxzj@163.com">lilong</a> <br/>
 * Date:2013-12-9 下午3:06:31<br/>
 * version:1.0 <br/>
 *<br>压缩暂不支持中文,'中文会出现乱码,此BUG为JDK自带BUG'<br>
 */
public class FileCompressUtils {
	private static Logger logger = Logger.getLogger(FileCompressUtils.class);

	public static void main(String[] args) {
		//		unZip("C:\\Users\\Administrator\\Desktop\\11.zip","C:\\Users\\Administrator\\Desktop\\LOG\\");
		try {
			zip("G:\\20131207.zip", "G:\\JAVA常见问题");
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/**
	 * <p>解压文件</P>
	 * Author lilong<br/>
	 * Date 2013-12-9 下午3:51:47
	 * @param zipFilePath
	 *            压缩文件路径,<b>暂仅支持zip格式</b>
	 * @param directoryPath
	 *            解压文件路径
	 */
	public static void unZip(String zipFilePath, String directoryPath) {
		try {
			if (!zipFilePath.endsWith(".zip")) {
				throw new IOException("文件解压仅支持zip格式:" + zipFilePath);
			}
			File directory = new File(directoryPath);
			if (!directory.isDirectory()) {
				throw new IOException("解压文件路径应为文件夹路径:" + directoryPath);
			}
			// 压缩文件
			File file = new File(zipFilePath);
			ZipFile zipFile = new ZipFile(file);
			// 实例化ZipFile，每一个zip压缩文件都可以表示为一个ZipFile
			// 实例化一个Zip压缩文件的ZipInputStream对象，可以利用该类的getNextEntry()方法依次拿到每一个ZipEntry对象
			ZipInputStream zipInputStream = new ZipInputStream(new FileInputStream(file));
			ZipEntry zipEntry = null;
			while ((zipEntry = zipInputStream.getNextEntry()) != null) {
				String fileName = zipEntry.getName();
				File temp = new File(directoryPath+"\\"+ fileName);
				if (!temp.getParentFile().exists()) {
					temp.getParentFile().mkdirs();
				}
				if (temp.getAbsolutePath().indexOf(".") < 0) {
					temp.mkdirs();
					continue;
				}
				temp.createNewFile();
				OutputStream os = new FileOutputStream(temp);
				// 通过ZipFile的getInputStream方法拿到具体的ZipEntry的输入流
				InputStream is = zipFile.getInputStream(zipEntry);
				int len = 0;
				while ((len = is.read()) != -1) {
					os.write(len);
				}
				os.close();
				is.close();
			}
			zipInputStream.close();
		} catch (ZipException e) {
			logger.error("解压文件出错:", e);
		} catch (IOException e) {
			logger.error("解压文件出错:", e);
		}
	}
	/**
	 *<p>压缩文件</P>
	 *Author lilong<br/>
	 * Date	2013-12-9 下午5:42:43
	 * @param zipFileName zip文件
	 * @param filePath 需要压缩的文件或文件夹
	 * @throws FileNotFoundException
	 * @throws IOException
	 */
	public static void zip(String zipFileName, String filePath) throws FileNotFoundException, IOException {
		if (!zipFileName.trim().endsWith(".zip")) {
			throw new IOException("文件压缩支持zip格式:" + zipFileName);
		}
		ZipOutputStream outputStream = new ZipOutputStream(new FileOutputStream(zipFileName));
		zip(outputStream,  filePath);
		if (null != outputStream) {
			outputStream.close();
		}
	}

	/**
	 * 压缩
	 * @param zos
	 *            压缩输出流
	 * @param relativePath
	 *            相对路径
	 * @param absolutPath
	 *            文件或文件夹绝对路径
	 * @throws IOException
	 * @author yayagepei
	 * @date 2008-8-26
	 */
	private static void zip(ZipOutputStream zos,String filePath) throws IOException {
		File file = new File(filePath);
		if (file.isDirectory()) {
			File[] files = file.listFiles();
			for (int i = 0; i < files.length; i++) {
				File tempFile = files[i];
				if (tempFile.isDirectory()) {
					String newRelativePath = filePath + tempFile.getName()+ File.separator;
					createZipNode(zos, newRelativePath);
					zip(zos, tempFile.getPath());
				} else {
					zipFile(zos, tempFile,filePath);
				}
			}
			return;
		} 
		zipFile(zos, file,filePath);
	}
	/**
	 * 压缩文件
	 * @param zos
	 *            压缩输出流
	 * @param file
	 *            文件对象
	 * @param relativePath
	 *            相对路径
	 * @throws IOException
	 * @author yayagepei
	 * @date 2008-8-26
	 */
	private static void zipFile(ZipOutputStream zos, File file,String filePath) throws IOException {
		ZipEntry entry = new ZipEntry(file.getAbsolutePath().replace(filePath, ""));
		zos.putNextEntry(entry);
		InputStream stream = new FileInputStream(file);
		int BUFFERSIZE = 2 << 10;
		int length = 0;
		byte[] buffer = new byte[BUFFERSIZE];
		while ((length = stream.read(buffer, 0, BUFFERSIZE)) >= 0) {
			zos.write(buffer, 0, length);
		}
		zos.flush();
		zos.closeEntry();
		if (null != stream) {
			stream.close();
		}
	}

	/**
	 * 创建目录
	 * 
	 * @param zos
	 *            zip输出流
	 * @param relativePath
	 *            相对路径
	 * @throws IOException
	 * @author yayagepei
	 * @date 2008-8-26
	 */
	private static void createZipNode(ZipOutputStream zos, String relativePath)
			throws IOException {
		ZipEntry zipEntry = new ZipEntry(relativePath);
		zos.putNextEntry(zipEntry);
		zos.closeEntry();
	}
}
