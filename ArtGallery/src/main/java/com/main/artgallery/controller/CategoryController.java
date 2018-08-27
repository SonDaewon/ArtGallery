package com.main.artgallery.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.main.artgallery.category.dao.CategoryDao;
import com.main.artgallery.category.dao.CategoryDaoImpl;
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
	

	//Son
	@RequestMapping("/user/list")
	public ModelAndView CategoryList(HttpServletRequest request, ModelAndView mView) {
		categoryService.SonGetList(request, mView);
		mView.setViewName("user/list");
		return mView;
		
	}
	
	@RequestMapping("/user/detail")
	public ModelAndView CategoryDetail(HttpServletRequest request, ModelAndView mView) {
		categoryService.SonGetData(request, mView);
		mView.setViewName("user/detail");
		
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
