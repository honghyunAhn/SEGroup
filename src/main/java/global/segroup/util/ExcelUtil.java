/**
 * 
 */
package global.segroup.util;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;

import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.VerticalAlignment;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

/**
 * @Author : 이종호
 * @Date : 2019. 4. 18.
 * @Class 설명 : 엑셀 다운로드를 위한 유틸 클래스
 * 
 */
public class ExcelUtil {
	
	public static String comp_id;
	public static String user_flag;
	
	/**
	 * 엑셀 출력 함수
	 * header의 순서와 content의 순서가 같아야 한다.
	 * 차후에는 시트 갯수 스타일등을 옵션으로 받는 설정을 추가해야함.
	 * */
	public static Workbook print_excel(ArrayList<LinkedHashMap<String, Object>> content, ArrayList<String> excel_header) {
		
		//Workbook 생성
		Workbook xlsxWb = new XSSFWorkbook();
		//Sheet 생성
		Sheet sheet = xlsxWb.createSheet("firstSheet");
		//엑셀의 행
		Row row = null;
		//엑셀의 셀
		Cell cell = null;
		
		for(int i=0; i <= content.size(); i++) {
			row = sheet.createRow(i);
			if(i == 0) {
				//헤더 셀 생성
				for(int j=0; j < excel_header.size(); j++) {
					cell = row.createCell(j);
					cell.setCellValue(excel_header.get(j));
				}
			}else {
				//본문 맨 앞 번호 셀 생성
				cell = row.createCell(0);
				cell.setCellValue(i);
				//본문 셀 생성
				Iterator<String> iter = content.get(i-1).keySet().iterator();
				int cell_num = 1;
				while (iter.hasNext()) {
					cell = row.createCell(cell_num);
					cell.setCellValue((content.get(i-1).get((String)iter.next())).toString());
					cell_num++;
				}
			}
		}
		
		return xlsxWb;
	}
	
	public static Workbook merge_excel(HashMap<String, Object> resultMap, ArrayList<ArrayList<String>> head_list,String excel_gb) {
		
		//Workbook 생성
		Workbook xlsxWb = new XSSFWorkbook();

		if(excel_gb.equalsIgnoreCase("APPLIER")) {
			ArrayList<LinkedHashMap<String, Object>> result = (ArrayList<LinkedHashMap<String, Object>>) resultMap.get("list");
			int k_num = (int)resultMap.get("k_num");
			int j_num = (int)resultMap.get("j_num");
			int rownum = result.size()+head_list.size();
			
			//Sheet 생성
			Sheet sheet = xlsxWb.createSheet("firstSheet");
			//엑셀의 행
			Row row = null;
			//엑셀의 셀
			Cell cell = null;
			
			//폰트 스타일
			Font font = xlsxWb.createFont();
			font.setBold(true);
			font.setUnderline(Font.U_SINGLE);
			
			//합격 스타일
			CellStyle success_style = xlsxWb.createCellStyle();
			success_style.setFillForegroundColor(IndexedColors.YELLOW.getIndex());
			success_style.setFillPattern(FillPatternType.SOLID_FOREGROUND);
			//불합격 스타일
			CellStyle fail_style = xlsxWb.createCellStyle();
			fail_style.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.getIndex());
			fail_style.setFillPattern(FillPatternType.SOLID_FOREGROUND);
			//예비합격 스타일
			CellStyle reserve_style = xlsxWb.createCellStyle();
			reserve_style.setFillForegroundColor(IndexedColors.AQUA.getIndex());
			reserve_style.setFillPattern(FillPatternType.SOLID_FOREGROUND);
			//내정확정 스타일
			CellStyle rt_style = xlsxWb.createCellStyle();
			rt_style.setFillForegroundColor(IndexedColors.YELLOW.getIndex());
			rt_style.setFillPattern(FillPatternType.SOLID_FOREGROUND);
			rt_style.setFont(font);
			
			//컬럼 사이즈 자동 조절
			sheet.autoSizeColumn(0);

			//예비번호
			String standby_num = "미정";
			
			for(int i=0; i < rownum; i++) {
				row = sheet.createRow(i);
				if(i <= 1) {
					for(int k=0; k < head_list.get(i).size(); k++) {
						cell = row.createCell(k);
						if(head_list.get(i).get(k) != null) {
							cell.setCellValue(head_list.get(i).get(k));
						}
					}
				}else {
					Cell cell_0 = row.createCell(0);
					cell_0.setCellValue(i-1);
					
					Cell cell_1 = row.createCell(1);
					cell_1.setCellValue(result.get(i-2).get("user_nm").toString());
					
					Cell cell_2 = row.createCell(2);
					String user_flag = "";
					if(result.get(i-2).get("user_flag").toString().equals("A0101")) {
						user_flag = "SC IT";
					}else if(result.get(i-2).get("user_flag").toString().equals("A0106")) {
						user_flag = "SW DO";
					}else if(result.get(i-2).get("user_flag").toString().equals("A0108")) {
						user_flag = "일본취업학교";
					}else if(result.get(i-2).get("user_flag").toString().equals("A0100")) {
						user_flag = "일반";
					}else if(result.get(i-2).get("user_flag").toString().equals("A0102")) {
						user_flag = "마스터 졸업생";
					}
					cell_2.setCellValue(user_flag);
					
					Cell cell_3 = row.createCell(3);
					cell_3.setCellValue("K");
					
					Cell cell_4 = row.createCell(4);
					cell_4.setCellValue(result.get(i-2).get("rt_count").toString());
					
					Cell cell_5 = row.createCell(5);
					cell_5.setCellValue(result.get(i-2).get("reserve_count").toString());
					
					Cell cell_6 = row.createCell(6);
					cell_6.setCellValue(result.get(i-2).get("standby_count").toString());
					
					Cell cell_7 = row.createCell(7);
					cell_7.setCellValue(result.get(i-2).get("final_fail_count").toString());
					
					Cell cell_8 = row.createCell(8);
					cell_8.setCellValue(result.get(i-2).get("k_apply_count").toString());
					
					Cell cell_9 = row.createCell(9);
					cell_9.setCellValue(result.get(i-2).get("k_process_count").toString());
					
					Cell cell_10 = row.createCell(10);
					cell_10.setCellValue(result.get(i-2).get("k_fail_count").toString());
					
					Cell cell_11 = row.createCell(11);
					cell_11.setCellValue(result.get(i-2).get("k_success_count").toString());
					
					for(int n=0; n<k_num; n++) {
						cell = row.createCell(12+n);
						ArrayList<HashMap<String, Object>> klist = (ArrayList<HashMap<String, Object>>)result.get(i-2).get("kFair");
						if(klist != null) {
							
							for(HashMap<String, Object> map : klist) {
								if(map.get("k_info_rank") != null) {
									if((n+1) == Integer.parseInt(map.get("k_info_rank").toString())) {
										
										if(map.get("k_standby_rank") != null) {
											standby_num = map.get("k_standby_rank").toString();
										}
										
										cell.setCellValue(map.get("k_comp_nm").toString());
										
										if(map.get("k_rt_acp") != null) {
											if(map.get("k_choice_gb").toString().equals("D0701")) {
												cell.setCellStyle(rt_style);
											}else if(map.get("k_rt_acp").toString().equals("D0001")) {
												cell.setCellStyle(success_style);
											}else if(map.get("k_rt_acp").toString().equals("D0002")) {
												cell.setCellStyle(fail_style);
											}else if(map.get("k_rt_acp").toString().equals("D0004")) {
												cell.setCellStyle(reserve_style);
											}
											
										}
									}
								}
								
							}
							
						}
					}
					
					Cell cell_j1 = row.createCell(12+k_num);
					cell_j1.setCellValue(result.get(i-2).get("apply_count").toString());
					
					Cell cell_j2 = row.createCell(13+k_num);
					cell_j2.setCellValue(result.get(i-2).get("process_count").toString());
					
					Cell cell_j3 = row.createCell(14+k_num);
					cell_j3.setCellValue(result.get(i-2).get("fail_count").toString());
					
					Cell cell_j4 = row.createCell(15+k_num);
					cell_j4.setCellValue(result.get(i-2).get("success_count").toString());
					
					for(int n=0; n<j_num; n++) {
						cell = row.createCell(16+k_num+n);
						ArrayList<HashMap<String, Object>> jlist = (ArrayList<HashMap<String, Object>>)result.get(i-2).get("jFair");
						if(jlist != null) {
							
							for(HashMap<String, Object> map : jlist) {
								if(map.get("info_rank") != null) {
									if((n+1) == Integer.parseInt(map.get("info_rank").toString())) {
										
										if(map.get("j_standby_rank") != null) {
											standby_num = map.get("j_standby_rank").toString();
										}
										
										cell.setCellValue(map.get("j_comp_nm").toString()+"("+standby_num+")");
										
										if(map.get("j_rt_acp") != null) {
											if(map.get("j_choice_gb").toString().equals("D0701")) {
												cell.setCellStyle(rt_style);
											}else if(map.get("j_rt_acp").toString().equals("D0001")) {
												cell.setCellStyle(success_style);
											}else if(map.get("j_rt_acp").toString().equals("D0002")) {
												cell.setCellStyle(fail_style);
											}else if(map.get("j_rt_acp").toString().equals("D0004")) {
												cell.setCellStyle(reserve_style);
											}
											
										}
									}
								}
								
							}
							
						}
					}
					
				}
			}
			
			
			sheet.addMergedRegion(new CellRangeAddress(0, 1, 0, 0));
			sheet.addMergedRegion(new CellRangeAddress(0, 1, 1, 1));
			sheet.addMergedRegion(new CellRangeAddress(0, 1, 2, 2));
			sheet.addMergedRegion(new CellRangeAddress(0, 1, 3, 3));
			sheet.addMergedRegion(new CellRangeAddress(0, 0, 4, 7));
			sheet.addMergedRegion(new CellRangeAddress(0, 0, 8, 11));
//			sheet.addMergedRegion(new CellRangeAddress(0, 0, 12, (11+k_num)));
			sheet.addMergedRegion(new CellRangeAddress(0, 0, (12+k_num), (15+k_num)));
			sheet.addMergedRegion(new CellRangeAddress(0, 0, (16+k_num), (17+k_num+j_num)));
			
		}else if(excel_gb.equalsIgnoreCase("COMP")) {
			ArrayList<LinkedHashMap<String, Object>> one = (ArrayList<LinkedHashMap<String, Object>>) resultMap.get("one");
			ArrayList<LinkedHashMap<String, Object>> two = (ArrayList<LinkedHashMap<String, Object>>) resultMap.get("two");
			ArrayList<LinkedHashMap<String, Object>> three = (ArrayList<LinkedHashMap<String, Object>>) resultMap.get("three");
			ArrayList<LinkedHashMap<String, Object>> four = (ArrayList<LinkedHashMap<String, Object>>) resultMap.get("four");
			ArrayList<LinkedHashMap<String, Object>> five = (ArrayList<LinkedHashMap<String, Object>>) resultMap.get("five");
			ArrayList<LinkedHashMap<String, Object>> six = (ArrayList<LinkedHashMap<String, Object>>) resultMap.get("six");
			ArrayList<LinkedHashMap<String, Object>> seven = (ArrayList<LinkedHashMap<String, Object>>) resultMap.get("seven");
			ArrayList<LinkedHashMap<String, Object>> eight = (ArrayList<LinkedHashMap<String, Object>>) resultMap.get("eight");
			ArrayList<LinkedHashMap<String, Object>> nine = (ArrayList<LinkedHashMap<String, Object>>) resultMap.get("nine");
			ArrayList<LinkedHashMap<String, Object>> ten = (ArrayList<LinkedHashMap<String, Object>>) resultMap.get("ten");
			ArrayList<LinkedHashMap<String, Object>> eleven = (ArrayList<LinkedHashMap<String, Object>>) resultMap.get("eleven");
			ArrayList<LinkedHashMap<String, Object>> twelve = (ArrayList<LinkedHashMap<String, Object>>) resultMap.get("twelve");
			ArrayList<LinkedHashMap<String, Object>> thirteen = (ArrayList<LinkedHashMap<String, Object>>) resultMap.get("thirteen");
			ArrayList<LinkedHashMap<String, Object>> fourteen = (ArrayList<LinkedHashMap<String, Object>>) resultMap.get("fourteen");
			ArrayList<LinkedHashMap<String, Object>> fifteen = (ArrayList<LinkedHashMap<String, Object>>) resultMap.get("fifteen");
			ArrayList<LinkedHashMap<String, Object>> sixteen = (ArrayList<LinkedHashMap<String, Object>>) resultMap.get("sixteen");
			int rownum = one.size()+head_list.size();
			
			//Sheet 생성
			Sheet sheet = xlsxWb.createSheet("firstSheet");
			//엑셀의 행
			Row row = null;
			//엑셀의 셀
			Cell cell = null;
			
			//헤더 스타일
			CellStyle header_style = xlsxWb.createCellStyle();
			header_style.setFillForegroundColor(IndexedColors.LIME.getIndex());
			header_style.setFillPattern(FillPatternType.SOLID_FOREGROUND);
			header_style.setBorderTop(BorderStyle.THIN);
			header_style.setBorderBottom(BorderStyle.THIN);
			header_style.setBorderLeft(BorderStyle.THIN);
			header_style.setBorderRight(BorderStyle.THIN);
			header_style.setAlignment(HorizontalAlignment.CENTER);
			header_style.setVerticalAlignment(VerticalAlignment.CENTER);
			header_style.setWrapText(true);
			
			for(int i=0; i < rownum; i++) {
				row = sheet.createRow(i);
				if(i <= 2) {
					for(int k=0; k < head_list.get(i).size(); k++) {
						cell = row.createCell(k);
						if(head_list.get(i).get(k) != null) {
							cell.setCellValue(head_list.get(i).get(k));
							cell.setCellStyle(header_style);
						}else {
							cell.setCellStyle(header_style);
						}
					}
				} else {
					cell = row.createCell(0);
					cell.setCellValue(i-2);
					//본문 셀 생성
					int cell_num = 1;
					//첫칸 건너띄기용도
					comp_id = "";
					for(String key : one.get(i-3).keySet()) {
						user_flag = "";
						if(!comp_id.equals("")) {
							cell = row.createCell(cell_num);
							switch ((one.get(i-3).get(key)).toString()) {
							case "k_apply_nm":
								cell.setCellValue(setNm(two));
								break;
							case "k_apply_fail_nm":
								cell.setCellValue(setNm(three));
								break;	
							case "k_apply_success_nm":
								cell.setCellValue(setNm(four));
								break;	
							case "k_apply_final_nm":
								cell.setCellValue(setNm(five));
								break;	
							case "j_apply_nm":
								cell.setCellValue(setNm(six));
								break;	
							case "j_apply_fail_nm":
								cell.setCellValue(setNm(seven));
								break;	
							case "j_apply_success_nm":
								cell.setCellValue(setNm(eight));
								break;	
							case "j_apply_reserve_nm":
								cell.setCellValue(setNm(nine));
								break;	
							case "j_apply_final_nm":
								cell.setCellValue(setNm(ten));
								break;
							case "post_apply_nm":
								cell.setCellValue(setNm(eleven));
								break;
							case "post_apply_fail_nm":
								cell.setCellValue(setNm(twelve));
								break;
							case "post_apply_success_nm":
								cell.setCellValue(setNm(thirteen));
								break;
							case "post_apply_reserve_nm":
								cell.setCellValue(setNm(fourteen));
								break;
							case "post_apply_final_nm":
								cell.setCellValue(setNm(fifteen));
								break;
							case "final_num":
								int num12 = Integer.parseInt(row.getCell(12).getStringCellValue());
								int num24 = Integer.parseInt(row.getCell(24).getStringCellValue());
								int num36 = Integer.parseInt(row.getCell(36).getStringCellValue());
								int num_total = num12 + num24 + num36;
								cell.setCellValue(num_total);
								break;
							case "final_nm":
								String str13 = row.getCell(13).getStringCellValue();
								String str25 = row.getCell(25).getStringCellValue();
								String str37 = row.getCell(37).getStringCellValue();
								String str_total = str13+str25+str37;
								cell.setCellValue(str_total);
								break;
							case "join_dt":
								String join_dt = "";
								for(LinkedHashMap<String, Object> map : sixteen) {
									for(String key_three : map.keySet()) {
										if(comp_id.equalsIgnoreCase(map.get(key_three).toString())) {
											join_dt += map.get("fap_job_join_dt")+" ";
										}else {
											break;
										}
										break;
									}
								}
								cell.setCellValue(join_dt);
								break;
							case "join_dtl":
								String join_dtl = "";
								for(LinkedHashMap<String, Object> map : sixteen) {
									for(String key_three : map.keySet()) {
										if(comp_id.equalsIgnoreCase(map.get(key_three).toString())) {
											join_dtl += map.get("fap_job_join_dtl")+" ";
										}else {
											break;
										}
										break;
									}
								}
								cell.setCellValue(join_dtl);
								break;
							default:
								cell.setCellValue((one.get(i-3).get(key)).toString());
								break;
							}
							cell_num++;
						}else {
							comp_id=(one.get(i-3).get(key)).toString();
						}
					}
				}
			}
			
			sheet.addMergedRegion(new CellRangeAddress(0, 2, 0, 0));
			sheet.addMergedRegion(new CellRangeAddress(0, 2, 1, 1));
			sheet.addMergedRegion(new CellRangeAddress(0, 2, 2, 2));
			sheet.addMergedRegion(new CellRangeAddress(0, 2, 3, 3));
			sheet.addMergedRegion(new CellRangeAddress(0, 0, 4, 13));
			sheet.addMergedRegion(new CellRangeAddress(0, 0, 14, 25));
			sheet.addMergedRegion(new CellRangeAddress(0, 0, 26, 37));
			sheet.addMergedRegion(new CellRangeAddress(0, 0, 38, 39));
			sheet.addMergedRegion(new CellRangeAddress(0, 2, 40, 40));
			sheet.addMergedRegion(new CellRangeAddress(0, 2, 41, 41));
			sheet.addMergedRegion(new CellRangeAddress(1, 2, 4, 4));
			sheet.addMergedRegion(new CellRangeAddress(1, 2, 5, 5));
			sheet.addMergedRegion(new CellRangeAddress(1, 1, 6, 7));
			sheet.addMergedRegion(new CellRangeAddress(1, 1, 8, 9));
			sheet.addMergedRegion(new CellRangeAddress(1, 1, 10, 11));
			sheet.addMergedRegion(new CellRangeAddress(1, 1, 12, 13));
			sheet.addMergedRegion(new CellRangeAddress(1, 2, 14, 14));
			sheet.addMergedRegion(new CellRangeAddress(1, 2, 15, 15));
			sheet.addMergedRegion(new CellRangeAddress(1, 1, 16, 17));
			sheet.addMergedRegion(new CellRangeAddress(1, 1, 18, 19));
			sheet.addMergedRegion(new CellRangeAddress(1, 1, 20, 21));
			sheet.addMergedRegion(new CellRangeAddress(1, 1, 22, 23));
			sheet.addMergedRegion(new CellRangeAddress(1, 1, 24, 25));
			sheet.addMergedRegion(new CellRangeAddress(1, 2, 26, 26));
			sheet.addMergedRegion(new CellRangeAddress(1, 2, 27, 27));
			sheet.addMergedRegion(new CellRangeAddress(1, 1, 28, 29));
			sheet.addMergedRegion(new CellRangeAddress(1, 1, 30, 31));
			sheet.addMergedRegion(new CellRangeAddress(1, 1, 32, 33));
			sheet.addMergedRegion(new CellRangeAddress(1, 1, 34, 35));
			sheet.addMergedRegion(new CellRangeAddress(1, 1, 36, 37));
			sheet.addMergedRegion(new CellRangeAddress(1, 1, 38, 39));
			
			
			for(int i=0; i<42; i++) {
				//컬럼 사이즈 자동 조절
				sheet.autoSizeColumn(i);
				sheet.setColumnWidth(i, Math.min(255*256, sheet.getColumnWidth(i)+1024));
			}
			
		}
		
		return xlsxWb;
	}
	
	private static String setNm(ArrayList<LinkedHashMap<String, Object>> list) {
		String temp = "";
		int newline = 0;
		for(LinkedHashMap<String, Object> map : list) {
			for(String key_three : map.keySet()) {
				if(comp_id.equalsIgnoreCase(map.get(key_three).toString())) {
					if(!user_flag.equals(map.get("user_flag").toString())) {
						user_flag = map.get("user_flag").toString();
						temp += "\r\n"+user_flag+"\r\n";
					}
					temp += map.get("user_nm")+"("+map.get("user_birth")+")";
					newline++;
				}else {
					break;
				}
				if(newline%3 ==0) {
					temp += "\r\n";
				}
				break;
			}
		}
		return temp;
	}
	
}
