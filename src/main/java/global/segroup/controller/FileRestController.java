/**
 * 
 */
package global.segroup.controller;

import java.util.HashMap;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import global.segroup.util.FileService;
import global.segroup.util.PathConstants;

/**
 * @Author : 이종호
 * @Date : 2017. 7. 27.
 * @Class 설명 : Soft Engineer Group의 File 관련 Rest Controller
 * 
 */
@RestController
public class FileRestController implements PathConstants {
	
	@Value("#{props['temporarilyPath']}")
	private String temporarilyPath;
	
	@ResponseBody
	@RequestMapping(value=PathConstants.TEMPORARILY_UPLOAD, method = RequestMethod.POST)
	public HashMap<String, String> temporarilyUpload(MultipartHttpServletRequest request, HttpServletResponse response) {
		HashMap<String, String> result = FileService.temporarilySave(request,temporarilyPath);
		return result;
	}
	
}
