package kr.co.edu.onlineEdu.paging;

import kr.co.unp.cmm.crud.paging.IPageInfo;
import kr.co.unp.util.ZValue;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Service("themeLecturePageInfo")
public class ThemeLecturePageInfo implements IPageInfo
{
	protected Log log = LogFactory.getLog(this.getClass());

	protected String lastPrevImg = "<span role='text' aria-lable='처음 목록으로 이동' tabindex='0'>처음 목록으로 이동</span>";
    protected String prev10Img = "<span role='text' aria-label='이전 10페이지 목록으로 이동' tabindex='0'>이전 목록으로 이동</span>";
    protected String next10Img = "<span role='text' aria-label='다음 10페이지 목록으로 이동' tabindex='0'>다음 목록으로 이동</span>";
    protected String lastNextImg = "<span role='text' aria=label='끝 목록으로 이동' tabindex='0'>끝 목록으로 이동</span>";

	public String getLastPrevImg() {
		return lastPrevImg;
	}

	public void setLastPrevImg(String lastPrevImg) {
		this.lastPrevImg = lastPrevImg;
	}

	public String getPrev10Img() {
		return prev10Img;
	}

	public void setPrev10Img(String prev10Img) {
		this.prev10Img = prev10Img;
	}

	public String getNext10Img() {
		return next10Img;
	}

	public void setNext10Img(String next10Img) {
		this.next10Img = next10Img;
	}

	public String getLastNextImg() {
		return lastNextImg;
	}

	public void setLastNextImg(String lastNextImg) {
		this.lastNextImg = lastNextImg;
	}

	@Override
	public String getPageNavString( int pageSize, int total, int cpage, String link )
	{
		return getPageNavString(pageSize, 10, total, cpage, link);
	}

	@Override
	public String getPageNavString( int pageSize, int pageUnit, int total, int cpage, String link )
	{
		// 전체페이지
		int totalPage = (total - 1) / pageUnit + 1;
		// 이전10개, 다음10개
		// 이전 마지막 페이지 0 이면 이전10개 없음
		int prev10 = (int) Math.floor((cpage - 1) / pageSize) * pageSize;
		// 다음 첫페이지 totalPage 보다 크면 다음10개 없음
		int next10 = prev10 + pageSize + 1;
		StringBuffer sbuf = new StringBuffer();

		if( link.indexOf("?") == -1) link += "?";

		sbuf.append("<div class='paginationSet'>");
		sbuf.append("<ul class='pagination pagination-centered'>" );
		if (prev10 > 0)
		{
			sbuf.append("<li class='first'><a style='opacity:1' title=\"처음 페이지로 이동\" href='").append(link).append("&amp;pageIndex2=1'>")/*.append("처음 페이지로 이동")*/.append("</a></li>");
			sbuf.append("<li class='prev'><a style='opacity:1' title=\"이전 "+pageSize+"페이지 목록으로 이동\" href='").append(link).append("&amp;pageIndex2=").append(prev10).append("'>")/*.append("이전 "+pageSize+"페이지 목록으로 이동")*/.append("</a></li>");
		} // end if 이전10개
		else
		{
			sbuf.append("<li class='first disabled'>").append(lastPrevImg).append("</li>");
			sbuf.append("<li class='prev disabled'>").append(prev10Img).append("</li>");
		}


		for (int i = 1 + prev10; i < next10 && i <= totalPage; i++)
		{
			if (i == cpage)
			{
				sbuf.append("<li class='active'><span role='text' aria-label='"+i+", 편재페이지' tabindex='0'><em title='현재페이지'>").append(i).append("</em></span></li>");
			}
			else
			{
				sbuf.append("<li><a title='"+i+"페이지로 이동' href='").append(link).append("&amp;pageIndex2=").append(i).append("'>").append(i).append("</a></li>");
			} // end if 현재페이지 링크제거
		} // end for
		
		int nextCnt = pageSize;
		if(((next10 - 1) + nextCnt) > totalPage){
			nextCnt = totalPage - (next10 - 1);
		}
		
		if (totalPage >= next10)
		{

			sbuf.append("<li class='next'><a style='opacity:1' title=\"다음 "+nextCnt+"페이지 목록으로 이동\" href='").append(link).append("&amp;pageIndex2=").append(next10).append("'>")/*.append("다음 "+nextCnt+"페이지 목록으로 이동")*/.append("</a></li>");
			sbuf.append("<li class='end'><a style='opacity:1' title=\"마지막 페이지로 이동\" href='").append(link).append("&amp;pageIndex2=").append(totalPage).append("'>")/*.append("마지막 페이지로 이동")*/.append("</a></li>");
		} // end if 다음10개
		else
		{
			sbuf.append("<li class='next disabled'>").append(next10Img).append("</li>");
			sbuf.append("<li class='end disabled'>").append(lastNextImg).append("</li>");
		}
		sbuf.append("</ul>" );
		sbuf.append("</div>" );

		return sbuf.toString();
	}

	@Override
	public String getPageNavStringToFunc( int pageSize, int total, int cpage, String funcName )
	{
		// 전체페이지
		int totalPage = (total - 1) / pageSize + 1;
		// 이전10개, 다음10개
		// 이전 마지막 페이지 0 이면 이전10개 없음
		int prev10 = (int) Math.floor((cpage - 1) / 10.0) * 10;
		// 다음 첫페이지 totalPage 보다 크면 다음10개 없음
		int next10 = prev10 + 11;
		StringBuffer sbuf = new StringBuffer();

		sbuf.append("<div class='paginationSet'>");
		sbuf.append("<ul class='pagination pagination-centered'>" );
		if (prev10 > 0)
		{
			sbuf.append("<li class='first'><a style='opacity:1' title=\"처음 페이지로 이동\" href='javascript:"+funcName+"(1);'>")/*.append("처음 페이지로 이동")*/.append("</a></li>");
			sbuf.append("<li class='prev'><a style='opacity:1' title\"이전 "+pageSize+"페이지 목록으로 이동\"href='javascript:"+funcName+"("+prev10+");'>")/*.append("이전 "+pageSize+"페이지 목록으로 이동")*/.append("</a></li>");
		} // end if 이전10개
		else
		{
			sbuf.append("<li class='first disabled'>").append(lastPrevImg).append("</li>");
			sbuf.append("<li class='prev disabled'>").append(prev10Img).append("</li>");
		}


		for (int i = 1 + prev10; i < next10 && i <= totalPage; i++)
		{
			if (i == cpage)
			{
				sbuf.append("<li class='active'><span role='text' aria-label='"+i+", 현재페이지' tabindex='0'><em title='현재페이지'>").append(i).append("</em></span></li>");
			}
			else
			{
				sbuf.append("<li><a title='"+i+"페이지로 이동' href='javascript:"+funcName+"("+i+");'>").append(i).append("</a></li>");
			} // end if 현재페이지 링크제거
		} // end for

		if (totalPage >= next10)
		{

			sbuf.append("<li class='next'><a style='opacity:1' title='다음 10페이지 목록으로 이동' href='javascript:"+funcName+"("+next10+");'>")/*.append("다음 10페이지 목록으로 이동")*/.append("</a></li>");
			sbuf.append("<li class='end'><a style='opacity:1' title='끝 목록으로 이동' href='javascript:"+funcName+"("+totalPage+");'>")/*.append("끝 목록으로 이동")*/.append("</a></li>");
		} // end if 다음10개
		else
		{
			sbuf.append("<li class='next disabled'>").append(next10Img).append("</li>");
			sbuf.append("<li class='end disabled'>").append(lastNextImg).append("</li>");
		}
		sbuf.append("</ul>" );
		sbuf.append("</div>" );
		return sbuf.toString();
	}

	public ZValue getPaginationInfo(ZValue zvl)
	{
		int pageUnit = zvl.getInt("pageUnit") == 0 ? 10 : zvl.getInt("pageUnit");
    	int pageSize = 10;
    	int pageIndex = zvl.getInt("pageIndex2", 1);
    	int totalRecordCount = zvl.getInt("totCnt", 1);

		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(pageIndex);
		paginationInfo.setRecordCountPerPage(pageUnit);
		paginationInfo.setPageSize(pageSize);
		paginationInfo.setTotalRecordCount(totalRecordCount);

    	zvl.put("pageIndex2", pageIndex);
    	zvl.put("pageUnit", pageUnit);
    	zvl.put("pageSize", pageSize);
    	zvl.put("firstIndex", paginationInfo.getFirstRecordIndex());
    	zvl.put("lastIndex", paginationInfo.getLastRecordIndex());
    	zvl.put("recordCountPerPage", paginationInfo.getRecordCountPerPage());
    	zvl.put("totalPageCount", paginationInfo.getTotalPageCount());

    	return zvl;
	}

	public String getPageNavString(ZValue zvl){
		return getPageNavString( zvl.getInt("pageSize2"), zvl.getInt("pageUnit"), zvl.getInt("totCnt"), zvl.getInt("pageIndex2",1), zvl.getString("link") );
	}
}
