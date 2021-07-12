/**
 * 
 */
package global.segroup.controller;

import java.util.HashMap;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import global.segroup.util.FileService;
import global.segroup.util.PathConstants;

/**
 * @Author : 이종호
 * @Date : 2017. 7. 27.
 * @Class 설명 : Soft Engineer Group의 File 관련 View Controller 
 * 
 */
@Controller
public class FIleViewController implements PathConstants {
	
	@Value("#{props['temporarilyPath']}")
	private String temporarilyPath;
	
	@Value("#{props['edu.apply.ckeditor']}")
	private String eduApplyCkeditor;

	@RequestMapping(value = PathConstants.TEMPORARILY_DOWNLOAD, method = RequestMethod.GET)
	public void temporarilyDownload(HttpServletResponse response, String origin , String saved){
		FileService.fileDownload(response, origin, saved,temporarilyPath);
		FileService.deleteFile(saved,temporarilyPath);
	}
	
	@RequestMapping(value = PathConstants.FILE_DOWNLOAD, method = RequestMethod.GET)
	public void fileDownload(HttpServletResponse response, String origin , String saved, String path){
		FileService.fileDownload(response, origin, saved, path);
	}
	
	@RequestMapping(value = "/board/imageUpload", method = RequestMethod.POST)
    public String communityImageUpload(MultipartHttpServletRequest request, Model model,String CKEditorFuncNum) {
 
		HashMap<String, String> result = FileService.temporarilySave(request,eduApplyCkeditor);
		
		model.addAttribute("file_path", eduApplyCkeditor+"/"+result.get("savedfile"));
		model.addAttribute("CKEditorFuncNum", CKEditorFuncNum);

        return "segroup/society/edu/admin/board_ckeditor";
    }
}
