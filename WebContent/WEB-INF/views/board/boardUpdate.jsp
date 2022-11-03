<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>boardUpdate 게시글 수정하기</title>
</head>
<script src="/resources/js/jquery-1.10.2.js"></script>
<body>
	<!-- 사용자 수정하는 input 태그를 감싸는 form태그를 새로추가한다. 해당 태그는 사용자가 수정한 데이터 내용을 서버에 전송하기 위한 목적이다.
해당 form 데이터는 POST 방식 "board/boardUpdate" url 매핑 메서드에 전송될 것이기 때문에 그에 맞게 속성과 속성 값을 추가한다. -->

	<!--  boardView jsp에서 수정을 누르면 이 jsp로 넘어오는 거니까, boardView에서 설정한 model.addAttribute("board", boardVo); 이걸로 여기서 ${board.boardNum}의 board.을 쓸 수 있다는 거?? -->
	<form id="boardupdateForm" action="/board/boardUpdate.do" method="post">
		<!-- <table align="center">  -->
		<table align="center" border="1">
			<tr>
				<td width="120" align="center">Board Num</td>
				<td width="400"><input name="boardNum" readonly="readonly" style="border: none" value='<c:out value="${board.boardNum}"/>'></td>
			</tr>

		<!-- 	<tr>
				<!-- 이게 없었어서 수정 완료가 되지 않았음. 근데 사용자한테 boardType말고 codeName보여주고싶음.. 고민을 해보자..
				<td width="120" align="center">Board Type</td>
				<td width="400"><input name="boardType" readonly="readonly" style="border: none" value='<c:out value="${board.boardType}"/>'></td>
			</tr>  -->

			<input type="hidden" name="boardType" readonly="readonly" style="border: none" value='<c:out value="${board.boardType}"/>'>


			<tr>
				<td width="120" align="center">Title</td>
				<td width="400"><input name="boardTitle" style="border: none" value='<c:out value="${board.boardTitle}"/>'></td>
			</tr>

			<!-- <tr>
				<td height="300" align="center">Comment</td>
				<td width="400"><input name="boardComment" style="border: none" value='<c:out value="${board.boardComment}"/>'></td>
			</tr>  -->

			<tr>
				<td height="300" align="center">Comment</td>
				<td valign="top"><textarea name="boardComment" rows="20" cols="55">${board.boardComment}</textarea></td>
			</tr>

			<tr>
				<td align="center">Writer</td>
				<td width="400"><input name="creator" readonly="readonly" style="border: none" value='<c:out value="${board.creator}"/>'></td>
			</tr>
		</table>

		<table align="center">
			<tr>
				<td align="right"><input id="update" type="button" value="수정완료"></td>
				<!-- <button type=submit  id="update_btn" class="btn" onclick=updateBoard(); >수정 완료</button> -->
				<td align="right"><a class="btn" id="list_btn" href="/board/boardList.do"><input type="button" value="목록으로 돌아가기"></a></td>
			</tr>
		</table>
	</form>
	<!-- <form id="infoForm" action="/board/boardUpdate.do" method="get">
	<input type="hidden"  id="boardNum" name="boardNum" value='<c:out value="${board.boardNum}"></c:out>'/>
	</form> -->
	<!-- 	</table>  -->
</body>

<script type="text/javascript">
	//let mform = $('#boardupdateForm'); //페이지 데이터 수정 폼

	/*목록페이지 이동 링크*/
	$("#list_btn").on("click", function(e) {
		/*
		form.find("#boardNum").remove();
		form.attr("action", "/board/boardList");
		form.submit();
		 */
	});

	/*	function updateBoard() {
	 $("#boardupdateForm").submit();
	 }*/

	/*	$j(document).ready(function(){
	
	 if(result === "modify success") {
	 alert("수정이 완료되었습니다.");
	 }
	 }); */

	//수정완료 유무
	$j("#update").on("click", function() {
		var $frm = $j('#boardupdateForm :input');
		var param = $frm.serialize();
		console.log("param값"+ param);
		
		$j.ajax({
			url : "/board/boardUpdate.do",
			dataType : "json", //json이니까 key,value형태로 간다. 컨트롤러에 json방식으로 넘어감.
			type : "POST",
			data : param,
			success : function(result, textStatus, jqXHR) { //result는 컨트롤러에서 받은 return값
			console.log("result값"+result.success);
				alert("수정 완료!! | " + result.success);

				location.href = "/board/boardList.do?pageNo=0";
			},
			error : function(jqXHR, textStatus, errorThrown) {
				alert("수정 완전 실패");
			}
		});
	});
</script>
</html>