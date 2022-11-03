<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>boardList 게시글 전체 목록</title>
</head>

<body>
	<table align="center">
		<tr>
			<td align="right">전체 게시글 : ${totalCnt} 개</td>
		</tr>

		<!-- <tr>
			<td  align="center" style="background-color: pink">${deleteResult}</td> <!-- 삭제되었다는 문구를 출력하기 위해
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
						<!-- 1.게시판 조회에 대한 컨트롤러에서 선언된 변수 boardList를 items로 사용! cf) List<BoardVo> boardList = new ArrayList<BoardVo>(); -->
						<tr>
							<td>${list.boardNum}</td>
							<td align="center">${list.codeName}</td>
							<!-- boardType을 CODE_NAME으로 보여줘야함. -->
							<!-- "/board/${list.boardNum}/boardView.do?pageNo=${pageNo}" List.jsp 랑 같이  -->
							<!-- <td><a href="/board/boardView/${list.boardNum}/${list.boardType}">${list.boardTitle}</a></td> -->
							<td><a href="/board/${list.boardType}/${list.boardNum}/boardView.do?pageNo=${pageNo}" style="text-decoration-line: none">${list.boardTitle}</a></td>
						</tr>
					</c:forEach>
				</table>
			</td>
		</tr>

		<tr>
			<td align="center"><a href="/board/boardWrite.do"><input type="button" value="게시글 작성하기" /></a></td>
		</tr>
	</table>

	<!-- 방법2. 한번에 불러올 수 있도록 -->
	<form action="/board/boardList.do" method="get" id="checking">
		<div style="display: flex; justify-content: center; align-items: center;">

			<input type="checkbox" class="typeCheck" id="checkAll" value="selectAll">전체

			<c:forEach var="code" items="${codeNameList}" varStatus="status">
				<!-- 이건 List.jsp가 띄워지는 순간부터 model객체를 통해 받아온 값이기 때문에 form태그와 상관없이 먼저 실행되는 것이라고 보면 된다.-->
				<!-- forEach문을 통해 반복해서 일반 익명,,,출력. ${codeName}자체가 컨트롤러에 배열로 담겨있는 상태 -->
				<input type="checkbox" class="typeCheck" name="codeId" value="${code.codeId}">${code.codeName}</>
			</c:forEach>

			<div style="display: flex; justify-content: center; align-items: center; margin-left: 10px">
				<button type="submit" name="searchBtn">조회</button>
			</div>
		</div>
	</form>
</body>
<!-- 방법1. 일일히 써야해서 효율적이지 않음 -->
<!-- <form action="/board/boardList.do" method="get" id="checking" class="checking">
		<div style="display: flex; justify-content: center; align-items: center;">
			<!-- checkbox를 체크한 후 이 양식을 제출하면 서버로 제출되는 name/value 쌍은 codeId=a01이 되는 것이다. -->
<!-- COM_CODE라는 테이블을 이용해서 처리해보자... 
			<input type="checkbox" name="selectAllName" value="selectAll" onclick="selectAll(this)">전체
			<!-- name : 전달할 값의 이름. value : 전달될 값 
			<input type="checkbox" name="codeId" value="a01" onclick="checkSelectAll(this)">일반 <input type="checkbox" name="codeId" value="a02" onclick="checkSelectAll(this)">Q&A <input type="checkbox" name="codeId" value="a03" onclick="checkSelectAll(this)">익명 <input type="checkbox" name="codeId" value="a04" onclick="checkSelectAll(this)">자유
		</div>
	</form>  -->


<script type="text/javascript">


console.log("codeName개수:" + ${fn:length(codeNameList)})
var codeNameLength = ${fn:length(codeNameList)};
console.log(codeNameLength);

 window.onload = function() {
	var all = document.getElementsByTagName("input");
	var categories = document.getElementsByName("codeId");
	
	//전체 선택시 전체 선택/다시 누르면 전체 해제
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
	
	//카테고리 내 checkbox클릭 시 c()실행
	for(var i=0; i<categories.length; i++ ){
		categories[i].onclick = c;
	}

	//카테고리 하나라도 안눌리면 전체 체크박스 해제, 카테고리 네개 다 선택 되면 전체에 선택되게 구현
	function c() {
		for(var i=0; i<categories.length; i++) {
			if(categories[i].checked ==false) { //동등 연산자. cf) === 은 일치연산자(값과 타입이 같아야한다.)
				checkAll.checked = false; //false를 checkAll.checked에 넣어줘. 대입연산자!!
			}else if($j("input[name='codeId']:checked").length == codeNameLength) {
				checkAll.checked = true;				
			}
		}
	}
}

//조회누르면 form을 통해 checkbox value값들을 배열로 컨트롤러에게 데이터 전송
/*  $j("searchBtn").click(function() {
 	$j("#checking").submit();
 }); */
 
/* console.log("codeName개수:" + ${fn:length(codeNameList)})
//var codeName = ${code.codeName}
//console.log("codeName목록:" + codeName) //코드네임 배열의 값들을 출력하고 싶다면? 여기서는 모르겠고 컨트롤러에서 확인함(디버그로)

var codeNameLength = ${fn:length(codeNameList)};

$j(".typeCheck").click(function(event){
	console.log('click', event);
	if ($j("#checkAll:checked")) { //전체에 체크가 되면,
		//나머지 input박스도 다 체크되게 해줘.
		$j("input[name='codeId']").prop("checked", true);
		
		//event.target.getAttribute('id') === 'checkAll'
		//$j("input[name='codeId']").prop("checked", true);
		//console.log('CheckAll!!!!!')
		//console.log('checked??', event.target.checked)
	} 
	else if($j("#checkAll:checked")===false) { //전체에 체크가 되지않으면, (체크가 해제되면)
			$j("input[name='codeId']").prop("checked", false);
	} 
	else { //input박스 길이와 코드네임길이가 같으면 전체선택 선택되게하고, 인풋박스에 하나라도 체크해제되면 전체선택 해제되게 하기.
		if($j("input[name='codeId']:checked").length == codeNameLength) {
			console.log('allcheck')
			$j("#checkAll").prop("checked", true);
		}else {
			console.log('here')
			$j("#checkAll").prop("checked",false);
		}
	}	
}); */

//방법1,2는 전체선택만 가능한거고... 이건 전체선택 후, 하나씩 개별로 지웠을 때 전체선택도 지워지도록 가능!실행 잘 안됫음... 근데 이젠 테이블값을 내가 받아오게 되었으니... 쓸 수 없음..

/* function checkSelectAll(checkbox) { //매개변수로 전달받은 체크박스 요소의 checked값이 false인 경우(하나라도 체크박스의 선택이 해제된 경우) selectAll채크박스값도 false로 변경되도록 구현.
	
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


//컨트롤러에 있는 값을 찍어 보는 법...알고싶다..
//const a = ${boardList};
//console.log(a.codeName);

//전체 선택/해제 구현 방법1, 방법2
//방법1. getElementsByName 사용해서 NodeList 만들기
/* function selectAll(selectAll) {
//name='boardType'인 모든 요소를 찾아서 NodeList형태로 리턴
const checkboxes = document.getElementsByName('boardType');
//forEach 반복문을 사용하여 순회하면서, 각 체크박스의 checked값을 '전체'요소의 check값(selectAll.checked)과 동일하게 변경
checkboxes.forEach((checkbox) => { //checkbox라고 item명을 설정해주는 건가? 기존에 있는 input의 type이 아니라??
	checkbox.checked = selectAll.checked;
		})
} */

 //방법2. querySelectorAll 사용해서 NodeList만들기
/*function selectAll(selectAll) {
	const checkboxes = document.querySelectorAll('input[type="checkbox"]');
	console.log(checkboxes);
	checkboxes.forEach((checkbox) => {
		checkbox.checked = selectAll.checked;
	})
}*/

//이건 왜인지 모르겠는데... 개별로 해제했을 때 전체선택해제 되야하는데 안된다.
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