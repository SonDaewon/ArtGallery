<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!-- 작성자 : hyung -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 작품</title>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/bootstrap.css" />
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css" integrity="sha384-hWVjflwFxL6sNzntih27bfxkr27PmbbK/iSvJ+a4+0owXq79v+lsFkW54bOGbiDQ" crossorigin="anonymous" />
<style>
	.con_left {
		display: inline-block;
	}
	.left {
		float: left;
	}
	.footer {
	  position: relative;
	  bottom: 0;
	  width: 100%;
	  /* Set the fixed height of the footer here */
	  height: 60px;
	  line-height: 60px; /* Vertically center the text there */
	  background-color: #f5f5f5;
	}
	
	.footer > .container_f {	
	  padding-right: 15px;
	  padding-left: 15px;
	}
	
	code {
	  font-size: 80%;
	}
</style>
</head>
<body>
<div class="container-fluid">
	<jsp:include page="../inc/header.jsp">
		<jsp:param name="navMenu" value="art"/>
	</jsp:include>
	
	<c:choose>
		<c:when test="${categoryType eq 'A' }">
			<h4><span class="glyphicon glyphicon-th" aria-hidden="true"></span>&nbsp; 아티스트정보 </h4>
		</c:when>
		<c:when test="${categoryType eq 'M' }">
			<h4><span class="glyphicon glyphicon-th" aria-hidden="true"></span>&nbsp; 재료정보 </h4>
		</c:when>
		<c:when test="${categoryType eq 'P' }">
			<h4><span class="glyphicon glyphicon-th" aria-hidden="true"></span>&nbsp; 화파정보 </h4>
		</c:when>
	</c:choose>	
	
	<form class="form-horizontal" action="update.do" method="post" enctype="multipart/form-data" id="updateForm">
		<input type="hidden" name="code" value="${categoryType}"/>
		<input type="hidden" name="seq" value="${dto.seq }"/>
		
		<div class="panel panel-default">	  
		  <div class="panel-body">	

		  	<c:choose>
		  		<c:when test="${categoryType eq 'A' }">
					  <div class="form-group">
					    <label class="col-sm-2 control-label">아티스트명</label>
					    <div class="col-sm-10">
					      	<input type="text" class="form-control" id="name" name="name" value="${dto.name }">
					    </div>
					  </div>
						<div class="form-group">
					    <label class="col-sm-2 control-label">출생일</label>
					    <div class="col-sm-10">
					      	<input type="text" class="form-control" id="bdate" name="bdate" value="${dto.bdate }">
					    </div>
					  </div>		  
						<div class="form-group">
					    <label class="col-sm-2 control-label">사망일</label>
					    <div class="col-sm-10">
					      	<input type="text" class="form-control" id="ddate" name="ddate" value="${dto.ddate }">
					    </div>
					  </div>		  
					  <div class="form-group">
					  	<label class="col-sm-2 control-label">비고</label>
							<div class="col-sm-10">
							    <textarea name="remark" id="remark" class="form-control" rows="8">${dto.remark }</textarea>
							</div>
					  </div>
					  <div class="form-group">
					  	<label class="col-sm-2 control-label">이미지</label>
							<div class="col-sm-10">		
									<input type="hidden" name="imagepath" value="${dto.imagepath }" />    
									<a href="${configDto.httpPath}${pageContext.request.contextPath }${dto.imagepath }" target="_image">${dto.imagepath } 이미지보기</a> 
						    	<input type="file" class="form-control" id="file" name="file">
					 		</div>
					  </div>	
		  		</c:when>
		  		
		  		<c:when test="${categoryType eq 'M' }">
					  <div class="form-group">
					    <label class="col-sm-2 control-label">재료명</label>
					    <div class="col-sm-10">
					      	<input type="text" class="form-control" id="name" name="name" value="${dto.name }">
					    </div>
					  </div>
					  <div class="form-group">
					  	<label class="col-sm-2 control-label">비고</label>
							<div class="col-sm-10">
							    <textarea name="remark" id="remark" class="form-control" rows="8">${dto.remark }</textarea>
							</div>
					  </div>
					  
					  <div class="form-group">
					  	<label class="col-sm-2 control-label">이미지</label>
							<div class="col-sm-10">			
									<input type="hidden" name="imagepath" value="${dto.imagepath }" />    
									<a href="${configDto.httpPath}${pageContext.request.contextPath }${dto.imagepath }" target="_image">${dto.imagepath } 이미지보기</a> 
						    	<input type="file" class="form-control" id="file" name="file">
					 		</div>
					  </div>			  		
		  		</c:when>
		  		
		  		<c:when test="${categoryType eq 'P' }">
					  <div class="form-group">
					    <label class="col-sm-2 control-label">화파명</label>
					    <div class="col-sm-10">
					      	<input type="text" class="form-control" id="name" name="name" value="${dto.name }">
					    </div>
					  </div>
					  <div class="form-group">
					  	<label class="col-sm-2 control-label">비고</label>
							<div class="col-sm-10">
							    <textarea name="remark" id="remark" class="form-control" rows="8">${dto.remark }</textarea>
							</div>
					  </div>
					  <div class="form-group">
					  	<label class="col-sm-2 control-label">이미지</label>
							<div class="col-sm-10">			 
 									<input type="hidden" name="imagepath" value="${dto.imagepath }" />    
									<a href="${configDto.httpPath}${pageContext.request.contextPath }${dto.imagepath }" target="_image">${dto.imagepath } 이미지보기</a> 
						    	<input type="file" class="form-control" id="file" name="file">
					 		</div>
					  </div>			  		
		  		</c:when>		  		
		  	</c:choose>  
			</div>
		</div>
		<!-- button // -->
		<div class="text-center">
			<button type="button" class="btn btn-primary" id="btnSave">수정</button>
			<button type="button" class="btn btn-warming" id="btnDelete">삭제</button>
		  <button type="button" class="btn btn-default" id="btnCancel">취소</button>
		</div>
		<!-- //button  -->
	</form>	
</div><!-- //container-fluid  -->

<jsp:include page="../inc/footer.jsp" />
<script>

	var section1="${configDto.section1}";
	var section2="${configDto.section2}";

	$("#btnCancel").click(function(){
		var isOk=confirm("작성을 취소하시겠습니까?\r\n목록으로 되돌아갑니다.");
		if(isOk){
			history.back();
			return;
		}		
	});
	
	$("#btnSave").click(function(){
		var FileFilter = /\.(jpg|gif|tif|bmp|png)$/i;
		var extArray = new Array(".jpg", ".gif", ".tif", ".bmp", ".png");     

		if($("#file").val()> '   '){
			if(!$("#file").val().match(FileFilter)){
				alert("다음 파일만 업로드가 가능합니다.\n\n"  + (extArray.join("  ")) + "\n\n 업로드할 파일을 "
					     + " 다시 선택하여 주세요.");
				return;
			}
		}
		$("#updateForm").submit();
	});
	
	$("#btnDelete").click(function(){
		isDelete=confirm("자료를 삭제하시겠습니까?");
		if (isDelete){
			location.href="delete.do?seq="+$("input[name=seq]").val();
		}
	});

</script>
</body>
</html>
