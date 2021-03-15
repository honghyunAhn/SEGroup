/**
 * 
 */
package global.segroup.school.book.util;

import java.util.Comparator;

import global.segroup.school.book.admin.domain.BookInfo;

/**
 * @Author : 이정식
 * @Date : 2017. 7. 27.
 * @Class 설명 : BookInfo의 등록날짜에 따라 정렬해줌
 * 
 */
public class SortBookInfoByDate {
	
	/**
	 * @Author : 이정식
	 * @Date : 2017. 7. 27.
	 * @Class 설명 : BookInfo의 등록날짜 내림차순으로 정렬
	 * 
	 */
	public class Descending implements Comparator<BookInfo> {
		@Override
		public int compare(BookInfo o1, BookInfo o2) {
			String date1 = o1.getBookinfo_ins_dt();
			String date2 = o2.getBookinfo_ins_dt();
			return date2.compareTo(date1);
		}

	}

	/**
	 * @Author : 이정식
	 * @Date : 2017. 7. 27.
	 * @Class 설명 : BookInfo의 등록날짜 오름차순으로 정렬
	 * 
	 */
	public class Ascending implements Comparator<BookInfo> {
		@Override
		public int compare(BookInfo o1, BookInfo o2) {
			String date1 = o1.getBookinfo_ins_dt();
			String date2 = o2.getBookinfo_ins_dt();
			return date1.compareTo(date2);
		}
	}
	
	
}
