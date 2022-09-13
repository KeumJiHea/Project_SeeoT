package com.kg.seeot.order.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kg.seeot.member.service.MemberService;
import com.kg.seeot.order.service.OrderService;
import com.kg.seeot.product.dto.ProductDTO;
import com.kg.seeot.product.service.ProductService;

@Controller
@RequestMapping("order")
public class OrderController {
	@Autowired OrderService os;
	@Autowired ProductService ps;
	@Autowired MemberService ms;
	
	@GetMapping("ordermain")
	public String orderMain(Model model,int productNo) {
		System.out.println("컨트롤러 동작 성공");
		ps.productView(model, productNo);
		return "/order/orderMain";
	}
	@PostMapping("orderchk")
	public String orderchk() {
		System.out.println("컨트롤러 동작 성공");
		return "/order/orderchk";
		
	}
	
	
	@PostMapping("test2")
	public String productOrder(Model model, HttpServletRequest req, String productName, String productColor, String productSize , String productStack) {
		System.out.println(req.getParameter("productNo"));
		System.out.println(req.getParameter("productName"));
		System.out.println(req.getParameter("productFile"));
		System.out.println(req.getParameter("productPrice"));
		System.out.println(productColor);
		System.out.println(productSize);
		System.out.println(productStack);
		os.productOrder(model, req, productColor, productSize, productStack);
		return "/order/test2";
	}
}
