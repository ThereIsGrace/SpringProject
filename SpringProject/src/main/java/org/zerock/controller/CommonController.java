package org.zerock.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.zerock.domain.Adminclaim;
import org.zerock.domain.Common;
import org.zerock.domain.Goods;
import org.zerock.service.CartService;
import org.zerock.service.ClaimService;
import org.zerock.service.GoodsService;

import lombok.extern.log4j.Log4j;

@RequestMapping("/")
@Controller
@Log4j 
public class CommonController {
	
	@Autowired
	GoodsService service;
		
	@Autowired
	ClaimService claimService;

	
	@RequestMapping("/home")
	public String mainPage(Model model, Common common) {

		List<Goods> goodsList = service.goodsList(common);

		model.addAttribute("goodsList",goodsList);
		if(goodsList.size() > 0)
			model.addAttribute("tot", goodsList.get(0).getTotalCount());

		return "home";
	}
	
	@RequestMapping("/home2")
	public String homePage2(Model model) {
	//	model.addAttribute("goodsList",service.goodsList());
		return "/main/home2";
	}
	
	@RequestMapping("/home3")
	public String homePage3(Model model) {
//		model.addAttribute("goodsList",service.goodsList());
		return "/main/home3";
	}
	
	
	@RequestMapping("/list/goods")
	public String goods() {
		return "item";
	}
	
	@RequestMapping("/about")
	public String about() {
		return "about";
	}
	
	@RequestMapping("/contact")
	public String contact() {
		return "contact";
	}
	
	@RequestMapping("/blogs")
	public String bloglist() {
		return "blogs";
	}
	
	@RequestMapping("/blogs/blog")
	public String blog() {
		return "blog";
	}

	@RequestMapping("/qna")
	public String qna() {
		return "qna";
	}
	
	@RequestMapping("/sample/member")
	public String membersample() {
		return "/sample/member";
	}
	
	@GetMapping("/test")
	public String test() {
		
		
		return "test";
	}
	
	@GetMapping("/test2")
	public String test2() {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String id = auth.getName();
		
		log.info("id:"+id);
		
		return "/claim/writeClaim";
	}
	
	@PostMapping("/test3")
	@ResponseBody
	public String test3() {
		
		return "test";
	}
}