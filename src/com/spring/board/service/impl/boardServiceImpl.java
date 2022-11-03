package com.spring.board.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.board.dao.BoardDao;
import com.spring.board.dao.impl.BoardDaoImpl;
import com.spring.board.service.boardService;
import com.spring.board.vo.BoardVo;
import com.spring.board.vo.ComCodeVo;
import com.spring.board.vo.PageVo;

@Service
public class boardServiceImpl implements boardService{
	
	@Autowired
	BoardDao boardDao;

	@Override
	public List<ComCodeVo> codeNameList() throws Exception { //codeName, codeId를 조회하는 메서드		
		return boardDao.codeNameList();
	}
	
	@Override
	public int selectBoardCnt() throws Exception {
		return boardDao.selectBoardCnt();
	}
	
	@Override
	public List<BoardVo> SelectBoardList(PageVo pageVo) throws Exception {
		return boardDao.selectBoardList(pageVo);
	}
	
	
	/*
	 * @Override 
	 * public BoardVo selectBoard(BoardVo boardVo) throws Exception { // 안됫던거
	 * TODO Auto-generated method stub
	 * 
	 * return boardDao.selectBoard(boardVo); 
	 * }
	 */	
	@Override
	public BoardVo selectBoard(String boardType, int boardNum) throws Exception {
		// TODO Auto-generated method stub
		BoardVo boardVo = new BoardVo();
		
		boardVo.setBoardType(boardType); // set을 하면 클라이언트가 클릭한 게시글의 type과 num에 해당하는 게시글을 where 조건으로 sql에 실행되는거
		boardVo.setBoardNum(boardNum);
		
		return boardDao.selectBoard(boardVo); //selectOne 메서드 때문에.. 메서드는 단하나만 들어올수있어서 타입과 넘버를 둘다 넣기 위해 객체를 넣은거.
	}
	
	
	@Override
	public int boardInsert(BoardVo boardVo) throws Exception {
		// TODO Auto-generated method stub
		return boardDao.boardInsert(boardVo);
	}

	//앞에 인터페이스에서 선언한 메서드를 구현. 구현 내용은 Dao메서드 호출이다.
	@Override
	public int boardUpdate(BoardVo boardVo) throws Exception {
		
		return boardDao.boardUpdate(boardVo);
	}

	@Override
	public int boardDelete(BoardVo boardVo) throws Exception {
		
		return boardDao.boardDelete(boardVo);
	}
	
	@Override
	public String selectTest() throws Exception {
		return boardDao.selectTest();
	}

}
