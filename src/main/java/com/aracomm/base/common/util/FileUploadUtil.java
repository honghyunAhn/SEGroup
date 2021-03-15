package com.aracomm.base.common.util;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import com.aracomm.base.common.AraCommConst;
import com.aracomm.base.common.vo.FileVo;
import com.aracomm.base.exceptions.UserFileUploadException;

@Component
public class FileUploadUtil {
	private static final Logger logger = LoggerFactory.getLogger(FileUploadUtil.class);

	private static final String sep = "/";

	@Value("#{config['upload.rootpath']}")
	String upload_root_path;

	@Value("#{config['upload.rooturl']}")
	String upload_root_url;

	public List<FileVo> fileUpload(List<MultipartFile> files, String subdir) throws UserFileUploadException {
		return fileUpload(null, files, subdir, true);
	}
	public List<FileVo> fileUpload(String fileId, List<MultipartFile> files, String subdir, boolean alwaysNewFileId) throws UserFileUploadException {
		List<FileVo> fileList = new ArrayList<FileVo>();

		String savePath = upload_root_path;

		try {

			File d = new File(savePath);
			if(!d.exists() || d.isFile()) {
				d.mkdirs();
			}

			if (StringUtils.isBlank(fileId)) {
				fileId = newFileId();
			}

			MultipartFile file;
			for(int i=0; i<files.size(); i++) {
				file = files.get(i);
				String orginFileName = file.getOriginalFilename();

				if (StringUtils.isBlank(orginFileName)) continue;

				String fileExt = orginFileName.substring(orginFileName.lastIndexOf(".") + 1);

				String newName = newFileName(fileExt);
				String newFileFullPath = savePath + File.separator + subdir + File.separator + newName;

				d = new File(newFileFullPath);
				if(!d.exists() || d.isFile()) {
					d.mkdirs();
				}
				file.transferTo(new File(newFileFullPath));

				FileVo fileVo = new FileVo();
				fileVo.setFile_id(alwaysNewFileId?newFileId():fileId);
				fileVo.setFile_name(newName);
				fileVo.setFile_ext(fileExt);
				fileVo.setFile_path(newFileFullPath);
				fileVo.setUrl_path(upload_root_url + sep + replaceUrlPathSepa(subdir) + sep + newName);
				fileVo.setOrigin_file_name(orginFileName);
				fileVo.setFile_size(String.valueOf(file.getSize()));

				fileList.add(fileVo);
			}
		} catch (Exception ex) {
			logger.error("fileUpload", ex);
			throw new UserFileUploadException(ex.getMessage());
		}

        return fileList;
	}

	/**
	 * 관리자단의 생성 규칙 적용
	 * @param prefix
	 * @return
	 */
	public static String newFileId() {
        int randomNumber = 1000000;

        // 한글 파일 처리를 위해 파일 명을 랜덤함수를 이용해서 저장하고 original 이름을 따로 저장시킨다.
        // FILE_현재 날짜_랜덤 8자리 수 형태의 파일로 생성함.
        Random random = new Random();

        // 현재 시간 저장(같은 이름 중복인 경우 기존 파일에 날짜를 붙여서 저장시킴)
        String currDate = new SimpleDateFormat("yyyyMMdd").format(new java.util.Date());

        // 랜덤 숫자 발생 기본은 1000000에서 9999999사이
        randomNumber = random.nextInt(9000000)+randomNumber;

        //20자리 FILE_오늘날짜+랜덤숫자(7) 로 이루어진 파일명 생성
        return AraCommConst.FILE_UPLOAD_PREFIX + currDate + randomNumber;
	}

	/**
	 * 관리자단 생성 규칙 적용
	 * @param fileExt
	 * @return
	 */
	private String newFileName(String fileExt) {
		int randomNumber = 10000000;

        Random random = new Random();

        // 현재 시간 저장(같은 이름 중복인 경우 기존 파일에 날짜를 붙여서 저장시킴)
        String currDate = new SimpleDateFormat("yyyyMMdd").format(new java.util.Date());

        // 랜덤 숫자 발생 기본은 10000000에서 99999999사이
        randomNumber = random.nextInt(90000000)+randomNumber;

        return currDate+randomNumber+(StringUtils.isEmpty(fileExt)?"":("."+fileExt));
	}

	/**
	 * 윈도우(\)저장경로 구분자를 url 경로 구분자로 변경
	 * @param path
	 * @return
	 */
	private String replaceUrlPathSepa(String path) {
		if (StringUtils.isBlank(path)) return path;
		return path.replaceAll("\\\\", "/");
	}
}
