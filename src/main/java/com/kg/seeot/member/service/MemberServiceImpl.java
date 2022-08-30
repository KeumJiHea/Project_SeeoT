package com.kg.seeot.member.service;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.kg.seeot.member.dto.MemberDTO;
import com.kg.seeot.mybatis.member.MemberMapper;

@Service
public class MemberServiceImpl implements MemberService{

	@Autowired MemberMapper mapper;
	BCryptPasswordEncoder en = new BCryptPasswordEncoder();

	public int login_check( HttpServletRequest request ) {
		MemberDTO dto = mapper.getUser(request.getParameter("id"));
		if(dto != null) {
			if(en.matches(request.getParameter("pw"),dto.getMember_pw()) || dto.getMember_pw().equals(request.getParameter("pw"))) {
				return 0;	
			}
		}
		return 1;
	}
	public void keepLogin(String id, String cookieId) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		map.put("cookieId", cookieId);
		mapper.keepLogin(map);
	}
	public int register(MemberDTO dto) {
		String seq = en.encode(dto.getMember_pw());
		
		dto.setMember_pw( seq );
		
		try {
			return mapper.register( dto );
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}
	public int idCheck(String id) throws Exception {
		
		return mapper.idCheck(id);
	}
}



















