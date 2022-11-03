package com.spring.board.vo;

import java.util.List;

public class BoardVo {
	
	/*
	 * 커맨드 객체 : 쉽게 말해 VO(DTO)와 같다고 생각해도 된다. 커맨드 객체가 되기 위한 조건은 Getter와 Setter가 필수. 클라이언트가 전달해주는 파라미터 데이터를 주입 받기 위해 사용되는 객체
	 * 커맨드 객체 역할 : 1) 컨트롤러에서 View로 바인딩 : View단에서 form:form태그를 사용하는 경우
	 * 2)View에서 컨트롤러로 바인딩 : View단에서 input type="text" or input type="hidden" 으로 값을 컨트롤러로 전송하는 경우
	 * 3) 컨트롤러에서 Mapper.xml로 바인딩 : Mapper.xml에서 title=#{title}, contents=#{contents}처럼 사용하는 경우, 커멘드 객체를 통해, #{변수명}과 커맨드 객체의 필드명을 통해 바인딩 해주는 경우
	 */
	
	private String 	boardType; //타입 a01 a02 a03 a04 boardType = codeId
	private int 	boardNum; //번호
	private String 	boardTitle; //제목
	private String 	boardComment; //내용
	private String 	creator; //작성자
	private String	modifier; //수정자 (왜 필요하지...? 작성자만 수정할 수 있게 해야하는데)
	private int totalCnt; //전체 게시글 수
	
	private String codeName; //일반 Q&A 익명 자유. codeId에 따라 부여된 codeName
	//private String[] codeId; //a01 a02 a03 a04. boardType = codeId ( boardType이랑 같으니까 아예 PageVo에다가 변수를 선언해주는 것인가!?!??
	//private String[] codeId;
	
	private List<BoardVo> boardVoList; //컨트롤러에 String[] array_boardType = request.getParameterValues("boardType"); 이렇게 일일히 안하고 배열로 받아서 for문으로 할라고.
	
//====================
	
	public int getTotalCnt() {
		return totalCnt;
	}
	public void setTotalCnt(int totalCnt) {
		this.totalCnt = totalCnt;
	}
	public int getBoardNum() {
		return boardNum;
	}
	public void setBoardNum(int boardNum) {
		this.boardNum = boardNum;
	}
	public String getBoardType() {
		return boardType;
	}
	public void setBoardType(String boardType) {
		this.boardType = boardType;
	}
	public String getBoardTitle() {
		return boardTitle;
	}
	public void setBoardTitle(String boardTitle) {
		this.boardTitle = boardTitle;
	}
	public String getBoardComment() {
		return boardComment;
	}
	public void setBoardComment(String boardComment) {
		this.boardComment = boardComment;
	}
	public String getCreator() {
		return creator;
	}
	public void setCreator(String creator) {
		this.creator = creator;
	}
	public String getModifier() {
		return modifier;
	}
	public void setModifier(String modifier) {
		this.modifier = modifier;
	}

	public String getCodeName() {
		return codeName;
	}
	public void setCodeName(String codeName) {
		this.codeName = codeName;
	}
	public List<BoardVo> getBoardVoList() {
		return boardVoList;
	}
	public void setBoardVoList(List<BoardVo> boardVoList) {
		this.boardVoList = boardVoList;
	}


	
}
