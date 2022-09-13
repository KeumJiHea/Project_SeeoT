package com.kg.seeot.mybatis.board;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.kg.seeot.board.dto.ReviewDTO;

public interface ReviewMapper {
	String select(@Param("reviewStar") Integer reviewStar);
	public List<ReviewDTO> reviewList();
	public void addReply(Map<String, String> map);
	public int addReview(ReviewDTO dto);
	public List<ReviewDTO> getRepList(int productNo);

}
