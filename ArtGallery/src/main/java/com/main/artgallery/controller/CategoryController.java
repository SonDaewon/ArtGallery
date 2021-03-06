package com.main.artgallery.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.main.artgallery.category.dto.CategoryDto;
import com.main.artgallery.service.CategoryService;



@Controller
public class CategoryController {
	@Autowired
	private CategoryService categoryService;
	
	// SHong,.
	@RequestMapping("/admin/adminCategory")
	public ModelAndView AdminCategory(HttpServletRequest request, ModelAndView mView) {
		categoryService.getList(request, mView);
		mView.setViewName("admin/category/admin_category");
		return mView;
	}

	@RequestMapping("/admin/insertform")
	public ModelAndView InsertForm(HttpServletRequest request, ModelAndView mView) {
		categoryService.insertForm(request, mView);
		mView.setViewName("admin/category/insertform");
		return mView;
	}
	
	@RequestMapping("/admin/insert")
	public ModelAndView Insert(HttpServletRequest request, ModelAndView mView, @ModelAttribute CategoryDto dto) {
		categoryService.insert(request, dto);
		mView.setViewName("redirect:/admin/adminCategory.do");
		return mView;
	}
	
	@RequestMapping("/admin/updateform")
	public	ModelAndView updateForm(HttpServletRequest request, ModelAndView mView) {
		categoryService.updateForm(request, mView);
		mView.setViewName("admin/category/updateform");
		return mView;
	}
	
	@RequestMapping("/admin/delete")
	public ModelAndView delete(HttpServletRequest request, ModelAndView mView) {
		categoryService.delete(request, mView);
		mView.setViewName("redirect:/admin/adminCategory.do");
		return mView;
	}
	
	@RequestMapping("/admin/update")
	public ModelAndView update(HttpServletRequest request, ModelAndView mView, @ModelAttribute CategoryDto dto) {
		categoryService.update(request, dto);
		mView.setViewName("redirect:/admin/adminCategory.do");
		return mView;
	}
	

	//Son
	@RequestMapping("/category/list")
	public ModelAndView CategoryList(HttpServletRequest request, ModelAndView mView) {
		categoryService.SonGetList(request, mView);
		mView.setViewName("category/list");
		return mView;
		
	}
	
	@RequestMapping("/category/detail")
	public ModelAndView CategoryDetail(HttpServletRequest request, ModelAndView mView) {
		categoryService.SonGetData(request, mView);
		
		mView.setViewName("category/detail");
		
		return mView;
		
	}

	//hyung
	@RequestMapping("/admin/category/categorySearchJson.do")
	@ResponseBody
	public List<CategoryDto> adminCategorySearch(HttpServletRequest request, ModelAndView mView){		
		categoryService.getSearchList(request, mView);
		List<CategoryDto> list=(List<CategoryDto>)request.getAttribute("list");
		return list;
	}
}
