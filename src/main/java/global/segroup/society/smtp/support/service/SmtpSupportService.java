package global.segroup.society.smtp.support.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aracomm.changbi.support.dao.SupportDao;

import global.segroup.society.smtp.apply.domain.InfoAttendance;

@Service
public class SmtpSupportService {
	
	@Autowired
	SupportDao dao;
	
	public List<HashMap<String, Object>> selectFaqList(HashMap<String, Object> param) {
		return dao.selectFaqList(param);
	}
}
