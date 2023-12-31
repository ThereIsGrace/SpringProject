package org.zerock.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.zerock.domain.Common;
import org.zerock.domain.Goods;
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

		log.info("enter the mainPage");
		List<Goods> goodsList = service.goodsList(common);

		model.addAttribute("goodsList",goodsList);
		if(goodsList.size() > 0)
			model.addAttribute("tot", goodsList.get(0).getTotalCount());

		return "home";
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
}