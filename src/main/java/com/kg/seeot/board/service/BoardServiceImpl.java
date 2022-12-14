package com.kg.seeot.board.service;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.kg.seeot.board.dto.BoardDTO;
import com.kg.seeot.board.dto.FileDTO;
import com.kg.seeot.board.dto.ReplyDTO;
import com.kg.seeot.common.PagingDTO;
import com.kg.seeot.mybatis.board.BoardMapper;

@Service
public class BoardServiceImpl implements BoardService {
	
	@Autowired
	BoardMapper mapper;
	@Autowired
	BoardFileService bfs;
	
	public void boardList(Model model, String nowPage, String cntPerPage) {
		int total = mapper.boardCount();
		
		PagingDTO dto = new PagingDTO(total, Integer.parseInt(nowPage), Integer.parseInt(cntPerPage));
		int start = dto.getStart();
		int end = dto.getEnd();
		
		model.addAttribute("paging", dto);
		model.addAttribute("boardList", mapper.boardList(start, end));
	}

	public void getBoard(int boardNo, Model model) {
		model.addAttribute("dto", mapper.getBoard(boardNo));
		model.addAttribute("fileList", mapper.getBoardFile(boardNo));
	}

	public String boardWrite(MultipartHttpServletRequest mul, HttpServletRequest request) {
		BoardDTO dto = new BoardDTO();

		dto.setMemberId(mul.getParameter("memberId"));
		dto.setMemberName(mul.getParameter("memberName"));
		dto.setBoardTitle(mul.getParameter("boardTitle"));
		dto.setBoardContent(mul.getParameter("boardContent"));
		dto.setBoardQnAType(mul.getParameter("boardQnAType"));
		
		int result = 0;
		result = mapper.boardWrite(dto);
		
		Iterator<String> itr = mul.getFileNames();
		
		while(itr.hasNext()) {
			List<MultipartFile> fileList = mul.getFiles(itr.next());
			if(fileList.size()>0) {
				for(MultipartFile file : fileList) {
					//System.out.println("νμΌμ" + file.getOriginalFilename());
					FileDTO fdto = bfs.saveFile(file);
					fdto.setBoardNo(dto.getBoardNo());
					mapper.boardFileWrite(fdto);
				}
			}

		}
	
		String msg, url;
		if (result == 1) {
			msg = "κ²μκΈμ λ±λ‘νμ΅λλ€.";
			url = request.getContextPath() + "/board/boardList";
		} else {
			msg = "κ²μκΈ λ±λ‘μ μ€ν¨νμ΅λλ€.";
			url = request.getContextPath() + "/board/writeForm";
		}
		return bfs.getMessage(msg, url);
	}
	
	public String boardModify(MultipartHttpServletRequest mul, HttpServletRequest request) {
		int boardNo = Integer.parseInt(mul.getParameter("boardNo"));
		
		BoardDTO dto = new BoardDTO();
		dto.setMemberName(mul.getParameter("memberName"));
		dto.setBoardTitle(mul.getParameter("boardTitle"));
		dto.setBoardContent(mul.getParameter("boardContent"));
		dto.setBoardQnAType(mul.getParameter("boardQnAType"));
		dto.setBoardNo(boardNo);
		
		//μ­μ ν  μ΄λ―Έμ§μ μ μ₯λ μ΄λ¦ κ°μ Έμ€κΈ°
		String[] deleteImages = mul.getParameterValues("delete_image");
		//String λ°°μ΄λ‘ κ°μ Έμ€κΈ° λλ¬Έμ μννλ©° μ΄λ¦ λ½μμ΄
		if(deleteImages != null) {
			for(String image : deleteImages) {
				bfs.deleteImage(image);
				mapper.deleteImage(image);
			}
		}
		
		Iterator<String> itr = mul.getFileNames();
		
		while(itr.hasNext()) {
			List<MultipartFile> fileList = mul.getFiles(itr.next());
			if(fileList.size()>0) {
				for(MultipartFile file : fileList) {
					FileDTO fdto = bfs.saveFile(file);
					fdto.setBoardNo(dto.getBoardNo());
					mapper.boardFileWrite(fdto);
				}
			}

		}
		
		int result = 0;
		result = mapper.boardModify(dto);
		
		String msg, url;
		if (result == 1) {
			msg = "κ²μκΈμ΄ μμ λμμ΅λλ€.";
			url = request.getContextPath() + "/board/boardList";
		} else {
			msg = "κ²μκΈ μμ μ μ€ν¨νμ΅λλ€.";
			url = request.getContextPath() + "/board/modifyForm?boardNo="+boardNo;
		}
		return bfs.getMessage(msg, url);
	}
	
	public String delete(int boardNo, HttpServletRequest request) {
		List<FileDTO> fileList = mapper.getBoardFile(boardNo);
		int result = mapper.delete(boardNo);
			
		String msg, url;
		if (result == 1) {
			if(fileList != null) {
				for(FileDTO file : fileList) {
					String deleteImage = file.getFileSaveName();
					bfs.deleteImage(deleteImage);
				}
			}
			msg = "μ±κ³΅μ μΌλ‘ μ­μ  λμμ΅λλ€!!!";
			url = request.getContextPath() + "/board/boardList";
		} else {
			msg = "μ­μ  μ€ν¨!!!";
			url = request.getContextPath() + "/board/getBoard?boardNo=" + boardNo;
		}
		return bfs.getMessage(msg, url);
	}
	
	public void upHit(int boardNo) {
		mapper.upHit(boardNo);
	}
	
	public void addReply(Map<String, String> map) {
		mapper.addReply(map);
		int boardNo = Integer.parseInt(map.get("boardNo"));
		mapper.replyCount(boardNo);
	}
	
	public ArrayList<ReplyDTO> getReplyList(int boardNo){
		return mapper.getReplyList(boardNo);
	}
	
	public int deleteReply(int replyNo, int boardNo) {
		int result = 0;
		result = mapper.deleteReply(replyNo);
		mapper.replyCount(boardNo);
		return result;
	}
	
	public int modifyReply(int replyNo, String updateContent) {
		return mapper.modifyReply(replyNo, updateContent);
	}
}
