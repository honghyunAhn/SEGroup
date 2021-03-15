/**
 * 
 */
package global.segroup.society.edu.apply.controller;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;

import global.segroup.domain.BoardPager;
import global.segroup.domain.FaqConsultingContents;
import global.segroup.domain.OfflineConsultingContents;
import global.segroup.domain.OnlineConsultingContents;
import global.segroup.service.SEGroupCommonService;
import global.segroup.society.edu.admin.domain.SocietyEduAdminCurriculumGisu;
import global.segroup.society.edu.admin.service.SocietyEduAdminService;
import global.segroup.society.edu.apply.domain.SocietyEduApplyCareer;
import global.segroup.society.edu.apply.domain.SocietyEduApplyEduHistory;
import global.segroup.society.edu.apply.domain.SocietyEduApplyFile;
import global.segroup.society.edu.apply.domain.SocietyEduApplyForm;
import global.segroup.society.edu.apply.domain.SocietyEduApplyLanguage;
import global.segroup.society.edu.apply.domain.SocietyEduApplyLicense;
import global.segroup.society.edu.apply.domain.SocietyEduApplyOverseas;
import global.segroup.society.edu.apply.domain.SocietyEduApplyStudy;
import global.segroup.society.edu.apply.service.SocietyEduApplyService;
import global.segroup.util.PathConstants;

/**
 * @Author : 이종호
 * @Date : 2017. 7. 26.
 * @Class 설명 : Soft Engineer Society 모집홍보 지원신청 View 컨트롤러
 * 
 */
@Controller
public class SocietyEduApplyViewController implements PathConstants {

	private static final Logger logger = LoggerFactory.getLogger(SocietyEduApplyViewController.class);
	
	@Autowired
	private SocietyEduApplyService seaService;
	@Autowired
	private SocietyEduAdminService seAdminService;
	@Autowired
	private SEGroupCommonService sgcService;

	/**
	 * file.propertices 의 등록된 모집홍보 공지사항 파일 경로
	 */
	@Value("#{props['edu.apply.board_file']}")
	private String eduApplyBoardFile;

	/**
	 * file.propertices 의 등록된 과정 기수 등록 이미지 파일 경로
	 */
	@Value("#{props['edu.apply.curriculum_gisu_insert_image']}")
	private String eduApplyCurriculumGisuInsertImage;
	
	/**
	 * @Method Name : apply_main
	 * @Date : 2017. 9. 4.
	 * @User : 이종호
	 * @Param : -
	 * @Return : JSP 리턴페이지(모집홍보 지원신청 서브페이지)
	 * @Method 설명 : 모집홍보 지원신청 서브페이지를 호출하는 컨트롤러 함수
	 */
	@RequestMapping(value = PathConstants.SOCIETY_EDU_APPLY_MAIN, method = RequestMethod.GET)
	public String apply_main(){
		return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_EDU_APPLY_MAIN;
	}
	
	/**
	 * @Method Name : apply_guide
	 * @Date : 2017. 9. 4.
	 * @User : 이종호
	 * @Param : -
	 * @Return : JSP 리턴페이지(모집홍보의 마스터 안내 페이지)
	 * @Method 설명 : 모집홍보 마스터 안내 페이지를 호출하는 컨트롤러 함수
	 */
	@RequestMapping(value = PathConstants.SOCIETY_EDU_APPLY_GUIDE, method = RequestMethod.GET)
	public String apply_guide(){
		return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_EDU_APPLY_GUIDE;
	}
	
	/**
	 * @Method Name : apply_priorEdu
	 * @Date : 2017. 9. 4.
	 * @User : 이종호
	 * @Param : -
	 * @Return : JSP 리턴페이지(모집홍보의 사전교육페이지)
	 * @Method 설명 : 모집홍보 사전교육 페이지를 호출하는 컨트롤러 함수
	 */
	@RequestMapping(value = PathConstants.SOCIETY_EDU_APPLY_PRIOREDU, method = RequestMethod.GET)
	public String apply_priorEdu(){
		return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_EDU_APPLY_PRIOREDU;
	}
	
	/**
	 * @Method Name : apply_teacher
	 * @Date : 2017. 9. 4.
	 * @User : 이종호
	 * @Param : -
	 * @Return : JSP 리턴페이지(모집홍보의 교수진 정보 페이지)
	 * @Method 설명 : 모집홍보 교수진 정보 페이지를 호출하는 컨트롤러 함수
	 */
	@RequestMapping(value = PathConstants.SOCIETY_EDU_APPLY_TEACHER, method = RequestMethod.GET)
	public String apply_teacher(){
		return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_EDU_APPLY_TEACHER;
	}
	
	/**
	 * @Method Name : apply_gallary
	 * @Date : 2017. 9. 6.
	 * @User : 이종호
	 * @Param : -
	 * @Return : JSP 리턴 페이지(모집홍보의 겔러리 페이지)
	 * @Method 설명 : 모집홍보 겔러리 페이지를 호출하는 컨트롤러 함수
	 */
	@RequestMapping(value = PathConstants.SOCIETY_EDU_APPLY_GALLARY, method = RequestMethod.GET)
	public String apply_gallary(){
		return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_EDU_APPLY_GALLARY;
	}
	
	/**
	 * @Method Name : community_notice
	 * @Date : 2017. 9. 6.
	 * @User : 이종호
	 * @Param : -
	 * @Return : JSP 리턴 페이지(모집홍보의 공지사항 페이지)
	 * @Method 설명 : 모집홍보 공지사항 페이지를 호출하는 컨트롤러 함수
	 */
	@RequestMapping(value = PathConstants.SOCIETY_EDU_COMMUNITY_NOTICE, method = RequestMethod.GET)
	public String apply_notice(Model model, Authentication auth,@RequestParam(defaultValue="contents") String searchOption,
            @RequestParam(defaultValue="") String keyword,
            @RequestParam(defaultValue="1") int curPage){
		BoardPager.setBLOCK_SCALE(25);
		BoardPager.setPAGE_SCALE(10);
		String boardSeq="8";
		int count=seaService.countBoard(searchOption,keyword,boardSeq);
		BoardPager boardPager = new BoardPager(count, curPage);
		
		int start = boardPager.getPageBegin();
		int end = boardPager.getPageEnd();
		
		ArrayList<HashMap<String, Object>> boardList = (ArrayList<HashMap<String, Object>>) seaService.boardListAll(start, end, searchOption, keyword, boardSeq);

		 Map<String, Object> map = new HashMap<String, Object>();
		    map.put("count", count); // 레코드의 갯수
		    map.put("searchOption", searchOption); // 검색옵션
		    map.put("keyword", keyword); // 검색키워드
		    map.put("boardPager", boardPager);
		    
		    for(int i=0;i<boardList.size();i++){
				
		    	String contents=  (((String) (boardList.get(i).get("board_content_title"))).replaceAll("\\<.*?>", "").substring(0,
						Math.min(((String) boardList.get(i).get("board_content_title")).replaceAll("\\<.*?>", "").length(), 150)));
		    	  if(contents.length()>61){
				    	contents=contents.substring(0,Math.min(contents.length(), 60));
				    	contents+="....";
				    }
		    	  boardList.get(i).put("board_content_title", contents);        
			}
		    
		    
		    
		    model.addAttribute("boardList", boardList);
			model.addAttribute("map", map);
		return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_EDU_COMMUNITY_NOTICE;
	}
	
	/**
	 * @Method Name : community_notice_detail
	 * @Date : 2017. 11. 16.
	 * @User : 전상수
	 * @Param : -
	 * @Return : JSP 리턴 페이지(이미지 게시판 내용보기 페이지)
	 * @Method 설명 : 이미지 내용보기 페이지를 호출하는 컨트롤러 함수
	 */
	@RequestMapping(value = PathConstants.SOCIETY_EDU_COMMUNITY_NOTICE_DETAIL, method = RequestMethod.GET)
	public String apply_notice_detail(Model model, Authentication auth, String seq, String searchOption,HttpServletRequest request){

		logger.debug("공지사항 게시판을 내용을 호출하는 컨트롤러 시작");
		try{
		seaService.boardHit(Integer.parseInt(seq));
		}catch(Exception e){
			e.printStackTrace();
		}
		HashMap<String, Object> detail = null;
		if(searchOption==null){
			detail= seaService.boardDetail(seq,"8");
		} else if(searchOption.equals("next")
				|| searchOption.equals("previous")){
			detail= seaService.boardDetail(seq, searchOption, "8");	
		}
		if(detail==null){
			String referer = request.getHeader("Referer");
		    return "redirect:"+ referer;
		}
		
		ArrayList<HashMap<String, Object>> files = null;
		files=seaService.boardFiles(detail.get("board_content_seq").toString());
		
		model.addAttribute("boardDetail", detail);
		model.addAttribute("files", files);
		model.addAttribute("path", eduApplyBoardFile);
		logger.debug("공지사항 게시판을 내용을 호출하는 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_EDU_COMMUNITY_NOTICE_DETAIL;
	}
	
	/**
	 * @Method Name : community_notice
	 * @Date : 2017. 9. 6.
	 * @User : 이종호
	 * @Param : -
	 * @Return : JSP 리턴 페이지(모집홍보의 공지사항 페이지)
	 * @Method 설명 : 모집홍보 공지사항 페이지를 호출하는 컨트롤러 함수
	 */
	@RequestMapping(value = PathConstants.SOCIETY_EDU_COMMUNITY_NOTICE2, method = RequestMethod.GET)
	public String apply_notice2(Model model, Authentication auth,@RequestParam(defaultValue="contents") String searchOption,
            @RequestParam(defaultValue="") String keyword,
            @RequestParam(defaultValue="1") int curPage){
		BoardPager.setBLOCK_SCALE(25);
		BoardPager.setPAGE_SCALE(10);
		String boardSeq="20";
		int count=seaService.countBoard(searchOption,keyword,boardSeq);
		BoardPager boardPager = new BoardPager(count, curPage);
		
		int start = boardPager.getPageBegin();
		int end = boardPager.getPageEnd();
		
		ArrayList<HashMap<String, Object>> boardList = (ArrayList<HashMap<String, Object>>) seaService.boardListAll(start, end, searchOption, keyword, boardSeq);

		 Map<String, Object> map = new HashMap<String, Object>();
		    map.put("count", count); // 레코드의 갯수
		    map.put("searchOption", searchOption); // 검색옵션
		    map.put("keyword", keyword); // 검색키워드
		    map.put("boardPager", boardPager);
		    
		    for(int i=0;i<boardList.size();i++){
				
		    	String contents=  (((String) (boardList.get(i).get("board_content_title"))).replaceAll("\\<.*?>", "").substring(0,
						Math.min(((String) boardList.get(i).get("board_content_title")).replaceAll("\\<.*?>", "").length(), 150)));
		    	  if(contents.length()>61){
				    	contents=contents.substring(0,Math.min(contents.length(), 60));
				    	contents+="....";
				    }
		    	  boardList.get(i).put("board_content_title", contents);        
			}
		    
		    model.addAttribute("boardList", boardList);
			model.addAttribute("map", map);
		return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_EDU_COMMUNITY_NOTICE2;
	}
	
	/**
	 * @Method Name : community_notice_detail
	 * @Date : 2017. 11. 16.
	 * @User : 전상수
	 * @Param : -
	 * @Return : JSP 리턴 페이지(이미지 게시판 내용보기 페이지)
	 * @Method 설명 : 이미지 내용보기 페이지를 호출하는 컨트롤러 함수
	 */
	@RequestMapping(value = PathConstants.SOCIETY_EDU_COMMUNITY_NOTICE2_DETAIL, method = RequestMethod.GET)
	public String apply_notice2_detail(Model model, Authentication auth, String seq, String searchOption,HttpServletRequest request){

		logger.debug("공지사항2 게시판을 내용을 호출하는 컨트롤러 시작");
		
		seaService.boardHit(Integer.parseInt(seq));
		HashMap<String, Object> detail = null;
		if(searchOption==null){
			detail= seaService.boardDetail(seq,"20");
		} else if(searchOption.equals("next")){
			detail= seaService.boardDetail(seq,searchOption,"20");
		} else if(searchOption.equals("previous")){
			detail= seaService.boardDetail(seq,searchOption,"20");
		}
		if(detail==null){
			String referer = request.getHeader("Referer");
		    return "redirect:"+ referer;
		}
		
		ArrayList<HashMap<String, Object>> files = null;
		files=seaService.boardFiles(detail.get("board_content_seq").toString());
		
		model.addAttribute("boardDetail", detail);
		model.addAttribute("files", files);
		model.addAttribute("path", eduApplyBoardFile);
		logger.debug("공지사항2 게시판을 내용을 호출하는 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_EDU_COMMUNITY_NOTICE2_DETAIL;
	}
	
	/**
	 * @Method Name : community_graduate_community
	 * @Date : 2017. 9. 6.
	 * @User : 이종호
	 * @Param : -
	 * @Return : JSP 리턴 페이지(모집홍보의 공지사항 페이지)
	 * @Method 설명 : 모집홍보 졸업생마당 페이지를 호출하는 컨트롤러 함수
	 */
	@RequestMapping(value = PathConstants.SOCIETY_EDU_COMMUNITY_GRADUATE_COMMUNITY, method = RequestMethod.GET)
	public String apply_graduate_community(Model model, Authentication auth,@RequestParam(defaultValue="contents") String searchOption,
            @RequestParam(defaultValue="") String keyword,
            @RequestParam(defaultValue="1") int curPage){
		BoardPager.setBLOCK_SCALE(25);
		BoardPager.setPAGE_SCALE(10);
		String boardSeq="9";
		int count=seaService.countBoard(searchOption,keyword,boardSeq);
		BoardPager boardPager = new BoardPager(count, curPage);
		
		int start = boardPager.getPageBegin();
		int end = boardPager.getPageEnd();
		
		ArrayList<HashMap<String, Object>> boardList = (ArrayList<HashMap<String, Object>>) seaService.boardListAll(start, end, searchOption, keyword, boardSeq);

		 Map<String, Object> map = new HashMap<String, Object>();
		    map.put("count", count); // 레코드의 갯수
		    map.put("searchOption", searchOption); // 검색옵션
		    map.put("keyword", keyword); // 검색키워드
		    map.put("boardPager", boardPager);
		    
		    for(int i=0;i<boardList.size();i++){
				
		    	String contents=  (((String) (boardList.get(i).get("board_content_title"))).replaceAll("\\<.*?>", "").substring(0,
						Math.min(((String) boardList.get(i).get("board_content_title")).replaceAll("\\<.*?>", "").length(), 150)));
		    	  if(contents.length()>61){
				    	contents=contents.substring(0,Math.min(contents.length(), 60));
				    	contents+="....";
				    }
		    	  boardList.get(i).put("board_content_title", contents);        
			}
		    
		    
		    
		    model.addAttribute("boardList", boardList);
			model.addAttribute("map", map);
		return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_EDU_COMMUNITY_GRADUATE_COMMUNITY;
	}
	
	/**
	 * @Method Name : community_graduate_community_detail
	 * @Date : 2017. 11. 16.
	 * @User : 전상수
	 * @Param : -
	 * @Return : JSP 리턴 페이지(이미지 게시판 내용보기 페이지)
	 * @Method 설명 : 이미지 내용보기 페이지를 호출하는 컨트롤러 함수
	 */
	@RequestMapping(value = PathConstants.SOCIETY_EDU_COMMUNITY_GRADUATE_COMMUNITY_DETAIL, method = RequestMethod.GET)
	public String apply_graduate_community_detail(Model model, Authentication auth, String seq, String searchOption,HttpServletRequest request){

		logger.debug("졸업생마당 게시판을 내용을 호출하는 컨트롤러 시작");
		
		if(seq == null || seq.equals("")) {
			return "redirect:"+PathConstants.SOCIETY_EDU_COMMUNITY_GRADUATE_COMMUNITY;
		}
		
		seaService.boardHit(Integer.parseInt(seq));
		HashMap<String, Object> detail = null;
		if(searchOption==null){
			detail= seaService.boardDetail(seq,"9");
		} else if(searchOption.equals("next")){
			detail= seaService.boardDetail(seq,searchOption,"9");	
		} else if(searchOption.equals("previous")){
			detail= seaService.boardDetail(seq,searchOption,"9");	
		}
		if(detail==null){
			String referer = request.getHeader("Referer");
		    return "redirect:"+ referer;
		}
		
		ArrayList<HashMap<String, Object>> files = null;
		files=seaService.boardFiles(detail.get("board_content_seq").toString());
		
		model.addAttribute("boardDetail", detail);
		model.addAttribute("files", files);
		model.addAttribute("path", eduApplyBoardFile);
		logger.debug("졸업생마당 게시판을 내용을 호출하는 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_EDU_COMMUNITY_GRADUATE_COMMUNITY_DETAIL;
	}
	
	/**
	 * @Method Name : community_media_in_it
	 * @Date : 2017. 9. 6.
	 * @User : 이종호
	 * @Param : -
	 * @Return : JSP 리턴 페이지(모집홍보의 공지사항 페이지)
	 * @Method 설명 : 모집홍보 미디어속 SC IT마스터 페이지를 호출하는 컨트롤러 함수
	 */
	@RequestMapping(value = PathConstants.SOCIETY_EDU_COMMUNITY_MEDIA_IN_IT, method = RequestMethod.GET)
	public String apply_media_in_it(Model model, Authentication auth,@RequestParam(defaultValue="contents") String searchOption,
            @RequestParam(defaultValue="") String keyword,
            @RequestParam(defaultValue="1") int curPage){
		BoardPager.setBLOCK_SCALE(25);
		BoardPager.setPAGE_SCALE(10);
		String boardSeq="10";
		int count=seaService.countBoard(searchOption,keyword,boardSeq);
		BoardPager boardPager = new BoardPager(count, curPage);
		
		int start = boardPager.getPageBegin();
		int end = boardPager.getPageEnd();
		
		ArrayList<HashMap<String, Object>> boardList = (ArrayList<HashMap<String, Object>>) seaService.boardListAll(start, end, searchOption, keyword, boardSeq);

		 Map<String, Object> map = new HashMap<String, Object>();
		    map.put("count", count); // 레코드의 갯수
		    map.put("searchOption", searchOption); // 검색옵션
		    map.put("keyword", keyword); // 검색키워드
		    map.put("boardPager", boardPager);
		    
		    for(int i=0;i<boardList.size();i++){
				
		    	String contents=  (((String) (boardList.get(i).get("board_content_title"))).replaceAll("\\<.*?>", "").substring(0,
						Math.min(((String) boardList.get(i).get("board_content_title")).replaceAll("\\<.*?>", "").length(), 150)));
		    	  if(contents.length()>61){
				    	contents=contents.substring(0,Math.min(contents.length(), 60));
				    	contents+="....";
				    }
		    	  boardList.get(i).put("board_content_title", contents);        
			}
		    
		    
		    
		    model.addAttribute("boardList", boardList);
			model.addAttribute("map", map);
		return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_EDU_COMMUNITY_MEDIA_IN_IT;
	}
	
	/**
	 * @Method Name : community_media_in_it_detail
	 * @Date : 2017. 11. 16.
	 * @User : 전상수
	 * @Param : -
	 * @Return : JSP 리턴 페이지(이미지 게시판 내용보기 페이지)
	 * @Method 설명 : 이미지 내용보기 페이지를 호출하는 컨트롤러 함수
	 */
	@RequestMapping(value = PathConstants.SOCIETY_EDU_COMMUNITY_MEDIA_IN_IT_DETAIL, method = RequestMethod.GET)
	public String apply_media_in_it_detail(Model model, Authentication auth, String seq, String searchOption,HttpServletRequest request){

		logger.debug("미디어속 SC IT마스터 게시판을 내용을 호출하는 컨트롤러 시작");
		
		seaService.boardHit(Integer.parseInt(seq));
		HashMap<String, Object> detail = null;
		if(searchOption==null){
			detail= seaService.boardDetail(seq,"10");
		} else if(searchOption.equals("next")){
			detail= seaService.boardDetail(seq,searchOption,"10");	
		} else if(searchOption.equals("previous")){
			detail= seaService.boardDetail(seq,searchOption,"10");	
		}
		if(detail==null){
			String referer = request.getHeader("Referer");
		    return "redirect:"+ referer;
		}
		
		ArrayList<HashMap<String, Object>> files = null;
		files=seaService.boardFiles(detail.get("board_content_seq").toString());
		
		model.addAttribute("boardDetail", detail);
		model.addAttribute("files", files);
		model.addAttribute("path", eduApplyBoardFile);
		logger.debug("미디어속 SC IT마스터 게시판을 내용을 호출하는 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_EDU_COMMUNITY_MEDIA_IN_IT_DETAIL;
	}
	
	/**
	 * @Method Name : community_pds
	 * @Date : 2017. 9. 6.
	 * @User : 이종호
	 * @Param : -
	 * @Return : JSP 리턴 페이지(모집홍보의 공지사항 페이지)
	 * @Method 설명 : 모집홍보 자료실 페이지를 호출하는 컨트롤러 함수
	 */
	@RequestMapping(value = PathConstants.SOCIETY_EDU_COMMUNITY_PDS, method = RequestMethod.GET)
	public String apply_pds(Model model, Authentication auth,@RequestParam(defaultValue="contents") String searchOption,
            @RequestParam(defaultValue="") String keyword,
            @RequestParam(defaultValue="1") int curPage){
		BoardPager.setBLOCK_SCALE(25);
		BoardPager.setPAGE_SCALE(10);
		String boardSeq="11";
		int count=seaService.countBoard(searchOption,keyword,boardSeq);
		BoardPager boardPager = new BoardPager(count, curPage);
		
		int start = boardPager.getPageBegin();
		int end = boardPager.getPageEnd();
		
		ArrayList<HashMap<String, Object>> boardList = (ArrayList<HashMap<String, Object>>) seaService.boardListAll(start, end, searchOption, keyword, boardSeq);

		 Map<String, Object> map = new HashMap<String, Object>();
		    map.put("count", count); // 레코드의 갯수
		    map.put("searchOption", searchOption); // 검색옵션
		    map.put("keyword", keyword); // 검색키워드
		    map.put("boardPager", boardPager);
		    
		    for(int i=0;i<boardList.size();i++){
				
		    	String contents=  (((String) (boardList.get(i).get("board_content_title"))).replaceAll("\\<.*?>", "").substring(0,
						Math.min(((String) boardList.get(i).get("board_content_title")).replaceAll("\\<.*?>", "").length(), 150)));
		    	  if(contents.length()>61){
				    	contents=contents.substring(0,Math.min(contents.length(), 60));
				    	contents+="....";
				    }
		    	  boardList.get(i).put("board_content_title", contents);        
			}
		    
		    
		    
		    model.addAttribute("boardList", boardList);
			model.addAttribute("map", map);
		return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_EDU_COMMUNITY_PDS;
	}
	
	/**
	 * @Method Name : community_pds_detail
	 * @Date : 2017. 11. 16.
	 * @User : 전상수
	 * @Param : -
	 * @Return : JSP 리턴 페이지(이미지 게시판 내용보기 페이지)
	 * @Method 설명 : 이미지 내용보기 페이지를 호출하는 컨트롤러 함수
	 */
	@RequestMapping(value = PathConstants.SOCIETY_EDU_COMMUNITY_PDS_DETAIL, method = RequestMethod.GET)
	public String apply_pds_detail(Model model, Authentication auth, String seq, String searchOption,HttpServletRequest request){

		logger.debug("자료실 게시판을 내용을 호출하는 컨트롤러 시작");
		
		seaService.boardHit(Integer.parseInt(seq));
		HashMap<String, Object> detail = null;
		if(searchOption==null){
			detail= seaService.boardDetail(seq,"11");
		} else if(searchOption.equals("next")){
			detail= seaService.boardDetail(seq,searchOption,"11");	
		} else if(searchOption.equals("previous")){
			detail= seaService.boardDetail(seq,searchOption,"11");	
		}
		if(detail==null){
			String referer = request.getHeader("Referer");
		    return "redirect:"+ referer;
		}
		
		ArrayList<HashMap<String, Object>> files = null;
		files=seaService.boardFiles(detail.get("board_content_seq").toString());
		
		model.addAttribute("boardDetail", detail);
		model.addAttribute("files", files);
		model.addAttribute("path", eduApplyBoardFile);
		logger.debug("자료실 게시판을 내용을 호출하는 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_EDU_COMMUNITY_PDS_DETAIL;
	}
	
	/**
	 * @Method Name : consulting_faq
	 * @Date : 2018. 7. 26.
	 * @User : 김도훈
	 * @Param : -
	 * @Return : JSP 리턴 페이지(상담센터의 FAQ 상담 페이지)
	 * @Method 설명 : FAQ 상담 페이지를 호출하는 컨트롤러 함수
	 */
	@RequestMapping(value = PathConstants.SOCIETY_EDU_CONSULTING_FAQ, method = RequestMethod.GET)
	public String consulting_faq(){
		return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_EDU_CONSULTING_FAQ;
	}

	@ResponseBody
	@RequestMapping(value = PathConstants.SOCIETY_EDU_CONSULTING_FAQ_REQUEST, method = RequestMethod.POST)
	public Map<String, Object> consulting_faq_request(
			String searchOption,
            String keyword,
            int curPage){
		
		BoardPager.setBLOCK_SCALE(25);
		BoardPager.setPAGE_SCALE(10);
		int count=seaService.faq_consulting_countBoard(searchOption,keyword);
		BoardPager boardPager = new BoardPager(count, curPage);
		
		int start = boardPager.getPageBegin();
		int end = boardPager.getPageEnd();
		
		ArrayList<HashMap<String, Object>> boardList = (ArrayList<HashMap<String, Object>>) seaService.faq_consulting_boardListAll(start, end, searchOption, keyword);

		Map<String, Object> map = new HashMap<String, Object>();
	    map.put("boardList", boardList); // 리스트 결과
	    map.put("count", count); // 레코드의 갯수
	    map.put("searchOption", searchOption); // 검색옵션
	    map.put("keyword", keyword); // 검색키워드
	    map.put("boardPager", boardPager);
		
		return map;
	}
	
	/**
	 * @Method Name : consulting_online
	 * @Date : 2018. 7. 26.
	 * @User : 김도훈
	 * @Param : -
	 * @Return : JSP 리턴 페이지(상담센터의 온라인 상담 페이지)
	 * @Method 설명 : 온라인 상담 페이지를 호출하는 컨트롤러 함수
	 */
	//원: apply_notice
	@RequestMapping(value = PathConstants.SOCIETY_EDU_CONSULTING_ONLINE, method = RequestMethod.GET)
	public String consulting_online(Model model, Authentication auth,@RequestParam(defaultValue="contents") String searchOption,
            @RequestParam(defaultValue="") String keyword,
            @RequestParam(defaultValue="1") int curPage){
		BoardPager.setBLOCK_SCALE(25);
		BoardPager.setPAGE_SCALE(10);
		int consulting_tp=1000; // 온라인상담 부분 검색
		int count=seaService.online_consulting_countBoard(searchOption,keyword,consulting_tp);
		BoardPager boardPager = new BoardPager(count, curPage);
		
		int start = boardPager.getPageBegin();
		int end = boardPager.getPageEnd();
		
		ArrayList<HashMap<String, Object>> boardList = (ArrayList<HashMap<String, Object>>) seaService.online_consulting_boardListAll(start, end, searchOption, keyword, consulting_tp);
		Map<String, Object> map = new HashMap<String, Object>();
	    map.put("count", count); // 레코드의 갯수
	    map.put("searchOption", searchOption); // 검색옵션
	    map.put("keyword", keyword); // 검색키워드
	    map.put("boardPager", boardPager);
		    
		    for(int i=0;i<boardList.size();i++){
		    	String contents=  (((String) (boardList.get(i).get("consulting_title"))).replaceAll("\\<.*?>", "").substring(0,
						Math.min(((String) boardList.get(i).get("consulting_title")).replaceAll("\\<.*?>", "").length(), 150)));
		    	  if(contents.length()>51){
				    	contents=contents.substring(0,Math.min(contents.length(), 50));
				    	contents+="....";
				    }
		    	  boardList.get(i).put("consulting_title", contents);        
			}
		    
		    if (auth != null) {
		    	model.addAttribute("consulting_ins_id", auth.getName());
			}
		    
		    model.addAttribute("boardList", boardList);
			model.addAttribute("map", map);
			
		return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_EDU_CONSULTING_ONLINE;
	}
	
	/**
	 * @Method Name : apply_online_consulting_detail
	 * @Date : 2018. 7. 26.
	 * @User : 김도훈
	 * @Param : -
	 * @Return : JSP 리턴 페이지(상담센터의 온라인상담 상세내용 페이지)
	 * @Method 설명 : 온라인 상담 상세내용 페이지를 호출하는 컨트롤러 함수
	 */
	@RequestMapping(value = PathConstants.SOCIETY_EDU_CONSULTING_ONLINE_DETAIL, method = RequestMethod.GET)
	public String apply_online_consulting_detail(Model model, Authentication auth, int consulting_seq, String searchOption, HttpServletRequest request){
		
		logger.debug("온라인상담 게시판을 내용을 호출하는 컨트롤러 시작");
		
		seaService.online_consulting_hit_update(consulting_seq);
		HashMap<String, Object> detail = null;
		if(searchOption==null){
			detail= seaService.online_consulting_boardDetail(consulting_seq);
		} else if(searchOption.equals("next")){
			detail= seaService.online_consulting_boardDetail(consulting_seq,searchOption);	
		} else if(searchOption.equals("previous")){
			detail= seaService.online_consulting_boardDetail(consulting_seq,searchOption);	
		}
		if(detail==null){
			String referer = request.getHeader("Referer");
			return "redirect:"+ referer;
		}
		
		if (auth != null) {
	    	model.addAttribute("consulting_ins_id", auth.getName());
		}
		
		model.addAttribute("boardDetail", detail);
		
		logger.debug("온라인상담 게시판을 내용을 호출하는 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_EDU_CONSULTING_ONLINE_DETAIL;
	}
	
	/**
	 * @Method Name : online_consulting_write_form
	 * @Date : 2017. 7. 31.
	 * @User : 김도훈
	 * @Param : 유저 시퀀스 정보
	 * @Return : JSP 리턴페이지(SMART Cloud IT마스터 지원신청서 페이지)
	 * @Method 설명 : 로그인 한 회원 정보를 온라인상담 신청 페이지로 전달
	 */
	@RequestMapping(value = PathConstants.SOCIETY_EDU_CONSULTING_ONLINE_WRITE_FORM , method = RequestMethod.GET)
	public String online_consulting_write_form(Model model, Authentication auth){
		
		model.addAttribute("consulting_ins_id", auth.getName());
		
		return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_EDU_CONSULTING_ONLINE_WRITE_FORM;
	}
	
	/**
	 * @Method Name : apply_online
	 * @Date : 2018. 07. 26.
	 * @User : 김도훈
	 * @Param : 온라인 상담 신청 페이지 작성 정보
	 * @Return : JSP 리턴 페이지(온라인상담 게시판 내용보기 페이지)
	 * @Method 설명 : 이미지 내용보기 페이지를 호출하는 컨트롤러 함수
	 */
	@ResponseBody
	@RequestMapping(value = PathConstants.SOCIETY_EDU_CONSULTING_ONLINE_APPLY, method = RequestMethod.POST)
	public boolean apply_online(Model model, Authentication auth, @ModelAttribute OnlineConsultingContents occ){
		logger.debug("온라인 상담 신청 컨트롤러 시작");
		
		boolean isRequested = false;

		if(seaService.apply_online_insert(occ)) {
			isRequested = true;
			logger.debug("온라인 상담 신청 성공!");
			
			seaService.online_consulting_admin_mail_send(occ, "온라인 상담 등록");
		}
		
		logger.debug("온라인 상담 신청 컨트롤러 종료");
		return isRequested;
	}

	/**
	 * @Method Name : online_consulting_update_form
	 * @Date : 2018. 07. 30.
	 * @User : 김도훈
	 * @Param : 온라인 상담 신청 정보
	 * @Return : JSP 리턴 페이지(온라인상담 게시판 내용수정 페이지)
	 * @Method 설명 : 온라인상담 수정 페이지를 호출하는 컨트롤러 함수
	 */
	@RequestMapping(value = PathConstants.SOCIETY_EDU_CONSULTING_ONLINE_UPDATE_FORM, method = RequestMethod.GET)
	public String online_consulting_update_form(int consulting_seq, Model model, Authentication auth){
		logger.debug("온라인상담 게시글 세부 내용 수정 폼 이동 컨트롤러 시작");
		
		HashMap<String, Object> resultMap = seaService.online_consulting_boardDetail(consulting_seq);

		model.addAttribute("consulting_ins_id", auth.getName());
		model.addAttribute("contentDetail", resultMap);
		
		logger.debug("온라인상담 게시글 세부 내용 수정 폼 이동 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_EDU_CONSULTING_ONLINE_UPDATE_FORM;
	}
	
	/**
	 * @Method Name : apply_online_udt
	 * @Date : 2018. 7. 30.
	 * @User : 김도훈
	 * @Param : 온라인 상담 신청 정보
	 * @Return : JSP 리턴페이지 (온라인상담 게시판 내용수정)
	 * @Method 설명 : 온라인상담 내용을 수정하는 컨트롤러 함수
	 */
	@ResponseBody
	@RequestMapping(value = PathConstants.SOCIETY_EDU_CONSULTING_ONLINE_APPLY_UPDATE, method = RequestMethod.POST)
	public boolean apply_online_udt(Model model, Authentication auth, @ModelAttribute OnlineConsultingContents occ){
		logger.debug("온라인 상담 수정 컨트롤러 시작");
		
		boolean isRequested = false;
		OnlineConsultingContents mail_occ = occ;

		if(seaService.apply_online_update(occ)) {
			isRequested = true;
			logger.debug("온라인 상담 수정 성공!");
			
			seaService.online_consulting_admin_mail_send(mail_occ, "온라인 상담 수정");
		}
		
		logger.debug("온라인 상담 수정 컨트롤러 종료");
		return isRequested;
	}
	
	/**
	 * @Method Name : apply_online_del
	 * @Date : 2018. 8. 20.
	 * @User : 김지훈
	 * @Param : 온라인 상담 신청 정보
	 * @Return : JSP 리턴페이지 (온라인상담 게시판 내용수정)
	 * @Method 설명 : 온라인상담 내용을 삭제하는 컨트롤러 함수
	 */
	@ResponseBody
	@RequestMapping(value = PathConstants.SOCIETY_EDU_CONSULTING_ONLINE_APPLY_DELETE, method = RequestMethod.POST)
	public boolean apply_online_del(Model model, Authentication auth, @ModelAttribute OnlineConsultingContents occ){
		logger.debug("온라인 상담 수정 컨트롤러 시작");
		
		boolean isRequested = false;
		OnlineConsultingContents mail_occ = occ;

		if(seaService.apply_online_delete(occ)) {
			isRequested = true;
			logger.debug("온라인 상담 삭제 성공!");
			
			seaService.online_consulting_admin_mail_send(mail_occ, "온라인 상담 게시글 삭제");
		}
		
		logger.debug("온라인 상담 수정 컨트롤러 종료");
		return isRequested;
	}
	
	/**
	 * @Method Name : consulting_offline
	 * @Date : 2018. 07. 11.
	 * @User : 김지훈
	 * @Param : -
	 * @Return : JSP 리턴 페이지(오프라인 상담 게시판 내용보기 페이지)
	 * @Method 설명 : 이미지 내용보기 페이지를 호출하는 컨트롤러 함수
	 */
	@RequestMapping(value = PathConstants.SOCIETY_EDU_CONSULTING_OFFLINE, method = RequestMethod.GET)
	public String consulting_offline(){
		logger.debug("오프라인 상담 페이지 컨트롤러 시작");
		logger.debug("오프라인 상담 페이지 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_EDU_CONSULTING_OFFLINE;
	}
	
	/**
	 * @Method Name : apply_offline
	 * @Date : 2018. 07. 12.
	 * @User : 김지훈
	 * @Param : 오프라인 상담 신청 페이지 작성 정보
	 * @Return : JSP 리턴 페이지(오프라인 상담 게시판 내용보기 페이지)
	 * @Method 설명 : 이미지 내용보기 페이지를 호출하는 컨트롤러 함수
	 */
	@ResponseBody
	@RequestMapping(value = PathConstants.SOCIETY_EDU_CONSULTING_OFFLINE_APPLY, method = RequestMethod.POST)
	public boolean apply_offline(@ModelAttribute OfflineConsultingContents occ){
		logger.debug("오프라인 상담 신청 컨트롤러 시작");
		
		boolean isRequested = false;

//		System.out.println(occ.toString());
		if(seaService.apply_offline_insert(occ)) {
			isRequested = true;
			logger.debug("오프라인 상담 신청 성공!");
		}
//		System.out.println(isRequested);
		
		logger.debug("오프라인 상담 신청 컨트롤러 종료");
		return isRequested;
	}
	
	/**
	 * @Method Name : image_notice
	 * @Date : 2017. 11. 10.
	 * @User : 전상수
	 * @Param : -
	 * @Return : JSP 리턴 페이지(이미지 게시판 페이지)
	 * @Method 설명 : 이미지 게시판을 호출하는 컨트롤러 함수
	 */
	@RequestMapping(value = PathConstants.SOCIETY_EDU_IMAGE_NOTICE, method = RequestMethod.GET)
	public String image_notice(Model model, Authentication auth,@RequestParam(defaultValue="contents") String searchOption,
            @RequestParam(defaultValue="") String keyword,
            @RequestParam(defaultValue="1") int curPage){
		
		logger.debug("이미지 게시판을 호출하는 컨트롤러 시작");
		BoardPager.setBLOCK_SCALE(5);
		BoardPager.setPAGE_SCALE(5);
		String boardSeq="7";
		int count=seaService.countBoard(searchOption,keyword,boardSeq);
		BoardPager boardPager = new BoardPager(count, curPage);
		
	    int start = boardPager.getPageBegin();
	    int end = boardPager.getPageEnd();
	    
		
		ArrayList<HashMap<String, Object>> imageList = (ArrayList<HashMap<String, Object>>) seaService.boardListAll(start, end, searchOption, keyword, boardSeq);

		 Map<String, Object> map = new HashMap<String, Object>();
		    map.put("count", count); // 레코드의 갯수
		    map.put("searchOption", searchOption); // 검색옵션
		    map.put("keyword", keyword); // 검색키워드
		    map.put("boardPager", boardPager);
		    
		for(int i=0;i<imageList.size();i++){
			
			String str = (String)imageList.get(i).get("board_content_ct");
			Pattern p = Pattern.compile("src=\"(.*?)\"");
			Matcher m = p.matcher(str);
			    if (m.find()) {
			    	imageList.get(i).put("board_content_thumb", m.group(1));
			    }else{
			    	imageList.get(i).put("board_content_thumb", "/edu/apply/ckeditor/noimage.png");
			    }
			    
			
			        
			       
			    String contents=  (((String) (imageList.get(i).get("board_content_ct"))).replaceAll("\\<.*?>", "").substring(0,
							Math.min(((String) imageList.get(i).get("board_content_ct")).replaceAll("\\<.*?>", "").length(), 150)));
			       
			        
		    if(contents.length()>100){
		    	contents=contents.substring(0,Math.min(contents.length(), 99));
		    	contents+="....";
		    }
			imageList.get(i).put("board_content_ct", contents);
			        
		}
		    
		model.addAttribute("imageNoticeList", imageList);
		model.addAttribute("map", map);
		
		
		logger.debug("이미지 게시판을 호출하는 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_EDU_IMAGE_NOTICE;
	}
	
	/**
	 * @Method Name : image_notice_detail
	 * @Date : 2017. 11. 16.
	 * @User : 전상수
	 * @Param : -
	 * @Return : JSP 리턴 페이지(이미지 게시판 내용보기 페이지)
	 * @Method 설명 : 이미지 내용보기 페이지를 호출하는 컨트롤러 함수
	 */
	@RequestMapping(value = PathConstants.SOCIETY_EDU_IMAGE_NOTICE_DETAIL, method = RequestMethod.GET)
	public String image_notice(Model model, Authentication auth, String seq, String searchOption,HttpServletRequest request){

		logger.debug("이미지 게시판을 내용을 호출하는 컨트롤러 시작");
		HashMap<String, Object> imageDetail = null;
		if(searchOption==null){
		imageDetail= seaService.boardDetail(seq,"7");
		}
		else if(searchOption.equals("next")){
		imageDetail= seaService.boardDetail(seq,searchOption,"7");	
			
		}else if(searchOption.equals("previous")){
		imageDetail= seaService.boardDetail(seq,searchOption,"7");	
			
		}
        
		if(imageDetail==null){
			String referer = request.getHeader("Referer");
		    return "redirect:"+ referer;
		}
		
		model.addAttribute("imageBoardDetail", imageDetail);
		
		logger.debug("이미지 게시판을 내용을 호출하는 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_EDU_IMAGE_NOTICE_DETAIL;
	}
	
	@RequestMapping(value = PathConstants.SOCIETY_EDU_APPLY_LONG_TERM_LIST, method = RequestMethod.GET)
	public String apply_list(Model model, Authentication auth){
		logger.debug("모집홍보 과정 리스트 검색 컨트롤러 시작");
		
		String user_id = "";
		if(auth != null){
			user_id = auth.getName();
		}
		model.addAttribute("longTermList", seaService.selectLongTermList(user_id, "%", "%"));
		
		logger.debug("모집홍보 과정 리스트 검색 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_EDU_APPLY_MAIN;
	}
	
	// 서울 링크 이동
	@RequestMapping(value = PathConstants.SOCIETY_EDU_APPLY_SCITMASTER_SEOUL, method = RequestMethod.GET)
	public String scitmaster_intro(Model model){
		logger.debug("모집홍보 장기과정 안내페이지 컨트롤러 시작");
		// 서울 링크 이동 수정 2018. 10. 10. 김준영
		ArrayList<String> seoul_img_select = seaService.seoul_img_select();
		model.addAttribute("seoul_img_select", seoul_img_select);
		
		logger.debug("모집홍보 장기과정 안내페이지 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_EDU_APPLY_SCITMASTER_SEOUL;
	}

	// 미국융복합
		@RequestMapping(value = PathConstants.SOCIETY_EDU_APPLY_USINTERN, method = RequestMethod.GET)
		public String usintern(Model model, Authentication auth){
			logger.debug("모집홍보 장기과정 미국융복합 안내페이지 컨트롤러 시작");
			try{
				
				ArrayList<String> gwangju_img_select = seaService.gwangju_img_select();
				model.addAttribute("gwangju_img_select", gwangju_img_select);
				
				// SW DevOps마스터 과정을 하드코딩으로 지정(inputValue : 3)
				model.addAttribute("seaCurriculum", seAdminService.searchCurriculum(10000));
				
				// 유저가 지원서를 작성할지 수정할지를 알 수 있게 기수정보를 취득
				String user_id = "";
				if(auth != null){
					user_id = auth.getName();
				}
				HashMap<String, Object> sw_devops_master = seaService.selectLongTermList(user_id, "A1205", "B2500");
				model.addAttribute("seaCurGisu", sw_devops_master);
				
				}catch(Exception e){
					e.printStackTrace();
				}
				
				logger.debug("모집홍보 장기과정 미국융복합 안내페이지 컨트롤러 종료");
			return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_EDU_APPLY_USINTERN;
		}
		
	// 일본취업학교
		@RequestMapping(value = PathConstants.SOCIETY_EDU_APPLY_JAPANJOB, method = RequestMethod.GET)
		public String japanjob(Model model, Authentication auth){
			logger.debug("모집홍보 장기과정 일본취업학교 안내페이지 컨트롤러 시작");
			try{
				
			ArrayList<String> gwangju_img_select = seaService.gwangju_img_select();
			model.addAttribute("gwangju_img_select", gwangju_img_select);
			
			// SW DevOps마스터 과정을 하드코딩으로 지정(inputValue : 3)
			model.addAttribute("seaCurriculum", seAdminService.searchCurriculum(10001));
			
			// 유저가 지원서를 작성할지 수정할지를 알 수 있게 기수정보를 취득
			String user_id = "";
			if(auth != null){
				user_id = auth.getName();
			}
			HashMap<String, Object> sw_devops_master = seaService.selectLongTermList(user_id, "A1206", "B2500");
			model.addAttribute("seaCurGisu", sw_devops_master);
			
			}catch(Exception e){
				e.printStackTrace();
			}
			
			logger.debug("모집홍보 장기과정 일본취업학교 스쿨 안내페이지 컨트롤러 종료");
			return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_EDU_APPLY_JAPANJOB;
		}

	// 광주 링크 이동
	@RequestMapping(value = PathConstants.SOCIETY_EDU_APPLY_KMOVE, method = RequestMethod.GET)
	public String kmove(Model model, Authentication auth){
		logger.debug("모집홍보 장기과정 k-move 스쿨 안내페이지 컨트롤러 시작");
		try{
			
		ArrayList<String> gwangju_img_select = seaService.gwangju_img_select();
		model.addAttribute("gwangju_img_select", gwangju_img_select);
		
		// k-move 스쿨 안내페이지에 사용될 이미지 2장을 SW DevOps마스터 과정(DB)에서 취득
		// SW DevOps마스터 과정을 하드코딩으로 지정(inputValue : 3)
		model.addAttribute("seaCurriculum", seAdminService.searchCurriculum(3));
		
		// 유저가 지원서를 작성할지 수정할지를 알 수 있게 기수정보를 취득
		String user_id = "";
		if(auth != null){
			user_id = auth.getName();
		}
		// 가장 최근의 1번째 활성화된 SW DevOps마스터 과정의 기수정보를 취득한다.
		// 만약 지원가능한 기수정보(신청기간아님 기타등등)가 없다면 null을 반환한다.
		// ArrayList<HashMap<String, Object>> sw_devops_master = seaService.selectLongTermList(user_id, "SW DevOps마스터");
		// ArrayList<HashMap> -> 그냥 HashMap으로 수정; 2018. 10. 10. 김준영
		HashMap<String, Object> sw_devops_master = seaService.selectLongTermList(user_id, "A1202", "B2503");
		model.addAttribute("seaCurGisu", sw_devops_master);
		/* if(sw_devops_master.size() > 0) {
			model.addAttribute("seaCurGisu", sw_devops_master.get(0));
		} */
		}catch(Exception e){
			e.printStackTrace();
		}
		/* String path = eduApplyCurriculumGisuInsertImage;
		model.addAttribute("path", path); */
		
		logger.debug("모집홍보 장기과정 k-move 스쿨 안내페이지 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_EDU_APPLY_KMOVE;
	}
	
	/**
	 * @Method Name : seoul
	 * @Date : 2019. 3. 5.
	 * @User : 이종호
	 * @Param : -
	 * @Return : JSP 리턴 페이지
	 * @Method 설명 : 서울 학생들을 지원시키기 위한 페이지 이동
	 */
	@RequestMapping(value = PathConstants.SOCIETY_EDU_APPLY_SEOUL, method = RequestMethod.GET)
	public String seoul(Model model, Authentication auth){
		logger.info("모집홍보 장기과정 마스터 서울 지원 페이지 컨트롤러 시작");
		// 유저가 지원서를 작성할지 수정할지를 알 수 있게 기수정보를 취득
		String user_id = "";
		if(auth != null){
			user_id = auth.getName();
		}
		
		HashMap<String, Object> sw_seoul = seaService.selectLongTermList(user_id, "A1200", "B2501");
		model.addAttribute("seaCurGisu", sw_seoul);
		logger.info("모집홍보 장기과정 마스터 서울 지원 페이지 컨트롤러 시작");
		return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_EDU_APPLY_SEOUL;
	}
	
	// 광주 링크 이동
		@RequestMapping(value = PathConstants.SOCIETY_EDU_APPLY_KMOVE_CUP, method = RequestMethod.GET)
		public String kmoveCup(Model model, Authentication auth){
			logger.debug("모집홍보 장기과정 k-move 스쿨 안내페이지 컨트롤러 시작");
		
			ArrayList<String> gwangju_img_select = seaService.gwangju_img_select();
			model.addAttribute("gwangju_img_select", gwangju_img_select);
			// k-move 스쿨 안내페이지에 사용될 이미지 2장을 SW DevOps마스터 과정(DB)에서 취득
			// SW DevOps마스터 과정을 하드코딩으로 지정(inputValue : 100)
			model.addAttribute("seaCurriculum", seAdminService.searchCurriculum(100));
			
			// 유저가 지원서를 작성할지 수정할지를 알 수 있게 기수정보를 취득
			String user_id = "";
			if(auth != null){
				user_id = auth.getName();
			}
			// 가장 최근의 1번째 활성화된 SW DevOps마스터 과정의 기수정보를 취득한다.
			// 만약 지원가능한 기수정보(신청기간아님 기타등등)가 없다면 null을 반환한다.
			// ArrayList<HashMap<String, Object>> sw_devops_master = seaService.selectLongTermList(user_id, "SW DevOps마스터");
			// ArrayList<HashMap> -> 그냥 HashMap으로 수정; 2018. 10. 10. 김준영
			HashMap<String, Object> sw_devops_master = seaService.selectLongTermList(user_id, "A1203", "B2500");
			model.addAttribute("seaCurGisu", sw_devops_master);
			/* if(sw_devops_master.size() > 0) {
				model.addAttribute("seaCurGisu", sw_devops_master.get(0));
			} */
			
			/* String path = eduApplyCurriculumGisuInsertImage;
			model.addAttribute("path", path); */
			
			logger.debug("모집홍보 장기과정 k-move cup 안내페이지 컨트롤러 종료");
			return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_EDU_APPLY_KMOVE_CUP;
		}
	
	@RequestMapping(value = PathConstants.SOCIETY_EDU_APPLY_SHORT_TERM_LIST, method = RequestMethod.GET)
	public String apply_short_list(Model model, Authentication auth){
		logger.debug("모집홍보 과정 리스트 검색 컨트롤러 시작");
		
		String user_id = "";
		if(auth != null){
			user_id = auth.getName();
		}
		model.addAttribute("shortTermList", seaService.selectShortTermList(user_id, "A1201"));
		
		logger.debug("모집홍보 과정 리스트 검색 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_EDU_APPLY_SHORT;
	}
	
	@RequestMapping(value = PathConstants.SOCIETY_EDU_APPLY_IT101_MENU, method = RequestMethod.GET)
	public String it101_menu(Model model, Authentication auth){
		logger.debug("모집홍보 IT 101 과정 리스트 검색 컨트롤러 시작");
		
		model.addAttribute("shortTermList", seaService.selectShortTermInfo("IT 101"));
		
		String path = eduApplyCurriculumGisuInsertImage;
		model.addAttribute("path", path);
		
		logger.debug("모집홍보 IT 101 과정 리스트 검색 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_EDU_APPLY_IT101_MENU;
	}
	
	@RequestMapping(value = PathConstants.SOCIETY_EDU_APPLY_CUP, method = RequestMethod.GET)
	public String apply_cup(Model model, Authentication auth){
		logger.debug("모집홍보 사전학습 과정 리스트 검색 컨트롤러 시작");
		
		String user_id = "";
		if(auth != null){
			user_id = auth.getName();
		}
		ArrayList<HashMap<String, Object>> resultList = seaService.selectShortTermList(user_id, "A1203");
		//SocietyEduAdminPayment payment = seaService.selectShortTermPayInfo(resultList.get(0).get("gisu_seq").toString());
		
		
		
		if(resultList == null) {
			resultList = new ArrayList<>();
		}else {
			for(int i=0;i<resultList.size();i++) {
				resultList.get(i).put("paySeq", seaService.selectShortTermPayInfo(resultList.get(i).get("gisu_seq").toString()).getSeq());
				resultList.get(i).put("payAmount", seaService.selectShortTermPayInfo(resultList.get(i).get("gisu_seq").toString()).getAmount());
			}
		}
		

		model.addAttribute("shortTermList", resultList);
		
		String path = eduApplyCurriculumGisuInsertImage;
		model.addAttribute("path", path);
		
		logger.debug("모집홍보 사전학습 과정 리스트 검색 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_EDU_APPLY_CUP;
	}
	
//	@RequestMapping(value = PathConstants.SOCIETY_EDU_APPLY_CUP_MENU, method = RequestMethod.GET)
//	public String cup_menu(Model model, Authentication auth){
//		logger.debug("모집홍보 사전학습 과정 리스트 검색 컨트롤러 시작");
//		
//		model.addAttribute("shortTermList", seaService.selectShortTermInfo("SC IT MASTER CUP과정"));
//		
//		String path = eduApplyCurriculumGisuInsertImage;
//		model.addAttribute("path", path);
//		
//		logger.debug("모집홍보 사전학습 과정 리스트 검색 컨트롤러 종료");
//		return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_EDU_APPLY_CUP_MENU;
//	}
	
	/**
	 * @Method Name : short_term_c1
	 * @Date : 2019. 8. 28.
	 * @User : 정병준
	 * @Param : -
	 * @Return : JSP 리턴페이지(모집홍보 C 단기 과정1)
	 * @Method 설명 : 모집홍보 C 단기 과정1을 호출하는 컨트롤러 함수
	 */
	@RequestMapping(value = PathConstants.SOCIETY_EDU_APPLY_SHORT_TERM_C1, method = RequestMethod.GET)
	public String short_term_c1(Model model, Authentication auth){
		logger.debug("모집홍보 C 단기 과정1 페이지 컨트롤러 시작");
		
		String user_id = "";
		if(auth != null){
			user_id = auth.getName();
		}
		ArrayList<HashMap<String, Object>> shortTermList = seaService.selectShortTermList(user_id, "A1204");
		ArrayList<HashMap<String, Object>> resultList = new ArrayList<>();
		
		if(shortTermList == null) {
			shortTermList = new ArrayList<>();
		}else {
			for(int i=0;i<shortTermList.size();i++) {
				Integer gisu_num = (Integer) shortTermList.get(i).get("gisu_num");
				if(gisu_num >= 0 && gisu_num < 200) { // 0~99 C언어 단기 과정1 오전반, 100~199 C언어 단기 과정1 오후반
					HashMap<String, Object> resultMap = shortTermList.get(i);
					resultMap.put("paySeq", seaService.selectShortTermPayInfo(shortTermList.get(i).get("gisu_seq").toString()).getSeq());
					resultMap.put("payAmount", seaService.selectShortTermPayInfo(shortTermList.get(i).get("gisu_seq").toString()).getAmount());
					resultList.add(resultMap);
				}
			}
		}
		Collections.sort(resultList, new Comparator<HashMap<String, Object>>() {
			@Override
			public int compare(HashMap<String, Object> o1, HashMap<String, Object> o2) {
				return ((Integer) o1.get("gisu_num")).compareTo((Integer) o2.get("gisu_num"));
			}
		});

		model.addAttribute("shortTermList", resultList);
		
		String path = eduApplyCurriculumGisuInsertImage;
		model.addAttribute("path", path);
		
		logger.debug("모집홍보 C 단기 과정1 페이지 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_EDU_APPLY_SHORT_TERM_C1;
	}
	
	/**
	 * @Method Name : short_term_c2
	 * @Date : 2019. 8. 28.
	 * @User : 정병준
	 * @Param : -
	 * @Return : JSP 리턴페이지(모집홍보 C 단기 과정2)
	 * @Method 설명 : 모집홍보 C 단기 과정2를 호출하는 컨트롤러 함수
	 */
	@RequestMapping(value = PathConstants.SOCIETY_EDU_APPLY_SHORT_TERM_C2, method = RequestMethod.GET)
	public String short_term_c2(Model model, Authentication auth){
		logger.debug("모집홍보 C 단기 과정2 페이지 컨트롤러 시작");
		
		String user_id = "";
		if(auth != null){
			user_id = auth.getName();
		}
		ArrayList<HashMap<String, Object>> shortTermList = seaService.selectShortTermList(user_id, "A1204");
		ArrayList<HashMap<String, Object>> resultList = new ArrayList<>();
		
		if(shortTermList == null) {
			shortTermList = new ArrayList<>();
		}else {
			for(int i=0;i<shortTermList.size();i++) {
				Integer gisu_num = (Integer) shortTermList.get(i).get("gisu_num");
				if(gisu_num >= 200 && gisu_num < 400) { // 200~299 C언어 단기 과정2 오전반, 300~399 C언어 단기 과정2 오후반
					HashMap<String, Object> resultMap = shortTermList.get(i);
					resultMap.put("paySeq", seaService.selectShortTermPayInfo(shortTermList.get(i).get("gisu_seq").toString()).getSeq());
					resultMap.put("payAmount", seaService.selectShortTermPayInfo(shortTermList.get(i).get("gisu_seq").toString()).getAmount());
					resultList.add(resultMap);
				}
			}
		}
		Collections.sort(resultList, new Comparator<HashMap<String, Object>>() {
			@Override
			public int compare(HashMap<String, Object> o1, HashMap<String, Object> o2) {
				return ((Integer) o1.get("gisu_num")).compareTo((Integer) o2.get("gisu_num"));
			}
		});

		model.addAttribute("shortTermList", resultList);
		
		String path = eduApplyCurriculumGisuInsertImage;
		model.addAttribute("path", path);
		
		logger.debug("모집홍보 C 단기 과정2 페이지 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_EDU_APPLY_SHORT_TERM_C2;
	}
	
	/**
	 * @Method Name : short_term_springboot2
	 * @Date : 2019. 8. 29.
	 * @User : 정병준
	 * @Param : -
	 * @Return : JSP 리턴페이지(모집홍보 Spring Boot 2 단기 과정)
	 * @Method 설명 : 모집홍보 Spring Boot 2 단기 과정을 호출하는 컨트롤러 함수
	 */
	@RequestMapping(value = PathConstants.SOCIETY_EDU_APPLY_SHORT_TERM_SPRINGBOOT2, method = RequestMethod.GET)
	public String short_term_springboot2(Model model, Authentication auth){
		logger.debug("모집홍보 Spring Boot 2 단기 과정 페이지 컨트롤러 시작");
		
		String user_id = "";
		if(auth != null){
			user_id = auth.getName();
		}
		ArrayList<HashMap<String, Object>> shortTermList = seaService.selectShortTermList(user_id, "A1204");
		ArrayList<HashMap<String, Object>> resultList = new ArrayList<>();
		
		if(shortTermList == null) {
			shortTermList = new ArrayList<>();
		}else {
			for(int i=0;i<shortTermList.size();i++) {
				Integer gisu_num = (Integer) shortTermList.get(i).get("gisu_num");
				if(gisu_num >= 400 && gisu_num < 800) { // 400~499 Spring Boot 2 단기 과정 오전반, 500~599 Spring Boot 2 단기 과정 오후반, 600~699 Spring Boot 2 단기 과정 야간반, 700~799 Spring Boot 2 단기 과정 주말반
					HashMap<String, Object> resultMap = shortTermList.get(i);
					resultMap.put("paySeq", seaService.selectShortTermPayInfo(shortTermList.get(i).get("gisu_seq").toString()).getSeq());
					resultMap.put("payAmount", seaService.selectShortTermPayInfo(shortTermList.get(i).get("gisu_seq").toString()).getAmount());
					resultList.add(resultMap);
				}
			}
		}
		Collections.sort(resultList, new Comparator<HashMap<String, Object>>() {
			@Override
			public int compare(HashMap<String, Object> o1, HashMap<String, Object> o2) {
				return ((Integer) o1.get("gisu_num")).compareTo((Integer) o2.get("gisu_num"));
			}
		});

		model.addAttribute("shortTermList", resultList);
		
		String path = eduApplyCurriculumGisuInsertImage;
		model.addAttribute("path", path);
		
		logger.debug("모집홍보 Spring Boot 2 단기 과정 페이지 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_EDU_APPLY_SHORT_TERM_SPRINGBOOT2;
	}
	
	/**
	 * @Method Name : short_term_python
	 * @Date : 2019. 8. 29.
	 * @User : 정병준
	 * @Param : -
	 * @Return : JSP 리턴페이지(모집홍보 Python 단기 과정)
	 * @Method 설명 : 모집홍보 Python 단기 과정을 호출하는 컨트롤러 함수
	 */
	@RequestMapping(value = PathConstants.SOCIETY_EDU_APPLY_SHORT_TERM_PYTHON, method = RequestMethod.GET)
	public String short_term_python(Model model, Authentication auth){
		logger.debug("모집홍보 Python 단기 과정 페이지 컨트롤러 시작");
		try{
		String user_id = "";
		if(auth != null){
			user_id = auth.getName();
		}
		ArrayList<HashMap<String, Object>> shortTermList = seaService.selectShortTermList(user_id, "A1204");
		ArrayList<HashMap<String, Object>> resultList = new ArrayList<>();
		
		if(shortTermList == null) {
			shortTermList = new ArrayList<>();
		}else {
			for(int i=0;i<shortTermList.size();i++) {
				Integer gisu_num = (Integer) shortTermList.get(i).get("gisu_num");
				if(gisu_num == 1) { // 800~899 Python 단기 과정 --> 1 파이썬 첫걸음만 가져오도록 함
					HashMap<String, Object> resultMap = shortTermList.get(i);
					resultMap.put("paySeq", seaService.selectShortTermPayInfo(shortTermList.get(i).get("gisu_seq").toString()).getSeq());
					resultMap.put("payAmount", seaService.selectShortTermPayInfo(shortTermList.get(i).get("gisu_seq").toString()).getAmount());
					resultList.add(resultMap);
				}
			}
		}
		Collections.sort(resultList, new Comparator<HashMap<String, Object>>() {
			@Override
			public int compare(HashMap<String, Object> o1, HashMap<String, Object> o2) {
				return ((Integer) o1.get("gisu_num")).compareTo((Integer) o2.get("gisu_num"));
			}
		});

		model.addAttribute("shortTermList", resultList);
		
		String path = eduApplyCurriculumGisuInsertImage;
		model.addAttribute("path", path);
		}catch(Exception e){
			e.printStackTrace();
		}
		logger.debug("모집홍보 Python 단기 과정 페이지 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_EDU_APPLY_SHORT_TERM_PYTHON;
	}
	
	/**
	 * @Method Name : short_term_java1
	 * @Date : 2019. 9. 2.
	 * @User : 정병준
	 * @Param : -
	 * @Return : JSP 리턴페이지(모집홍보 JAVA 단기 과정1)
	 * @Method 설명 : 모집홍보 JAVA 단기 과정1을 호출하는 컨트롤러 함수
	 */
	@RequestMapping(value = PathConstants.SOCIETY_EDU_APPLY_SHORT_TERM_JAVA1, method = RequestMethod.GET)
	public String short_term_java1(Model model, Authentication auth){
		logger.debug("모집홍보 JAVA 단기 과정1 페이지 컨트롤러 시작");
		
		String user_id = "";
		if(auth != null){
			user_id = auth.getName();
		}
		ArrayList<HashMap<String, Object>> shortTermList = seaService.selectShortTermList(user_id, "A1204");
		ArrayList<HashMap<String, Object>> resultList = new ArrayList<>();
		
		if(shortTermList == null) {
			shortTermList = new ArrayList<>();
		}else {
			for(int i=0;i<shortTermList.size();i++) {
				Integer gisu_num = (Integer) shortTermList.get(i).get("gisu_num");
				if(gisu_num >= 1000 && gisu_num < 1400) { // 1000~1099 JAVA 단기 과정1 오전반, 1100~1199 JAVA 단기 과정1 오후반, 1200~1299 JAVA 단기 과정1 야간반, 1300~1399 JAVA 단기 과정1 주말반
					HashMap<String, Object> resultMap = shortTermList.get(i);
					resultMap.put("paySeq", seaService.selectShortTermPayInfo(shortTermList.get(i).get("gisu_seq").toString()).getSeq());
					resultMap.put("payAmount", seaService.selectShortTermPayInfo(shortTermList.get(i).get("gisu_seq").toString()).getAmount());
					resultList.add(resultMap);
				}
			}
		}
		Collections.sort(resultList, new Comparator<HashMap<String, Object>>() {
			@Override
			public int compare(HashMap<String, Object> o1, HashMap<String, Object> o2) {
				return ((Integer) o1.get("gisu_num")).compareTo((Integer) o2.get("gisu_num"));
			}
		});

		model.addAttribute("shortTermList", resultList);
		
		String path = eduApplyCurriculumGisuInsertImage;
		model.addAttribute("path", path);
		
		logger.debug("모집홍보 JAVA 단기 과정1 페이지 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_EDU_APPLY_SHORT_TERM_JAVA1;
	}
	
	/**
	 * @Method Name : short_term_java2
	 * @Date : 2019. 9. 2.
	 * @User : 정병준
	 * @Param : -
	 * @Return : JSP 리턴페이지(모집홍보 JAVA 단기 과정2)
	 * @Method 설명 : 모집홍보 JAVA 단기 과정2를 호출하는 컨트롤러 함수
	 */
	@RequestMapping(value = PathConstants.SOCIETY_EDU_APPLY_SHORT_TERM_JAVA2, method = RequestMethod.GET)
	public String short_term_java2(Model model, Authentication auth){
		logger.debug("모집홍보 JAVA 단기 과정2 페이지 컨트롤러 시작");
		
		String user_id = "";
		if(auth != null){
			user_id = auth.getName();
		}
		ArrayList<HashMap<String, Object>> shortTermList = seaService.selectShortTermList(user_id, "A1204");
		ArrayList<HashMap<String, Object>> resultList = new ArrayList<>();
		
		if(shortTermList == null) {
			shortTermList = new ArrayList<>();
		}else {
			for(int i=0;i<shortTermList.size();i++) {
				Integer gisu_num = (Integer) shortTermList.get(i).get("gisu_num");
				if(gisu_num >= 1400 && gisu_num < 1800) { // 1400~1499 JAVA 단기 과정2 오전반, 1500~1599 JAVA 단기 과정2 오후반, 1600~1699 JAVA 단기 과정2 야간반, 1700~1799 JAVA 단기 과정2 주말반
					HashMap<String, Object> resultMap = shortTermList.get(i);
					resultMap.put("paySeq", seaService.selectShortTermPayInfo(shortTermList.get(i).get("gisu_seq").toString()).getSeq());
					resultMap.put("payAmount", seaService.selectShortTermPayInfo(shortTermList.get(i).get("gisu_seq").toString()).getAmount());
					resultList.add(resultMap);
				}
			}
		}
		Collections.sort(resultList, new Comparator<HashMap<String, Object>>() {
			@Override
			public int compare(HashMap<String, Object> o1, HashMap<String, Object> o2) {
				return ((Integer) o1.get("gisu_num")).compareTo((Integer) o2.get("gisu_num"));
			}
		});

		model.addAttribute("shortTermList", resultList);
		
		String path = eduApplyCurriculumGisuInsertImage;
		model.addAttribute("path", path);
		
		logger.debug("모집홍보 JAVA 단기 과정2 페이지 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_EDU_APPLY_SHORT_TERM_JAVA2;
	}
	
	/**
	 * @Method Name : short_term_work_in_japan
	 * @Date : 2019. 9. 30.
	 * @User : 정병준
	 * @Param : -
	 * @Return : JSP 리턴페이지(모집홍보 일본취업 프로그램 단기 과정)
	 * @Method 설명 : 모집홍보 일본취업 프로그램 단기 과정을 호출하는 컨트롤러 함수
	 */
	@RequestMapping(value = PathConstants.SOCIETY_EDU_APPLY_SHORT_TERM_WORK_IN_JAPAN, method = RequestMethod.GET)
	public String short_term_work_in_japan(Model model, Authentication auth){
		logger.debug("모집홍보 일본취업 프로그램 단기 과정 페이지 컨트롤러 시작");
		
		String user_id = "";
		if(auth != null){
			user_id = auth.getName();
		}
		ArrayList<HashMap<String, Object>> shortTermList = seaService.selectShortTermList(user_id, "A1204");
		ArrayList<HashMap<String, Object>> resultList = new ArrayList<>();
		
		if(shortTermList == null) {
			shortTermList = new ArrayList<>();
		}else {
			for(int i=0;i<shortTermList.size();i++) {
				Integer gisu_num = (Integer) shortTermList.get(i).get("gisu_num");
				/*
				 * 10000~10099 일본취업 프로그램 단기 과정 종합반
				 * 10100~10199 일본취업 프로그램 단기 과정 1단계
				 * 10200~10299 일본취업 프로그램 단기 과정 2단계 
				 * 10300~10399 일본취업 프로그램 단기 과정 3단계
				 * 10400~10499 일본취업 프로그램 단기 과정 4단계 
				 * 10500~10599 일본취업 프로그램 단기 과정 5단계
				 * 10600~10699 일본취업 프로그램 단기 과정 6단계
				 */
				if(gisu_num >= 10000 && gisu_num < 10700) {
					HashMap<String, Object> resultMap = shortTermList.get(i);
					resultMap.put("paySeq", seaService.selectShortTermPayInfo(shortTermList.get(i).get("gisu_seq").toString()).getSeq());
					resultMap.put("payAmount", seaService.selectShortTermPayInfo(shortTermList.get(i).get("gisu_seq").toString()).getAmount());
					resultList.add(resultMap);
				}
			}
		}
		Collections.sort(resultList, new Comparator<HashMap<String, Object>>() {
			@Override
			public int compare(HashMap<String, Object> o1, HashMap<String, Object> o2) {
				return ((Integer) o1.get("gisu_num")).compareTo((Integer) o2.get("gisu_num"));
			}
		});

		model.addAttribute("shortTermList", resultList);
		
		logger.debug("모집홍보 일본취업 프로그램 단기 과정 페이지 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_EDU_APPLY_SHORT_TERM_WORK_IN_JAPAN;
	}
	
	/**
	 * @Method Name : short_term_japan_oa
	 * @Date : 2019. 9. 30.
	 * @User : 정병준
	 * @Param : -
	 * @Return : JSP 리턴페이지(모집홍보 일본어 OA 단기 과정)
	 * @Method 설명 : 모집홍보 일본어 OA 단기 과정을 호출하는 컨트롤러 함수
	 */
	@RequestMapping(value = PathConstants.SOCIETY_EDU_APPLY_SHORT_TERM_JAPAN_OA, method = RequestMethod.GET)
	public String short_term_japan_oa(Model model, Authentication auth){
		logger.debug("모집홍보 일본어 OA 단기 과정 페이지 컨트롤러 시작");
		
		String user_id = "";
		if(auth != null){
			user_id = auth.getName();
		}
		ArrayList<HashMap<String, Object>> shortTermList = seaService.selectShortTermList(user_id, "A1204");
		ArrayList<HashMap<String, Object>> resultList = new ArrayList<>();
		
		if(shortTermList == null) {
			shortTermList = new ArrayList<>();
		}else {
			for(int i=0;i<shortTermList.size();i++) {
				Integer gisu_num = (Integer) shortTermList.get(i).get("gisu_num");
				/*
				 * 10700~10799 일본어 OA 단기 과정
				 */
				if(gisu_num >= 10700 && gisu_num < 10800) {
					HashMap<String, Object> resultMap = shortTermList.get(i);
					resultMap.put("paySeq", seaService.selectShortTermPayInfo(shortTermList.get(i).get("gisu_seq").toString()).getSeq());
					resultMap.put("payAmount", seaService.selectShortTermPayInfo(shortTermList.get(i).get("gisu_seq").toString()).getAmount());
					resultList.add(resultMap);
				}
			}
		}
		Collections.sort(resultList, new Comparator<HashMap<String, Object>>() {
			@Override
			public int compare(HashMap<String, Object> o1, HashMap<String, Object> o2) {
				return ((Integer) o1.get("gisu_num")).compareTo((Integer) o2.get("gisu_num"));
			}
		});

		model.addAttribute("shortTermList", resultList);
		
		logger.debug("모집홍보 일본어 OA 단기 과정 페이지 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_EDU_APPLY_SHORT_TERM_JAPAN_OA;
	}
	
	/**
	 * @Method Name : short_term_japan_on_demand
	 * @Date : 2019. 9. 30.
	 * @User : 정병준
	 * @Param : -
	 * @Return : JSP 리턴페이지(모집홍보 일본어 On Demand 단기 과정)
	 * @Method 설명 : 모집홍보 일본어 On Demand 단기 과정을 호출하는 컨트롤러 함수
	 */
	@RequestMapping(value = PathConstants.SOCIETY_EDU_APPLY_SHORT_TERM_JAPAN_ON_DEMAND, method = RequestMethod.GET)
	public String short_term_japan_on_demand(Model model, Authentication auth){
		logger.debug("모집홍보 일본어 On Demand 단기 과정 페이지 컨트롤러 시작");
		
		String user_id = "";
		if(auth != null){
			user_id = auth.getName();
		}
		ArrayList<HashMap<String, Object>> shortTermList = seaService.selectShortTermList(user_id, "A1204");
		ArrayList<HashMap<String, Object>> resultList = new ArrayList<>();
		
		if(shortTermList == null) {
			shortTermList = new ArrayList<>();
		}else {
			for(int i=0;i<shortTermList.size();i++) {
				Integer gisu_num = (Integer) shortTermList.get(i).get("gisu_num");
				/*
				 * 10800~10899 일본어 On Demand 단기 과정
				 */
				if(gisu_num >= 10800 && gisu_num < 10900) {
					HashMap<String, Object> resultMap = shortTermList.get(i);
					resultMap.put("paySeq", seaService.selectShortTermPayInfo(shortTermList.get(i).get("gisu_seq").toString()).getSeq());
					resultMap.put("payAmount", seaService.selectShortTermPayInfo(shortTermList.get(i).get("gisu_seq").toString()).getAmount());
					resultList.add(resultMap);
				}
			}
		}
		Collections.sort(resultList, new Comparator<HashMap<String, Object>>() {
			@Override
			public int compare(HashMap<String, Object> o1, HashMap<String, Object> o2) {
				return ((Integer) o1.get("gisu_num")).compareTo((Integer) o2.get("gisu_num"));
			}
		});

		model.addAttribute("shortTermList", resultList);
		
		logger.debug("모집홍보 일본어 On Demand 단기 과정 페이지 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_EDU_APPLY_SHORT_TERM_JAPAN_ON_DEMAND;
	}
	
	/**
	 * @Method Name : short_term_japan_employment
	 * @Date : 2019. 9. 30.
	 * @User : 정병준
	 * @Param : -
	 * @Return : JSP 리턴페이지(모집홍보 일본어 Employment 단기 과정)
	 * @Method 설명 : 모집홍보 일본어 Employment 단기 과정을 호출하는 컨트롤러 함수
	 */
	@RequestMapping(value = PathConstants.SOCIETY_EDU_APPLY_SHORT_TERM_JAPAN_EMPLOYMENT, method = RequestMethod.GET)
	public String short_term_japan_employment(Model model, Authentication auth){
		logger.debug("모집홍보 일본어 Employment 단기 과정 페이지 컨트롤러 시작");
		
		String user_id = "";
		if(auth != null){
			user_id = auth.getName();
		}
		ArrayList<HashMap<String, Object>> shortTermList = seaService.selectShortTermList(user_id, "A1204");
		ArrayList<HashMap<String, Object>> resultList = new ArrayList<>();
		
		if(shortTermList == null) {
			shortTermList = new ArrayList<>();
		}else {
			for(int i=0;i<shortTermList.size();i++) {
				Integer gisu_num = (Integer) shortTermList.get(i).get("gisu_num");
				/*
				 * 10900~10999 일본어 Employment 단기 과정
				 */
				if(gisu_num >= 10900 && gisu_num < 11000) {
					HashMap<String, Object> resultMap = shortTermList.get(i);
					resultMap.put("paySeq", seaService.selectShortTermPayInfo(shortTermList.get(i).get("gisu_seq").toString()).getSeq());
					resultMap.put("payAmount", seaService.selectShortTermPayInfo(shortTermList.get(i).get("gisu_seq").toString()).getAmount());
					resultList.add(resultMap);
				}
			}
		}
		Collections.sort(resultList, new Comparator<HashMap<String, Object>>() {
			@Override
			public int compare(HashMap<String, Object> o1, HashMap<String, Object> o2) {
				return ((Integer) o1.get("gisu_num")).compareTo((Integer) o2.get("gisu_num"));
			}
		});

		model.addAttribute("shortTermList", resultList);
		
		logger.debug("모집홍보 일본어 Employment 단기 과정 페이지 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_EDU_APPLY_SHORT_TERM_JAPAN_EMPLOYMENT;
	}
	
	/**
	 * @Method Name : short_term_japan_sjpt
	 * @Date : 2019. 9. 30.
	 * @User : 정병준
	 * @Param : -
	 * @Return : JSP 리턴페이지(모집홍보 일본어 SJPT 단기 과정)
	 * @Method 설명 : 모집홍보 일본어 SJPT 단기 과정을 호출하는 컨트롤러 함수
	 */
	@RequestMapping(value = PathConstants.SOCIETY_EDU_APPLY_SHORT_TERM_JAPAN_SJPT, method = RequestMethod.GET)
	public String short_term_japan_sjpt(Model model, Authentication auth){
		logger.debug("모집홍보 일본어 SJPT 단기 과정 페이지 컨트롤러 시작");
		
		String user_id = "";
		if(auth != null){
			user_id = auth.getName();
		}
		ArrayList<HashMap<String, Object>> shortTermList = seaService.selectShortTermList(user_id, "A1204");
		ArrayList<HashMap<String, Object>> resultList = new ArrayList<>();
		
		if(shortTermList == null) {
			shortTermList = new ArrayList<>();
		}else {
			for(int i=0;i<shortTermList.size();i++) {
				Integer gisu_num = (Integer) shortTermList.get(i).get("gisu_num");
				/*
				 * 11000~11299 일본어 SJPT 단기 과정
				 */
				if(gisu_num >= 11000 && gisu_num < 11300) {
					HashMap<String, Object> resultMap = shortTermList.get(i);
					resultMap.put("paySeq", seaService.selectShortTermPayInfo(shortTermList.get(i).get("gisu_seq").toString()).getSeq());
					resultMap.put("payAmount", seaService.selectShortTermPayInfo(shortTermList.get(i).get("gisu_seq").toString()).getAmount());
					resultList.add(resultMap);
				}
			}
		}
		Collections.sort(resultList, new Comparator<HashMap<String, Object>>() {
			@Override
			public int compare(HashMap<String, Object> o1, HashMap<String, Object> o2) {
				return ((Integer) o1.get("gisu_num")).compareTo((Integer) o2.get("gisu_num"));
			}
		});

		model.addAttribute("shortTermList", resultList);
		
		logger.debug("모집홍보 일본어 SJPT 단기 과정 페이지 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_EDU_APPLY_SHORT_TERM_JAPAN_SJPT;
	}
	
	/**
	 * @Method Name : short_term_japan_business
	 * @Date : 2019. 12. 18.
	 * @User : 전상수
	 * @Param : -
	 * @Return : JSP 리턴페이지(모집홍보 일본어 회화 단기 과정)
	 * @Method 설명 : 모집홍보 일본어 회화 단기 과정을 호출하는 컨트롤러 함수
	 */
	@RequestMapping(value = PathConstants.SOCIETY_EDU_APPLY_SHORT_TERM_JAPAN_BUSINESS, method = RequestMethod.GET)
	public String short_term_japan_business(Model model, Authentication auth){
		logger.debug("모집홍보 일본어 회화 단기 과정 페이지 컨트롤러 시작");
		
		String user_id = "";
		if(auth != null){
			user_id = auth.getName();
		}
		ArrayList<HashMap<String, Object>> shortTermList = seaService.selectShortTermList(user_id, "A1204");
		ArrayList<HashMap<String, Object>> resultList = new ArrayList<>();
		
		if(shortTermList == null) {
			shortTermList = new ArrayList<>();
		}else {
			for(int i=0;i<shortTermList.size();i++) {
				Integer gisu_num = (Integer) shortTermList.get(i).get("gisu_num");
				/*
				 * 11300~11500 일본어 회화 단기 과정
				 */
				if(gisu_num >= 11300 && gisu_num <= 11500) {
					HashMap<String, Object> resultMap = shortTermList.get(i);
					resultMap.put("paySeq", seaService.selectShortTermPayInfo(shortTermList.get(i).get("gisu_seq").toString()).getSeq());
					resultMap.put("payAmount", seaService.selectShortTermPayInfo(shortTermList.get(i).get("gisu_seq").toString()).getAmount());
					resultList.add(resultMap);
				}
			}
		}
		Collections.sort(resultList, new Comparator<HashMap<String, Object>>() {
			@Override
			public int compare(HashMap<String, Object> o1, HashMap<String, Object> o2) {
				return ((Integer) o1.get("gisu_num")).compareTo((Integer) o2.get("gisu_num"));
			}
		});

		model.addAttribute("shortTermList", resultList);
		
		logger.debug("모집홍보 일본어 회화 단기 과정 페이지 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_EDU_APPLY_SHORT_TERM_JAPAN_BUSINESS;
	}
	
	
	/**
	 * @Method Name : short_term_japan_freetalk
	 * @Date : 2019. 12. 18.
	 * @User : 전상수
	 * @Param : -
	 * @Return : JSP 리턴페이지(모집홍보 일본어 회화 단기 과정)
	 * @Method 설명 : 모집홍보 일본어 개인회화 단기 과정을 호출하는 컨트롤러 함수
	 */
	@RequestMapping(value = PathConstants.SOCIETY_EDU_APPLY_SHORT_TERM_JAPAN_FREETALK, method = RequestMethod.GET)
	public String short_term_japan_freetalk(Model model, Authentication auth){
		logger.debug("모집홍보 일본어 개인회화 단기 과정 페이지 컨트롤러 시작");
		
		String user_id = "";
		if(auth != null){
			user_id = auth.getName();
		}
		ArrayList<HashMap<String, Object>> shortTermList = seaService.selectShortTermList(user_id, "A1204");
		ArrayList<HashMap<String, Object>> resultList = new ArrayList<>();
		
		if(shortTermList == null) {
			shortTermList = new ArrayList<>();
		}else {
			for(int i=0;i<shortTermList.size();i++) {
				Integer gisu_num = (Integer) shortTermList.get(i).get("gisu_num");
				/*
				 * 11600~11699 일본어 개인회화 단기 과정
				 */
				if(gisu_num >= 11600 && gisu_num < 11700) {
					HashMap<String, Object> resultMap = shortTermList.get(i);
					resultMap.put("paySeq", seaService.selectShortTermPayInfo(shortTermList.get(i).get("gisu_seq").toString()).getSeq());
					resultMap.put("payAmount", seaService.selectShortTermPayInfo(shortTermList.get(i).get("gisu_seq").toString()).getAmount());
					resultList.add(resultMap);
				}
			}
		}
		Collections.sort(resultList, new Comparator<HashMap<String, Object>>() {
			@Override
			public int compare(HashMap<String, Object> o1, HashMap<String, Object> o2) {
				return ((Integer) o1.get("gisu_num")).compareTo((Integer) o2.get("gisu_num"));
			}
		});

		model.addAttribute("shortTermList", resultList);
		
		logger.debug("모집홍보 일본어 개인회화 단기 과정 페이지 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_EDU_APPLY_SHORT_TERM_JAPAN_FREETALK;
	}
	
	
	/**
	 * @Method Name : short_term_japan_jpt
	 * @Date : 2019. 12. 18.
	 * @User : 전상수
	 * @Param : -
	 * @Return : JSP 리턴페이지(모집홍보 일본어 SJPT 단기 과정)
	 * @Method 설명 : 모집홍보 일본어 SJPT 단기 과정을 호출하는 컨트롤러 함수
	 */
	@RequestMapping(value = PathConstants.SOCIETY_EDU_APPLY_SHORT_TERM_JAPAN_JPT, method = RequestMethod.GET)
	public String short_term_japan_jpt(Model model, Authentication auth){
		logger.debug("모집홍보 일본어 JPT 단기 과정 페이지 컨트롤러 시작");
		
		String user_id = "";
		if(auth != null){
			user_id = auth.getName();
		}
		ArrayList<HashMap<String, Object>> shortTermList = seaService.selectShortTermList(user_id, "A1204");
		ArrayList<HashMap<String, Object>> resultList = new ArrayList<>();
		
		if(shortTermList == null) {
			shortTermList = new ArrayList<>();
		}else {
			for(int i=0;i<shortTermList.size();i++) {
				Integer gisu_num = (Integer) shortTermList.get(i).get("gisu_num");
				/*
				 * 11700~11799 일본어 JPT 단기 과정
				 */
				if(gisu_num >= 11700 && gisu_num < 11800) {
					HashMap<String, Object> resultMap = shortTermList.get(i);
					resultMap.put("paySeq", seaService.selectShortTermPayInfo(shortTermList.get(i).get("gisu_seq").toString()).getSeq());
					resultMap.put("payAmount", seaService.selectShortTermPayInfo(shortTermList.get(i).get("gisu_seq").toString()).getAmount());
					resultList.add(resultMap);
				}
			}
		}
		Collections.sort(resultList, new Comparator<HashMap<String, Object>>() {
			@Override
			public int compare(HashMap<String, Object> o1, HashMap<String, Object> o2) {
				return ((Integer) o1.get("gisu_num")).compareTo((Integer) o2.get("gisu_num"));
			}
		});

		model.addAttribute("shortTermList", resultList);
		
		logger.debug("모집홍보 일본어 JPT 단기 과정 페이지 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_EDU_APPLY_SHORT_TERM_JAPAN_JPT;
	}
	
	/**
	 * @Method Name : short_term_japan_business_all
	 * @Date : 2019. 12. 18.
	 * @User : 전상수
	 * @Param : -
	 * @Return : JSP 리턴페이지(모집홍보 일본어 회화 단기 과정)
	 * @Method 설명 : 모집홍보 일본어 회화 단기 과정을 호출하는 컨트롤러 함수
	 */
	@RequestMapping(value = PathConstants.SOCIETY_EDU_APPLY_SHORT_TERM_JAPAN_BUSINESS_ALL, method = RequestMethod.GET)
	public String short_term_japan_business_all(Model model, Authentication auth){
		logger.debug("모집홍보 일본어 회화 단기 과정 페이지 컨트롤러 시작");
		
		String user_id = "";
		if(auth != null){
			user_id = auth.getName();
		}
		ArrayList<HashMap<String, Object>> shortTermList = seaService.selectShortTermList(user_id, "A1204");
		ArrayList<HashMap<String, Object>> resultList = new ArrayList<>();
		
		if(shortTermList == null) {
			shortTermList = new ArrayList<>();
		}else {
			for(int i=0;i<shortTermList.size();i++) {
				Integer gisu_num = (Integer) shortTermList.get(i).get("gisu_num");
				/*
				 * 11300~11500 일본어 회화 단기 과정
				 */
				if(gisu_num >= 11800 && gisu_num < 11900) {
					HashMap<String, Object> resultMap = shortTermList.get(i);
					resultMap.put("paySeq", seaService.selectShortTermPayInfo(shortTermList.get(i).get("gisu_seq").toString()).getSeq());
					resultMap.put("payAmount", seaService.selectShortTermPayInfo(shortTermList.get(i).get("gisu_seq").toString()).getAmount());
					resultList.add(resultMap);
				}
			}
		}
		Collections.sort(resultList, new Comparator<HashMap<String, Object>>() {
			@Override
			public int compare(HashMap<String, Object> o1, HashMap<String, Object> o2) {
				return ((Integer) o1.get("gisu_num")).compareTo((Integer) o2.get("gisu_num"));
			}
		});

		model.addAttribute("shortTermList", resultList);
		
		logger.debug("모집홍보 일본어 회화 단기 과정 페이지 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_EDU_APPLY_SHORT_TERM_JAPAN_BUSINESS_ALL;
	}
	
	
	/**
	 * @Method Name : short_term_japan_freetalk_all
	 * @Date : 2019. 12. 18.
	 * @User : 전상수
	 * @Param : -
	 * @Return : JSP 리턴페이지(모집홍보 일본어 회화 단기 과정)
	 * @Method 설명 : 모집홍보 일본어 개인회화 단기 과정을 호출하는 컨트롤러 함수
	 */
	@RequestMapping(value = PathConstants.SOCIETY_EDU_APPLY_SHORT_TERM_JAPAN_FREETALK_ALL, method = RequestMethod.GET)
	public String short_term_japan_freetalk_all(Model model, Authentication auth){
		logger.debug("모집홍보 일본어 개인회화 단기 과정 페이지 컨트롤러 시작");
		
		String user_id = "";
		if(auth != null){
			user_id = auth.getName();
		}
		ArrayList<HashMap<String, Object>> shortTermList = seaService.selectShortTermList(user_id, "A1204");
		ArrayList<HashMap<String, Object>> resultList = new ArrayList<>();
		
		if(shortTermList == null) {
			shortTermList = new ArrayList<>();
		}else {
			for(int i=0;i<shortTermList.size();i++) {
				Integer gisu_num = (Integer) shortTermList.get(i).get("gisu_num");
				/*
				 * 11600~11699 일본어 개인회화 단기 과정
				 */
				if(gisu_num >= 11900 && gisu_num < 12000) {
					HashMap<String, Object> resultMap = shortTermList.get(i);
					resultMap.put("paySeq", seaService.selectShortTermPayInfo(shortTermList.get(i).get("gisu_seq").toString()).getSeq());
					resultMap.put("payAmount", seaService.selectShortTermPayInfo(shortTermList.get(i).get("gisu_seq").toString()).getAmount());
					resultList.add(resultMap);
				}
			}
		}
		Collections.sort(resultList, new Comparator<HashMap<String, Object>>() {
			@Override
			public int compare(HashMap<String, Object> o1, HashMap<String, Object> o2) {
				return ((Integer) o1.get("gisu_num")).compareTo((Integer) o2.get("gisu_num"));
			}
		});

		model.addAttribute("shortTermList", resultList);
		
		logger.debug("모집홍보 일본어 개인회화 단기 과정 페이지 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_EDU_APPLY_SHORT_TERM_JAPAN_FREETALK_ALL;
	}
	
	
	/**
	 * @Method Name : short_term_japan_jpt_all
	 * @Date : 2019. 12. 18.
	 * @User : 전상수
	 * @Param : -
	 * @Return : JSP 리턴페이지(모집홍보 일본어 SJPT 단기 과정)
	 * @Method 설명 : 모집홍보 일본어 SJPT 단기 과정을 호출하는 컨트롤러 함수
	 */
	@RequestMapping(value = PathConstants.SOCIETY_EDU_APPLY_SHORT_TERM_JAPAN_JPT_ALL, method = RequestMethod.GET)
	public String short_term_japan_jpt_all(Model model, Authentication auth){
		logger.debug("모집홍보 일본어 JPT 단기 과정 페이지 컨트롤러 시작");
		
		String user_id = "";
		if(auth != null){
			user_id = auth.getName();
		}
		ArrayList<HashMap<String, Object>> shortTermList = seaService.selectShortTermList(user_id, "A1204");
		ArrayList<HashMap<String, Object>> resultList = new ArrayList<>();
		
		if(shortTermList == null) {
			shortTermList = new ArrayList<>();
		}else {
			for(int i=0;i<shortTermList.size();i++) {
				Integer gisu_num = (Integer) shortTermList.get(i).get("gisu_num");
				/*
				 * 11700~11799 일본어 JPT 단기 과정
				 */
				if(gisu_num >= 12000 && gisu_num < 13000) {
					HashMap<String, Object> resultMap = shortTermList.get(i);
					resultMap.put("paySeq", seaService.selectShortTermPayInfo(shortTermList.get(i).get("gisu_seq").toString()).getSeq());
					resultMap.put("payAmount", seaService.selectShortTermPayInfo(shortTermList.get(i).get("gisu_seq").toString()).getAmount());
					resultList.add(resultMap);
				}
			}
		}
		Collections.sort(resultList, new Comparator<HashMap<String, Object>>() {
			@Override
			public int compare(HashMap<String, Object> o1, HashMap<String, Object> o2) {
				return ((Integer) o1.get("gisu_num")).compareTo((Integer) o2.get("gisu_num"));
			}
		});

		model.addAttribute("shortTermList", resultList);
		
		logger.debug("모집홍보 일본어 JPT 단기 과정 페이지 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_EDU_APPLY_SHORT_TERM_JAPAN_JPT_ALL;
	}
	
	
	@RequestMapping(value = PathConstants.SOCIETY_EDU_APPLY_ORACLE_MENU, method = RequestMethod.GET)
	public String oracle_menu(Model model, Authentication auth){
		logger.debug("모집홍보 오라클 과정 리스트 검색 컨트롤러 시작");
		
		model.addAttribute("shortTermList", seaService.selectShortTermInfo("ORACLE"));
		
		String path = eduApplyCurriculumGisuInsertImage;
		model.addAttribute("path", path);
		
		logger.debug("모집홍보 오라클 과정 리스트 검색 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_EDU_APPLY_ORACLE_MENU;
	}
	
	@RequestMapping(value = PathConstants.SOCIETY_EDU_APPLY_IT101_DETAIL, method = RequestMethod.GET)
	public String it101_detail(int gisu_seq, Model model, Authentication auth){
		logger.debug("모집홍보 IT 101 과정 상세화면 컨트롤러 시작");

		model.addAttribute("seaCurGisu",seaService.searchCurGisu(gisu_seq));
		
		String path = eduApplyCurriculumGisuInsertImage;
		model.addAttribute("path", path);
		
		logger.debug("모집홍보 IT 101 과정 상세화면 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_EDU_APPLY_IT101_DETAIL;
	}
	
	@RequestMapping(value = PathConstants.SOCIETY_EDU_APPLY_CUP_DETAIL, method = RequestMethod.GET)
	public String cup_detail(int gisu_seq, Model model, Authentication auth){
		logger.debug("모집홍보 사전학습 과정 상세화면 컨트롤러 시작");
		SocietyEduAdminCurriculumGisu temp = seaService.searchCurGisu(gisu_seq);
		model.addAttribute("seaCurGisu",temp);
		model.addAttribute("SEAPayInfo",seaService.selectShortTermPayInfo(String.valueOf(temp.getGisu_seq())));
		String path = eduApplyCurriculumGisuInsertImage;
		model.addAttribute("path", path);
		
		logger.debug("모집홍보 사전학습 과정 상세화면 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_EDU_APPLY_CUP_DETAIL;
	}
	
	@RequestMapping(value = PathConstants.SOCIETY_EDU_APPLY_ORACLE_DETAIL, method = RequestMethod.GET)
	public String oracle_detail(int gisu_seq, Model model, Authentication auth){
		logger.debug("모집홍보 오라클 과정 상세화면 컨트롤러 시작");

		model.addAttribute("seaCurGisu",seaService.searchCurGisu(gisu_seq));
		
		String path = eduApplyCurriculumGisuInsertImage;
		model.addAttribute("path", path);
		
		logger.debug("모집홍보 오라클 과정 상세화면 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_EDU_APPLY_ORACLE_DETAIL;
	}
	
	/**
	 * @Method Name : apply_form
	 * @Date : 2017. 7. 31.
	 * @User : 이종호
	 * @Param : 기수 시퀀스 정보
	 * @Return : JSP 리턴페이지(SMART Cloud IT마스터 지원신청서 페이지)
	 * @Method 설명 : 로그인 한 회원 정보를 SMART Cloud IT마스터 지원신청서 페이지로 전달
	 */
	@RequestMapping(value = PathConstants.SOCIETY_EDU_APPLY_FORM , method = RequestMethod.GET)
	public String apply_form(int gisu_seq, Model model, Authentication auth){
		
		HashMap<String, Object> param = new HashMap<>();
		
		if(auth==null){
			return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_EDU_USER_LOGIN_FORM;
		}
		
		param.put("user_id", auth.getName());
		param.put("gisu_seq", gisu_seq);
		model.addAttribute("gisu_seq", gisu_seq);
		
		if(seaService.selectEduApplyResult(param) != null){
			return "redirect:"+PathConstants.SOCIETY_EDU_APPLY_UPDATE_FORM;
		}else{
			return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_EDU_APPLY_FORM;
		}
		
		
	}
	
	@RequestMapping(value = PathConstants.SOCIETY_EDU_APPLY_UPDATE_FORM , method = RequestMethod.GET)
	public String apply_update_form(int gisu_seq, Model model, Authentication auth){
		HashMap<String, Object> param = new HashMap<>();

		if(auth==null){
			return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_EDU_USER_LOGIN_FORM;
		}
		param.put("user_id", auth.getName());
		param.put("gisu_seq", gisu_seq);
		
		HashMap<String, Object> el = seaService.selectEduApply(param);
		model.addAttribute("eduApply", el);
		model.addAttribute("app_self_intro",el.get("app_self_intro"));
		Gson gson = new Gson();
		el.remove("app_self_intro");
		model.addAttribute("eduApplyJson", gson.toJson(el));
		
		return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_EDU_APPLY_UPDATE_FORM;
	}
	
	/**
	 * @Method Name : apply_seoul_form
	 * @Date : 2019. 3. 5.
	 * @User : 이종호
	 * @Param : 기수 시퀀스 정보
	 * @Return : JSP 리턴페이지(SMART Cloud IT마스터 지원신청서 페이지)
	 * @Method 설명 : 로그인 한 회원 정보를 SMART Cloud IT마스터 지원신청서 페이지로 전달
	 */
	@RequestMapping(value = PathConstants.SOCIETY_EDU_APPLY_SEOUL_FORM , method = RequestMethod.GET)
	public String apply_seoul_form(int gisu_seq, Model model, Authentication auth){
		
		HashMap<String, Object> param = new HashMap<>();

		if(auth==null){
			return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_EDU_USER_LOGIN_FORM;
		}
		param.put("user_id", auth.getName());
		param.put("gisu_seq", gisu_seq);
		model.addAttribute("gisu_seq", gisu_seq);
		
		HashMap<String, String> params = new HashMap<String, String>();
		params.put("user_id", auth.getName());
		params.put("user_flag", "A0101");
		
		sgcService.updateUserFlag(params);
		
		if(seaService.selectEduApplyResult(param) != null){
			return "redirect:"+PathConstants.SOCIETY_EDU_APPLY_SEOUL_UPDATE_FORM;
		}else{
			return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_EDU_APPLY_SEOUL_FORM;
		}
		
		
	}
	
	@RequestMapping(value = PathConstants.SOCIETY_EDU_APPLY_SEOUL_UPDATE_FORM , method = RequestMethod.GET)
	public String apply_seoul_update_form(int gisu_seq, Model model, Authentication auth){
		HashMap<String, Object> param = new HashMap<>();

		if(auth==null){
			return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_EDU_USER_LOGIN_FORM;
		}
		param.put("user_id", auth.getName());
		param.put("gisu_seq", gisu_seq);
		
		HashMap<String, Object> el = seaService.selectEduApply(param);
		model.addAttribute("eduApply", el);
		model.addAttribute("app_self_intro",el.get("app_self_intro"));
		Gson gson = new Gson();
		el.remove("app_self_intro");
		model.addAttribute("eduApplyJson", gson.toJson(el));
		
		return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_EDU_APPLY_SEOUL_UPDATE_FORM;
	}
	
	/**
	 * @Method Name : apply_insert
	 * @Date : 2017. 7. 31.
	 * @User : 이종호
	 * @Param : SMART Cloud IT마스터 지원신청 정보(기본정보 , 학력, 경력, 교육이수, 언어능력, 자격증, 해외체류, 증빙자료)
	 * @Return : JSP 리턴페이지(TODO)
	 * @Method 설명 : 사용자로부터 입력받은 정보를 모집홍보 서비스로 전달한다.
	 */
	@RequestMapping(value = PathConstants.SOCIETY_EDU_APPLY_INSERT , method = RequestMethod.POST)
	public String apply_insert(SocietyEduApplyForm seaForm,SocietyEduApplyEduHistory seaEduHistory
											,SocietyEduApplyCareer seaCareer, SocietyEduApplyStudy seaStudy
											,SocietyEduApplyLanguage seaLanguage, SocietyEduApplyLicense seaLicense
											,SocietyEduApplyOverseas seaOverseas, SocietyEduApplyFile seaFile
											, Authentication auth){

		HashMap<String, Object> param = new HashMap<>();
		param.put("user_id", seaForm.getApp_id());
		param.put("gisu_seq", seaForm.getGisu_seq());

		if(seaService.selectEduApplyResult(param) == null){
			seaService.apply_insert(seaForm, seaEduHistory, seaCareer, seaStudy, seaLanguage, seaLicense, seaOverseas, seaFile);
		}
		
		return "redirect:"+PathConstants.SOCIETY_ICTCENTER;
	}
	
	/**
	 * @Method Name : apply_update
	 * @Date : 2017. 8. 16.
	 * @User : 이종호
	 * @Param : SMART Cloud IT마스터 지원신청 정보(기본정보 , 학력, 경력, 교육이수, 언어능력, 자격증, 해외체류, 증빙자료)
	 * @Return : JSP 리턴페이지 (모집홍보 지원 리스트)
	 * @Method 설명 : 지원신청 정보를 수정하는 컨트롤러 함수
	 */
	@Transactional
	@RequestMapping(value = PathConstants.SOCIETY_EDU_APPLY_UPDATE, method = RequestMethod.POST)
	public String apply_update(SocietyEduApplyForm seaForm,SocietyEduApplyEduHistory seaEduHistory
											,SocietyEduApplyCareer seaCareer, SocietyEduApplyStudy seaStudy
											,SocietyEduApplyLanguage seaLanguage, SocietyEduApplyLicense seaLicense
											,SocietyEduApplyOverseas seaOverseas, SocietyEduApplyFile seaFile){

		HashMap<String, Object> param = new HashMap<>();
		param.put("user_id", seaForm.getApp_id());
		param.put("gisu_seq", seaForm.getGisu_seq());
		
		seaService.apply_delete(param);
		seaService.apply_insert(seaForm, seaEduHistory, seaCareer, seaStudy, seaLanguage, seaLicense, seaOverseas, seaFile);

		return "redirect:"+PathConstants.SOCIETY_ICTCENTER;
	}
	
	
	/**
	 * @Method Name : faq_test_search
	 * @Date : 2018. 7. 20.
	 * @User : 김도훈
	 * @Param : 타입 구분, 온라인상담 및 FAQ 타입을 가진 게시판 타입 객체
	 * @Return : 온라인상담 및 FAQ게시판 시퀀스, 온라인상담 및 FAQ 타입 리스트 객체
	 * @Method 설명 : 특정 구분, 타입 값을 가진 FAQ게시판 리스트를 조회하는 컨트롤러 함수
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_EDU_APPLY_TEST, method = RequestMethod.POST)
	public ArrayList<FaqConsultingContents> faq_test_search(FaqConsultingContents ConsultingTp){
		logger.debug("온라인상담 및 FAQ게시판 타입별 리스트 조회 컨트롤러 함수 시작");
		
		ArrayList<FaqConsultingContents> resultList = seaService.faq_test_search(ConsultingTp);
		System.out.println(resultList);
		logger.debug("온라인상담 및 FAQ게시판 타입별 리스트 조회 컨트롤러 함수 종료");
		return resultList;
	}
	
	
}
