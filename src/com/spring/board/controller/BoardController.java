package com.spring.board.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.board.HomeController;
import com.spring.board.controller.dto.DeleteBoardDto;
import com.spring.board.service.boardService;
import com.spring.board.vo.BoardVo;
import com.spring.board.vo.ComCodeVo;
import com.spring.board.vo.PageVo;
import com.spring.common.CommonUtil;

@Controller
public class BoardController {

	@Autowired 	// @Inject하면 뭐가 다른 것일까? 옛날거다..?
	boardService boardService;

	private static final Logger logger = LoggerFactory.getLogger(HomeController.class); //옛날방식?

	// 1. 게시판 목록 조회창으로 이동. (첫페이지)
	@RequestMapping(value = "/board/boardList.do", method = RequestMethod.GET)
	public String boardList(HttpServletRequest request, Model model, PageVo pageVo) throws Exception {

		System.out.println("게시글조회가능");

		int page = 1;
		int totalCnt = 0;

		if (pageVo.getPageNo() == 0)
			pageVo.setPageNo(page);

		List<ComCodeVo> comCodeNameList = new ArrayList<ComCodeVo>(); // list 선언 (codeName과 codeId 를 조회해줘라는 sql문을 comCodeNameList로 받은 것이다.)
		List<BoardVo> boardList = new ArrayList<BoardVo>(); // jsp에서 c:foreach문에서 ${boardList}로 활용함.

		comCodeNameList = boardService.codeNameList(); // SELECT CODE_NAME,CODE_ID FROM COM_CODE WHERE CODE_TYPE='menu'
		boardList = boardService.SelectBoardList(pageVo); // SELECT CODE_NAME,BOARD_TYPE,BOARD_NUM,BOARD_TITLE,BOARD_COMMENT,TOTAL_CNT

		totalCnt = boardService.selectBoardCnt(); // SELECT COUNT(*) AS TOTAL_CNT FROM BOARD //이 세개는 서버까지 갖고 왔다.

		// model을 이용해 view에 데이터 넘겨주기 (model : Controller에서 생성한 데이터를 담아서 View로 전달할 때 사용하는 객체.)
		model.addAttribute("codeNameList", comCodeNameList); // boardList.jsp 에서 codeNameList으로 불러올 수 있는 이유 ("key", value)
		model.addAttribute("boardList", boardList);
		model.addAttribute("totalCnt", totalCnt);
		model.addAttribute("pageNo", page);

		return "board/boardList";
	}

	// 2. 작성된 모든 게시글 중에서, 선택된 게시글로이동하기 (List -> boardView.jsp)
	/*
	 * @RequestMapping(value = "/board/{boardType}/{boardNum}/boardView.do", method
	 * = RequestMethod.GET) public String boardView(Locale locale, Model
	 * model, @PathVariable("boardType") String boardType, @PathVariable("boardNum")
	 * int boardNum) throws Exception {
	 * 
	 * BoardVo boardVo = new BoardVo();
	 * 
	 * boardVo = boardService.selectBoard(boardType, boardNum);
	 * 
	 * model.addAttribute("boardType", boardType); // boardView.jsp에서 사용
	 * model.addAttribute("boardNum", boardNum); // boardView.jsp에서 사용
	 * model.addAttribute("board", boardVo); // boardView.jsp에서 사용
	 * 
	 * return "board/boardView"; }
	 */

	@RequestMapping(value = "/board/{boardType}/{boardNum}/boardView.do", method = RequestMethod.GET)
	public String boardView(Locale locale, Model model, @PathVariable("boardType") String boardType, @PathVariable("boardNum") int boardNum,BoardVo request)
			throws Exception {
		
		//BoardVo boardVo = new BoardVo();
		
		BoardVo boardVo = boardService.selectBoard(request.getBoardType(), request.getBoardNum());
		
		//model.addAttribute("boardType", boardType); // boardView.jsp에서 사용
		//model.addAttribute("boardNum", boardNum); // boardView.jsp에서 사용
		model.addAttribute("board", boardVo); // boardView.jsp에서 사용
		
		return "board/boardView";
	}

	// 3. 게시글 작성 창으로 이동(List.jsp->Write.jsp)-----------------------------------------------------------
	@RequestMapping(value = "/board/boardWrite.do", method = RequestMethod.GET)
	// @ResponseBody //이걸 넣으면 board/boardWrite를 String형태로 그냥 jsp에 출력이 된다. 예를 들어, 여기서 쓰는 이유는 ajax로 성공했을 때의 data를 넘겨줄 때 쓴다.
	public String boardWrite(Model model, PageVo pageVo, ComCodeVo comCodeVo) throws Exception {
		// codeId와 codeName을 작성페이지에 줘야해서 ComCodeVo객체 활용
		List<ComCodeVo> boardWriteList = new ArrayList<ComCodeVo>(); // jsp에서 c:foreach문에서 ${boardWriteList}로 활용함.

		boardWriteList = boardService.codeNameList(); // codeNameList()는 codeId와 codeName을 조회하는 쿼리.

		model.addAttribute("boardWriteList", boardWriteList); // model객체에 담아서 view단 즉 jsp에 보냄.

		return "board/boardWrite";
	}

	// 4. 게시글 작성 완료클릭했을 때 액션 (boardWrite -> boardList.jsp )  행추가로 인해 많이 어려웠던 부분.
	@RequestMapping(value = "/board/boardWriteAction.do", method = RequestMethod.POST) // jsp에 매핑을 통해 동일한 url로 온다. POST는 서버상의 데이터 값이나 상태를 바꾸기 위해 사용한다.
	@ResponseBody // 서버에서 클라이언트로 응답데이터를 전송하기 위해, 이 어노테이션을 사용해 자바객체를 HTTP응답 본문의 객체로 변환하여 클라이언트로 전송.
	public String boardWriteAction(HttpServletRequest request, BoardVo boardVo) throws Exception { // boardWriteAction! controller단의 번호가 각각 지정되서 게시글이 넘어가야한다.
		// values붙은건 배열로 받아줌. "boardType" select태그의 name을 사용한 것. 태그의 name값이 키(key)로 해서 값(value)가 전송된다.
		// 즉, request에 값이 전달될 때 Map과 마찬가지로 key와 value쌍의 형식으로 데이터가 저장된다.
		// 서버단에서 request.getParameterValues(parameterName)으로 값을 가져온다.
		String[] array_boardType = request.getParameterValues("boardType");
		String[] array_boardTitle = request.getParameterValues("boardTitle");
		String[] array_boardComment = request.getParameterValues("boardComment");
		int count = 0;

		// xml에 있는 sql구문이 클라이언트가 추가한 개수만큼 실행해야되니까 for문을 통해서 개수만큼 추가시키기 위해.
		for (int i = 0; i < array_boardTitle.length; i++) {
			// BoardVo boardVo = new BoardVo();
			boardVo.setBoardType(array_boardType[i]);
			boardVo.setBoardTitle(array_boardTitle[i]);
			boardVo.setBoardComment(array_boardComment[i]);
			int resultCnt = boardService.boardInsert(boardVo); // controller의 역할! service를 호출하는 구문. (insert가 되는 게시글 개수를 resultCnt에 받는다.)
			count += resultCnt;
		}

		System.out.println(boardVo.getBoardVoList());

		HashMap<String, String> result = new HashMap<String, String>(); // HashMap key value 형식

		CommonUtil commonUtil = new CommonUtil(); // getJsonCallBackString메서드를 사용하기 위해 CommonUtil의 객체를 생성한 것 같다.

		result.put("success", (count > 0) ? "Y : " + count : "N"); // HashMap에 put메서드를 이용해 값을 추가한다. String(key) , String(value)

		String callbackMsg = commonUtil.getJsonCallBackString(" ", result); // getJsonCallBackString(String callback,
		// Object obj)
		System.out.println("등록완료여부callbackMsg::" + callbackMsg); // callbackMsg 콘솔에 출력

		return callbackMsg; // callbackMsg 리턴 (boardWrite.jsp에 있는 ajax로 가는 것?)
	}

	// 게시글 수정은!!!!!!!!!!!! 두개의 url매핑 메서드를 작성해야한다.
	// 첫번째는 조회 List.jsp에서 수정 Update.jsp로 이동할 수 있도록 해주는 메서드. 5번
	// 두번째는 수정 Update.jsp에서 내용 변경 후 수정 완료 링크 눌렀을 때 실행되는 메서드. 6번
	
	// 5. 수정 페이지 이동 메서드 (List.jsp -> Update.jsp)
	@RequestMapping(value = "/board/{boardType}/{boardNum}/boardUpdateView.do", method = RequestMethod.GET)
	public String boardUpdate(@PathVariable("boardType") String boardType, @PathVariable("boardNum") int boardNum, Model model) throws Exception {

		BoardVo boardVo = new BoardVo();

		boardVo.setBoardNum(boardNum);
		boardVo.setBoardType(boardType);

		// boardVo = boardService.selectBoard(boardVo);
		boardVo = boardService.selectBoard(boardType, boardNum); // SELECT BOARD_NUM,BOARD_TYPE,BOARD_TITLE,BOARD_COMMENT FROM BOARD WHERE
																	// BOARD_TYPE = #{boardType} AND BOARD_NUM = #{boardNum}
		model.addAttribute("boardNum", boardNum);
		model.addAttribute("boardType", boardType);
		model.addAttribute("board", boardVo);

		return "board/boardUpdate";
	}

	// 수정될 내용의 데이터를 가져오기 위해 BoardVo 클래스를 매개변수로 부여했고,
	// 수정 기능 실행 후 리다이렉트 방식으로 리스트페이지 이동 시 업데이트된 데이터를같이 전송하기 위해 RedirectAttributes 객체를
	// 파라미터로 부여!
	// boardList.jsp 페이지 이동 시 수정이 완료 되었음을 알리는 얼랏을 띄울라고 success스트링 데이터를 result속성 값에
	// 저장하는 flash 메서드를 호출함.

	// 6. 두번째. 수정 완료 링크 눌렀을 때 실행되는 메서드. Post방식으로 작성. 왜 post방식으로 해야할까? 스트링쿼리로 보여줄라고?
	// -> 아니. 수정은 서버상의 데이터 값or상태를 바꾸기 위한 것이니 POST방식인거.
	@RequestMapping(value = "/board/boardUpdate.do", method = RequestMethod.POST)
	@ResponseBody // 서버에서 클라이언트로 응답데이터를 전송하기 위해, 이 어노테이션을 사용해 자바객체를 HTTP응답 본문의 객체로 변환하여 클라이언트로 전송.
	public String boardUpdatePOST(BoardVo boardVo) throws Exception { // boardWriteAction! controller단의 메서드...

		HashMap<String, String> result = new HashMap<String, String>(); // HashMap key value 형식
		CommonUtil commonUtil = new CommonUtil(); // getJsonCallBackString메서드를 사용하기 위해 CommonUtil의 객체를 생성한 것 같다.

		int resultCnt = boardService.boardUpdate(boardVo); // controller의 역할! service를 호출하는 구문.

		result.put("success", (resultCnt > 0) ? "Y" : "N"); // HashMap에 put메서드를 이용해 값을 추가한다. String(key) , String(value)

		String callbackMsg = commonUtil.getJsonCallBackString(" ", result); // getJsonCallBackString(String callback,
																			// Object obj)
		System.out.println("수정완료여부callbackMsg::" + callbackMsg); // callbackMsg 콘솔에 출력

		return callbackMsg; // callbackMsg 리턴
	}

	// 7. 게시글 삭제를 때 액션 (jsp에 삭제되었다고 표시될 수 있게봄)
	@RequestMapping(value = "/board/boardDelete.do", method = RequestMethod.POST) // jsp에 매핑을 통해 동일한 url로 온다. POST는 서버상의 데이터 값or상태를 바꾸기 위해 사용.
	@ResponseBody // 서버에서 클라이언트로 응답데이터를 전송하기 위해, 이 어노테이션을 사용해 자바객체를 HTTP응답 본문의 객체로 변환하여 클라이언트로 전송.
	public DeleteBoardDto boardDelete(BoardVo boardVo, Model model) throws Exception { // boardWriteAction!
																														// controller단의
		// 메서드... //RedirectAttributes redirectAttributes
		//int resultCnt = boardService.boardDelete(boardVo); // controller의 역할! service를 호출하는 구문.

		//if (resultCnt > 0) { //Model객체가 아닌 redirectAttribute해야지 List.jsp에 뜨게 할 수 있다. Flash를 써야지 List.jsp 를 새로고침 시 삭제되었습니다의 문구가 안뜬다!
		//	String deleteResult = "해당 게시글이 삭제되었습니다";
		//redirectAttributes.addFlashAttribute("deleteResult", deleteResult); String 통으로가 아닌 매핑을 해서 보내야한다. 1회용으로 준다.(새로고침하면 문구 더 안뜸)
		//}
		
		DeleteBoardDto deleteBoardDto = new DeleteBoardDto(); //이렇게 객체 자체를 ajax로 보내서 사용가능하다.
		
		//ajax를 통해 성공하면 성공했다는 데이터를 넘겨주고 alert에 삭제되었다고 띄울 떄
		  
		  HashMap<String, String> result = new HashMap<String, String>(); // HashMap key value 형식
		  CommonUtil commonUtil = new CommonUtil(); //getJsonCallBackString메서드를 사용하기 위해 CommonUtil의 객체를 생성한 것 같다.
		  
		  int resultCnt = boardService.boardDelete(boardVo); // controller의 역할! service를 호출하는 구문.
		  
		  
		  result.put("success", (resultCnt > 0) ? "Y" : "N"); // HashMap에 put메서드를 이용해 값을 추가한다.  String(key) , String(value)

		  deleteBoardDto.setSuccess((resultCnt > 0)? "Y" : "N");
		  
		  String callbackMsg = commonUtil.getJsonCallBackString(" ", result); //getJsonCallBackString(String callback, // Object obj)
		  System.out.println("삭제완료여부callbackMsg::" + callbackMsg); // callbackMsg 콘솔에출력
		

		//return "redirect:/board/boardList.do"; // callbackMsg 리턴
		//return result; // callbackMsg 리턴
		return deleteBoardDto; // callbackMsg 리턴
	}

}
