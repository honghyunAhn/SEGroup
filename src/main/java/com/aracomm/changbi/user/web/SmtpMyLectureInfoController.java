package com.aracomm.changbi.user.web;

import java.security.Principal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.MessageSource;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;

import com.aracomm.base.common.AraCommConst;
import com.aracomm.base.exceptions.InvalidAccessException;
import com.aracomm.changbi.common.GlobalConst;
import com.aracomm.changbi.common.base.BaseController;
import com.aracomm.changbi.mypage.service.LectureService;
import com.aracomm.changbi.user.dao.UserDao;
import com.aracomm.changbi.user.service.MyLectureInfoService;
import com.aracomm.changbi.user.service.MyLectureService;
import com.aracomm.changbi.user.vo.AttendanceInfoTime;
import com.aracomm.changbi.user.vo.GisuCategoryVO;
import com.aracomm.changbi.user.vo.SurveyAnswerVO;
import com.aracomm.changbi.user.vo.UserScoreVO;
import com.google.gson.Gson;


@Controller
public class SmtpMyLectureInfoController extends BaseController {

	private static final Logger logger = LoggerFactory.getLogger(SmtpMyLectureInfoController.class);
	
	@Autowired
	MyLectureInfoService infoService; 
	
	@Autowired
	private MyLectureService lecService;
	
	@Autowired
	private LectureService service;
	
	@Resource(name="messageSource")
	private MessageSource messageSource;
	
	@Value("#{config['upload.subdir.report']}")
	private String report_upload_sub_dir;
	
	@Autowired
	private UserDao userDao;
	
	// 2020/08/28 ?????????
	
	@RequestMapping(value="/smtp/user/smtpScore", method= RequestMethod.GET)
	public String smtpScore(Authentication auth, @RequestParam HashMap<String,Object> params, HttpSession session, Model model, UserScoreVO vo) throws Exception {
		logger.info("?????? ?????? ????????? ???????????? ??????");
		String user_id = (auth!=null ? auth.getName() : null);
		params.put("user_id",user_id);
		
		System.out.println(params.get("user_id"));
		
		String crc_id = (String) params.get("course_id");
		String gisu_id = (String) params.get("cardinal_id");
		
		vo.setUser_id(user_id);
		vo.setCrc_id(crc_id);
		vo.setGisu_id(gisu_id);		
		model.addAttribute("course_id", vo.getCrc_id());
		model.addAttribute("cardinal_id", vo.getGisu_id());
		model.addAttribute("id",vo.getUser_id());
		model.addAttribute("checkOnline", infoService.selectCheckOnline(crc_id));
		
		// leftmenu ?????? ?????? ????????? ?????? ??????id, ??????id, checkOnline test
		/*model.addAttribute("course_id", params.get("course_id"));
		model.addAttribute("cardinal_id", params.get("cardinal_id"));*/

		logger.info("?????? ?????? ????????? ???????????? ??????");
		return "/mypage/smtp_lecture/scoreDetail";
	}
	
	@RequestMapping(value="/smtp/user/userScore", method= RequestMethod.POST)
	@ResponseBody public List<HashMap<String, String>> userScore(Authentication auth, @RequestParam HashMap<String,Object> params, UserScoreVO vo) throws Exception {
		logger.info("?????? ???????????? ????????? ???????????? ??????");
		/*
		String user_id = (auth!=null ? auth.getName() : null);*/
		/*params.put("user_id",user_id);*/
		
		String userId = vo.getUser_id();
		
		vo.setUser_id("");
		
		GisuCategoryVO testVO = new GisuCategoryVO();
		testVO.setCrc_id(vo.getCrc_id());
		testVO.setGisu_id(vo.getGisu_id());
		List<HashMap<String, String>> testInfo = infoService.searchtUserTestInfo(vo);
		List<HashMap<String, String>> catInfo = infoService.searchtCategoryInfo(vo);
		List<HashMap<String, String>> needInfo = new ArrayList<HashMap<String,String>>();
		List<HashMap<String, String>> haveNotInfo = new ArrayList<HashMap<String,String>>();
		List<HashMap<String, String>> memberList = infoService.TestListAll(testVO);
		List<HashMap<String, String>> testInfoM = new ArrayList<HashMap<String,String>>();
		List<String> mL = new ArrayList<String>();
		HashMap<String, HashMap<Integer,Double>> testInfoMember = new HashMap<String, HashMap<Integer,Double>>();
		List<HashMap<String, String>> testList = infoService.callSmallCategory(testVO);
		List<HashMap<String, String>> list = infoService.createUpperCategory(testVO);
		boolean check = false;
		
		for(int i = 0; i < testInfo.size(); i++) {
			if(String.valueOf(testInfo.get(i).get("USER_ID")).equalsIgnoreCase(userId)) {
				check = true;
				break;
			}
		}
		
		if(check == false) {
			return null;
		}
		
		for(int i = 0; i < memberList.size(); i++) {
			if("A1801".equalsIgnoreCase(String.valueOf(memberList.get(i).get("state")))) {
				memberList.remove(i);
				i--;
			}
		}
		
		for (int i = 0; i < testInfo.size(); i++) {
			if (String.valueOf(testInfo.get(i).get("TEST_SEQ")).equalsIgnoreCase("") || String.valueOf(testInfo.get(i).get("TEST_SEQ")).equalsIgnoreCase("NULL") || String.valueOf(testInfo.get(i).get("TEST_SEQ")).equalsIgnoreCase(null)) {
				haveNotInfo.add(testInfo.get(i));
				testInfo.remove(i);
				i--;
			}
		}
		for (int i = 0; i < memberList.size(); i++) {
			mL.add(String.valueOf(memberList.get(i).get("USER_ID")));
			testInfoM.add(new HashMap<String,String>());
			testInfoM.get(i).put("USER_ID", String.valueOf(memberList.get(i).get("USER_ID")));
		}
		
		HashMap<String, String> testCount = new HashMap<>();
		
		for(int i = 0; i < catInfo.size(); i++) {
			if(!String.valueOf(catInfo.get(i).get("BIG_CAT_SEQ")).equalsIgnoreCase("0") && !String.valueOf(catInfo.get(i).get("MID_CAT_SEQ")).equalsIgnoreCase("0")) {
				int count = infoService.testCount(String.valueOf(catInfo.get(i).get("CAT_SEQ")));
				testCount.put(String.valueOf(catInfo.get(i).get("CAT_SEQ")), String.valueOf(count));				
			}
		}
		
		for (int i = 0; i < testInfo.size(); i++) {
			String user_id = String.valueOf(testInfo.get(i).get("USER_ID"));
			
//			System.out.println("testInfo [ " +i+" ] : "+ testInfo.get(i).toString());
			if (testInfoMember.get(String.valueOf(testInfo.get(i).get("USER_ID")))==null) {
				testInfoMember.put(String.valueOf(testInfo.get(i).get("USER_ID")),new HashMap<Integer, Double>());
			}
			
			double addScore = Double.parseDouble(String.valueOf(testInfo.get(i).get("SCORE")))+Double.parseDouble(String.valueOf(testInfo.get(i).get("PLUS_SCORE")));
			double totalScore = Double.parseDouble(String.valueOf(testInfo.get(i).get("TOTAL_SCORE")));
			
			double userScore = 0.00;
			if (addScore >= totalScore) {
				userScore = totalScore;
			}else {
				userScore = addScore;
			}
			testInfoMember.get(String.valueOf(testInfo.get(i).get("USER_ID"))).put(Integer.parseInt(String.valueOf(testInfo.get(i).get("CAT_SEQ"))), userScore);
			for (int j = 0; j < testInfoM.size(); j++) {
				if (String.valueOf(testInfoM.get(j).get("USER_ID")).equalsIgnoreCase(user_id)) {
					
					if(testInfoM.get(j).get(String.valueOf(testInfo.get(i).get("CAT_SEQ"))) != null) {
						double score = userScore + Double.parseDouble(String.valueOf(testInfoM.get(j).get(String.valueOf(testInfo.get(i).get("CAT_SEQ")))));
						testInfoM.get(j).put(String.valueOf(testInfo.get(i).get("CAT_SEQ")), String.valueOf(score));
						
					} else {
						testInfoM.get(j).put(String.valueOf(testInfo.get(i).get("CAT_SEQ")), String.valueOf(userScore));
					}
					
					testInfoM.get(j).put(String.valueOf(testInfo.get(i).get("TEST_NM")), String.valueOf(userScore));
					break;
				}
			}
		}
		
		for(int i = 0; i < catInfo.size(); i++) {
			if(!String.valueOf(catInfo.get(i).get("BIG_CAT_SEQ")).equalsIgnoreCase("0") && !String.valueOf(catInfo.get(i).get("MID_CAT_SEQ")).equalsIgnoreCase("0")) {
				String cat = String.valueOf(catInfo.get(i).get("CAT_SEQ"));
			
				for(int j = 0; j < testInfoM.size(); j++) {
//					System.out.println("testinfoM = " + String.valueOf(testInfoM.get(j).get(cat))+" " + cat);
					if(!(String.valueOf(testInfoM.get(j).get(cat)).equalsIgnoreCase("null"))) {
						double score = Double.parseDouble(String.valueOf(testInfoM.get(j).get(cat)));
						double total = Double.parseDouble(String.valueOf(testCount.get(cat)));
						double finalScore = score/total;
						/*	System.out.println("score = " + score + "total = " + total + " final = " + finalScore);*/
						testInfoM.get(j).put(cat, String.valueOf(Math.round(finalScore*100)/100.0));
					}
				}
			}
		}
		
			
			// ????????? ????????????..
			for (int i = 0; i < catInfo.size(); i++) {
				Integer cat_seq = Integer.parseInt(String.valueOf(catInfo.get(i).get("CAT_SEQ")));
				int nm = cat_seq;	
				for (int j = 0; j < mL.size(); j++) {
					if (!(testInfoMember.containsKey(mL.get(j)))) {
						continue;
					}
					if (testInfoMember.get(mL.get(j)).containsKey(nm)) {
						needInfo.add(catInfo.get(i));
						break;
					}
				
				}
			}
			
			for (int i = 0; i < needInfo.size(); i++) {
				for (int j = 0; j < catInfo.size(); j++) {
					if (String.valueOf(needInfo.get(i).get("MID_CAT_SEQ")).equalsIgnoreCase(String.valueOf(catInfo.get(j).get("CAT_SEQ"))) && (!(needInfo.contains(catInfo.get(j))))) {
						needInfo.add(catInfo.get(j));
					}
				}
			}
			for (int i = 0; i < needInfo.size(); i++) {
				for (int j = 0; j < catInfo.size(); j++) {
					if (String.valueOf(needInfo.get(i).get("BIG_CAT_SEQ")).equalsIgnoreCase(String.valueOf(catInfo.get(j).get("CAT_SEQ"))) && (!(needInfo.contains(catInfo.get(j)))) && String.valueOf(needInfo.get(i).get("MID_CAT_SEQ")).equalsIgnoreCase("0")) {
						needInfo.add(catInfo.get(j));
					}
				}
			}
			for (int i = 0; i < needInfo.size(); i++) {
				for (int j = 0; j < testInfo.size(); j++) {
					if (String.valueOf(needInfo.get(i).get("CAT_SEQ")).equalsIgnoreCase(String.valueOf(testInfo.get(j).get("CAT_SEQ")))) {
						needInfo.get(i).put("TOTAL_SCORE", String.valueOf(testInfo.get(j).get("TOTAL_SCORE")));
						break;
					}
				}
			}
			
//			for (int i = 0; i < needInfo.size(); i++) {
//				System.out.println("needInfo ["+i+"] : "+needInfo.get(i).toString());
//			}
			
			
			HashMap<String,Double> percent = new HashMap<String,Double>();
			for (int i = 0; i < testInfoM.size(); i++) {	
				for (int j = 0; j < needInfo.size(); j++) {
					if (String.valueOf(needInfo.get(j).get("MID_CAT_SEQ")).equalsIgnoreCase("0")) {
						continue;
					}
					String cat_seq = String.valueOf(needInfo.get(j).get("CAT_SEQ"));
					String cat_percent = String.valueOf(needInfo.get(j).get("CAT_PERCENT"));
					String total_score = String.valueOf(needInfo.get(j).get("TOTAL_SCORE"));
					if (i==0) {
						if (percent.get(String.valueOf(needInfo.get(j).get("MID_CAT_SEQ"))) == null && needInfo.get(j).get("MID_CAT_SEQ") != "0" && needInfo.get(j).get("BIG_CAT_SEQ") != "0") {
							percent.put(String.valueOf(needInfo.get(j).get("MID_CAT_SEQ")), Double.parseDouble(cat_percent));
						}else if(needInfo.get(j).get("MID_CAT_SEQ") != "0" && needInfo.get(j).get("BIG_CAT_SEQ") != "0"){
							percent.replace(String.valueOf(needInfo.get(j).get("MID_CAT_SEQ")), (percent.get(String.valueOf(needInfo.get(j).get("MID_CAT_SEQ")))+Double.parseDouble(cat_percent)));
						}	
					}
					
					if (testInfoM.get(i).get(cat_seq) != null) {
						Double fixedScore = Double.parseDouble(testInfoM.get(i).get(cat_seq))*(Double.parseDouble(cat_percent)/100);
						if (total_score != "null" && Double.parseDouble(total_score)!=100) {
							fixedScore = fixedScore * (100/(Double.parseDouble(total_score)));
						}
						if (testInfoM.get(i).get(String.valueOf(needInfo.get(j).get("MID_CAT_SEQ")))== null && needInfo.get(j).get("BIG_CAT_SEQ") != "0" && String.valueOf(needInfo.get(j).get("MID_CAT_SEQ")) != "0") {
							testInfoM.get(i).put(String.valueOf(needInfo.get(j).get("MID_CAT_SEQ")), String.valueOf(Math.round(fixedScore*100)/100.0));
						} else if(testInfoM.get(i).get(String.valueOf(needInfo.get(j).get("MID_CAT_SEQ")))!=null && String.valueOf(needInfo.get(j).get("MID_CAT_SEQ")) != "0" && needInfo.get(j).get("BIG_CAT_SEQ") != "0"){
							fixedScore = Double.parseDouble(testInfoM.get(i).get(String.valueOf(needInfo.get(j).get("MID_CAT_SEQ"))))+Math.round(fixedScore*100)/100.0;
							testInfoM.get(i).replace(String.valueOf(needInfo.get(j).get("MID_CAT_SEQ")), String.valueOf(fixedScore));				
						}
					}
				}
			}
			for (int i = 0; i < testInfoM.size(); i++) {
				for (int j = 0; j < needInfo.size(); j++) {
					if ((!(String.valueOf(needInfo.get(j).get("MID_CAT_SEQ")).equalsIgnoreCase("0"))) || String.valueOf(needInfo.get(j).get("BIG_CAT_SEQ")).equalsIgnoreCase("0")) {
						continue;
					}
					String cat_seq = String.valueOf(needInfo.get(j).get("CAT_SEQ"));
					String cat_percent = String.valueOf(needInfo.get(j).get("CAT_PERCENT"));
					
					if (i==0) {
						if (percent.get(String.valueOf(needInfo.get(j).get("BIG_CAT_SEQ"))) == null) {
							percent.put(String.valueOf(needInfo.get(j).get("BIG_CAT_SEQ")), Double.parseDouble(cat_percent));
						}else {
							percent.replace(String.valueOf(needInfo.get(j).get("BIG_CAT_SEQ")), (percent.get(String.valueOf(needInfo.get(j).get("BIG_CAT_SEQ")))+Double.parseDouble(cat_percent)));
						}	
					}
					if (testInfoM.get(i).get(cat_seq) != null) {
						Double fixedScore = Double.parseDouble(testInfoM.get(i).get(cat_seq))*(Double.parseDouble(cat_percent)/100);
						
						if (testInfoM.get(i).get(String.valueOf(needInfo.get(j).get("BIG_CAT_SEQ")))== null) {
							testInfoM.get(i).put(String.valueOf(needInfo.get(j).get("BIG_CAT_SEQ")), String.valueOf(Math.round(fixedScore*100)/100.0));
						} else {
							fixedScore = Double.parseDouble(testInfoM.get(i).get(String.valueOf(needInfo.get(j).get("BIG_CAT_SEQ"))))+Math.round(fixedScore*100)/100.0;
							testInfoM.get(i).replace(String.valueOf(needInfo.get(j).get("BIG_CAT_SEQ")), String.valueOf(fixedScore));				
						}
					}
				}
				
			}
			Iterator<String> keys = percent.keySet().iterator();
        	while (keys.hasNext()){
                	String key = keys.next();					
                for (int i = 0; i < testInfoM.size(); i++) {
                	if (testInfoM.get(i).get(key)==null) {
						continue;
					}
                	double score = Double.parseDouble(testInfoM.get(i).get(key)) * Math.round((100.0/percent.get(key)*100)/100.0);
                	testInfoM.get(i).replace(key, String.valueOf(Math.round(score*100)/100.0));
                } 
			}
			
			for (int i = 0; i < testInfoM.size(); i++) {
				for (int j = 0; j < needInfo.size(); j++) {
					if ((!(String.valueOf(needInfo.get(j).get("MID_CAT_SEQ")).equalsIgnoreCase("0"))) || (!(String.valueOf(needInfo.get(j).get("BIG_CAT_SEQ")).equalsIgnoreCase("0")))) {
						continue;
					}
					String cat_seq = String.valueOf(needInfo.get(j).get("CAT_SEQ"));
					String cat_percent = String.valueOf(needInfo.get(j).get("CAT_PERCENT"));
					if (testInfoM.get(i).get(cat_seq) != null) {
						Double fixedScore = Double.parseDouble(testInfoM.get(i).get(cat_seq))*(Double.parseDouble(cat_percent)/100);
						if (testInfoM.get(i).get("TOTAL") == null) {
							testInfoM.get(i).put("TOTAL", String.valueOf(Math.round(fixedScore*100)/100.0));
						} else {
							fixedScore = Double.parseDouble(testInfoM.get(i).get("TOTAL"))+(Math.round(fixedScore*100)/100.0);
							fixedScore = Math.round(fixedScore*100)/100.0;
							testInfoM.get(i).replace("TOTAL", String.valueOf(fixedScore));
						}
					}
				}
			}

			for (int i = 0; i < testInfoM.size(); i++) {
				if (testInfoM.get(i).get("TOTAL") == null) {
					testInfoM.remove(i);
					i--;
				}
			}
			
			for (int i = 0; i < testInfoM.size(); i++) {
				for (int j = 0; j < memberList.size(); j++) {
					if (String.valueOf(testInfoM.get(i).get("USER_ID")).equalsIgnoreCase(String.valueOf(memberList.get(j).get("USER_ID")))) {
						testInfoM.get(i).put("USER_NM", String.valueOf(memberList.get(j).get("USER_NAME")));
						break;
					}
				}
			}
			
//			for (int i = 0; i < testInfoM.size(); i++) {
//				System.out.println("testInfoM ?????? : "+ testInfoM.get(i).toString());
//			}
			
			HashMap<String, String> userInfo = new HashMap<>();
			HashMap<String, String> rank = new HashMap<>();
			
			for(int i = 0; i < testInfoM.size(); i++) {
				if(testInfoM.get(i).get("USER_ID").equalsIgnoreCase(userId)) {
					userInfo = testInfoM.get(i);
				}
			}
			
			for(int i = 0; i < needInfo.size(); i++) {
				int ranking = 1;
				for(int j = 0; j < testInfoM.size(); j++) {
					if(userInfo.get("USER_ID").equalsIgnoreCase(testInfoM.get(j).get("USER_ID")) && testInfoM.size() != 1) {
						continue;
					}
					if(Double.parseDouble(testInfoM.get(j).get(String.valueOf(needInfo.get(i).get("CAT_SEQ")))) < Double.parseDouble(userInfo.get(String.valueOf(needInfo.get(i).get("CAT_SEQ"))))) {
						rank.put(String.valueOf(needInfo.get(i).get("CAT_SEQ")), String.valueOf(ranking));
					} else if(Double.parseDouble(testInfoM.get(j).get(String.valueOf(needInfo.get(i).get("CAT_SEQ")))) > Double.parseDouble(userInfo.get(String.valueOf(needInfo.get(i).get("CAT_SEQ"))))) {
						ranking++;
						rank.put(String.valueOf(needInfo.get(i).get("CAT_SEQ")), String.valueOf(ranking));
					} else {
						rank.put(String.valueOf(needInfo.get(i).get("CAT_SEQ")), String.valueOf(ranking));
					}
				}
			}
			
			for(int i = 0; i < testList.size(); i++) {
				int ranking = 1;
				for(int j = 0; j < testInfoM.size(); j++) {
					if(userInfo.get("USER_ID").equalsIgnoreCase(testInfoM.get(j).get("USER_ID")) && testInfoM.size() != 1) {
						continue;
					}
					if(Double.parseDouble(testInfoM.get(j).get(String.valueOf(testList.get(i).get("TEST_NM")))) < Double.parseDouble(userInfo.get(String.valueOf(testList.get(i).get("TEST_NM"))))) {
						rank.put(String.valueOf(testList.get(i).get("TEST_NM")), String.valueOf(ranking));
					} else if(Double.parseDouble(testInfoM.get(j).get(String.valueOf(testList.get(i).get("TEST_NM")))) > Double.parseDouble(userInfo.get(String.valueOf(testList.get(i).get("TEST_NM"))))) {
						ranking++;
						rank.put(String.valueOf(testList.get(i).get("TEST_NM")), String.valueOf(ranking));
					} else {
						rank.put(String.valueOf(testList.get(i).get("TEST_NM")), String.valueOf(ranking));
					}
				}
			}
			
			int tranking = 1;
			
			for(int j = 0; j < testInfoM.size(); j++) {
				if(userInfo.get("USER_ID").equalsIgnoreCase(testInfoM.get(j).get("USER_ID")) && testInfoM.size() != 1) {
					continue;
				}
				if(Double.parseDouble(testInfoM.get(j).get("TOTAL")) < Double.parseDouble(userInfo.get("TOTAL"))) {
					rank.put(String.valueOf("TOTAL"), String.valueOf(tranking));
				} else if(Double.parseDouble(testInfoM.get(j).get("TOTAL")) > Double.parseDouble(userInfo.get("TOTAL"))) {
					tranking++;
					rank.put(String.valueOf("TOTAL"), String.valueOf(tranking));
				} else {
					rank.put(String.valueOf("TOTAL"), String.valueOf(tranking));
				}
			}
			
			for (int i = 0; i < testInfoM.size(); i++) {
				for (int j = 0; j < needInfo.size(); j++) {
					if (testInfoM.get(i).get(String.valueOf(needInfo.get(j).get("CAT_SEQ"))) != null) {
							String score = testInfoM.get(i).get(String.valueOf(needInfo.get(j).get("CAT_SEQ")));
						if (String.valueOf(needInfo.get(j).get("BIG_CAT_SEQ")).equalsIgnoreCase("0") && String.valueOf(needInfo.get(j).get("MID_CAT_SEQ")).equalsIgnoreCase("0")) {
							testInfoM.get(i).put("????????????"+String.valueOf(needInfo.get(j).get("CAT_NM")), score);
						} else if((!String.valueOf(needInfo.get(j).get("BIG_CAT_SEQ")).equalsIgnoreCase("0")) && String.valueOf(needInfo.get(j).get("MID_CAT_SEQ")).equalsIgnoreCase("0")) {
							testInfoM.get(i).put("????????????"+String.valueOf(needInfo.get(j).get("CAT_NM")), score);	
						}else {
							testInfoM.get(i).put("????????????"+String.valueOf(needInfo.get(j).get("CAT_NM")), score +" / " +Double.parseDouble(String.valueOf(needInfo.get(j).get("TOTAL_SCORE"))));
						}
						testInfoM.get(i).remove(String.valueOf(needInfo.get(j).get("CAT_SEQ")));
					}
				}
			}
			
			for (int i = 0; i < needInfo.size(); i++) {
				if(rank.get(String.valueOf(needInfo.get(i).get("CAT_SEQ"))) != null) {
					String ranking = rank.get(String.valueOf(needInfo.get(i).get("CAT_SEQ")));
					rank.put(String.valueOf(needInfo.get(i).get("CAT_NM")), ranking);
					rank.remove(String.valueOf(needInfo.get(i).get("CAT_SEQ")));
				}
			}
			
			logger.info("ranking = " + rank.toString());
			
//			for (int i = 0; i < testInfoM.size(); i++) {
//				System.out.println("testInfoM ?????? : "+ testInfoM.get(i).toString());
//			}
				
		List<HashMap<String, String>> newList = new ArrayList<HashMap<String, String>>();
		
		for(int i = 0; i < list.size(); i++) {
			HashMap<String, String> a = new HashMap<>();
			for (String key : list.get(i).keySet()) {
	            String value = String.valueOf(list.get(i).get(key));
	            a.put(key, value);
	        }
			newList.add(a);
		}
		
		for(int i = 0; i < testList.size(); i++) {
			HashMap<String, String> a = new HashMap<>();
			for (String key : testList.get(i).keySet()) {
				//System.out.println(testList.get(i).get("TEST_NM"));
				for(int j = 0; j < testInfo.size(); j++) {
					if(testInfo.get(j).get("TEST_NM").equalsIgnoreCase(String.valueOf(testList.get(i).get("TEST_NM")))) {
						
						if(testInfo.get(j).get("USER_ID").equalsIgnoreCase(userId)) {
							String content = testInfo.get(j).get("CONTENT");
							
							if(content.equalsIgnoreCase("null") || content.equalsIgnoreCase("")) {
								a.put("CONTENT", "");
								//System.out.println("content1 = "+content);
							} else {
								a.put("CONTENT", content);
								//System.out.println("content2 = "+content);
							}
						}
						
					}
				}
				
	            String value = String.valueOf(testList.get(i).get(key));
	            a.put(key, value);
	        }
			newList.add(a);
		}
		
		HashMap<String, String> ave = new HashMap<>();
		HashMap<String, String> std = new HashMap<>();
		
		if (newList.size()!=0) {
			for (int i = 0; i < testList.size(); i++) {
				double sum = 0;
				double avgValue = 0;
				for(int j = 0; j < testInfoM.size(); j++) {
					sum += Double.parseDouble(testInfoM.get(j).get(testList.get(i).get("TEST_NM")));
				}
				
				avgValue = sum / memberList.size();
				String avg = String.valueOf(Math.round(avgValue*100)/100.0);
				ave.put(testList.get(i).get("TEST_NM"), avg);
			}
		}
		
		if (newList.size()!=0) {			
			for (int i = 0; i < testList.size(); i++) {
				double dev = 0;
				double var = 0;
				double stv = 0;
				double devSqvSum = 0;
				for(int j = 0; j < testInfoM.size(); j++) {
					dev = (Double.parseDouble(testInfoM.get(j).get(testList.get(i).get("TEST_NM"))) 
							- Double.parseDouble(ave.get(testList.get(i).get("TEST_NM"))));
					devSqvSum += Math.pow(dev, 2);
				}
			
				var = devSqvSum / memberList.size();
				stv = Math.sqrt(var);
				String stdValue = String.valueOf(Math.round(stv*100)/100.0);
				std.put(testList.get(i).get("TEST_NM"), stdValue);
			}
		}
		
		HashMap<String, String> user = new HashMap<>();
		
		for(int i = 0; i < testInfoM.size(); i++) {
			if(testInfoM.get(i).get("USER_ID").equalsIgnoreCase(userId)) {
				user = testInfoM.get(i);
			}
		}
				
		rank.put("All", String.valueOf(testInfoM.size()));
		newList.add(ave);
		newList.add(std);
		newList.add(rank);
		newList.add(user);
		
//		for(int i = 0; i < newList.size(); i++) {
//			System.out.println("newList = " + newList.get(i).toString());
//		}
		
		logger.info("?????? ???????????? ????????? ???????????? ??????");
		return newList;
	}
	
	@RequestMapping(value="/smtp/user/searchGrade", method=RequestMethod.POST)
	@ResponseBody public List<HashMap<String, String>> searchGrade(@RequestParam HashMap<String,Object> params) throws Exception {
		logger.info("?????? ???????????? ??????");
//		logger.info("?????? = " + params.get("gisu_id"));
//		logger.info("?????? = " + params.get("crc_id"));
		List<HashMap<String, String>> list = new ArrayList<>();
		list = infoService.searchGrade(params);
		
//		logger.info("?????? = " + list.toString());
		
		List<HashMap<String, String>> real = new ArrayList<>();
		
		for(int i = 0; i < list.size(); i++) {
			HashMap<String, String> a = new HashMap<>();
			HashMap<String, String> mid = list.get(i);
			
			for (String key : mid.keySet()) {
				String value = String.valueOf(mid.get(key));
				a.put(key, value);
			}
			
			real.add(a);
		}
		
//		logger.info("???????????? = " + real.toString());
		logger.info("?????? ???????????? ??????");
		return real;
	}
	
	@ResponseBody
	@RequestMapping(value = "/smtp/myLecture/surveyList", method = RequestMethod.GET)
	public List<HashMap<String, Object>> surveyList(Authentication auth, @RequestParam HashMap<String, Object> params) {
		logger.info("???????????? ????????? ???????????? ??????");
		
		String user_id = (auth!=null ? auth.getName() : null);
		params.put("user_id", user_id);
		List<HashMap<String, Object>> surveyList = infoService.selectSurveyList(params);
		
		logger.info("???????????? ????????? ???????????? ??????");
		return surveyList;
	}
	
	@RequestMapping(value = "/smtp/myLecture/sub05-view-survey", method= RequestMethod.POST)
	public String sub05_view_survey(Authentication auth, @RequestParam HashMap<String, Object> params, Model model) {
		logger.info("???????????? ?????? ?????? ??????");
		
		String user_id = (auth != null ? auth.getName() : null);
		params.put("user_id", user_id);
		List<HashMap<String, Object>> surveyDetail = infoService.selectSurveyDetail(params);
		
		Gson gson = new Gson();
		model.addAttribute("info", params); //???????????? ?????? ??????
		model.addAttribute("surveyDetail", gson.toJson(surveyDetail));
		logger.info("???????????? ?????? ?????? ??????");
		return "/segroup/society/smtp/mylecture/sub05-view-survey";
	}
	
	@ResponseBody
	@RequestMapping(value = "/smtp/myLecture/insertSurveyAnswer", method = RequestMethod.POST)
	public boolean insertSurveyAnswer(Authentication auth, @RequestBody List<SurveyAnswerVO> list) {
		logger.info("???????????? ?????? ?????? ???????????? ??????");
		
		boolean result = false;
		String user_id = (auth!=null ? auth.getName() : null);
		
		if(user_id != null) {
			for(SurveyAnswerVO vo : list) vo.setUser_id(user_id);
			
			if(infoService.insertSurveyAnswer(list) == list.size()) {
				if(infoService.insertSurveyComplete(list.get(0)) == 1)
					result = true;
			}
		}
		logger.info("???????????? ?????? ?????? ???????????? ??????");
		return result;
	}
	
	@ResponseBody
	@RequestMapping(value = "/smtp/myLecture/updateSurveyAnswer", method = RequestMethod.POST)
	public boolean updateSurveyAnswer(Authentication auth, @RequestBody List<SurveyAnswerVO> list) {
		logger.info("???????????? ?????? ?????? ???????????? ??????");
		
		boolean result = false;
		String user_id = (auth!=null ? auth.getName() : null);
		
		if(user_id != null) {
			for(SurveyAnswerVO vo : list) vo.setUser_id(user_id);
			
			if(infoService.updateSurveyAnswer(list) == 1)
				result = true;
		}
		logger.info("???????????? ?????? ?????? ???????????? ??????");
		return result;
	}
	
	/*@ResponseBody
	@RequestMapping(value = "/smtp/user/smtpSurveyAnswer", method = RequestMethod.POST)
	public boolean smtpInsertSurveyAnswer(Authentication auth, @RequestBody ArrayList<SurveyAnswerVO> answerVO_list) {
		logger.info("???????????? ?????? ?????? ???????????? ??????");
		
		boolean result = false;
		String user_id = (auth!=null ? auth.getName() : null);
		
		if(user_id != null) {
			for(int i=0; i<answerVO_list.size(); i++){
				SurveyAnswerVO vo = answerVO_list.get(i);
				vo.setUser_id(user_id);
				infoService.insertSurveyAnswer(vo);
				
				if(i == answerVO_list.size()-1) {
					infoService.insertSurveyComplete(vo);
					result = true;
				}
			}
		}
		
		logger.info("???????????? ?????? ?????? ???????????? ??????");
		return result;
	}*/
	
	/*@ResponseBody
	@RequestMapping(value = "/smtp/user/smtpSelectAnswer", method = RequestMethod.POST)
	public ArrayList<HashMap<String, Object>> smtpSelectAnswer(Authentication auth, @RequestBody HashMap<String, Object> params) {
		logger.info("???????????? ???????????? ?????? ???????????? ??????");
		String user_id = (auth != null ? auth.getName() : null);
		params.put("user_id", user_id);
		
		ArrayList<HashMap<String, Object>> list = infoService.selectSurveyAnswer(params);
		logger.info("???????????? ???????????? ?????? ???????????? ??????");
		return list;
	}*/
	
	/*@ResponseBody
	@RequestMapping(value = "/smtp/user/smtpSelectClosedSurvey", method = RequestMethod.POST)
	public ArrayList<SurveyQuestionVO> smtpSelectClosedSurvey(@RequestBody HashMap<String, Object> params) {
		logger.info("????????? ????????? ?????? ?????? ???????????? ??????");
		
		ArrayList<SurveyQuestionVO> list = infoService.selectClosedSurvey(params);
		logger.info("????????? ????????? ?????? ?????? ???????????? ??????");
		return list;
	}*/
	
	// ?????? ????????? ?????? ????????????
	@RequestMapping(value = "/smtp/mypage/sub05-01-01", method=RequestMethod.POST)
	public String sub05_01_01(@RequestParam HashMap<String, Object> params, Authentication auth, String course_id, String cardinal_id, Model model){
		
		logger.info("?????? ????????? ????????? ?????? ???????????? ??????");
		
		String user_id = (auth!=null ? auth.getName() : null);
		
		model.addAttribute("course_id", course_id);
		model.addAttribute("cardinal_id", cardinal_id);
		model.addAttribute("user_id", user_id);
		model.addAttribute("checkOnline", infoService.selectCheckOnline(course_id));
		
//		/* -----------------------------??????????????? ??????----------------------------------------*/		
		params.put("course", course_id);
		params.put("cardinal", cardinal_id);
		params.put("user_id", user_id);
		params.put("quiz_type", GlobalConst.QUIZ_EXAM);
		String id = infoService.SelectLearnAppId(params);
		params.put("id", id);
		
		HashMap<String,Object> classInfo = service.selectClassInfo(params);

		//????????? ?????? ????????? ????????? ???????????? ??????
		if (classInfo == null) throw new InvalidAccessException(getMessage(messageSource, "msg.mypage.invalidaccess"));

		int reviewDays = Integer.parseInt(String.valueOf(classInfo.get("REVIEW_DAYS")));
		//??????????????? ????????? ?????????????????? ????????? ??????
		if (reviewDays < 0) throw new InvalidAccessException(getMessage(messageSource, "msg.mypage.invalidaccess"));
		
		model.addAttribute("classParam", params);
		model.addAttribute("classInfo", classInfo);
		model.addAttribute("examList", service.selectExamList(params));
//		/* ----------------------------------------------------------------------------------------------------- */
		
		logger.info("?????? ????????? ????????? ?????? ???????????? ??????");
		
		return "/segroup/society/smtp/mylecture/sub05-01-01";
	}
	
	@ResponseBody
	@RequestMapping(value = "/smtp/mypage/attendance_smtp", method = RequestMethod.GET)
	public List<HashMap<String, Object>> attendance_smtp(Authentication auth, @RequestParam HashMap<String, Object> params, Model model){
		
		String user_id = (auth!=null ? auth.getName() : null);
		params.put("user_id",user_id);
		
		System.out.println(params.toString());
		
		List<HashMap<String, Object>> map = infoService.attendance(params);
		
		if(map.isEmpty() || map == null) {
			System.out.println("Null Return");
			return null;
		} else {
			for(int i=0; i<map.size(); i++) {
				System.out.println("ATTEND TEST : " + map.get(i).toString());
			}
		}
		
		ArrayList<Object> temp = new ArrayList<>();
		
		for (int i = 0; i < map.size(); i++) {
			temp.add(map.get(i).get("ATT_DATE").toString().substring(0, 10));
			map.get(i).remove("ATT_DATE");
			map.get(i).put("ATT_DATE", temp.get(i).toString());
		}
		
		return map;
	}
	
	// 20 09 23 ????????? 
	// 20 09 25 ????????? ?????? ????????????
	@RequestMapping(value="/smtp/mypage/sisuCount", method=RequestMethod.GET)
    public @ResponseBody ArrayList<HashMap<String, Object>> sisuCount(Authentication auth ,@RequestParam HashMap<String, Object> param) {
 		
 		HashMap<String, Object> allMap = new HashMap<>();
 		HashMap<String, Object> monthMap = new HashMap<>();
 		
 		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
 		
 		String userNm = auth.getName();
 		
 		param.put("user_id", userNm);
 		Date current;
 		String currentMonth = (String)param.get("currentMonth");
 		
 		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM");
 		
 		try {
			current = format.parse(currentMonth);
			currentMonth = format.format(current);
		} catch (ParseException e) {
			e.printStackTrace();
		}
 		
 		param.put("currentMonth", currentMonth);
// 		System.out.println("Param Check : " + param.toString());
 		int allSisuCount = infoService.allSisuCount(param);
 		int monthSisuCount = infoService.monthSisuCount(param);
//		System.out.println("Sisu Count : " + allSisuCount + " " + monthSisuCount);
 		
 		String[] strArr = {"B4701", "B4702", "B4703", "B4704"};
 		List<Integer> attList = new ArrayList<>();
 		List<Integer> monthList = new ArrayList<>();
 		
 		for(int i=0; i<strArr.length; i++) {
 			param.put("att_info_gubun", strArr[i]);
 			attList.add(infoService.allAttendStatus(param));
 			monthList.add(infoService.monthAttendStatus(param));
 		}
 		
// 		System.out.println("All Total Sisu Count : " + allSisuCount);
// 		System.out.println("Month Total Sisu Count : " + monthSisuCount);
 		
// 		for(int i=0; i<attList.size(); i++) {
// 			System.out.println("All Count Check : " + attList.get(i));
// 			System.out.println("Month Count Check : " + monthList.get(i));
// 		}
 		
 		allMap.put("status", "all");
 		allMap.put("allCount", allSisuCount);
 		allMap.put("attend", attList.get(0));
 		allMap.put("absence", attList.get(1));
 		allMap.put("late", attList.get(2));
 		allMap.put("accepted", attList.get(3));
 		list.add(allMap);
 		
 		monthMap.put("status", "month");
 		monthMap.put("monthCount", monthSisuCount);
 		monthMap.put("attend", monthList.get(0));
 		monthMap.put("absence", monthList.get(1));
 		monthMap.put("late", monthList.get(2));
 		monthMap.put("accepted", monthList.get(3));
 		list.add(monthMap);

 		return list;
    }
	
	@ResponseBody
	@RequestMapping(value="/smtp/mypage/selectExamList")
	public Object selectExamList(Model model, @RequestParam HashMap<String,Object> params, Principal principal) {
		
		logger.info("?????? ??? ???????????? ??????/?????? ?????? ???????????? ??????");
		String user_id = (principal != null ? principal.getName() : null);
		params.put("user_id", user_id);
		String id = infoService.SelectLearnAppId(params);
		params.put("id", id);
		logger.info(params.toString());
		List<HashMap<String,Object>> list = service.selectExamList(params);
		for(int i = 0; i < list.size(); i++) {
			list.get(i).put("learnappid", id);
		}
		logger.info(list.toString());
		logger.info("?????? ??? ???????????? ??????/?????? ?????? ???????????? ??????");
		return list;
	}

	@RequestMapping(value="/smtp/mypage/examListAjax")
	public @ResponseBody Object examListAjax(Model model, @RequestParam HashMap<String,Object> params, Principal principal) {
		String user_id = (principal != null ? principal.getName() : null);
		params.put("user_id", user_id);
		logger.info("?????? ???????????? ???????????? ??????");
		HashMap<String,Object> result = new HashMap<>();
		
//		logger.info("course = " + params.get("course"));
//		logger.info("cardinal = " + params.get("cardinal"));
//		logger.info("id = " + params.get("id"));
		
		HashMap<String, Object> examInfo = service.selectExamInfo(params);
		String limits = (String)examInfo.get("LIMITS");
		if (limits.contains("3")) {//???PC ??????????????? ??????, ??????PC????????? ?????? PASS, ??????PC????????? ???????????? ?????????????????? ????????????
			List<HashMap<String, String>> pcList = userDao.selectIpList(user_id);
			examInfo.put("REGIST_PC_COUNT", pcList!=null?pcList.size():0);
		}

		List<HashMap<String, Object>> list = service.selectExamItemList(params);

		// ???????????? ?????? ??? ???????????? ??????
		if (list != null && list.size() > 0) {
			examInfo.put("TAKE_COUNT", service.selectExamTakeCount(params));
		} else {
			examInfo.put("TAKE_COUNT", 0);
		}
		
		if(!String.valueOf(examInfo.get("TAKE_COUNT")).equalsIgnoreCase("0")) {
			HashMap<String, Object> reportInfo = service.selectReportInfo(params);
			params.put("report_id", reportInfo.get("ID"));
			List<HashMap<String, Object>> replyList = service.selectExamReplyList(params);
			
			result.put("replyList", replyList);
		}

		result.put("examInfo", examInfo);
		result.put("list", list);
		logger.info("?????? ???????????? ???????????? ??????");
		return result;
	}

	@RequestMapping(value="popup/smtpReport")
	public void popupSmtpReport(Authentication auth, @RequestParam HashMap<String,Object> params, Model model) {
		logger.info("smtp ?????? ??? ?????? ??????");
		String user_id = (auth!=null ? auth.getName() : null);
		params.put("user_id",user_id);
		
		logger.info("tags = " + params.toString());
		
		HashMap<String,Object> result = new HashMap<>();
		
		HashMap<String, Object> examInfo = service.selectExamInfo(params);
		List<HashMap<String, Object>> list = service.selectExamItemList(params);
		
		logger.info("examInfo " + examInfo.toString());
		logger.info("list " + list.toString());
		
		result.put("examInfo", examInfo);
		result.put("list", list);	

		String takeYn =String.valueOf(params.get("takeYn"));
		
		logger.info("takeYn " + takeYn);
		
		if(takeYn.equalsIgnoreCase("1")) {
			HashMap<String, Object> reportInfo = service.selectReportInfo(params);
			params.put("report_id", reportInfo.get("ID"));
			List<HashMap<String, Object>> replyList = service.selectExamReplyList(params);
			result.put("reply", replyList);
			logger.info("list " + replyList.toString());
		}
		
		//lecService
		model.addAttribute("params", params);
		model.addAttribute("result", result);
		logger.info("smtp ?????? ??? ?????? ??????");
	}
	
	@RequestMapping(value="popup/smtpExam")
	public void popupSmtpExam(Authentication auth, @RequestParam HashMap<String,Object> params, Model model) {
		logger.info("smtp ?????? ??? ?????? ??????");
		String user_id = (auth!=null ? auth.getName() : null);
		params.put("user_id",user_id);
		
/*		logger.info("tags = " + params.toString());*/
		
		HashMap<String,Object> result = new HashMap<>();
		
		HashMap<String, Object> examInfo = service.selectExamInfo(params);
		List<HashMap<String, Object>> list = service.selectExamItemList(params);
		
/*		logger.info("examInfo = " + examInfo.toString());
		logger.info("list = " + list.toString());*/
		
		// ???????????? ?????? ??? ???????????? ??????
		if (list != null && list.size() > 0) {
			examInfo.put("TAKE_COUNT", service.selectExamTakeCount(params));
		} else {
			examInfo.put("TAKE_COUNT", 0);
		}

		result.put("examInfo", examInfo);
		result.put("list", list);
		
		if(!String.valueOf(examInfo.get("TAKE_COUNT")).equalsIgnoreCase("0")) {
			HashMap<String, Object> reportInfo = service.selectReportInfo(params);
			params.put("report_id", reportInfo.get("ID"));
			List<HashMap<String, Object>> replyList = service.selectExamReplyList(params);
			
			result.put("replyList", replyList);
		}
		
		//lecService
		model.addAttribute("params", params);
		model.addAttribute("result", result);
		logger.info("smtp ?????? ??? ?????? ??????");
	}
	
	// ?????? ?????? ??????
	@RequestMapping(value="/smtp/mypage/examTakeHistAjax")
	public @ResponseBody Object examTakeHistAjax(Model model, @RequestParam HashMap<String,Object> params, Principal principal) {
		String user_id = (principal != null ? principal.getName() : null);
		params.put("user_id", user_id);
		
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		
		String ip = request.getHeader("X-Forwarded-For");
		
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("Proxy-Client-IP");
            //logger.info(">>>> Proxy-Client-IP : " + ip);
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("WL-Proxy-Client-IP"); // ?????????
            //logger.info(">>>> WL-Proxy-Client-IP : " + ip);
        }
        if (ip == null ||ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("HTTP_CLIENT_IP");
            //logger.info(">>>> HTTP_CLIENT_IP : " + ip);
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("HTTP_X_FORWARDED_FOR");
            //logger.info(">>>> HTTP_X_FORWARDED_FOR : " + ip);
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getRemoteAddr();
        }
        
        if("0:0:0:0:0:0:0:1".equals(ip)) {
        	ip = "127.0.0.1";
        }
        
        logger.info(">>>>> Result : IP Address : " + ip);
        params.put("ip", ip);
		
		HashMap<String,Object> result = new HashMap<>();
		try {
			result.put("result", service.insertExamTakeHistory(params));
		} catch (Exception e) {
			e.printStackTrace();
			result.put("result", "FAILURE");
		}

		return result;
	}

	@RequestMapping(value="/smtp/mypage/examTakeAjax")
	public @ResponseBody Object examTakeAjax(Model model, @RequestParam HashMap<String,Object> params, Principal principal) {
		String user_id = (principal != null ? principal.getName() : null);
		params.put("user_id", user_id);

		HashMap<String,Object> result = new HashMap<>();
		try {
			result.put("result", service.insertExamItemReply(params, null));
		} catch (Exception e) {
			e.printStackTrace();
			result.put("result", "FAILURE");
		}
		return result;
	}

	@RequestMapping(value="/smtp/mypage/reportTakeAjax", method=RequestMethod.POST)
	public @ResponseBody Object reportTakeAjax(Model model, @RequestParam HashMap<String,Object> params, List<MultipartFile> reportfile, Principal principal) {
		String user_id = (principal != null ? principal.getName() : null);
		params.put("user_id", user_id);
		
		HashMap<String,Object> result = new HashMap<>();
		logger.info("?????? ?????? ???????????? ??????");
		logger.info("???????????? = " + params.toString());
		logger.info("?????? = " + reportfile.toString());
		
		// ???????????? ?????? (?????????????????? 2?????? ???????????? ?????? ???????????? ?????? ???????????? ??????)
/*		List<FileVo> fileList = fileUtil.fileUpload(reportfile, report_upload_sub_dir);
		for(int i=0; i<fileList.size(); i++) {
			FileVo fileVo = fileList.get(i);
			fileVo.setUser(user_id);
			params.put("fileid", fileVo.getFile_id());
		}*/

		try {
			result.put("result", service.insertExamItemReply(params, /*fileList*/reportfile)); // fileList
		} catch (Exception e) {
			e.printStackTrace();
			result.put("result", AraCommConst.TEXT_FAIL);
		}
		logger.info("?????? ?????? ???????????? ??????");
		return result;
	}
	
	@RequestMapping(value="/smtp/mypage/selectMyOnlineExamAnswerAjax")
	public @ResponseBody Object selectMyOnlineExamAnswerAjax(Model model, @RequestParam HashMap<String,Object> params, Principal principal) {
		String user_id = (principal != null ? principal.getName() : null);
		logger.info("?????? ???????????? ???????????? ??????");
		HashMap<String,Object> result = new HashMap<>();
		
		if(params == null || params.isEmpty()) {
			result.put("result", AraCommConst.TEXT_FAIL);
			return result;
		}

		params.put("user_id", user_id);
		params.put("answeryn", "Y");

		try {
			HashMap<String, Object> examInfo = service.selectExamInfo(params);
			if (examInfo == null || examInfo.isEmpty()) {
				result.put("result", AraCommConst.TEXT_FAIL);
				result.put("message", "?????? ????????? ?????????????????? ????????????.");
				return result;
			}
			
			HashMap<String, Object> reportInfo = service.selectReportInfo(params);
			
			if(params.get("quiz_type").equals('2')) {
				if (reportInfo == null || reportInfo.get("MARK_YN").equals("N")) {
					result.put("result", AraCommConst.TEXT_FAIL);
					result.put("message", "??????????????? ?????? ?????? ??? ?????????.");
					return result;
				}
			}
			
			HashMap<String, Object> classInfo = service.selectClassInfo(params);
			if (reportInfo == null || reportInfo.get("MARK_YN").equals("N")) {
				result.put("result", AraCommConst.TEXT_FAIL);
				return result;
			}
			
			List<HashMap<String, Object>> quizList = service.selectExamItemList(params);
			if (quizList == null || quizList.isEmpty()) {
				result.put("result", AraCommConst.TEXT_FAIL);
				return result;
			}
			
			params.put("report_id", reportInfo.get("ID"));
			List<HashMap<String, Object>> replyList = service.selectExamReplyList(params);
			if (replyList == null || replyList.isEmpty()) {
				result.put("result", AraCommConst.TEXT_FAIL);
				return result;
			}
			
			result.put("result", AraCommConst.TEXT_SUCCESS);
			result.put("classInfo", classInfo);
			result.put("examInfo", examInfo);
			result.put("reportInfo", reportInfo);
			result.put("quizList", quizList);
			result.put("replyList", replyList);
		} catch (Exception e) {
			e.printStackTrace();
			result.put("result", AraCommConst.TEXT_FAIL);
			result.put("message", e.getMessage());
		}
		logger.info("?????? ???????????? ???????????? ??????");
		return result;
	}
	
	@RequestMapping(value="/smtp/mypage/updateReply")
	public @ResponseBody Object updateReply(Model model, @RequestParam HashMap<String,Object> params, Principal principal) {
		String user_id = (principal != null ? principal.getName() : null);
		params.put("user_id", user_id);
		params.put("answeryn", "Y");
		logger.info("?????? ???????????? ???????????? ??????");
		HashMap<String,Object> result = new HashMap<>();
		
		HashMap<String,Object> report = service.selectReportInfo(params);
		params.put("report_id", report.get("ID"));
		logger.info("params = " + params.toString());
		
		try {
			infoService.updateReportReply(params);
			result.put("result", AraCommConst.TEXT_SUCCESS);
		} catch (Exception e) {
			e.printStackTrace();
			result.put("result", AraCommConst.TEXT_FAIL);
			result.put("message", e.getMessage());
		}
		logger.info("?????? ???????????? ???????????? ??????");
		return result;
	}
	
	@RequestMapping(value="/smtp/mypage/selectExamTime")
	public @ResponseBody Object selectExamTime(Model model, @RequestParam HashMap<String,Object> params, Principal principal) {
		String user_id = (principal != null ? principal.getName() : null);
		params.put("user_id", user_id);
		params.put("answeryn", "Y");
		logger.info("?????? ???????????? ???????????? ??????");
		
		HashMap<String, Object> result = new HashMap<>();
		
		logger.info("params = " + params.toString());
		
		try {
			List<HashMap<String, Object>> date = infoService.selectExamTime(params);
			
			if(date.size() == 1) {
				service.InitiateExam(params);
				result.put("date", date.get(date.size()-1).get("TIME"));
				result.put("start", date.get(0).get("TIME"));
			} else {
				logger.info("date = " + date.get(date.size()-2));
				result.put("date", date.get(date.size()-2).get("TIME"));
				result.put("start", date.get(0).get("TIME"));
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			result.put("message", e.getMessage());
		}
		logger.info("?????? ???????????? ???????????? ??????");
		return result;
	}
	
	@RequestMapping(value="/smtp/user/printScore")
	public String printScore(UserScoreVO vo, Model model, Authentication auth) {
		logger.info("????????? ????????? ???????????? ??????");
		String userId = (auth!=null ? auth.getName() : null);
		
		vo.setUser_id("");
		
		GisuCategoryVO testVO = new GisuCategoryVO();
		testVO.setCrc_id(vo.getCrc_id());
		testVO.setGisu_id(vo.getGisu_id());
		// ?????? ?????? ?????? ?????????
		List<HashMap<String, String>> testInfo = infoService.searchtUserTestInfo(vo);
		// ?????? ???????????? ?????????
		List<HashMap<String, String>> catInfo = infoService.searchtCategoryInfo(vo);
		//
		List<HashMap<String, String>> needInfo = new ArrayList<HashMap<String,String>>();
		List<HashMap<String, String>> haveNotInfo = new ArrayList<HashMap<String,String>>();
		// ?????? ?????? ?????????
		List<HashMap<String, String>> memberList = infoService.TestListAll(testVO);
		List<HashMap<String, String>> testInfoM = new ArrayList<HashMap<String,String>>();
		List<String> mL = new ArrayList<String>();
		HashMap<String, HashMap<Integer,Double>> testInfoMember = new HashMap<String, HashMap<Integer,Double>>();
		HashMap<String, String> fail = new HashMap<>();
		int failCount = 0;
		
		// fail ?????? ?????? ??????????????? ??????
		for(int i = 0; i < memberList.size(); i++) {
			if("A1801".equalsIgnoreCase(String.valueOf(memberList.get(i).get("state")))) {
				failCount++;
				memberList.remove(i);
				i--;
			}
		}
		// fail ????????? ??????
		fail.put("Fail", String.valueOf(failCount));
		
		// ?????? ??????(???????????? ?????? ?????? ??????)
		for (int i = 0; i < testInfo.size(); i++) {
			if (String.valueOf(testInfo.get(i).get("TEST_SEQ")).equalsIgnoreCase("") || String.valueOf(testInfo.get(i).get("TEST_SEQ")).equalsIgnoreCase("NULL") || String.valueOf(testInfo.get(i).get("TEST_SEQ")).equalsIgnoreCase(null)) {
				haveNotInfo.add(testInfo.get(i));
				testInfo.remove(i);
				i--;
			}
		}
		// ????????? ????????? ????????? ????????? ??????
		for (int i = 0; i < memberList.size(); i++) {
			mL.add(String.valueOf(memberList.get(i).get("USER_ID")));
			testInfoM.add(new HashMap<String,String>());
			testInfoM.get(i).put("USER_ID", String.valueOf(memberList.get(i).get("USER_ID")));
			testInfoM.get(i).put("START_DATE", String.valueOf(memberList.get(i).get("START_DATE")));
			testInfoM.get(i).put("END_DATE", String.valueOf(memberList.get(i).get("END_DATE")));
		}
		
		HashMap<String, String> testCount = new HashMap<>();
		// ???????????? ????????? ??? ?????? ????????? ?????? ??????(?????? ???????????? category seq) 
		for(int i = 0; i < catInfo.size(); i++) {
			if(!String.valueOf(catInfo.get(i).get("BIG_CAT_SEQ")).equalsIgnoreCase("0") && !String.valueOf(catInfo.get(i).get("MID_CAT_SEQ")).equalsIgnoreCase("0")) {
				int count = infoService.testCount(String.valueOf(catInfo.get(i).get("CAT_SEQ")));
				testCount.put(String.valueOf(catInfo.get(i).get("CAT_SEQ")), String.valueOf(count));				
			}
		}
		// ??? ????????? ??? ????????? ?????? ????????? 
		for (int i = 0; i < testInfo.size(); i++) {
			String user_id = String.valueOf(testInfo.get(i).get("USER_ID"));
			// ?????? ???????????? ?????? testInfoMember??? ??????
//			System.out.println("testInfo [ " +i+" ] : "+ testInfo.get(i).toString());
			if (testInfoMember.get(String.valueOf(testInfo.get(i).get("USER_ID")))==null) {
				testInfoMember.put(String.valueOf(testInfo.get(i).get("USER_ID")),new HashMap<Integer, Double>());
			}
			// ????????????(?????? ?????? ??????)??? ??? ????????? ??????
			double addScore = Double.parseDouble(String.valueOf(testInfo.get(i).get("SCORE")))+Double.parseDouble(String.valueOf(testInfo.get(i).get("PLUS_SCORE")));
			double totalScore = Double.parseDouble(String.valueOf(testInfo.get(i).get("TOTAL_SCORE")));
			// ???????????? ????????? ?????? ????????? ????????? ?????? ????????? ?????? 
			double userScore = 0.00;
			if (addScore >= totalScore) {
				userScore = totalScore;
			}else {
				userScore = addScore;
			}
			// ?????? ????????? ???????????? key ????????? ????????? testInfoMember??? ????????? ????????? ??????
			testInfoMember.get(String.valueOf(testInfo.get(i).get("USER_ID"))).put(Integer.parseInt(String.valueOf(testInfo.get(i).get("CAT_SEQ"))), userScore);
			// testInfoM?????? ????????? ????????? ???????????? ?????? ??????, ?????? ???????????? ?????? ?????? ????????? ?????? ????????? ?????? ????????? ?????? ?????? ?????? ????????? key ?????? hashmap??? ??????
			for (int j = 0; j < testInfoM.size(); j++) {
				if (String.valueOf(testInfoM.get(j).get("USER_ID")).equalsIgnoreCase(user_id)) {
					
					if(testInfoM.get(j).get(String.valueOf(testInfo.get(i).get("CAT_SEQ"))) != null) {
						double score = userScore + Double.parseDouble(String.valueOf(testInfoM.get(j).get(String.valueOf(testInfo.get(i).get("CAT_SEQ")))));
						testInfoM.get(j).put(String.valueOf(testInfo.get(i).get("CAT_SEQ")), String.valueOf(score));
						
					} else {
						testInfoM.get(j).put(String.valueOf(testInfo.get(i).get("CAT_SEQ")), String.valueOf(userScore));
					}
					
					testInfoM.get(j).put(String.valueOf(testInfo.get(i).get("TEST_NM")), String.valueOf(userScore));
					break;
				}
			}
		}
		// ??????????????? ???????????? ??????, ?????? ???????????? seq ??? ?????? ?????? ?????? ??????????????? ???????????? ?????? ??? ?????? ???????????? ????????? ?????? ????????? ???????????? ????????? ????????? ?????? ???????????? seq??? ??????  
		for(int i = 0; i < catInfo.size(); i++) {
			if(!String.valueOf(catInfo.get(i).get("BIG_CAT_SEQ")).equalsIgnoreCase("0") && !String.valueOf(catInfo.get(i).get("MID_CAT_SEQ")).equalsIgnoreCase("0")) {
				String cat = String.valueOf(catInfo.get(i).get("CAT_SEQ"));
			
				for(int j = 0; j < testInfoM.size(); j++) {
//					System.out.println("testinfoM = " + String.valueOf(testInfoM.get(j).get(cat)));
					if(!(String.valueOf(testInfoM.get(j).get(cat)).equalsIgnoreCase("null"))) {
						double score = Double.parseDouble(String.valueOf(testInfoM.get(j).get(cat)));
						double total = Double.parseDouble(String.valueOf(testCount.get(cat)));
						double finalScore = score/total;
						/*	System.out.println("score = " + score + "total = " + total + " final = " + finalScore);*/
						testInfoM.get(j).put(cat, String.valueOf(Math.round(finalScore*100)/100.0));
					}
				}
			}
		}
		
			
			// ????????? ????????????
			for (int i = 0; i < catInfo.size(); i++) {
				Integer cat_seq = Integer.parseInt(String.valueOf(catInfo.get(i).get("CAT_SEQ")));
				int nm = cat_seq;
				for (int j = 0; j < mL.size(); j++) {
					// testInfoMember??? ????????? ???????????? ?????? ?????? ??????
					if (!(testInfoMember.containsKey(mL.get(j)))) {
						continue;
					}
					// testInfoMember??? ?????? ???????????? ?????? ??????, ???????????? seq ?????? ??? 
					if (testInfoMember.get(mL.get(j)).containsKey(nm)) {
						needInfo.add(catInfo.get(i));
						break;
					}
				
				}
			}
			
			// ????????? ???????????? ??????
			for (int i = 0; i < needInfo.size(); i++) {
				for (int j = 0; j < catInfo.size(); j++) {
					if (String.valueOf(needInfo.get(i).get("MID_CAT_SEQ")).equalsIgnoreCase(String.valueOf(catInfo.get(j).get("CAT_SEQ"))) && (!(needInfo.contains(catInfo.get(j))))) {
						needInfo.add(catInfo.get(j));
					}
				}
			}
			
			// ????????? ???????????? ??????
			for (int i = 0; i < needInfo.size(); i++) {
				for (int j = 0; j < catInfo.size(); j++) {
					if (String.valueOf(needInfo.get(i).get("BIG_CAT_SEQ")).equalsIgnoreCase(String.valueOf(catInfo.get(j).get("CAT_SEQ"))) && (!(needInfo.contains(catInfo.get(j)))) && String.valueOf(needInfo.get(i).get("MID_CAT_SEQ")).equalsIgnoreCase("0")) {
						needInfo.add(catInfo.get(j));
					}
				}
			}
			
			// ????????? ???????????? ????????? ??????
			for (int i = 0; i < needInfo.size(); i++) {
				for (int j = 0; j < testInfo.size(); j++) {
					if (String.valueOf(needInfo.get(i).get("CAT_SEQ")).equalsIgnoreCase(String.valueOf(testInfo.get(j).get("CAT_SEQ")))) {
						needInfo.get(i).put("TOTAL_SCORE", String.valueOf(testInfo.get(j).get("TOTAL_SCORE")));
						break;
					}
				}
			}
			
//			for (int i = 0; i < needInfo.size(); i++) {
//				System.out.println("needInfo ["+i+"] : "+needInfo.get(i).toString());
//			}
			
			// ????????? ????????? ???????????? ????????? ????????? ?????????
			HashMap<String,Double> percent = new HashMap<String,Double>();
			for (int i = 0; i < testInfoM.size(); i++) {	
				for (int j = 0; j < needInfo.size(); j++) {
					// ???????????? ?????? ??????, ????????? ?????? ??????
					if (String.valueOf(needInfo.get(j).get("MID_CAT_SEQ")).equalsIgnoreCase("0")) {
						continue;
					}
					// ???????????? seq, ??????, ??????
					String cat_seq = String.valueOf(needInfo.get(j).get("CAT_SEQ"));
					String cat_percent = String.valueOf(needInfo.get(j).get("CAT_PERCENT"));
					String total_score = String.valueOf(needInfo.get(j).get("TOTAL_SCORE"));
					
					if (i==0) {
						if (percent.get(String.valueOf(needInfo.get(j).get("MID_CAT_SEQ"))) == null && needInfo.get(j).get("MID_CAT_SEQ") != "0" && needInfo.get(j).get("BIG_CAT_SEQ") != "0") {
							percent.put(String.valueOf(needInfo.get(j).get("MID_CAT_SEQ")), Double.parseDouble(cat_percent));
						}else if(needInfo.get(j).get("MID_CAT_SEQ") != "0" && needInfo.get(j).get("BIG_CAT_SEQ") != "0"){
							percent.replace(String.valueOf(needInfo.get(j).get("MID_CAT_SEQ")), (percent.get(String.valueOf(needInfo.get(j).get("MID_CAT_SEQ")))+Double.parseDouble(cat_percent)));
						}	
					}
					// ?????? ???????????? ????????? ???????????? ?????? ??? ???????????? ????????? ??????
					if (testInfoM.get(i).get(cat_seq) != null) {
						Double fixedScore = Double.parseDouble(testInfoM.get(i).get(cat_seq))*(Double.parseDouble(cat_percent)/100);
						// ????????? 100?????? ????????? ????????? ??????
						if (total_score != "null" && Double.parseDouble(total_score)!=100) {
							fixedScore = fixedScore * (100/(Double.parseDouble(total_score)));
						}
						if (testInfoM.get(i).get(String.valueOf(needInfo.get(j).get("MID_CAT_SEQ")))== null && needInfo.get(j).get("BIG_CAT_SEQ") != "0" && String.valueOf(needInfo.get(j).get("MID_CAT_SEQ")) != "0") {
							testInfoM.get(i).put(String.valueOf(needInfo.get(j).get("MID_CAT_SEQ")), String.valueOf(Math.round(fixedScore*100)/100.0));
						} else if(testInfoM.get(i).get(String.valueOf(needInfo.get(j).get("MID_CAT_SEQ")))!=null && String.valueOf(needInfo.get(j).get("MID_CAT_SEQ")) != "0" && needInfo.get(j).get("BIG_CAT_SEQ") != "0"){
							fixedScore = Double.parseDouble(testInfoM.get(i).get(String.valueOf(needInfo.get(j).get("MID_CAT_SEQ"))))+Math.round(fixedScore*100)/100.0;
							testInfoM.get(i).replace(String.valueOf(needInfo.get(j).get("MID_CAT_SEQ")), String.valueOf(fixedScore));				
						}
					}
				}
			}
			
			// ????????? ????????? ???????????? ????????? ????????? ?????????
			for (int i = 0; i < testInfoM.size(); i++) {
				for (int j = 0; j < needInfo.size(); j++) {
					if ((!(String.valueOf(needInfo.get(j).get("MID_CAT_SEQ")).equalsIgnoreCase("0"))) || String.valueOf(needInfo.get(j).get("BIG_CAT_SEQ")).equalsIgnoreCase("0")) {
						continue;
					}
					String cat_seq = String.valueOf(needInfo.get(j).get("CAT_SEQ"));
					String cat_percent = String.valueOf(needInfo.get(j).get("CAT_PERCENT"));
					
					if (i==0) {
						if (percent.get(String.valueOf(needInfo.get(j).get("BIG_CAT_SEQ"))) == null) {
							percent.put(String.valueOf(needInfo.get(j).get("BIG_CAT_SEQ")), Double.parseDouble(cat_percent));
						}else {
							percent.replace(String.valueOf(needInfo.get(j).get("BIG_CAT_SEQ")), (percent.get(String.valueOf(needInfo.get(j).get("BIG_CAT_SEQ")))+Double.parseDouble(cat_percent)));
						}	
					}
					if (testInfoM.get(i).get(cat_seq) != null) {
						Double fixedScore = Double.parseDouble(testInfoM.get(i).get(cat_seq))*(Double.parseDouble(cat_percent)/100);
						
						if (testInfoM.get(i).get(String.valueOf(needInfo.get(j).get("BIG_CAT_SEQ")))== null) {
							testInfoM.get(i).put(String.valueOf(needInfo.get(j).get("BIG_CAT_SEQ")), String.valueOf(Math.round(fixedScore*100)/100.0));
						} else {
							fixedScore = Double.parseDouble(testInfoM.get(i).get(String.valueOf(needInfo.get(j).get("BIG_CAT_SEQ"))))+Math.round(fixedScore*100)/100.0;
							testInfoM.get(i).replace(String.valueOf(needInfo.get(j).get("BIG_CAT_SEQ")), String.valueOf(fixedScore));				
						}
					}
				}
				
			}
			// ????????? ??????????????? ?????? percent ????????? ???????????? ?????? ??????????????? ?????? ????????? ?????????
			Iterator<String> keys = percent.keySet().iterator();
        	while (keys.hasNext()){
                	String key = keys.next();					
                for (int i = 0; i < testInfoM.size(); i++) {
                	if (testInfoM.get(i).get(key)==null) {
						continue;
					}
                	double score = Double.parseDouble(testInfoM.get(i).get(key)) * Math.round((100.0/percent.get(key)*100)/100.0);
                	testInfoM.get(i).replace(key, String.valueOf(Math.round(score*100)/100.0));
                } 
			}
			// ???????????? ????????? ????????? ?????? ????????? ?????????
			for (int i = 0; i < testInfoM.size(); i++) {
				for (int j = 0; j < needInfo.size(); j++) {
					if ((!(String.valueOf(needInfo.get(j).get("MID_CAT_SEQ")).equalsIgnoreCase("0"))) || (!(String.valueOf(needInfo.get(j).get("BIG_CAT_SEQ")).equalsIgnoreCase("0")))) {
						continue;
					}
					String cat_seq = String.valueOf(needInfo.get(j).get("CAT_SEQ"));
					String cat_percent = String.valueOf(needInfo.get(j).get("CAT_PERCENT"));
					if (testInfoM.get(i).get(cat_seq) != null) {
						Double fixedScore = Double.parseDouble(testInfoM.get(i).get(cat_seq))*(Double.parseDouble(cat_percent)/100);
						if (testInfoM.get(i).get("TOTAL") == null) {
							testInfoM.get(i).put("TOTAL", String.valueOf(Math.round(fixedScore*100)/100.0));
						} else {
							fixedScore = Double.parseDouble(testInfoM.get(i).get("TOTAL"))+(Math.round(fixedScore*100)/100.0);
							fixedScore = Math.round(fixedScore*100)/100.0;
							testInfoM.get(i).replace("TOTAL", String.valueOf(fixedScore));
						}
					}
				}
			}
			// ??? ????????? null ??? ?????? ??????
			for (int i = 0; i < testInfoM.size(); i++) {
				if (testInfoM.get(i).get("TOTAL") == null) {
					testInfoM.remove(i);
					i--;
				}
			}
			// ?????? ?????? ?????? ????????? ?????? ?????? ??????
			for (int i = 0; i < testInfoM.size(); i++) {
				for (int j = 0; j < memberList.size(); j++) {
					if (String.valueOf(testInfoM.get(i).get("USER_ID")).equalsIgnoreCase(String.valueOf(memberList.get(j).get("USER_ID")))) {
						testInfoM.get(i).put("USER_NM", String.valueOf(memberList.get(j).get("USER_NAME")));
						break;
					}
				}
			}
			
			List<String> cat_nm = new ArrayList<>(); 
			
			for (int i = 0; i < testInfoM.size(); i++) {
				for (int j = 0; j < needInfo.size(); j++) {
					if (testInfoM.get(i).get(String.valueOf(needInfo.get(j).get("CAT_SEQ"))) != null) {
						String score = testInfoM.get(i).get(String.valueOf(needInfo.get(j).get("CAT_SEQ")));
						if (String.valueOf(needInfo.get(j).get("BIG_CAT_SEQ")).equalsIgnoreCase("0") && String.valueOf(needInfo.get(j).get("MID_CAT_SEQ")).equalsIgnoreCase("0")) {
							// ???????????? ??????, ???????????? ???????????? ????????? ??????
							testInfoM.get(i).put(String.valueOf(needInfo.get(j).get("CAT_NM")), score);
							// ?????? ???????????? ????????? ?????? 
							if(i == 0) {
								cat_nm.add(String.valueOf(needInfo.get(j).get("CAT_NM")));
							}
						}
						// ???????????? ?????????????????? category seq??? ??????
						testInfoM.get(i).remove(String.valueOf(needInfo.get(j).get("CAT_SEQ")));
					}
				}
			}
			
//			for (int i = 0; i < testInfoM.size(); i++) {
//				System.out.println("testInfoM ?????? : "+ testInfoM.get(i).toString());
//			}

		HashMap<String,Object> params = new HashMap<>();
		
		params.put("gisu_id", vo.getGisu_id());
		params.put("crc_id", vo.getCrc_id());
		// ??????, ?????? id??? ???????????? ?????? ?????? ????????? ?????????
		List<HashMap<String, String>> grade = infoService.searchGrade(params);
//		System.out.println(grade.toString());
		
		List<HashMap<String, String>> newInfo = new ArrayList<>();
		// ????????? ?????? ????????? ?????? ????????? ??????
		for(int i = 0; i < testInfoM.size(); i++) {
			HashMap<String, String> map = new HashMap<>();
			for(int j = 0; j < grade.size(); j++) {
				if(Double.parseDouble(String.valueOf(grade.get(j).get("START_SCORE"))) > Double.parseDouble(testInfoM.get(i).get("TOTAL")) && Double.parseDouble(String.valueOf(grade.get(j).get("END_SCORE"))) <= Double.parseDouble(testInfoM.get(i).get("TOTAL"))) {
					map.put("TOTAL", grade.get(j).get("GRADE"));
					
				}
			}
			map.put("USER_ID", testInfoM.get(i).get("USER_ID"));
			map.put("USER_NM", testInfoM.get(i).get("USER_NM"));
			map.put("START_DATE", testInfoM.get(i).get("START_DATE"));
			map.put("END_DATE", testInfoM.get(i).get("END_DATE"));
			map.put("COURSE_NAME", memberList.get(0).get("COURSE_NAME"));
			map.put("CARDINAL_NAME", memberList.get(0).get("CARDINAL_NAME"));
			newInfo.add(map);
		}
		// ?????? ???????????? ????????? ?????? ????????? ??????
		for(int i = 0; i < testInfoM.size(); i++) {
			for(int z = 0; z < cat_nm.size(); z++) {
				for(int j = 0; j < grade.size(); j++) {
					if(Double.parseDouble(String.valueOf(grade.get(j).get("START_SCORE"))) > Double.parseDouble(testInfoM.get(i).get(cat_nm.get(z))) && Double.parseDouble(String.valueOf(grade.get(j).get("END_SCORE"))) <= Double.parseDouble(testInfoM.get(i).get(cat_nm.get(z)))) {
						newInfo.get(i).put(cat_nm.get(z), String.valueOf(grade.get(j).get("GRADE")));
					}
				}
			}
		}
		// fail ?????? ?????? ??? ?????????
		int allMember = testInfoM.size();
		// fail ???????????? 0 ??? ????????? ???????????? ??????
		if(!"0".equalsIgnoreCase(String.valueOf(fail.get("Fail")))) {
			allMember += fail.size();
		}
		
		List<HashMap<String, String>> gradeMap = new ArrayList<>();
		
		for(int j = 0; j < grade.size(); j++) {
			HashMap<String, String> map = new HashMap<>();
			int count = 0;
			// ?????? ????????? ????????? ??????
			for(int i = 0; i < newInfo.size(); i++) {
				if(grade.get(j).get("GRADE").equalsIgnoreCase(newInfo.get(i).get("TOTAL"))) {
					count++;
				}
			}
//			System.out.println("count = " + count);
			// ?????? ????????? ????????? ????????? ??? ?????? ??????????????? ??????????????? ??????
			double ratio = (double)count/allMember;
			double ratio2 = ratio*100.0;
			String gradeR = String.valueOf(Math.round(ratio2*100)/100.0);
			// ?????? ????????? ?????? ????????? ??????
			map.put(grade.get(j).get("GRADE"), gradeR);
			
			gradeMap.add(map);
		}
		// fail ????????? ?????? ?????? ??????
		double ratio = (Double.parseDouble(fail.get("Fail"))/allMember)*100.0;
		fail.put("Fail", String.valueOf(Math.round(ratio*100)/100.0));
		gradeMap.add(fail);
		
		HashMap<String, String> user = new HashMap<>();
		// ????????? ???????????? ????????? ?????? ????????? ??????
		for(int i = 0; i < newInfo.size(); i++) {
			if(newInfo.get(i).get("USER_ID").equalsIgnoreCase(userId)) {
				user = newInfo.get(i);
			}
		}
		
		//System.out.println("user = " + user.toString());
		//System.out.println("grade = " + gradeMap.toString());
		// ?????? ????????? ????????? ?????????
		HashMap<String, Object> memberInfo = userDao.selectMemberInfo((String)user.get("USER_ID"));
		// ?????? ????????? ??????????????? ?????? ????????? ??????
		if(memberInfo != null) user.put("USER_BIRTH", memberInfo.get("USER_BIRTH").toString());
		
		Gson userG = new Gson();
		Gson gradeG = new Gson();
		// ????????? ?????? ??????, ?????? ?????? ?????? ??????, ?????? ?????? ??????
		model.addAttribute("result", user.isEmpty());
		model.addAttribute("user", userG.toJson(user));
		model.addAttribute("grade", gradeG.toJson(gradeMap));
		logger.info("????????? ????????? ???????????? ??????");
		
		return "popup/sub05-view-transcript";
	}
	
	@RequestMapping(value = "/smtp/user/printCertificate", method = RequestMethod.POST)
	public String printCertificate (String cardinal_id, Model model, HttpSession session) {
		
		logger.info("????????? ?????? ???????????? ??????");
		
		String user_id = (String) session.getAttribute("user_id");
		
		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("cardinal_id", cardinal_id);
		params.put("user_id", user_id);
		
		Gson certificateG = new Gson();
		Gson userG = new Gson();
		
		List<HashMap<String, Object>> certificateInfo = lecService.smtpSelectCompleteList(params);
		HashMap<String, Object> userInfo = userDao.selectMemberInfo(user_id);
		
		model.addAttribute("certificateInfo", certificateG.toJson(certificateInfo));
		model.addAttribute("userInfo", userG.toJson(userInfo));
		
		logger.info("????????? ?????? ???????????? ??????");
		
		return "popup/sub05-view-certificate_completion";
	}
	
	@RequestMapping(value = "/smtp/user/printTrainingCertificate", method = RequestMethod.POST)
	public String printTrainingCertificate (String cardinal_id, Model model, HttpSession session) {
		
		logger.info("??????????????? ?????? ???????????? ??????");
		
		String user_id = (String) session.getAttribute("user_id");
		
		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("cardinal_id", cardinal_id);
		params.put("user_id", user_id);
		
		Gson certificateG = new Gson();
		Gson userG = new Gson();
		
		List<HashMap<String, Object>> result = lecService.smtpSelectProgressList(params);
		HashMap<String, Object> userInfo = userDao.selectMemberInfo(user_id);
		userInfo.put("user_birth", userInfo.get("USER_BIRTH").toString());
		model.addAttribute("certificateInfo", certificateG.toJson(result));
		model.addAttribute("userInfo", userG.toJson(userInfo));
		
		logger.info("??????????????? ?????? ???????????? ??????");
		
		return "popup/sub05-view-certificate_training";
	}
	
	@RequestMapping(value="/smtp/user/certiSubmit", method=RequestMethod.POST)
 	public String certiSubmit(Authentication auth, Model model, String courseId, String cardinalId, String attDate) {
 		
 		String userName = auth.getName();
 		
 		HashMap<String, Object> paramMap = new HashMap<>();
 		
 		paramMap.put("user_id", userName);
 		paramMap.put("course_id", courseId);
 		paramMap.put("cardinal_id", cardinalId);
 		paramMap.put("att_date", attDate);
 		
 		HashMap<String, Object> infoTime = infoService.getInfoTime(paramMap);
 		List<HashMap<String, Object>> infoList = infoService.getInfoList(paramMap);
 		
// 		System.out.println("Info Time Check : " + infoTime.toString());
 		
 		for(int i=0; i<infoList.size(); i++) {
// 			System.out.println("Info List Check : " + infoList.get(i).toString());
 		}
 		
 		model.addAttribute("infoTime", infoTime);
 		model.addAttribute("infoList", infoList);
 		model.addAttribute("filelink", "user/attendance/cert");
 		
 		return "popup/certiSubmit";
 	}
	
	@ResponseBody
	@RequestMapping(value="/smtp/user/subCertification", method=RequestMethod.POST)
	public void subCertification(AttendanceInfoTime infoTime) {
		
		System.out.println("Info Time VO Check : " + infoTime.toString());
		
		infoService.subCertification(infoTime);
	}
    
	@ResponseBody
	@RequestMapping(value="/smtp/user/deleteCertification", method=RequestMethod.POST)
	public void deleteCertification(AttendanceInfoTime infoTime) {
		
		//System.out.println("Info Time VO Check : " + infoTime.toString());
		
		infoService.deleteCertification(infoTime);
	}
}
