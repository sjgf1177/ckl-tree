package kr.co.unp.cmm.view;

import java.io.OutputStream;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.unp.cmm.view.vo.ExcelGenerateVO;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRichTextString;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.springframework.web.servlet.view.AbstractView;

public class ExcelGenerateView extends AbstractView {

	public ExcelGenerateView(){
		super.setContentType("application/x-msexcel");
	}

	@Override
	protected void renderMergedOutputModel(Map<String, Object> model, HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		ExcelGenerateVO excelVO = (ExcelGenerateVO)model.get("excel");
		String fileName = excelVO.getExcelFileName();

		HSSFWorkbook objWorkBook = null;
		if (model.get("customTp") != null && "Y".equals((String)model.get("customTp"))) {
			objWorkBook = (HSSFWorkbook)model.get("workBook");
		}
		else {
			objWorkBook = this.defaultRenderMergedOutputModel(model);
		}


		OutputStream out = null;
		try {
			response.setCharacterEncoding("utf-8");
			response.setContentType("application/x-msexcel");
			response.setHeader("Content-Disposition", "attachment;filename=" + new String((fileName + ".xls").getBytes("KSC5601"), "8859_1"));
			response.setHeader("Content-Transfer-Encoding", "binary");
			response.setHeader("Cache-Control","max-age=0");
			//response.setHeader("pragma","no-cache");
			//response.setHeader("expires", "-1");

			out = response.getOutputStream();
			objWorkBook.write(out);
			out.close();
		} catch (Exception e) {
			System.out.println("엑셀 파일 생성 오류 [ 엑셀파일명 : " + fileName);
			e.printStackTrace();
		} finally {
			if ( out != null ) out.close();
		}

	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	public HSSFWorkbook defaultRenderMergedOutputModel(Map<String, Object> model) throws Exception {

		ExcelGenerateVO excelVO = (ExcelGenerateVO)model.get("excel");

		String[] excelTitle = excelVO.getTitle();
		List<?> dataList = excelVO.getDataList();

		// 워크북 생성
		HSSFWorkbook objWorkBook = new HSSFWorkbook();
		// 워크시트 생성
		HSSFSheet objSheet = objWorkBook.createSheet();

		// title 행생성
		HSSFRow titleRow = objSheet.createRow(0);

		HSSFCellStyle titleStyle = objWorkBook.createCellStyle();
		titleStyle.setFillForegroundColor(HSSFColor.LIME.index);
		titleStyle.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
		titleStyle.setBorderLeft(HSSFCellStyle.SOLID_FOREGROUND);
		titleStyle.setBorderRight(HSSFCellStyle.SOLID_FOREGROUND);
		titleStyle.setBorderTop(HSSFCellStyle.SOLID_FOREGROUND);
		titleStyle.setBorderBottom(HSSFCellStyle.SOLID_FOREGROUND);
		titleStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);


		// title 셀 생성
		for(int titleCnt = 0 ; titleCnt <  excelTitle.length; titleCnt++ ) {
			HSSFCell objCell = titleRow.createCell(titleCnt);
			HSSFRichTextString richTextString = new HSSFRichTextString(excelTitle[titleCnt]);
			objCell.setCellValue(richTextString);
			objCell.setCellStyle(titleStyle);
			objSheet.setColumnWidth(titleCnt, 4000);
		}

		// row & cell 생성
		/*HSSFFont font = objWorkBook.createFont();
		font.setColor(HSSFColor.BLACK.index);
		titleStyle.setFont(font);*/
		
		for ( int listCnt = 0 ; listCnt < dataList.size(); listCnt++  ) {
			Object obj = dataList.get(listCnt);
			Map<Object, Object> map = null;
			if (obj instanceof Map ){
				map = (Map)obj;
			}
			else{
				map = BeanUtils.describe(obj);
			}
			// 맵키추출
			Iterator<String> mapKeys = ((Set)map.keySet()).iterator();
			HSSFRow dataRow = objSheet.createRow(listCnt + 1);

			int cellCnt = 0;
			while(mapKeys.hasNext()) {
				String mapkey = mapKeys.next();
				String cellData = String.valueOf(map.get(mapkey));
				HSSFCell dataCell = dataRow.createCell(cellCnt);
				HSSFRichTextString richTextString = new HSSFRichTextString("null".equals(cellData) ? "" : cellData);

				//dataCell.setCellStyle(titleStyle);

				dataCell.setCellValue(richTextString);
				cellCnt++;
			}
		}
		return objWorkBook;

	}
}
