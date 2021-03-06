<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관심 작품 목록</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/artgallery.css" />
<link rel="stylesheet" type="text/css" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css" integrity="sha384-hWVjflwFxL6sNzntih27bfxkr27PmbbK/iSvJ+a4+0owXq79v+lsFkW54bOGbiDQ" crossorigin="anonymous" />
<style>
	.thumbnail-wrappper { 
		width: 25%; 
	} 
	.thumbnail { 
		position: relative;
		padding-top: 100%;
		  /* 1:1 ratio */ 
		overflow: hidden; 
		border:0;
		border-radius: 0;
	} 
	.thumbnail .centered {
	 	position: absolute; 
	 	top: 0; 
	 	left: 0; 
	 	right: 0; 
	 	bottom: 0; 
	 	
	 } 
	.thumbnail .centered img { 
		position: absolute; 
		top: 0; 
		left: 0; 
		max-width: 100%; 
		max-height:100%;
		height:100%;
		width:100%;
				
		 
	}
	.thumb_title1 {
		position: absolute; 
		bottom:5px;
		z-index:10000;
		color:#fff;
		font-weight:bold;
		left:5px;
		overflow: hidden; 
	 	text-overflow: ellipsis;
	 	white-space: nowrap; 
	 	width: 100%;
	}
	
	.thumb_items {
		position: absolute; 
		bottom:5px;
		z-index:2000;
		color:#fff;
		left:5px;
	}
	.thumb_bg{
		position: absolute;
		bottom:0;
		margin:0;
		width: 100%;
		height:100%;
		background-color: rgba(0, 0, 0, 0.2);
		z-index:5000;
	}
	body{padding-top: 70px;}
</style>
</head>
<body>
<jsp:include page="../header.jsp"/>
<div class="container">
	
	<h4><i class="fas fa-heart"></i> 관심작품</h4>
		
  	<%-- <div class="row">
  		<c:forEach var="dto" items="${list }">
	  		<div class=".row.row-eq-height col-md-3 col-sm-6 col-xs-6" style="background-image: url('${configDto.httpPath}${pageContext.request.contextPath }${dto.imagepath }');">
		  		<a class="col-md-3 col-sm-6 col-xs-6" href="favoriteDetail.do?seq=${dto.seq }&code=${dto.code }" style="background-image: url('${configDto.httpPath}${pageContext.request.contextPath }${dto.imagepath }');">
		  			<img src="${configDto.httpPath}${pageContext.request.contextPath }${dto.imagepath }" class="img-responsive" alt="Responsive image"/>
		  			<p>${dto.title }</p>
		  		</a>
		  	</div>
  		</c:forEach>
	</div><!-- //아티스트 --> --%>
	<c:forEach var="dto" items="${list }">
	<div class="thumbnail-wrapper col-md-2 col-sm-3 col-xs-6">
		<div class="thumbnail">
			<div class="centered">
				<a href="favoriteDetail.do?seq=${dto.seq }" title="${dto.title }">
					<div class="thumb_bg">		
						<div class="thumb_title1">${dto.title }</div>							
					</div>
					<img src="${configDto.httpPath}${pageContext.request.contextPath }${dto.imagepath }" style="z-index:2000;">			
				</a>
			</div>
		</div>
	</div>
	</c:forEach>

</div>


<jsp:include page="../footer.jsp"/>
</body>
</html>
