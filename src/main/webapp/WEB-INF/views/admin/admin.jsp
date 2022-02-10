<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>


<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage.css"/>

<h1>관리자 메인페이지</h1>

<div class="container member-profile">
    	<form method="get" action="">
       		<div class="row">
               <div class="col-2">
                   <div class="profile-work">
                       <a href="#"><p>회원목록</p></a>
                       <b>통계</b><br />	
 				 	   <a href="${pageContext.request.contextPath}/admin/chart/chart.do">-가입 회원</a><br />
 				 	   <a href="${pageContext.request.contextPath}/admin/chart/addressChart.do">-회원 주소</a><br />
 				 	   <a href="#">-리뷰 작성</a><br />
 				 	   <a href="${pageContext.request.contextPath}/admin/chart/cashChart.do">-북토리 충전</a>
                   </div>
               </div>
           </div>
		</form>           
	</div>








<jsp:include page="/WEB-INF/views/common/footer.jsp"/>