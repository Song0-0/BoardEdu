package com.spring.board.dao.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.board.dao.BoardDao;
import com.spring.board.vo.BoardVo;
import com.spring.board.vo.ComCodeVo;
import com.spring.board.vo.PageVo;

@Repository
public class BoardDaoImpl implements BoardDao {

	@Autowired
	private SqlSession sqlSession;
	

	/*
	 * 보면 크게 2가지 방법이 있다. 첫째로 정의된 namespace와 id를 직접 이용해 sqlSession객체로 실행할 수 있다. 둘째로는
	 * sqlSession을 통해 Mapper객체를 생성하고 이를 통해 실행하는 방법이다. 나는 첫번째방법을 계속 썼던거고.
	 */

	// 책에서 BoardMapper 인터페이스 만들어서
	// public List<BoradVO> getList(); 로 만들었던데, DAO랑 MAPPER 역할이 비슷한거고 sqlSession사용한
	// 방법이랑 이 어노테이션 방법이랑 비슷하다는거?

	// code_name을 불러오기 위해 ...
	@Override
	public List<ComCodeVo> codeNameList() throws Exception {
		return sqlSession.selectList("board.codeNameList");
	}

	// 게시글 전체 개수 확인
	@Override
	public int selectBoardCnt() throws Exception {
		return sqlSession.selectOne("board.boardTotal");
	}

	// 게시글 전체 목록 보여주기
	@Override
	public List<BoardVo> selectBoardList(PageVo pageVo) throws Exception {
		return sqlSession.selectList("board.boardList", pageVo);
	}

	@Override
	public BoardVo selectBoard(BoardVo boardVo) throws Exception {
		return sqlSession.selectOne("board.boardView", boardVo); // "namespace.쿼리id" 는 xml파일에 있는 sql문참고하는 것! 콤마 뒤에 있는 객체형식 변수넣는건 옵션이다
	}

	// sqlSession : int insert(query_id, Object obj) : id에 대한 insert문을 실행하면서 객체의 값을
	// 테이블에 추가
	// 입력 추가된 게시글이 1건이니까 int반환타입에 의해 1이 리턴되는 것인가?
	@Override
	public int boardInsert(BoardVo boardVo) throws Exception {
		return sqlSession.insert("board.boardInsert", boardVo);
	}

	// 게시글 삭제
	@Override
	public int boardDelete(BoardVo boardVo) throws Exception {
		return sqlSession.delete("board.boardDelete", boardVo);
	}

	// 게시글 수정
	@Override
	public int boardUpdate(BoardVo boardVo) throws Exception {
		return sqlSession.update("board.boardUpdate", boardVo);
	}

	// Test해본듯
	@Override
	public String selectTest() throws Exception {
		String a = sqlSession.selectOne("board.boardList");
		return a;
	}

}
