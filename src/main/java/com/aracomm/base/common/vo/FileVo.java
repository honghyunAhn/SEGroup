package com.aracomm.base.common.vo;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class FileVo {

	private String file_id;
	private String file_name;
	private String origin_file_name;
	private String file_path;
	private String file_size;
	private String file_ext;
	private String url_path;
	private String user;
	private String date;
    private MultipartFile filedata; //form태그내에 존재하는 file 태그의 name명과 일치시켜줌
    private List<MultipartFile> filedatas; //form태그내에 존재하는 file 태그의 name명과 일치시켜줌(파일 여러개)
    private String callback; //callback URL
    private String callback_func;

    public String getFile_id() {
		return file_id;
	}
	public void setFile_id(String file_id) {
		this.file_id = file_id;
	}
	public String getFile_name() {
		return file_name;
	}
	public void setFile_name(String file_name) {
		this.file_name = file_name;
	}
	public String getOrigin_file_name() {
		return origin_file_name;
	}
	public void setOrigin_file_name(String origin_file_name) {
		this.origin_file_name = origin_file_name;
	}
	public String getFile_path() {
		return file_path;
	}
	public void setFile_path(String file_path) {
		this.file_path = file_path;
	}
	public String getFile_size() {
		return file_size;
	}
	public void setFile_size(String file_size) {
		this.file_size = file_size;
	}
	public String getUrl_path() {
		return url_path;
	}
	public void setUrl_path(String url_path) {
		this.url_path = url_path;
	}
	public MultipartFile getFiledata() {
		return filedata;
	}
	public void setFiledata(MultipartFile filedata) {
		this.filedata = filedata;
	}
	public String getCallback() {
		return callback;
	}
	public void setCallback(String callback) {
		this.callback = callback;
	}
	public String getCallback_func() {
		return callback_func;
	}
	public void setCallback_func(String callback_func) {
		this.callback_func = callback_func;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getUser() {
		return user;
	}
	public void setUser(String user) {
		this.user = user;
	}
	public String getFile_ext() {
		return file_ext;
	}
	public void setFile_ext(String file_ext) {
		this.file_ext = file_ext;
	}

	public List<MultipartFile> getFiledatas() {
		return filedatas;
	}
	public void setFiledatas(List<MultipartFile> filedatas) {
		this.filedatas = filedatas;
	}
	@Override
	public String toString() {
		return "FileVo [file_id=" + file_id + ", file_name=" + file_name
				+ ", origin_file_name=" + origin_file_name + ", file_path="
				+ file_path + ", file_size=" + file_size + ", url_path="
				+ url_path + ", user=" + user + ", date=" + date
				+ ", filedata=" + filedata + ", callback=" + callback
				+ ", callback_func=" + callback_func + "]";
	}




}
