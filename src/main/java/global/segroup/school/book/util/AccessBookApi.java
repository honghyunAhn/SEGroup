package global.segroup.school.book.util;

import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import global.segroup.school.book.admin.domain.BookInfo;

/**
 * @Author : 이정식
 * @Date : 2017. 7. 18.
 * @Class 설명 : NAVER 검색 api에서 도서 상세 내용을 가져오는 class
 * 		상세 검색 조건 : 책 제목(d_titl), 저자명(d_auth), 목차(d_cont), ISBN(d_isbn) 중 하나 이상 입력
 * 		참고 site url : https://developers.naver.com/docs/search/book/
 */
public class AccessBookApi {
	
	private static final Logger logger = LoggerFactory.getLogger(AccessBookApi.class);
	private final int RESULT_NUMBER = 10;
	
	public AccessBookApi() {
		
	}
	
	/**
	 * @Method Name : searchByTitle
	 * @Date : 2017. 7. 19.
	 * @User : 이정식
	 * @Param : 사용자가 입력한 검색 문구
	 * @Return : api 검색 결과
	 * @Method 설명 : 책 제목으로 api에서 검색해서 책 세부정보를 가져오는 함수
	 */
	public ArrayList<BookInfo> searchByTitle(String userInput) {
		return accessApi("d_titl", userInput);
	}

	/**
	 * @Method Name : searchByAuthor
	 * @Date : 2017. 7. 19.
	 * @User : 이정식
	 * @Param : 사용자가 입력한 검색 문구
	 * @Return : api 검색 결과
	 * @Method 설명 : 저자명으로 api에서 검색해서 책 세부정보를 가져오는 함수
	 */
	public ArrayList<BookInfo> searchByAuthor(String userInput) {
		return accessApi("d_auth", userInput);
	}

	/**
	 * @Method Name : searchByContents
	 * @Date : 2017. 7. 19.
	 * @User : 이정식
	 * @Param : 사용자가 입력한 검색 문구
	 * @Return : api 검색 결과
	 * @Method 설명 : 목차로 api에서 검색해서 책 세부정보를 가져오는 함수
	 */
	public ArrayList<BookInfo> searchByContents(String userInput) {
		return accessApi("d_cont", userInput);
	}

	/**
	 * @Method Name : searchByIsbn
	 * @Date : 2017. 7. 19.
	 * @User : 이정식
	 * @Param : 사용자가 입력한 검색 문구
	 * @Return : api 검색 결과
	 * @Method 설명 : ISBN으로 api에서 검색해서 책 세부정보를 가져오는 함수
	 */
	public ArrayList<BookInfo> searchByIsbn(String userInput) {
		return accessApi("d_isbn", userInput);
	}

	/**
	 * @Method Name : accessApi
	 * @Date : 2017. 7. 19.
	 * @User : 이정식
	 * @Param : api에서 검색할 종류(저자명, 목차, ISBN)와 사용자가 입력한 검색 문구
	 * @Return : api 검색 결과
	 * @Method 설명 : 지정된 검색 종류로 api에서 검색해서 책 세부정보를 가져오는 함수
	 */
	public ArrayList<BookInfo> accessApi(String type, String userInput) {
		
		ArrayList<BookInfo> resultList = new ArrayList<>();
		
		String clientId = "_LtDtsKGFwm3NTTrFjRD";
		String clientSecret = "jwxK8VTbwm";
		
		try {
			String keyword = URLEncoder.encode(userInput, "UTF-8");
			String apiURL = "https://openapi.naver.com/v1/search/book_adv.xml?" + type + "=" + keyword
					+ "&display="+RESULT_NUMBER+"&start=1";

			URL url = new URL(apiURL);
			HttpURLConnection con = (HttpURLConnection) url.openConnection();
			con.setRequestMethod("GET");
			con.setRequestProperty("X-Naver-Client-Id", clientId);
			con.setRequestProperty("X-Naver-Client-Secret", clientSecret);
			int responseCode = con.getResponseCode();
			BufferedReader br;
			if (responseCode == 200) {
				br = new BufferedReader(new InputStreamReader(con.getInputStream()));
			} else {
				br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
			}
			String inputLine;
			StringBuffer response = new StringBuffer();

			while ((inputLine = br.readLine()) != null) {
				response.append(inputLine);
			}
			br.close();
			
			logger.debug(response.toString());
			logger.debug("API 검색 시스템 시작");

			try {
				DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
				DocumentBuilder builder = factory.newDocumentBuilder();
				InputStream is = new ByteArrayInputStream(response.toString().getBytes("utf-8"));
				Document doc = builder.parse(is);

				Element searchResult = doc.getDocumentElement();
				NodeList books = searchResult.getElementsByTagName("item");

				for (int i = 0; i < RESULT_NUMBER; i++) {
					Node book = books.item(i);
					if (book == null){
						break;
					}
					if (book.getNodeType() == Node.ELEMENT_NODE) {
						Element eBook = (Element) book;
						logger.debug((i+1)+"th book");

						BookInfo temp = new BookInfo();
						
						//title
						String title = eBook.getElementsByTagName("title").item(0).getTextContent().toString();
						title = deleteBoldTag(title);
						temp.setBookinfo_book_nm(title);
						//author
						String author = eBook.getElementsByTagName("author").item(0).getTextContent().toString();
						author = deleteBoldTag(author);
						temp.setBookinfo_author(author);
						//publisher
						String publisher = eBook.getElementsByTagName("publisher").item(0).getTextContent().toString();
						publisher = deleteBoldTag(publisher);
						temp.setBookinfo_publisher(publisher);
						//publish date
						String pubdate = eBook.getElementsByTagName("pubdate").item(0).getTextContent().toString();
						pubdate = deleteBoldTag(pubdate);
						temp.setBookinfo_published_dt(pubdate);
						//isbn
						String isbn = eBook.getElementsByTagName("isbn").item(0).getTextContent().toString();
						String[] cutIsbn = isbn.split("\\s"); 
						temp.setBookinfo_isbn(cutIsbn[1]); //*** 13자리 isbn으로 변경
						//description
						//*** vo 내부에 따로 지정한 변수가 없어서 임의로 board_file_saved를 사용하였음
						String description = eBook.getElementsByTagName("description").item(0).getTextContent().toString();
						description = deleteBoldTag(description);
						temp.setBoard_file_saved(description);
						System.out.println(temp.toString());
						resultList.add(temp);
					}
				}

			} catch (Exception e) {
				e.printStackTrace();
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return resultList;
	}
	
	
	/**
	 * @Method Name : deleteBoldTag
	 * @Date : 2017. 7. 27.
	 * @User : 이정식
	 * @Param : xml에서 가져온 결과값
	 * @Return : bold tag가 제거된 결과값
	 * @Method 설명 : string 내부의 bold tag 제거
	 */
	public String deleteBoldTag(String result) {
		result = result.replaceAll("<b>", "");
		result = result.replaceAll("</b>", "");
		return result;
	}
	
	
	/// 여기서부터 test
	public static void main(String[] args) {
		new AccessBookApi();
	}
	/*
		public AccessBookApi(){		
			searchByTitle("수학귀신");
		}
	*/

}
