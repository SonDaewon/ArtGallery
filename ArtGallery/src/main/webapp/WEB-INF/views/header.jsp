<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<nav class="navbar navbar-default navbar-fixed-top" >
  <div class="container-fluid">
    <!-- Brand and toggle get grouped for better mobile display -->
    <div class="navbar-header">
      <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
        <span class="sr-only">Toggle navigation</span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
      <a class="navbar-brand" href="${pageContext.request.contextPath }/">
      	<span style="color: #333;"><i class="fas fa-university"></i> <strong>ArtGallery</strong></span>
      </a>
    </div>
    
    <!-- Collect the nav links, forms, and other content for toggling -->
    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
        <ul class="nav navbar-nav">
        	<li class="dropdown">
	          	<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">카테고리 <span class="caret"></span></a>
		          <ul class="dropdown-menu">
		            <li><a href="${pageContext.request.contextPath }/category/list.do?soncategorytype=A">아티스트</a></li>
		            <li><a href="${pageContext.request.contextPath }/category/list.do?soncategorytype=M">재료</a></li>
		            <li><a href="${pageContext.request.contextPath }/category/list.do?soncategorytype=P">화파</a></li>		           
		          </ul>
	        </li>

	       	<li><a href="${pageContext.request.contextPath }/opinion/list.do">의견보내기 </a></li>

        </ul>
      	<ul class="nav navbar-nav navbar-right">
      		<c:choose>
      			<c:when test="${not empty id }">      		
      				<li><a href="${pageContext.request.contextPath }/user/info.do" title="회원정보"><strong>${id }</strong>님 반갑습니다.</a></li>
      				<li><a href="javascript:signOut()" title="로그아웃"><span style="font-size:1.3em;color: #333;"><i class="fas fa-sign-out-alt"></i></span></a></li>
      				<li><a href="${pageContext.request.contextPath }/user/info.do" title="회원정보"><span style="font-size:1.3em;color: #333;"><i class="fas fa-user-tie"></i></span></a></li>
					<li><a href="${pageContext.request.contextPath }/art/favorArtList.do" title="관심작품"><span style="font-size:1.3em;color: #333;"><i class="fas fa-heart"></i></span></a></li>
      			</c:when>
      			<c:otherwise>
      				<li><a id="signinForm" href="#" title="로그인"><span style="font-size:1.3em;color: #333;"><i class="fas fa-user"></i></span></a></li>
	        		<li><a href="${pageContext.request.contextPath }/user/signup_form.do" title="회원가입"><span style="font-size:1.3em;color: #333;"><i class="fas fa-user-plus"></i></span></a></li>
      			</c:otherwise>
      		</c:choose>
        <li><a href="#" title="검색" id="search_icon"><span style="font-size:1.3em;color: #333;"><i class="fas fa-search"></i></span></a></li>
	       	<c:if test="${role eq 'A' }">

	        	<li style="margin-right:10px"><a href="${pageContext.request.contextPath }/admin/home.do" title="관리자"><span style="font-size:1.3em;color: #333;"><i class="fas fa-users-cog"></i></span></a>
	        	</li>
	        	<span class="badge" style="position:absolute;right:-5px;margin-right:10px;margin-top:10px;background-color: #cc0000;"></span>		        	
	        </c:if>	        	               
      	</ul>
    </div>
  </div>
</nav>
<style>
	.h_s {
		display: none;
		
		z-index: 999;
	}
	
</style>

<!-- search// -->
<div id="search_box" class="h_s"> 	
 	<div class="navbar-header" style="; width:100%;">
 		<a class="navbar-brand" href="#" id="search_close">
	      	<span style="color: #333;"><i class="fas fa-arrow-left"></i> </span>
	    </a>
		<form id="topSearchForm" class="navbar-form navbar-left" role="search" action="${pageContext.request.contextPath }/category/result.do" >
		  <div class="form-group">
		    <input type="text" class="form-control" placeholder="Search" id="searchKeyword" name="searchKeyword" value="${param.searchKeyword }">
		  </div>
		  <button type="submit" class="btn btn-default"><i class="fas fa-search"></i></button>		
		</form>		
 	</div> 	
</div>

<script src="${pageContext.request.contextPath }/resources/js/jquery-3.3.1.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/bootstrap.js"></script>
<script>
	$("#signinForm").click(function(){
		var currentPathname=$(location).attr('pathname');
		var currentParam=$(location).attr('search');
		var currentUrl=currentPathname+currentParam;
		$("#signinForm").attr("href", "${pageContext.request.contextPath }/user/signin_form.do?url="+currentUrl)
	});
	
	//search box open
	$("#search_icon").click(function() {
		
		$("#search_box").css("display","block").css("z-index","10000").animate({top:"0px"});
		
	});
	//search box close
	$("#search_close").click(function() {
		console.log("클릭 취소됨");
		$("#search_box").css("display","none").animate({top:"-60px"});
	});
	
	function signOut() {
		confirm("로그아웃 됐습니다.");
		location.href="${pageContext.request.contextPath }/user/signout.do";
	};
	
	$("#topSearchForm").submit(function(){
		var keyword=$("#searchKeyword").val().trim();
		if( keyword <= "   ") {
			alert("검색어를 입력해주세요.");
			return false;
		}
		if( keyword == "%") {
			alert("%는 검색할 수 없습니다.");
			return false;
		}
	});
	
<c:if test="${!empty id && !empty role && role eq 'A' }">
	$.ajax({
		url:"${pageContext.request.contextPath }/opinion/count.do",
		method:"get",
		success:function(data) {
			if ( data.opinionCount > 0 )  {
				$(".badge").text(data.opinionCount);				
			}else {
				$(".badge").text("");
			}
		}
	});
</c:if>	

</script>

