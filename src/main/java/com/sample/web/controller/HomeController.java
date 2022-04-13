package com.sample.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sample.web.controller.HomeController;

@Controller
public class HomeController {

	// 홈
	@RequestMapping("/")
	public String home(Model model) {
		
		return "home";
	}
}
