package com.spring.board.dao;

import java.util.List;

import com.spring.board.vo.BoardVo;
import com.spring.board.vo.ComCodeVo;
import com.spring.board.vo.PageVo;

public interface BoardDao { // Mapper 인터페이스로 만든것들은 Impl없던대.. 인터페이스인데 구현 안해도되나?? -> 구현안해도된다. 그럼 매퍼를 그냥 클래스로
							// 만들면 되나? -> 그냥 인터페이스로 구현한다. MyBatis는 Mapper interface에 대한 구현 클래스를 자동으로 생성하므로 개발자는 인터페이스만 생성하면 된다.

	public List<ComCodeVo> codeNameList() throws Exception;

	public int selectBoardCnt() throws Exception;

	public List<BoardVo> selectBoardList(PageVo pageVo) throws Exception; // 왜 pageVo를 매개변수로 받았을까?

	public BoardVo selectBoard(BoardVo boardVo) throws Exception; // 매개변수를 각각의 필드명이아니라 이렇게 다 객체로 받아버리는게 편한거 같은데.. 뭐 용량같은걸 신경써야하나?

	public int boardInsert(BoardVo boardVo) throws Exception;

	public int boardDelete(BoardVo boardVo) throws Exception; // 게시글 삭제

	// 게시글 수정 (필요한 데이터가 bnum,title,content,creator 즉 vo에 정의되어있는 거니까 매개변수로 vo를 넣은
	// 것이다. 수정 수행하는 메서드는 반환타입 필요 없다.
	// 그렇지만 int로 return타입주면 성공시1반환 실패시0반환
	public int boardUpdate(BoardVo boardVo) throws Exception;

	
	public String selectTest() throws Exception;
	//public void boardCount(BoardVo boardVo) throws Exception;

}
