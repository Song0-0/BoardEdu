<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>boardUpdate �Խñ� �����ϱ�</title>
</head>
<script src="/resources/js/jquery-1.10.2.js"></script>
<body>
	<!-- ����� �����ϴ� input �±׸� ���δ� form�±׸� �����߰��Ѵ�. �ش� �±״� ����ڰ� ������ ������ ������ ������ �����ϱ� ���� �����̴�.
�ش� form �����ʹ� POST ��� "board/boardUpdate" url ���� �޼��忡 ���۵� ���̱� ������ �׿� �°� �Ӽ��� �Ӽ� ���� �߰��Ѵ�. -->

	<!--  boardView jsp���� ������ ������ �� jsp�� �Ѿ���� �Ŵϱ�, boardView���� ������ model.addAttribute("board", boardVo); �̰ɷ� ���⼭ ${board.boardNum}�� board.�� �� �� �ִٴ� ��?? -->
	<form id="boardupdateForm" action="/board/boardUpdate.do" method="post">
		<!-- <table align="center">  -->
		<table align="center" border="1">
			<tr>
				<td width="120" align="center">Board Num</td>
				<td width="400"><input name="boardNum" readonly="readonly" style="border: none" value='<c:out value="${board.boardNum}"/>'></td>
			</tr>

		<!-- 	<tr>
				<!-- �̰� ����� ���� �Ϸᰡ ���� �ʾ���. �ٵ� ��������� boardType���� codeName�����ְ����.. ����� �غ���..
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
				<td align="right"><input id="update" type="button" value="�����Ϸ�"></td>
				<!-- <button type=submit  id="update_btn" class="btn" onclick=updateBoard(); >���� �Ϸ�</button> -->
				<td align="right"><a class="btn" id="list_btn" href="/board/boardList.do"><input type="button" value="������� ���ư���"></a></td>
			</tr>
		</table>
	</form>
	<!-- <form id="infoForm" action="/board/boardUpdate.do" method="get">
	<input type="hidden"  id="boardNum" name="boardNum" value='<c:out value="${board.boardNum}"></c:out>'/>
	</form> -->
	<!-- 	</table>  -->
</body>

<script type="text/javascript">
	//let mform = $('#boardupdateForm'); //������ ������ ���� ��

	/*��������� �̵� ��ũ*/
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
	 alert("������ �Ϸ�Ǿ����ϴ�.");
	 }
	 }); */

	//�����Ϸ� ����
	$j("#update").on("click", function() {
		var $frm = $j('#boardupdateForm :input');
		var param = $frm.serialize();
		console.log("param��"+ param);
		
		$j.ajax({
			url : "/board/boardUpdate.do",
			dataType : "json", //json�̴ϱ� key,value���·� ����. ��Ʈ�ѷ��� json������� �Ѿ.
			type : "POST",
			data : param,
			success : function(result, textStatus, jqXHR) { //result�� ��Ʈ�ѷ����� ���� return��
			console.log("result��"+result.success);
				alert("���� �Ϸ�!! | " + result.success);

				location.href = "/board/boardList.do?pageNo=0";
			},
			error : function(jqXHR, textStatus, errorThrown) {
				alert("���� ���� ����");
			}
		});
	});
</script>
</html>