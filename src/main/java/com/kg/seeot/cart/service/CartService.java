package com.kg.seeot.cart.service;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

import com.kg.seeot.cart.dto.CartDTO;

public interface CartService {
	public void addCart(int productNo,int orderStack);
	public ArrayList<CartDTO> getCart(Model model,String memberId);
	public int deleteOneCart(String memberId,int productNo);
	public int deleteChkCart(String memberId, int cartNum);
}
