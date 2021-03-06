<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>의견 보내기</title>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/artgallery.css" />
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css" integrity="sha384-hWVjflwFxL6sNzntih27bfxkr27PmbbK/iSvJ+a4+0owXq79v+lsFkW54bOGbiDQ" crossorigin="anonymous" />
<script src="${pageContext.request.contextPath }/SmartEditor/js/HuskyEZCreator.js"></script>
</head>
<body>
<jsp:include page="../header.jsp"/>
<div class="container">
	<h4><i class="fas fa-kiss-wink-heart"></i> 의견보내기</h4>
	<form class="form-horizontal" method="post" id="form1">
		<input type="hidden" name="num" value="${dto.num }" />
		<div class="panel panel-default">	  
			<div class="panel-body">
				<div class="form-group">
			    	<label for="writer" class="col-sm-1 control-label">작성자</label>
			    	<div class="col-sm-10">
			      		<input type="text" class="form-control" id="writer" value="${dto.writer }" disabled="disabled"/>
			    	</div>
			  	</div>				
				<div class="form-group">
			    	<label for="title" class="col-sm-1 control-label">제목</label>
			    	<div class="col-sm-10">
			      		<input type="text" class="form-control" name="title" id="title" value="${dto.title }"/>
			    	</div>
			  	</div>
				<div class="form-group">
			    	<div class="col-sm-12">
						<textarea name="content" id="content" style="height:340px;display:none">${dto.content }</textarea>
			    	</div>
			  	</div>				
			</div>			
			
		</div><!-- //panel  -->	
		<!-- button // -->
		<div class="text-center">
			<input type="button" onclick="pasteHTML();" value="본문에 내용 넣기" class="btn btn-default"/>
			<input type="button" onclick="showHTML();" value="본문 내용 가져오기" class="btn btn-default"/>			
			<input type="button" onclick="setDefaultFont();" value="기본 폰트 지정하기 (궁서_24)" class="btn btn-default"/>
			
			<input type="button" onclick="submitContents(this);" value="수정 확인" class="btn btn-primary"/>
		</div>
	</form>	
	
</div>
<br /><br />
<jsp:include page="../footer.jsp"/>

<script>
var oEditors = [];
//추가 글꼴 목록
//var aAdditionalFontSet = [["MS UI Gothic", "MS UI Gothic"], ["Comic Sans MS", "Comic Sans MS"],["TEST","TEST"]];
nhn.husky.EZCreator.createInIFrame({
	oAppRef: oEditors,
	elPlaceHolder: "content",
	sSkinURI: "${pageContext.request.contextPath}/SmartEditor/SmartEditor2Skin.html",	
	htParams : {
		bUseToolbar : true,				// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
		bUseVerticalResizer : true,		// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
		bUseModeChanger : true,			// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
		//aAdditionalFontList : aAdditionalFontSet,		// 추가 글꼴 목록
		fOnBeforeUnload : function(){
			//alert("완료!");
		}
	}, //boolean
	fOnAppLoad : function(){
		//예제 코드
		//oEditors.getById["ir1"].exec("PASTE_HTML", ["로딩이 완료된 후에 본문에 삽입되는 text입니다."]);
	},
	fCreator: "createSEditor2"
});
function pasteHTML() {
	var sHTML = "<span style='color:#FF0000;'>이미지도 같은 방식으로 삽입합니다.<\/span>";
	oEditors.getById["content"].exec("PASTE_HTML", [sHTML]);
}
function showHTML() {
	var sHTML = oEditors.getById["content"].getIR();
	alert(sHTML);
}
	
function submitContents(elClickedObj) {
	oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);	// 에디터의 내용이 textarea에 적용됩니다.
	
	// 에디터의 내용에 대한 값 검증은 이곳에서 document.getElementById("ir1").value를 이용해서 처리하면 됩니다.
	
	try {
		var isSuccess=false;
		var param=$("#form1").serialize();	// this->form
		$.ajax({
			url:"update.do",
			method:"post",
			data: param,		//요청 파라미터
			success:function(data) {
				if(data.isSuccess){
					alert("수정했습니다.");
					location.href="detail.do?num=${dto.num }";
				} else {
					alert("오류가 발생했습니다.\r\n다시 해주세요.");
				}
		    }
		});
		
		//elClickedObj.form.submit();
	} catch(e) {}
}
function setDefaultFont() {
	var sDefaultFont = '궁서';
	var nFontSize = 24;
	oEditors.getById["content"].setDefaultFont(sDefaultFont, nFontSize);
}
</script>
</body>
</html>