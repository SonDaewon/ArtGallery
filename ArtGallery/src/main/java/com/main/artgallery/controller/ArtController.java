package com.main.artgallery.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.main.artgallery.art.dto.ArtDto;
import com.main.artgallery.service.ArtService;


@Controller
public class ArtController {
	@Autowired
	private ArtService aService;		// ArtService에서 T_ArtRel도 함께 관리합니다.
	
	
	/*
	 * ----------------------------------------------------------------------------
	 * 사용자 서비스 영역 시작
	 * ----------------------------------------------------------------------------
	 */
	
	
	
	
	/*
	 * ----------------------------------------------------------------------------
	 * 관리자 서비스 영역 시작
	 * ----------------------------------------------------------------------------
	 */	
	// 임시 로그인 처리
	@RequestMapping("/loginAuto")
	public String loginAuto(HttpSession session, @RequestParam String id) {
		session.setAttribute("id", id);
		if(id.equals("hyung")) {
			session.setAttribute("roll", "A");
		}else {
			session.setAttribute("roll", "U");
		}
		return "redirect:/home.do";
	}
	
	//관리자 작품 목록
	@RequestMapping("/admin/art/list.do")
	public ModelAndView adminArtList(HttpServletRequest request, ModelAndView mView, @ModelAttribute ArtDto dto) {
		aService.getList(mView, dto);
		mView.setViewName("admin/art/list");
		return mView;
	}
	//관리자 작품 등록화면
	@RequestMapping("/admin/art/insertform.do")
	public ModelAndView adminArtInsertform(HttpServletRequest request) {
		return new ModelAndView("admin/art/insertform");
	}
	//관리자 작품 등록처리
	@RequestMapping("/admin/art/insert.do")
	public ModelAndView adminArtInsert(HttpServletRequest request, @ModelAttribute ArtDto dto) {
		aService.insert(dto);
		return new ModelAndView("redirect:/admin/art/list");
	}
}
