package com.main.artgallery.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.main.artgallery.exception.ForbiddenException;
import com.main.artgallery.opinion.dao.OpinionCommentDao;
import com.main.artgallery.opinion.dao.OpinionDao;
import com.main.artgallery.opinion.dto.OpinionCommentDto;
import com.main.artgallery.opinion.dto.OpinionDto;

@Service
public class OpinionServiceImpl implements OpinionService{
	@Autowired
	private OpinionDao opinionDao;
	@Autowired
	private OpinionCommentDao opinionCommentDao;
	
	//한 페이지에 나타낼 로우의 갯수
	private static final int PAGE_ROW_COUNT=5;
	//하단 디스플레이 페이지 갯수
	private static final int PAGE_DISPLAY_COUNT=3;	
	
	@Override
	public void getList(HttpServletRequest request) {
		//관리자모드 여부
		String adminMode=(String)request.getAttribute("adminMode");	// controller에서 setting
		
		//검색과 관련된 파라미터를 읽어와 본다.
		String keyword=request.getParameter("keyword");
		String condition=request.getParameter("condition");		
		
		//OpinionDto 객체를 생성해서 
		OpinionDto dto=new OpinionDto();
		if(keyword != null) {//검색어가 전달된 경우 
			if(condition.equals("titlecontent")) {//제목+내용 검색
				dto.setTitle(keyword);
				dto.setContent(keyword);
			}else if(condition.equals("title")) {//제목 검색
				dto.setTitle(keyword);
			}else if(condition.equals("writer")) {//작성자 검색
				dto.setWriter(keyword);
			}
			//list.jsp 에서 필요한 내용 담기
			request.setAttribute("condition", condition);
			request.setAttribute("keyword", keyword);
		}
		
		// 관리자 모드가 아니면 자기 아이디만 조회되도록 처리
		if(!adminMode.equals("Y")) {
			String id=(String)request.getSession().getAttribute("id");
			dto.setWriter(id);
		}
		
		//보여줄 페이지의 번호
		int pageNum=1;
		//보여줄 페이지의 번호가 파라미터로 전달되는지 읽어온다.
		String strPageNum=request.getParameter("pageNum");
		if(strPageNum != null){//페이지 번호가 파라미터로 넘어온다면
			//페이지 번호를 설정한다.
			pageNum=Integer.parseInt(strPageNum);
		}
		//보여줄 페이지 데이터의 시작 ResultSet row 번호
		int startRowNum=1+(pageNum-1)*PAGE_ROW_COUNT;
		//보여줄 페이지 데이터의 끝 ResultSet row 번호
		int endRowNum=pageNum*PAGE_ROW_COUNT;
		
		//전체 row 의 갯수를 읽어온다.
		int totalRow=opinionDao.getCount(dto);
		//전체 페이지의 갯수 구하기
		int totalPageCount=
				(int)Math.ceil(totalRow/(double)PAGE_ROW_COUNT);
		//시작 페이지 번호
		int startPageNum=
			1+((pageNum-1)/PAGE_DISPLAY_COUNT)*PAGE_DISPLAY_COUNT;
		//끝 페이지 번호
		int endPageNum=startPageNum+PAGE_DISPLAY_COUNT-1;
		//끝 페이지 번호가 잘못된 값이라면 
		if(totalPageCount < endPageNum){
			endPageNum=totalPageCount; //보정해준다. 
		}
		
		// 위에서 만든 OpinionDto 에 추가 정보를 담는다. 
		dto.setStartRowNum(startRowNum);
		dto.setEndRowNum(endRowNum);
		
		//1. FileDto 객체를 전달해서 파일 목록을 불러온다 
		List<OpinionDto> list=opinionDao.getList(dto);
		
		//2. request 에 담고
		request.setAttribute("list", list);
		// 페이징 처리에 관련된 값도 request 에 담기 
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("startPageNum", startPageNum);
		request.setAttribute("endPageNum", endPageNum);
		request.setAttribute("totalPageCount", totalPageCount);
		// 전체 row 의 갯수도 전달하기
		request.setAttribute("totalRow", totalRow);		
	}

	@Override
	public void insert(HttpServletRequest request) {
		//작성자
		String writer=(String)request.getSession().getAttribute("id");
		//제목
		String title=request.getParameter("title");
		//내용
		String content=request.getParameter("content");
		
		//OpinionDto 에 담기
		OpinionDto dto=new OpinionDto();
		dto.setWriter(writer);
		dto.setTitle(title);
		dto.setContent(content);
		//DB 에 저장
		opinionDao.insert(dto);
		
	}

	@Override
	public void detail(HttpServletRequest request) {
		String adminMode=(String)request.getAttribute("adminMode");	// controller에서 setting
		
		//1. 파라미터로 전달되는 글번호 읽어오기
		int num=Integer.parseInt(request.getParameter("num"));
		//검색과 관련된 파라미터를 읽어와 본다.
		String keyword=request.getParameter("keyword");
		String condition=request.getParameter("condition");		
		
		//OpinionDto 객체를 생성해서 
		OpinionDto dto=new OpinionDto();
		if(keyword != null) {//검색어가 전달된 경우 
			if(condition.equals("titlecontent")) {//제목+내용 검색
				dto.setTitle(keyword);
				dto.setContent(keyword);
			}else if(condition.equals("title")) {//제목 검색
				dto.setTitle(keyword);
			}else if(condition.equals("writer")) {//작성자 검색
				dto.setWriter(keyword);
			}
			//list.jsp 에서 필요한 내용 담기
			request.setAttribute("condition", condition);
			request.setAttribute("keyword", keyword);
		}		
		//글번호도 dto 에 담는다.
		dto.setNum(num);
		
		//2. OpinionDao 를 이용해서 글정보를 읽어와서
		OpinionDto resultDto=opinionDao.getData(dto);
		
		// 관리자 모드인 경우만 조회수 증가
		if(adminMode.equals("Y")) {
			// 글 조회수 올리기
			opinionDao.addViewCount(num);			
		}
	
		//3. request 에 담고
		request.setAttribute("dto", resultDto);
		//로그인 여부 확인해서  request 에 담기 
		String id=(String)request.getSession().getAttribute("id");
		boolean isLogin=false;
		if(id!=null) {
			isLogin=true;
		}
	
		// 로그인 여부 
		request.setAttribute("isLogin", isLogin);
		// 댓글 목록
		List<OpinionCommentDto> commentList=
				opinionCommentDao.getList(num);
		request.setAttribute("commentList", commentList);		
	}

	@Override
	public void commentInsert(OpinionCommentDto dto) {
		
		//저장할 댓글의 번호를 미리 얻어낸다.
		int seq=opinionCommentDao.getSequence();
		//댓글을 DB 에 저장
		dto.setNum(seq);
		//댓글의 그룹 번호를 읽어온다. ( 0 or 다른 숫자가 들어있다 )
		int comment_group=dto.getComment_group();
		if(comment_group==0) {//원글의 댓글인 경우
			dto.setComment_group(seq);
		}
		//새 댓글을 저장한다. 
		opinionCommentDao.insert(dto);		
	}

	@Override
	public void delete(HttpServletRequest request) {
		
		//1. 파라미터로 전달되는 글번호
		int num=Integer.parseInt(request.getParameter("num"));
		
		/*
		 *  로그인된 아이디와 삭제할 글의 작성자와 다르면
		 *  ForbiddenException 발생 시키기
		 */
		String id=(String)request.getSession().getAttribute("id");
		//글번호를 이용해서 
		OpinionDto dto=new OpinionDto();
		dto.setNum(num);
		//해당글의 작성자를 읽어와서 
		String writer=opinionDao.getData(dto).getWriter();
		if(!id.equals(writer)) {
			throw new ForbiddenException();
		}
		
		//2. 삭제하기 
		opinionCommentDao.delete(num);	// 댓글삭제
		opinionDao.delete(num);			// 의견 삭제
	}

	@Override
	public void update(HttpServletRequest request) {
		//수정할 글정보 얻어오기 
		int num=Integer.parseInt(request.getParameter("num"));
		String title=request.getParameter("title");
		String content=request.getParameter("content");
		//OpinionDto 에 담기
		OpinionDto dto=new OpinionDto();
		dto.setNum(num);
		dto.setTitle(title);
		dto.setContent(content);
		//OpinionDao 를 이용해서 수정 반영
		opinionDao.update(dto);		
	}

	@Override
	public void getCountNoView(HttpServletRequest request) {
		int opinionCount=opinionDao.getCountNoView();
		request.setAttribute("opinionCount", opinionCount);
	}
	
}
