package com.main.artgallery.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.servlet.ModelAndView;

import com.main.artgallery.art.dto.ArtCommentDto;
import com.main.artgallery.art.dto.ArtDto;
import com.main.artgallery.art.dto.ArtRelDto;

public interface ArtService {
	//-------- Son ----------------------
	public void getSearchList(HttpServletRequest request, ModelAndView mView);
	
	
	//-------- hyung ----------------------
	
	public void getList(HttpServletRequest request, ModelAndView mView, ArtDto dto);
	public void getData(HttpServletRequest request, ModelAndView mView, ArtDto dto);
	public void insert(HttpServletRequest request, ArtDto dto);
	public void update(HttpServletRequest request, ArtDto dto);
	public void delete(HttpServletRequest request, int seq);
	public int  getSequence();							// sequence값 가져오기
	public void insertRel(int seq, String relData);		// 연계 텍스트 자료 분리해서 insert 하기
	public void fileDelete(String realPath, String imagePath);	// 파일삭제
	public void getConfig(HttpServletRequest request);
	public String[] artRelTextMerge(List<ArtRelDto> list);
	
	// artcomment
	public void getCommentList(HttpServletRequest request, ModelAndView mView);
	public void getCommentList(HttpServletRequest request, ModelAndView mView, ArtCommentDto dto);
	public void commentInsert(HttpServletRequest request, ArtCommentDto dto);
	public void commentDelete(HttpServletRequest request, int num);	
}
