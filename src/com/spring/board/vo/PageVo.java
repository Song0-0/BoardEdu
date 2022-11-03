package com.spring.board.vo;

public class PageVo {

	private int pageNo = 0;
	private String[] codeId; //배열로 설정한 이유가 checkbox에서 여러개를 선택할 수 있으니깍.
	private String codeName;
	private int boardNum;
	private String boardType;
	// 게시글제목, 작성자, 코드아이디
	// titleName, writer , codeId


	public int getPageNo() {
		return pageNo;
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

	public void setPageNo(int pageNo) {
		this.pageNo = pageNo;
	}

	public String[] getCodeId() {
		return codeId;
	}

	public void setCodeId(String[] codeId) {
		this.codeId = codeId;
	}

	public String getCodeName() {
		return codeName;
	}

	public void setCodeName(String codeName) {
		this.codeName = codeName;
	}
	
	

}
