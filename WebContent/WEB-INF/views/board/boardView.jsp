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
		//����
		$j("#delete").on("click", function() {
			var $frm = $j('.boardView :input'); //input�� ��Ȯ�� ������ �ް��ִ� ���ΰ� button�� �ƴϰ��� �������� �����ϱ�. input�� boardNum�� ���̴�..
			var param = $frm.serialize(); //serialize() : jquery ajax�� ȣ���ϱ� ���� serialize()�� ���ָ� form�ȿ� ������ �ѹ��� ���� ������ data�� ���� �� �־� ���� data�� ���� �� �����ϴ�.(ajax�ƴ� ��Ȳ������ ��� ����). ���� : $("form id�Ǵ� name").serialize();
			//serialize()�� ������� �ʴ´ٸ� �ϳ��� �������ϱ� ������ ���� data�� �������� �밡�ٸ� ��û�ؾ���.

			$j.ajax({
				url : "/board/boardDelete.do",
				dataType : "json",
				type : "POST",
				data : param,
				success : function(data, textStatus, jqXHR) { //N�� error�� �����ϴµ� �� �Ȱ��°ɱ�???!!!!!!!!!!!!!!!!

					if (data.success == 'Y') {
						alert("���� ���� �Ǿ����ϴ�.");
					} else {
						alert("�̹� ���� �Ϸ�� ���Դϴ�.");
					}

					location.href = "/board/boardList.do?pageNo=0";
				},
				error : function(jqXHR, textStatus, errorThrown) {
					alert("���� ���� ����");
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

			<input type="hidden" name="boardType" size="50" value="${board.boardType}" readonly="readonly"/> <!-- ȭ��ܿ��� �Ⱥ��̰� �Ͱ�, �����ܿ��� �����ϰ� �; -->

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
					<td align="right"><a href="/board/boardList.do"><input type="button" value="���" /></a></td>
					<td align="right"><a href="/board/${board.boardType}/${board.boardNum}/boardUpdateView.do"><input type="button" value="����"></a></td>
					<!-- "/board/boardUpdateView.do"  -->
					<td align="right"><input id="delete" type="button" value="���û���"></td> <!-- type="submit" -->
				</tr> 
			</table>
		</div>
	</form>
</body>
</html>