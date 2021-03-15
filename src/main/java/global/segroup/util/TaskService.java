/**
 * 
 */
package global.segroup.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.mail.MessagingException;

import org.apache.commons.io.IOUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aracomm.changbi.user.service.UserService;
import com.aracomm.changbi.user.web.UserController;

import global.segroup.domain.User;

/**
 * @Author : 김지훈
 * @Date : 2018. 8. 29.
 * @Class 설명 : Spring 3.1 버전 부터는 Quartz Scheduler를 사용하지 않고도 Scheduler를 통한 Job을 실행할 수 있게 되었다
 * 
 */
@Service
public class TaskService {
	
	private static final Logger logger = LoggerFactory.getLogger(UserController.class);
	/**
	 * 메일을 보내는 서비스
	 */
	@Autowired
	private MailService mail;
	
	@Autowired
	private UserService userService;
	
	// 시작직후 10초 단위로 스케줄링
//	@Scheduled(cron="*/10 * * * * *")c
	// 현재시각 5분 단위로 스케줄링
//	@Scheduled(cron="0 0/5 * * * *")
    
    /**
	 * @Method Name : checkRestUser
	 * @Date : 2020.10.22
	 * @User : 김나영
	 * @Method 설명 : 휴면계정 체크 스케줄러
	 */
//    매일 00:00 에 실행함
//    @Scheduled(cron="0 0 0 * * *")
    public void checkRestUser() {
    	logger.info("휴면계정 처리 시작");
    	
    	//전체 회원 목록
    	List<User> userList= new ArrayList<>();
    	userList = userService.selectUserListAll();
    	
    	List<User> result = new ArrayList<>();
    	
    	for(User user : userList) {
    		User restUser = userService.selectRestUser(user.getUser_id());
    		if(restUser != null) {
    			result.add(restUser);
    		}
    	}
    	
    	String content="";
    	
    	// 본문으로 사용할 html 파일의 경로(위: 운영서버 적용 시/아래: 로컬)
//    	String filePath = "/var/lib/tomcat8/webapps/SEGroup/resources/dormancyMailForm.html";
    	String filePath = "C:\\STSworkspace\\SEGroup\\src\\main\\webapp\\resources\\dormancyMailForm.html";
    	content = getText(filePath);
    	
    	//휴면 계정에 해당하는 유저가 있을 경우, 휴면처리하고 메일을 보냄
    	if(result.size() != 0) {
			for(User user : result) {
				if(userService.selectRestMemberInfo(user.getUser_id()) == null) {
					userService.insertRestUser(user);
					userService.updateRestUserInfo(user);
					
					try {
						final String from = "sesoc@gmail.com";
						final String to = user.getUser_email();
						final String subject = "[Soft Engineer Society] 휴면계정 전환 안내";
						final String text = content;
						mail.sendHtmlMail(from, to, subject, text);
					} catch (MessagingException e) {
						e.printStackTrace();
					}
				} 
			}
		}
    	logger.info("휴면계정 처리 끝");
    }
    
    
    /**
	 * @Method Name : getText
	 * @Date : 2020.10.26
	 * @User : 김나영
	 * @Method 설명 : 메일 본문으로 사용할 html의 내용을 읽어오는 메소드.(다른 내용이 추가될 시 변형해서 사용)
	 */
    public String getText(String filePath) {
    	String content = "";
    	
    	try {
    		FileInputStream inputStream = new FileInputStream(new File(filePath));
			content = IOUtils.toString(inputStream);
		} catch (IOException e) {
			e.printStackTrace();
		}
    	return content;
	}
}
