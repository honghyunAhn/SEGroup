package com.aracomm.changbi.mypage.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.MessageSource;
//import org.springframework.security.web.util.TextEscapeUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.aracomm.base.common.AraCommConst;
import com.aracomm.base.common.vo.FileVo;
import com.aracomm.base.exceptions.UserControlException;
import com.aracomm.changbi.common.GlobalConst;
import com.aracomm.changbi.common.dao.CommonDao;
import com.aracomm.changbi.member.dao.PointDao;
import com.aracomm.changbi.mypage.dao.BookAppDao;
import com.aracomm.changbi.mypage.dao.CouponDao;
import com.aracomm.changbi.mypage.dao.LectureDao;
import com.aracomm.changbi.mypage.vo.SurveyResVo;
import com.aracomm.changbi.payment.KcpCommonReturnParam;
import com.aracomm.changbi.payment.KcpPaymentParam;
import com.aracomm.changbi.payment.dao.KcpPaymentDao;
import com.aracomm.changbi.payment.service.KcpCommonReturnSavableService;
import com.aracomm.changbi.user.dao.MyLectureInfoDao;
import com.aracomm.changbi.user.vo.SurveyAnswerVO;

import ch.qos.logback.classic.Logger;
import global.segroup.util.FileService;

@Service
public class LectureService extends KcpCommonReturnSavableService {

	@Autowired
	private LectureDao dao;

	@Autowired
	private CouponDao couponDao;

	@Autowired
	private PointDao pointDao;

	@Autowired
	private CommonDao commonDao;

	@Autowired
	private KcpPaymentDao kcpPaymentDao;

	@Autowired
	private BookAppDao bookAppDao;

	@Autowired
	MessageSource messageSource;
	
	@Autowired
	private MyLectureInfoDao infodao;
	
	@Value("#{config['upload.subdir.report']}")
	private String report_upload_sub_dir;

	public HashMap<String,Object> selectPointInfo(HashMap<String, Object> params) {
		return dao.selectPointInfo(params);
	}

	public HashMap<String,Object> selectCouponInfo(HashMap<String, Object> params) {
		return couponDao.selectCouponInfo(params);
	}

	public HashMap<String,Object> selectUserInfo(HashMap<String, Object> params) {
		return dao.selectUserInfo(params);
	}

	public List<HashMap<String,Object>> selectProgressList(HashMap<String, Object> params) {
		return dao.selectProgressList(params);
	}

	public List<HashMap<String,Object>> selectWaitingList(HashMap<String, Object> params) {
		return dao.selectWaitingList(params);
	}

	public List<HashMap<String,Object>> selectCompleteList(HashMap<String, Object> params) {
		return dao.selectCompleteList(params);
	}

	public HashMap<String,Object> selectClassInfo(HashMap<String, Object> params) {
		return dao.selectClassInfo(params);
	}

	public HashMap<String,String> selectTimeInfo(HashMap<String, Object> params) {
		HashMap<String,String> result = new HashMap<>();
		result.put("TOT_LEARN_TIME", dao.selectTotLearnTime(params));
		result.put("AVG_LEARN_TIME", dao.selectAvgLearnTime(params));
		result.put("BASE_LEARN_TIME", dao.selectBaseLearnTime(params));

		return result;
	}

	public HashMap<String,Object> selectJinfoInfo(HashMap<String, Object> params) {
		HashMap<String,Object> result = new HashMap<>();
		result.put("USER_JINDO", dao.selectUserJindo(params));
		result.put("BASE_JINDO", dao.selectBaseJindo(params));

		return result;
	}

	public List<HashMap<String, Object>> selectJindoList(HashMap<String, Object> params) {
		return dao.selectJindoList(params);
	}

	public HashMap<String,Object> selectClassStudyHist(HashMap<String, Object> params) {
		HashMap<String,Object> result = new HashMap<>();

		HashMap<String,Object> studyHist = dao.selectClassStudyHist(params);
		result.put("ACCESS_COUNT", String.valueOf(studyHist.get("ACCESS_COUNT")));
		result.put("START_DATE", studyHist.get("START_DATE"));
		result.put("END_DATE", studyHist.get("END_DATE"));
		result.put("AVG_CHAPTER_TIME", dao.selectClassAvgStudyTime(params));
		result.put("AVG_JINDO", dao.selectClassAvgChapter(params));

		return result;
	}

	public List<HashMap<String,Object>>  selectChapterList(HashMap<String, Object> params) {
		List<HashMap<String,Object>> result = dao.selectChapterList(params);
		return result;
	}

	public HashMap<String,Object> selectChapterInfo(HashMap<String, Object> params) {
		return dao.selectChapterInfo(params);
	}

	public void insertStudyHistory(HashMap<String, Object> params) {
		HashMap<String, Object> classInfo =  dao.selectClassInfo(params);
		HashMap<String, Object> chapterInfo = dao.selectChapterInfo(params);

		HashMap<String, String> attLecCheckInfo = dao.selectAttLec(params);
		if (attLecCheckInfo == null) { //첫수강인 경우에 해당 테이블에 insert 작업을 진행함.

			params.put("study", String.valueOf(chapterInfo.get("STUDY")));
			params.put("chk", String.valueOf(chapterInfo.get("CHK")));
			dao.insertAttLec(params);
			dao.insertAttLecHist(params);
		}
	}

	public void updateStudyHistory(HashMap<String, Object> params) {
		HashMap<String,Object> chapterInfo = dao.selectChapterInfo(params);
		if (chapterInfo == null) {
			params.put("chk", 0);
		} else {
			params.put("chk", chapterInfo.get("CHK")!=null?chapterInfo.get("CHK"):"0");
		}

		HashMap<String, String> attLecCheckInfo = dao.selectAttLec(params);
		if (attLecCheckInfo == null) {
			params.put("learn_time", 0);
		} else {
			params.put("learn_time",  attLecCheckInfo.get("LEARN_TIME")!=null?attLecCheckInfo.get("LEARN_TIME"):"0");
		}

		dao.updateAttLec(params);
		dao.updateAttLecHist(params);
	}

	public List<HashMap<String, Object>> selectExamList(HashMap<String, Object> params) {
		List<HashMap<String, Object>> result = dao.selectExamList(params);
		//온라인 과제의 경우 첨삭지도 데이터 추가
//		if (GlobalConst.QUIZ_REPORT.equals(params.get("quiz_type"))) {
//			for (HashMap<String, Object> hashMap : result) {
//				hashMap.putAll(params);
//				List<HashMap<String, Object>> copyRatioList = dao.selectCopyRatioList(hashMap);
//				hashMap.put("copyRatioList", copyRatioList);
//			}
//		}

		return result;
	}

	public List<HashMap<String, Object>> selectExamItemList(HashMap<String, Object> params) {
		return dao.selectExamItemList(params);
	}

	@Transactional
	public String insertExamItemReply(HashMap<String, Object> params, /*List<FileVo> fileList*/List<MultipartFile> reportfile) {
		/*재응시인 경우 기존 입력된 데이터 삭제처리 후 저장 로직 실행 */
		HashMap<String, Object> reportResult = dao.selectReportInfo(params);
		
		if(params.get("quiz_type").equals("3")) {
			if (reportResult != null && reportResult.get("ID") != null) {//기존 입려된 데이터가 있는 경우.
				HashMap<String, Object> deleteMap  = new HashMap<>();
				deleteMap.put("id", reportResult.get("ID"));
				deleteMap.put("user_id", params.get("user_id"));
				deleteMap.put("learn_app_id", params.get("id"));
				deleteMap.put("course_id", params.get("course"));
				deleteMap.put("cardinal_id", params.get("cardinal"));
				deleteMap.put("quiz_id", params.get("quiz"));

				dao.deleteExamReport(deleteMap);
				dao.deleteExamReply(deleteMap);
			}
		}
		
		/*CB_QUIZ_ITEM의 필드를 기준으로 CB_QUIZ_REPLY에 insert 필요*/
		params.put("answeryn", "Y");//조회시 정답여부를 포함시킴
		List<HashMap<String, Object>>  itemList = dao.selectExamItemList(params);
		HashMap<String, Object> quizInfo = dao.selectExamInfo(params);

		//문항별 목록
		List<HashMap<String, Object>> answerList = new ArrayList<>();
		//종합 채점 점수 합계 데이터
		HashMap<String, Object> reportMap = new HashMap<>();
		int totalScore = 0;

		//for문을 돌려 문항별로 채점 및 데이터를 생성한다.
		for (int i = 0; i < itemList.size(); i++) {
			HashMap<String, Object> quiz = itemList.get(i);

			HashMap<String, Object> answerMap = new HashMap<String, Object>();
			answerMap.put("userid", (String)params.get("user_id"));
			answerMap.put("bank", String.valueOf(quiz.get("QUIZ_BANK_ID")));
			answerMap.put("item", String.valueOf(quiz.get("ID")));
			answerMap.put("ostype", quiz.get("OS_TYPE"));
			answerMap.put("comment", quiz.get("COMMENT"));
			answerMap.put("title", quiz.get("TITLE"));
			answerMap.put("ordernum", String.valueOf(i+1));
			answerMap.put("useyn", "Y");
			answerMap.put("pscore", String.valueOf(quizInfo.get("ITEM_SCORE")));

			if (quiz.get("OS_TYPE").equals(GlobalConst.EXAM_TYPE_CHOICE)) { //객관식
				String oAnswer = String.valueOf(quiz.get("O_ANSWER")).trim(); //문제정답
				String uAnswer = params.get("answer" + String.valueOf(i+1))== null?"0":String.valueOf(params.get("answer" + String.valueOf(i+1))).trim(); //제출정답

				answerMap.put("oanswer", oAnswer);
				answerMap.put("oreply", uAnswer);

				//정답여부에 따라 채점진행
				if (oAnswer.equals(uAnswer)) {
					answerMap.put("tscore", answerMap.get("pscore"));
				} else {
					answerMap.put("tscore", "0");
				}

				totalScore += Integer.parseInt((String) answerMap.get("tscore"));
			} else { //주관식
				//별도의 채점진행없이 진행.
				answerMap.put("sanswer", String.valueOf(quiz.get("S_ANSWER")));
				answerMap.put("sreply", String.valueOf(params.get("answer" + String.valueOf(i+1))));
				answerMap.put("tscore", "0");
			}

			answerList.add(answerMap);
		}

	/*	//제출파일이 있는경우 처리 진행.
		if (fileList != null && fileList.size() > 0) {
			for(int i=0; i<fileList.size(); i++) {
				FileVo fileVo = fileList.get(i);
				commonDao.insertAttachFile(fileVo);
				commonDao.insertAttachFileDetail(fileVo);
			}
			reportMap.put("fileid", params.get("fileid"));
		}*/
		
		String fullPath = "/" + params.get("user_id") + "_" + String.valueOf(params.get("cardinal"));
		
		if (reportfile != null && reportfile.size() > 0) {			
			for(int i = 0; i < reportfile.size(); i++) {
				String oldsaved = (String)params.get("saved"+String.valueOf(i+1));
				String oldorigin = (String)params.get("original"+String.valueOf(i+1));
				System.out.println("olds = " + oldsaved);
				System.out.println("oldo = " + oldorigin);
				
				MultipartFile file = reportfile.get(i);
				
				if(!file.isEmpty()) {
					FileService.deleteFile(oldsaved, report_upload_sub_dir+fullPath);
					
					String saved = FileService.saveFile(file, report_upload_sub_dir+fullPath);
					System.out.println("저장명 = " + saved);
					params.put("original"+String.valueOf(i+1), file.getOriginalFilename());
					params.put("saved"+String.valueOf(i+1), saved);
				}
			}
		}
		
		//채점점수 종합 데이터 저장
		reportMap.put("cardinal", params.get("cardinal"));
		reportMap.put("course", params.get("course"));
		reportMap.put("user_id", params.get("user_id"));
		reportMap.put("id", params.get("id"));
		reportMap.put("quiz", params.get("quiz"));
		reportMap.put("quiztype", quizInfo.get("QUIZ_TYPE"));
		
		if(totalScore > 100) {
			reportMap.put("score", String.valueOf(100));
		} else {
			reportMap.put("score", String.valueOf(totalScore));
		}
		
		reportMap.put("useyn", "Y");
		reportMap.put("markyn", quizInfo.get("QUIZ_TYPE").equals(GlobalConst.QUIZ_EXAM)?"Y":"N");
		reportMap.put("submit", "Y");
		
		//종합 데이터 저장
		if(params.get("quiz_type").equals("2")) {
			reportMap.put("report_id", reportResult.get("ID"));
			infodao.updateReport(reportMap);
		} else {
			dao.insertExamReport(reportMap);
		}
		
		//문항별로 데이터 저장
		int i = 0;
		for (HashMap<String, Object> answer : answerList) {
			answer.put("report", String.valueOf(reportMap.get("id")));
			answer.put("user_id", params.get("user_id"));
			
			if(answer.get("ostype").equals("S")) {
				answer.put("original", params.get("original"+String.valueOf(i+1)));
				answer.put("saved", params.get("saved"+String.valueOf(i+1)));
				i++;
			}
			System.out.println("수정 확인 = " + answer.toString());
			if(params.get("quiz_type").equals("3")) {
				//infodao.updateReportReply(answer);
				dao.insertExamReply(answer);
			}
		}

		return AraCommConst.TEXT_SUCCESS;
	}

	public HashMap<String, Object> selectExamInfo(HashMap<String, Object> params) {
		return dao.selectExamInfo(params);
	}

	public int selectExamTakeCount(HashMap<String, Object> params) {
		return dao.selectExamTakeCount(params);
	}
	
	public int insertExamTakeHistory(HashMap<String, Object> params) {
		return dao.insertExamTakeHistory(params);
	}

	public List<HashMap<String, Object>> selectSurveyDetail(HashMap<String, Object> params) {
		return dao.selectSurveyDetail(params);
	}
	
	public int insertSurveyAnswer(List<SurveyAnswerVO> list) {
		return dao.insertSurveyAnswer(list);
	}
	
	public int updateSurveyAnswer(List<SurveyAnswerVO> list) {
		return dao.updateSurveyAnswer(list);
	}
	
	public int insertSurveyComplete(SurveyAnswerVO vo) {
		return dao.insertSurveyComplete(vo);
	}
	
	public HashMap<String, Object>  selectBookInfo(HashMap<String, Object> params) {
		HashMap<String, Object> result = new HashMap<>();

		result.put("PAY_CHECK", dao.selectBookPayCheck(params));
		result.put("DELIVERY_CHECK", dao.selectBookDeliveryCheck(params));
		result.put("PAYMENT", dao.selectBookPayment(params));

		return result;
	}

	public String editLocaleCode(HashMap<String, Object> params) {
		StringBuilder sb = new StringBuilder();
		sb.append(params.get("des1"));
		sb.append("-");
		sb.append(params.get("des2"));
		sb.append("-");
		sb.append(params.get("des3"));
		sb.append("-");
		sb.append(params.get("des4"));

		params.put("des_num", sb.toString());

		dao.updateLocaleCode(params);

		return AraCommConst.TEXT_SUCCESS;
	}

	public List<HashMap<String,Object>> selectOrderBookList(HashMap<String, Object> params) {
		return dao.selectOrderBookList(params);
	}

	public int selectLessonReviewCnt(HashMap<String, Object> params) {
		return dao.selectLessonReviewCnt(params);
	}

	public int insertLessonReview(HashMap<String, Object> params) {
		int rst = dao.insertLessonReview(params);

		/*연수후기 작성시 과정별 1회 포인트 지급*/
		if (rst > 0) {
			//포인트 정책에 의함.
			Map<String, Object> pointPolicy = pointDao.selectPolicyPoint();
			if (pointPolicy != null) {
				String useYn = (String) pointPolicy.get("SAVE_TRAIN_USE");
				if ("Y".equals(useYn)) {
					int save_train_point = (int) pointPolicy.get("SAVE_TRAIN_POINT");

					Map<String, Object> point = new HashMap<String, Object>();
					point.put("user_id", params.get("user_id"));
					point.put("learn_app_id", params.get("id"));
					point.put("give", save_train_point);
					point.put("withdraw", 0);
					point.put("note", messageSource.getMessage("point.trainSave", null, "point.trainSave", Locale.getDefault()));
					pointDao.insertPoint(point);
				}
			}
		}

		return rst;
	}

	public HashMap<String, Object> selectClassPollInfo(HashMap<String, Object> params) {
		return dao.selectClassPollInfo(params);
	}

	public List<HashMap<String, Object>> selectClassPollList(HashMap<String, Object> params) {
		return dao.selectClassPollList(params);
	}

	public int insertSurveyResponse(SurveyResVo resVO) {
		HashMap<String, Object> params = new HashMap<>();
		params.put("list", resVO.getSurvey());

		return dao.insertSurveyResponse(params);
	}

	public HashMap<String, Object> selectReportInfo(HashMap<String, Object> params) {
		return dao.selectReportInfo(params);
	}

	public List<HashMap<String, Object>> selectExamSpotList(HashMap<String, Object> params) {
		return dao.selectExamSpotList(params);
	}

	public String saveExamSpot(HashMap<String, Object> params, List<FileVo> fileList) {
		if (fileList != null && fileList.size() > 0) {
			for(int i=0; i<fileList.size(); i++) {
				FileVo fileVo = fileList.get(i);
				commonDao.insertAttachFile(fileVo);
				commonDao.insertAttachFileDetail(fileVo);
			}
		}

		dao.insertExamSpot(params);

		return AraCommConst.TEXT_SUCCESS;
	}

	public HashMap<String, Object> selectExamPrintInfo(HashMap<String, Object> params) {
		return dao.selectExamPrintInfo(params);
	}

	public int saveBookApp(HashMap<String, String> params, KcpPaymentParam kcpPaymentParam) {
		int affected = insertBookApp(params);

		if (affected > 0) kcpPaymentParam.setBsucc(KcpPaymentParam.BSUCC_SUCCESS);
		else kcpPaymentParam.setBsucc(KcpPaymentParam.BSUCC_FAIL);
		kcpPaymentDao.insertKcpPayment(kcpPaymentParam);

		return affected;
	}

	public int insertBookApp(HashMap<String, String> params) {
		return bookAppDao.insertBookApp(params);
	}

	public List<HashMap<String, Object>> selectExamReplyList(HashMap<String, Object> params) {
		return dao.selectExamReplyList(params);
	}

	@Override
	@Transactional
	public int updateVbankReturn(KcpCommonReturnParam kcpCommonReturnParam) throws UserControlException {
		int affected = 0;

		// 신청정보 결제 상태 업데이트
		bookAppDao.updateDonePayment(kcpCommonReturnParam.getAppId());

		// 결제내역 통보정보 업데이트
		affected = kcpPaymentDao.updateVankKcpReturn(kcpCommonReturnParam);

		return affected;
	}

	@Transactional
	public int updateCancelWaitingApp(HashMap<String, Object> params) {
		// 수강신청시 포인트 환원
		Map<String, Object> pointParam = new HashMap<String, Object>();
		pointParam.put("learn_app_id", params.get("id"));
		pointParam.put("note", messageSource.getMessage("point.applyCancel", null, "point.applyCancel", Locale.getDefault()));
		pointDao.insertPointForApplyCancel(pointParam);

		return dao.updateCancelWaitingApp(params);
	}
	
	@Transactional
	public String InitiateExam(HashMap<String, Object> params) {
		/*CB_QUIZ_ITEM의 필드를 기준으로 CB_QUIZ_REPLY에 insert 필요*/
		params.put("answeryn", "Y");//조회시 정답여부를 포함시킴
		List<HashMap<String, Object>>  itemList = dao.selectExamItemList(params);
		HashMap<String, Object> quizInfo = dao.selectExamInfo(params);

		//문항별 목록
		List<HashMap<String, Object>> answerList = new ArrayList<>();
		//종합 채점 점수 합계 데이터
		HashMap<String, Object> reportMap = new HashMap<>();

		//for문을 돌려 문항별로 채점 및 데이터를 생성한다.
		for (int i = 0; i < itemList.size(); i++) {
			HashMap<String, Object> quiz = itemList.get(i);

			HashMap<String, Object> answerMap = new HashMap<String, Object>();
			answerMap.put("userid", (String)params.get("user_id"));
			answerMap.put("bank", String.valueOf(quiz.get("QUIZ_BANK_ID")));
			answerMap.put("item", String.valueOf(quiz.get("ID")));
			answerMap.put("ostype", quiz.get("OS_TYPE"));
			answerMap.put("comment", quiz.get("COMMENT"));
			answerMap.put("title", quiz.get("TITLE"));
			answerMap.put("ordernum", String.valueOf(i+1));
			answerMap.put("useyn", "Y");
			answerMap.put("pscore", String.valueOf(quizInfo.get("ITEM_SCORE")));

			String oAnswer = String.valueOf(quiz.get("O_ANSWER")).trim(); //문제정답
			String uAnswer = "0";
			
			answerMap.put("oanswer", oAnswer);
			answerMap.put("oreply", uAnswer);
			answerMap.put("tscore", "0");

			answerList.add(answerMap);
		}
		
		//채점점수 종합 데이터 저장
		reportMap.put("cardinal", params.get("cardinal"));
		reportMap.put("course", params.get("course"));
		reportMap.put("user_id", params.get("user_id"));
		reportMap.put("id", params.get("id"));
		reportMap.put("quiz", params.get("quiz"));
		reportMap.put("quiztype", quizInfo.get("QUIZ_TYPE"));
		reportMap.put("score", String.valueOf(0));
		reportMap.put("useyn", "Y");
		reportMap.put("markyn", "N");
		reportMap.put("submit", "N");

		//종합 데이터 저장
		dao.insertExamReport(reportMap);

		//문항별로 데이터 저장
		for (HashMap<String, Object> answer : answerList) {
			answer.put("report", String.valueOf(reportMap.get("id")));
			answer.put("user_id", params.get("user_id"));
			
			dao.insertExamReply(answer);
			
		}

		return AraCommConst.TEXT_SUCCESS;
	}
}
