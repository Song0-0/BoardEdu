<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>boardList �Խñ� ��ü ���</title>
</head>

<body>
	<table align="center">
		<tr>
			<td align="right">��ü �Խñ� : ${totalCnt} ��</td>
		</tr>

		<!-- <tr>
			<td  align="center" style="background-color: pink">${deleteResult}</td> <!-- �����Ǿ��ٴ� ������ ����ϱ� ����
		</tr>  -->

		<tr>
			<td>
				<table id="boardTable" border="1">
					<tr>
						<td width="40" align="center" style="background-color: pink">No</td>
						<td width="60" align="center" style="background-color: pink">Type</td>
						<td width="300" align="center" style="background-color: pink">Title</td>
					</tr>
					<c:forEach items="${boardList}" var="list">
						<!-- 1.�Խ��� ��ȸ�� ���� ��Ʈ�ѷ����� ����� ���� boardList�� items�� ���! cf) List<BoardVo> boardList = new ArrayList<BoardVo>(); -->
						<tr>
							<td>${list.boardNum}</td>
							<td align="center">${list.codeName}</td>
							<!-- boardType�� CODE_NAME���� ���������. -->
							<!-- "/board/${list.boardNum}/boardView.do?pageNo=${pageNo}" List.jsp �� ����  -->
							<!-- <td><a href="/board/boardView/${list.boardNum}/${list.boardType}">${list.boardTitle}</a></td> -->
							<td><a href="/board/${list.boardType}/${list.boardNum}/boardView.do?pageNo=${pageNo}" style="text-decoration-line: none">${list.boardTitle}</a></td>
						</tr>
					</c:forEach>
				</table>
			</td>
		</tr>

		<tr>
			<td align="center"><a href="/board/boardWrite.do"><input type="button" value="�Խñ� �ۼ��ϱ�" /></a></td>
		</tr>
	</table>

	<!-- ���2. �ѹ��� �ҷ��� �� �ֵ��� -->
	<form action="/board/boardList.do" method="get" id="checking">
		<div style="display: flex; justify-content: center; align-items: center;">

			<input type="checkbox" class="typeCheck" id="checkAll" value="selectAll">��ü

			<c:forEach var="code" items="${codeNameList}" varStatus="status">
				<!-- �̰� List.jsp�� ������� �������� model��ü�� ���� �޾ƿ� ���̱� ������ form�±׿� ������� ���� ����Ǵ� ���̶�� ���� �ȴ�.-->
				<!-- forEach���� ���� �ݺ��ؼ� �Ϲ� �͸�,,,���. ${codeName}��ü�� ��Ʈ�ѷ��� �迭�� ����ִ� ���� -->
				<input type="checkbox" class="typeCheck" name="codeId" value="${code.codeId}">${code.codeName}</>
			</c:forEach>

			<div style="display: flex; justify-content: center; align-items: center; margin-left: 10px">
				<button type="submit" name="searchBtn">��ȸ</button>
			</div>
		</div>
	</form>
</body>
<!-- ���1. ������ ����ؼ� ȿ�������� ���� -->
<!-- <form action="/board/boardList.do" method="get" id="checking" class="checking">
		<div style="display: flex; justify-content: center; align-items: center;">
			<!-- checkbox�� üũ�� �� �� ����� �����ϸ� ������ ����Ǵ� name/value ���� codeId=a01�� �Ǵ� ���̴�. -->
<!-- COM_CODE��� ���̺��� �̿��ؼ� ó���غ���... 
			<input type="checkbox" name="selectAllName" value="selectAll" onclick="selectAll(this)">��ü
			<!-- name : ������ ���� �̸�. value : ���޵� �� 
			<input type="checkbox" name="codeId" value="a01" onclick="checkSelectAll(this)">�Ϲ� <input type="checkbox" name="codeId" value="a02" onclick="checkSelectAll(this)">Q&A <input type="checkbox" name="codeId" value="a03" onclick="checkSelectAll(this)">�͸� <input type="checkbox" name="codeId" value="a04" onclick="checkSelectAll(this)">����
		</div>
	</form>  -->


<script type="text/javascript">


console.log("codeName����:" + ${fn:length(codeNameList)})
var codeNameLength = ${fn:length(codeNameList)};
console.log(codeNameLength);

 window.onload = function() {
	var all = document.getElementsByTagName("input");
	var categories = document.getElementsByName("codeId");
	
	//��ü ���ý� ��ü ����/�ٽ� ������ ��ü ����
	document.getElementById("checkAll").onclick = function() {
		if(checkAll.checked) {
			for(var i=0; i<categories.length; i++) {
				categories[i].checked = true;
			}
		}else {
				for(var i=0; i<categories.length; i++) {
					categories[i].checked = false;
				}
			}
		}
	
	//ī�װ� �� checkboxŬ�� �� c()����
	for(var i=0; i<categories.length; i++ ){
		categories[i].onclick = c;
	}

	//ī�װ� �ϳ��� �ȴ����� ��ü üũ�ڽ� ����, ī�װ� �װ� �� ���� �Ǹ� ��ü�� ���õǰ� ����
	function c() {
		for(var i=0; i<categories.length; i++) {
			if(categories[i].checked ==false) { //���� ������. cf) === �� ��ġ������(���� Ÿ���� ���ƾ��Ѵ�.)
				checkAll.checked = false; //false�� checkAll.checked�� �־���. ���Կ�����!!
			}else if($j("input[name='codeId']:checked").length == codeNameLength) {
				checkAll.checked = true;				
			}
		}
	}
}

//��ȸ������ form�� ���� checkbox value������ �迭�� ��Ʈ�ѷ����� ������ ����
/*  $j("searchBtn").click(function() {
 	$j("#checking").submit();
 }); */
 
/* console.log("codeName����:" + ${fn:length(codeNameList)})
//var codeName = ${code.codeName}
//console.log("codeName���:" + codeName) //�ڵ���� �迭�� ������ ����ϰ� �ʹٸ�? ���⼭�� �𸣰ڰ� ��Ʈ�ѷ����� Ȯ����(����׷�)

var codeNameLength = ${fn:length(codeNameList)};

$j(".typeCheck").click(function(event){
	console.log('click', event);
	if ($j("#checkAll:checked")) { //��ü�� üũ�� �Ǹ�,
		//������ input�ڽ��� �� üũ�ǰ� ����.
		$j("input[name='codeId']").prop("checked", true);
		
		//event.target.getAttribute('id') === 'checkAll'
		//$j("input[name='codeId']").prop("checked", true);
		//console.log('CheckAll!!!!!')
		//console.log('checked??', event.target.checked)
	} 
	else if($j("#checkAll:checked")===false) { //��ü�� üũ�� ����������, (üũ�� �����Ǹ�)
			$j("input[name='codeId']").prop("checked", false);
	} 
	else { //input�ڽ� ���̿� �ڵ���ӱ��̰� ������ ��ü���� ���õǰ��ϰ�, ��ǲ�ڽ��� �ϳ��� üũ�����Ǹ� ��ü���� �����ǰ� �ϱ�.
		if($j("input[name='codeId']:checked").length == codeNameLength) {
			console.log('allcheck')
			$j("#checkAll").prop("checked", true);
		}else {
			console.log('here')
			$j("#checkAll").prop("checked",false);
		}
	}	
}); */

//���1,2�� ��ü���ø� �����ѰŰ�... �̰� ��ü���� ��, �ϳ��� ������ ������ �� ��ü���õ� ���������� ����!���� �� �ȵ���... �ٵ� ���� ���̺��� ���� �޾ƿ��� �Ǿ�����... �� �� ����..

/* function checkSelectAll(checkbox) { //�Ű������� ���޹��� üũ�ڽ� ����� checked���� false�� ���(�ϳ��� üũ�ڽ��� ������ ������ ���) selectAlläũ�ڽ����� false�� ����ǵ��� ����.
	
	const selectAll = document.querySelector('input[name="selectAll"]');
	
	if(checkbox.checked === false) {
		selectAll.checked = false;
	}
}   */

 /* function selectAll(selectAll) {
	const checkboxes = document.getElementsByName("codeId");
	
	checkboxes.forEach((checkbox) => {
		checkbox.checked = selectAll.checked
	})
}    */


//��Ʈ�ѷ��� �ִ� ���� ��� ���� ��...�˰�ʹ�..
//const a = ${boardList};
//console.log(a.codeName);

//��ü ����/���� ���� ���1, ���2
//���1. getElementsByName ����ؼ� NodeList �����
/* function selectAll(selectAll) {
//name='boardType'�� ��� ��Ҹ� ã�Ƽ� NodeList���·� ����
const checkboxes = document.getElementsByName('boardType');
//forEach �ݺ����� ����Ͽ� ��ȸ�ϸ鼭, �� üũ�ڽ��� checked���� '��ü'����� check��(selectAll.checked)�� �����ϰ� ����
checkboxes.forEach((checkbox) => { //checkbox��� item���� �������ִ� �ǰ�? ������ �ִ� input�� type�� �ƴ϶�??
	checkbox.checked = selectAll.checked;
		})
} */

 //���2. querySelectorAll ����ؼ� NodeList�����
/*function selectAll(selectAll) {
	const checkboxes = document.querySelectorAll('input[type="checkbox"]');
	console.log(checkboxes);
	checkboxes.forEach((checkbox) => {
		checkbox.checked = selectAll.checked;
	})
}*/

//�̰� ������ �𸣰ڴµ�... ������ �������� �� ��ü�������� �Ǿ��ϴµ� �ȵȴ�.
/* $j(document).ready(function(){
		$j("#selectAll").click(function() {
			
		if($j("#selectAll").is("checked")) 
			$j("input[name=codeId]").prop("checked", true);
		else $j("input[name=codeId]").prop("checked", false);		
		});
	
		$j("input[name=codeId]").click(function(){
			var total = $j("input[name=codeId]").length;
			var checked = $j("input[name=codeId]:checked").length;
			
			if(total != checked)
				$j("#selectAll").prop("checked", false);
			else $j("#selectAll").prop("checked", true);
		});
});*/

</script>

</html>