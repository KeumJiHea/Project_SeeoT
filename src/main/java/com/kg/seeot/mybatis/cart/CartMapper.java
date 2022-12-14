package com.kg.seeot.mybatis.cart;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.kg.seeot.cart.dto.CartDTO;

public interface CartMapper {
	public void addCart_p(@Param("m")String memberId,@Param("n") int productNo,@Param("s") String productSize, @Param("c") String productColor,@Param("o") String productSatck);
	public void addCart_m(@Param("n") int productNo,@Param("s") String productSize, @Param("c") String productColor);
	public ArrayList<CartDTO> getCart(String memberId);
	public int deleteCartOne(@Param("m") String memberId, @Param("c") int cartnum);
	public int deleteChkCart(@Param("m") String memberId, @Param("c") int cartNum);
	public void alldel(String memberId);
	public ArrayList<CartDTO> getSameCart(@Param("m")String memberId,@Param("n")int productNo,@Param("s") String productSize, @Param("c") String productColor);	
	public int adminDel(int productNo);
}
