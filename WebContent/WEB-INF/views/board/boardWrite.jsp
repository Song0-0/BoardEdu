<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>boardWrite게시글 등록</title>
</head>
<script type="text/javascript">
$j(document).ready(function() { //문서가 준비되면 매개변수로 넣은 콜백함수를 실행하라는 의미
	//3. 게시글 등록하기 버튼을 누르면,
	//행추가로 인하여, title과 comment가 여러개가 된다. 따라서 이 여러개를 각 게시글로 인식하도록 해주어야한다.
	//title, comment의 값들을 갖고와서 배열에 집어넣고 배열형태로 controller에 보내주자.
	$j("#submit").on("click", function() {

		var board_type = [];
		var title = [];
		var comment = [];
 
		$j('select[name="boardType"]').each(function(i) {
			board_type.push($j(this).val());
		});

		$j('input[name="boardTitle"]').each(function(i) {
			title.push($j(this).val());
		});

		$j('textarea').each(function(i) {
			comment.push($j(this).val());
		});

		var objParams = {
			"boardTitle" : JSON.stringify(title), //제목 저장
			"boardComment" : JSON.stringify(comment) //내용 저장
		};
		 
		var objParams = {
			"boardType" : board_type,
			"boardTitle" : title,
			"boardComment" : comment
		}; 

		//title과 comment가 없으면 alert 띄우기해보기. (클라가 꼭 값을 입력할 수 있도록) validate쓸 수도 있지만 잘 안쓰임

		$j.ajax({
			url : "/board/boardWriteAction.do",
			dataType : "json", //위의 url에 대한 return값
			type : "POST", //서버상의 데이터 값이나 상태를 바꾸기 위해 사용. (게시글 작성 후 DB에 클라이언트로 받은 값들을 넣으니까)
			traditional : true, //왜 쓰는지 알아보기
			data : objParams,
			success : function(data, textStatus, jqXHR) {
				alert("게시글 등록 완료, 메시지 : " + data.success + "건");
				location.href = "/board/boardList.do?";
			},
			error : function(jqXHR, textStatus, errorThrown) {
				alert("게시글 등록 실패");
			}
		});
	});
}); 
</script>

<body>

	<form action="/board/boardWriteAction.do" method="POST">

		<div style="display: flex; justify-content: center; align-items: center; margin-left: 300px">
			<input type="button" value="행 추가" onclick="insertRow()" /> 
			<input type="button" value="행 선택 삭제" onclick="deleteRow()" /> 
			<a href="/board/boardList.do"><input type="button" value="목록" /></a>
		</div>

		<table id="copyTable" align="center" border="1">
			<tbody>
				<tr>
					<td><input type="checkbox" name="eachBoard" class="check" value="" /></td>
					<td></td>
				</tr>

				<tr>
					<td width="120" align="center">Type</td>

					<td width="400"><select name="boardType">
							<c:forEach items="${boardWriteList}" var="boardWriteList">
								<option value="${boardWriteList.codeId}">${boardWriteList.codeName}</option>
							</c:forEach>
					</select></td>
				</tr>

				<tr>
					<td width="120" align="center">Title</td>
					<!-- checkbox로 게시글 선택되게 하기 -->
					<td width="400"><input name="boardTitle" type="text" size="50" value="${board.boardTitle}"></td>
					<!-- model.attribute가 이거에 해당하는 컨트롤러에는 없는데? 그럼 board.은 어디서 나온건가 -->
					<!--컨트롤러에서 이 부분에 의한 board. !!! model.addAttribute("board", boardVo); -->
				</tr>

				<tr>
					<td height="300" align="center">Comment</td>
					<td valign="top"><textarea name="boardComment" rows="20" cols="55">${board.boardComment}</textarea></td>
				</tr>
			</tbody>

			<tr>
				<td align="center">Writer</td>
				<td>${board.creator}</td>
			</tr>
			
		</table>

		<div style="display: flex; justify-content: center; align-items: center;">
			<input id="submit" type="button" value="게시글 등록하기"> <!-- type="submit" -->
		</div>

	</form>

</body>

<script type="text/javascript">
	//body안에 있는 함수는 가끔 body하단에 넣어야 된다!!!
	//1. 행 추가 버튼을 누르면,

	// 이건 클래스명 유동적으로 붙이는 방법임;
	//var count = 0;
	//$j("#copyTable tbody").attr('class', 'check_tbody'+count++);

	let sum = 1;
	
	function insertRow() {

		// copyTable id를 가진 table중 tbody중 뒤에서 2번째 요소 선택
		const table = $j("#copyTable tbody:nth-last-child(2)");
		// 해당 요소 복제
		const clone = table.clone();

		// 복제한 요소를 뒤에서 2번째 tbody요소 뒤에(형제)로 붙여넣기
		table.after(clone);
		

		// 복제한 요소에 내용이 같이 딸려오니 초기화 작업 
		// find는 뒤에서 2번째 tbody 후손 중 해당 선택자 가져오는 function
		// children은 자손만 가져옴
		// 자손은 바로 아래의 것, 후손은 아래 전부 것 <-- 차이는 구글링 해보시면 이해가 빠를 거에요~
		$j("tbody:nth-last-child(2)").find('input').val('');
		$j("tbody:nth-last-child(2)").find('textarea').val('');

		
	}
	
	//2. 행 삭제 버튼을 누르면,
	function deleteRow() {

		// id가 copyTable인 요소에서 input type checkbox인 것 전부 가져와서 for문 돌림
		$j('#copyTable input[type=checkbox]').each(function(index, item) { // item == this

			// 해당 요소 중에 check가 된것만 삭제할 것이기 때문에 if절 처리
			if ($j(this).prop('checked')) {

			// parents()는 부모 요소 전부를 선택(body까지였나..html까지엿나 일꺼에요)
			// 그래서 그 부모 중 tbody요소만 지울꺼라 tbody만 골라줌
			$j(this).parents('tbody').remove();
			
			}
		})
	}
</script>
</html>