<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>boardView</title>
</head>
<script type="text/javascript">
	$j(document).ready(function() {
		//삭제
		$j("#delete").on("click", function() {
			var $frm = $j('.boardView :input'); //input이 정확히 무엇을 받고있는 것인가 button은 아니겠지 연속으로 받으니까. input은 boardNum일 것이다..
			var param = $frm.serialize(); //serialize() : jquery ajax로 호출하기 전에 serialize()를 해주면 form안에 값들을 한번에 전송 가능한 data로 만들 수 있어 많은 data를 보낼 때 유용하다.(ajax아닌 상황에서도 사용 가능). 형태 : $("form id또는 name").serialize();
			//serialize()를 사용하지 않는다면 하나씩 담아줘야하기 때문에 보낼 data가 많을수록 노가다를 엄청해야함.

			$j.ajax({
				url : "/board/boardDelete.do",
				dataType : "json",
				type : "POST",
				data : param,
				success : function(data, textStatus, jqXHR) { //N면 error로 가야하는데 왜 안가는걸까???!!!!!!!!!!!!!!!!

					if (data.success == 'Y') {
						alert("정상 삭제 되었습니다.");
					} else {
						alert("이미 삭제 완료된 건입니다.");
					}

					location.href = "/board/boardList.do?pageNo=0";
				},
				error : function(jqXHR, textStatus, errorThrown) {
					alert("삭제 완전 실패");
				}
			});

		});

	});
</script>
<body>
	<form class="boardView" action="/board/boardDelete.do" method="POST">
		<table border="1" align="center">

			<tr>
				<td width="120" align="center" style="background-color:pink">Board Num</td>
				<td width="400"><input name="boardNum" size="50" value="${board.boardNum}" readonly="readonly"></td>
			</tr>

			<input type="hidden" name="boardType" size="50" value="${board.boardType}" readonly="readonly"/> <!-- 화면단에는 안보이고 싶고, 서버단에는 전달하고 싶어서 -->

			<tr>
				<td width="120" align="center" style="background-color:pink">Title</td>
				<td width="400">${board.boardTitle}</td>
			</tr>

			<tr>
				<td height="300" align="center" style="background-color:pink">Comment</td>
				<td>${board.boardComment}</td>
			</tr>

			<tr>
				<td align="center" style="background-color:pink">Writer</td>
				<td>${board.creator}</td>
			</tr>
		</table>

		<div style="display: flex; justify-content: center; align-items: center;">
			<table align="right">
				<tr>
					<td align="right"><a href="/board/boardList.do"><input type="button" value="목록" /></a></td>
					<td align="right"><a href="/board/${board.boardType}/${board.boardNum}/boardUpdateView.do"><input type="button" value="수정"></a></td>
					<!-- "/board/boardUpdateView.do"  -->
					<td align="right"><input id="delete" type="button" value="선택삭제"></td> <!-- type="submit" -->
				</tr> 
			</table>
		</div>
	</form>
</body>
</html>