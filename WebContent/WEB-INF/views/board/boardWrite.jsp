<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>boardWrite�Խñ� ���</title>
</head>
<script type="text/javascript">
$j(document).ready(function() { //������ �غ�Ǹ� �Ű������� ���� �ݹ��Լ��� �����϶�� �ǹ�
	//3. �Խñ� ����ϱ� ��ư�� ������,
	//���߰��� ���Ͽ�, title�� comment�� �������� �ȴ�. ���� �� �������� �� �Խñ۷� �ν��ϵ��� ���־���Ѵ�.
	//title, comment�� ������ ����ͼ� �迭�� ����ְ� �迭���·� controller�� ��������.
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
			"boardTitle" : JSON.stringify(title), //���� ����
			"boardComment" : JSON.stringify(comment) //���� ����
		};
		 
		var objParams = {
			"boardType" : board_type,
			"boardTitle" : title,
			"boardComment" : comment
		}; 

		//title�� comment�� ������ alert �����غ���. (Ŭ�� �� ���� �Է��� �� �ֵ���) validate�� ���� ������ �� �Ⱦ���

		$j.ajax({
			url : "/board/boardWriteAction.do",
			dataType : "json", //���� url�� ���� return��
			type : "POST", //�������� ������ ���̳� ���¸� �ٲٱ� ���� ���. (�Խñ� �ۼ� �� DB�� Ŭ���̾�Ʈ�� ���� ������ �����ϱ�)
			traditional : true, //�� ������ �˾ƺ���
			data : objParams,
			success : function(data, textStatus, jqXHR) {
				alert("�Խñ� ��� �Ϸ�, �޽��� : " + data.success + "��");
				location.href = "/board/boardList.do?";
			},
			error : function(jqXHR, textStatus, errorThrown) {
				alert("�Խñ� ��� ����");
			}
		});
	});
}); 
</script>

<body>

	<form action="/board/boardWriteAction.do" method="POST">

		<div style="display: flex; justify-content: center; align-items: center; margin-left: 300px">
			<input type="button" value="�� �߰�" onclick="insertRow()" /> 
			<input type="button" value="�� ���� ����" onclick="deleteRow()" /> 
			<a href="/board/boardList.do"><input type="button" value="���" /></a>
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
					<!-- checkbox�� �Խñ� ���õǰ� �ϱ� -->
					<td width="400"><input name="boardTitle" type="text" size="50" value="${board.boardTitle}"></td>
					<!-- model.attribute�� �̰ſ� �ش��ϴ� ��Ʈ�ѷ����� ���µ�? �׷� board.�� ��� ���°ǰ� -->
					<!--��Ʈ�ѷ����� �� �κп� ���� board. !!! model.addAttribute("board", boardVo); -->
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
			<input id="submit" type="button" value="�Խñ� ����ϱ�"> <!-- type="submit" -->
		</div>

	</form>

</body>

<script type="text/javascript">
	//body�ȿ� �ִ� �Լ��� ���� body�ϴܿ� �־�� �ȴ�!!!
	//1. �� �߰� ��ư�� ������,

	// �̰� Ŭ������ ���������� ���̴� �����;
	//var count = 0;
	//$j("#copyTable tbody").attr('class', 'check_tbody'+count++);

	let sum = 1;
	
	function insertRow() {

		// copyTable id�� ���� table�� tbody�� �ڿ��� 2��° ��� ����
		const table = $j("#copyTable tbody:nth-last-child(2)");
		// �ش� ��� ����
		const clone = table.clone();

		// ������ ��Ҹ� �ڿ��� 2��° tbody��� �ڿ�(����)�� �ٿ��ֱ�
		table.after(clone);
		

		// ������ ��ҿ� ������ ���� �������� �ʱ�ȭ �۾� 
		// find�� �ڿ��� 2��° tbody �ļ� �� �ش� ������ �������� function
		// children�� �ڼո� ������
		// �ڼ��� �ٷ� �Ʒ��� ��, �ļ��� �Ʒ� ���� �� <-- ���̴� ���۸� �غ��ø� ���ذ� ���� �ſ���~
		$j("tbody:nth-last-child(2)").find('input').val('');
		$j("tbody:nth-last-child(2)").find('textarea').val('');

		
	}
	
	//2. �� ���� ��ư�� ������,
	function deleteRow() {

		// id�� copyTable�� ��ҿ��� input type checkbox�� �� ���� �����ͼ� for�� ����
		$j('#copyTable input[type=checkbox]').each(function(index, item) { // item == this

			// �ش� ��� �߿� check�� �Ȱ͸� ������ ���̱� ������ if�� ó��
			if ($j(this).prop('checked')) {

			// parents()�� �θ� ��� ���θ� ����(body��������..html�������� �ϲ�����)
			// �׷��� �� �θ� �� tbody��Ҹ� ���ﲨ�� tbody�� �����
			$j(this).parents('tbody').remove();
			
			}
		})
	}
</script>
</html>