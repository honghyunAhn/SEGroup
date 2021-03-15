package com.aracomm.base.common;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Component;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.servlet.view.AbstractView;

import com.aracomm.base.common.vo.FileVo;

@Component
public class FileDownloadView extends AbstractView{
	 public FileDownloadView() {
		 setContentType("application/download; charset=utf-8");
	 }

	@Override
	protected void renderMergedOutputModel(Map<String, Object> model, HttpServletRequest request, HttpServletResponse response)	throws Exception {
		
		FileVo fv = (FileVo) model.get("fv");
		File file = new File(fv.getFile_path());
		
		response.setContentType(getContentType());
		response.setContentLength((int)file.length());
		
//		String fileName = java.net.URLEncoder.encode(file.getName(), "UTF-8");
		// 익스플로러 인지 확인
        String userAgent = request.getHeader("User-Agent");
        boolean ie = userAgent.indexOf ("MSIE") != -1 || userAgent.indexOf("Trident") != - 1;
        String fileName = null;
        if (ie) {
        	fileName = URLEncoder.encode(fv.getOrigin_file_name(), "utf-8").replace("+",  "%20");
        } else {
            if(fv.getFile_id().equals("00000") || fv.getFile_id().equals("00000FAQ")){
            	fileName = fv.getOrigin_file_name();
            }else{
            	fileName = new String(fv.getOrigin_file_name().getBytes("utf-8"), "iso-8859-1").replace("+", "%20");
            }

        }
		
		response.setHeader("Content-Disposition", "attachment;filename=\""+fileName+"\";");
        response.setHeader("Content-Transfer-Encoding", "binary;");
		
		OutputStream out = response.getOutputStream();
		FileInputStream fis = null;
		
		try {
			fis = new FileInputStream(file);
			FileCopyUtils.copy(fis, out);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (fis != null) { try { fis.close(); } catch (Exception e2) {}}
		}
		out.flush();
		
	}
}
