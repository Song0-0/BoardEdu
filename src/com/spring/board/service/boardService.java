package com.spring.board.service;

import java.util.List;

import com.spring.board.vo.BoardVo;
import com.spring.board.vo.ComCodeVo;
import com.spring.board.vo.PageVo;

public interface boardService {

	public List<ComCodeVo> codeNameList() throws Exception; //ComCode테이블에 있는 codeName, codeId 조회

	public int selectBoardCnt() throws Exception; //게시글 전체 개수

	public List<BoardVo> SelectBoardList(PageVo pageVo) throws Exception; //전체 게시글 목록

	//public BoardVo selectBoard(BoardVo boardVo) throws Exception; //수정버튼에 대한 게시글 선택 (안됫던거)
	public BoardVo selectBoard(String boardType, int boardNum) throws Exception; //(된거)


	public int boardInsert(BoardVo boardVo) throws Exception; //게시글 작성
	
	//Dao메서드를 호출하기 위한 메서드를 선언한다. 이 메서드도 반환타입 int로 하기. Controller에서 활용하지 않더라도 선택지를 넓혀주는 의미에서 반환타입 설정.
	public int boardUpdate(BoardVo boardVo) throws Exception;
	
	public int boardDelete(BoardVo boardVo) throws Exception;

	public String selectTest() throws Exception;

}
