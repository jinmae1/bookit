<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<sec:authentication property="principal" var="loginMember" />
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="게시판 상세보기" name="title" />
</jsp:include>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/community.css" />
<script src="https://kit.fontawesome.com/01809a491f.js"
	crossorigin="anonymous"></script>

<script>


//좋아요
function communityLike(no){ 
	    $.ajax({
	           type : "POST",  
	           url : `${pageContext.request.contextPath}/board/communityLike.do`,,       
	           dataType : "json",   
	           data : 'no' : no
	           error : function(){
	              alert("에러");
	           },
	           success : function(likeCheck) {
	               
	                   if(no == 0){
	                   	alert("추천완료.");
	                	document.getElementById('full').style.display = 'inline-block';
	                	document.getElementById('empty').style.display = 'none';
	                 	location.href = "${pageContext.request.contextPath}/board/likeCountCancel.do";
	                   }
	                   else (no == 1){
	                    alert("추천취소");
	                	document.getElementById('full').style.display = 'none';
	                	document.getElementById('empty').style.display = 'inline-block';
	                	location.href = "${pageContext.request.contextPath}/board/likeCountCancel.do";

	               
	               }

	           }
	       });
	}
	
}

//수정
 const csrfHeader = "${_csrf.headerName}";
	const csrfToken = "${_csrf.token}";
	const headers = {};
	headers[csrfHeader] = csrfToken;
	
	function updateCommentEvent(e){
		
		
		var className = '.comment_content_'+e;
	
		var replyContent = document.querySelector(className).value;
	
		
		var paramData = JSON.stringify({
			"content": replyContent	,
			"no" : e
	});
	
		
		$.ajax({
			url:`${pageContext.request.contextPath}/board/updateComment.do`,
			headers : headers,
			type	:"post",
			data: paramData,
			contentType: 'application/json;charset=UTF-8',
			success:function(responseData){
				// responseData : {isSuccess:true}
				if(responseData.isSuccess){
					//폼에 입력한 내용 읽어오기
					var content=$this.find("textarea").val();
					//pre 요소에 수정 반영하기 
					$this.parent().find("pre").text(content);
				}
			}
		});

	};
	
//수정 폼 출력 
function showUpdateCommentFrm(e){
	var className = '.updateCommentFrm_'+e;
	 document.querySelector(className).style.display = 'block';
}

//대댓글 폼 출력 
function writeReComment(){
	 document.querySelector('.reCommentInput').style.display = 'block';
}
//대댓글 입력 
function btnReCommentSubmit(){
		var replyContent = $('#reCommentContent').val();
		var paramData = JSON.stringify({
			"content": replyContent
			, "commentLevel": 2
			, "communityNo" : "${community.communityNo}"
			, "commentRef" : "${comment.no}"
			
	});
	 const csrfHeader = "${_csrf.headerName}";
		const csrfToken = "${_csrf.token}";
		const headers = {};
		headers[csrfHeader] = csrfToken;
		$.ajax({
			url: `${pageContext.request.contextPath}/board/insertComment.do`
			, headers : headers
			, data : paramData
			, type : 'POST'
			,  contentType: 'application/json;charset=UTF-8'
			, success: function(result){
				console.log(result)
				showCommentsByAjax();
				
				$('#content').val('');
				
			}
			, error: function(error){
				console.log("에러 : " + error);
			}
		});
}

//삭제 
function deleteComment(no){
		var isDelete=confirm("댓글을 정말 삭제하겠습니까");
		if(isDelete){
			$.ajax({
				url:"deleteComment.do",
				method:"post",
				data:{"no":no}, 
				success:function(responseData){
					if(responseData.isSuccess){
						
					}
				}
			});
		}
	}

function showCommentsByAjax() {
	
	$.ajax({
		url: "${pageContext.request.contextPath}/board/commentList.do",
		method: "GET",
		data:{
			no: "${community.communityNo}"
		},
		success(comment){
			console.log("=====> ", comment);
		},
		error(e){ console.log(e);}
	});
	
}
//댓글 저장 버튼 클릭 이벤트
function btnCommentSubmit() {
	
	var replyContent = $('#comment_content').val();
	var paramData = JSON.stringify({
		"content": replyContent
		, "commentLevel": 1
		, "communityNo" : "${community.communityNo}"
		
});
 const csrfHeader = "${_csrf.headerName}";
	const csrfToken = "${_csrf.token}";
	const headers = {};
	headers[csrfHeader] = csrfToken;
	$.ajax({
		url: `${pageContext.request.contextPath}/board/insertComment.do`
		, headers : headers
		, data : paramData
		, type : 'POST'
		,  contentType: 'application/json;charset=UTF-8'
		, success: function(result){
			console.log(result)
			showCommentsByAjax();
			
			$('#content').val('');
			
		}
		, error: function(error){
			console.log("에러 : " + error);
		}
	});
		
}
//댓글 저장 버튼 클릭 이벤트
function onClickTest() {
	
	var replyContent = $('#comment_content').val();
	console.log("====> ",replyContent)
		
}
//댓글등록전 검사
$(document.commentFrm).submit((e) => {
	const $content = $("[name=content]", e.target);
	if(!/^(.|\n)+$/.test($content.val())){
		alert("댓글을 작성해주세요.");
		e.preventDefault();
	}
});


function updateCommunity(){
	location.href = "${pageContext.request.contextPath}/board/communityUpdate.do?no=${community.communityNo}";
}
function communityDelete(){
	let check = confirm("정말 삭제하시겠습니까?");
	if (check){
		location.href='communityDelete.do?no=${community.communityNo}'
	}
}
function showButton(){
	if ("${community.memberId}" == "${loginMember.id}"){
		
	}else{
		document.getElementById('delete').style.display = 'none';
		document.getElementById('modify').style.display = 'none';
	}
}



function goCommunityList(){
	location.href = "${pageContext.request.contextPath}/board/community.do";
}
$(document).ready(function(){
	// 페이지 로드시 모달창 출력 방지
	$(".modal").css({"display": "none"});
	// modal창 끄고 다시 켰을 때 내용 리셋
	$('.modal').on('hidden.bs.modal', function (e) {
	  $(this).find('form')[0].reset();
	});
});
// modal textarea 높이 조절
function adjustHeight() {
	var textEle = $('textarea');
	textEle[0].style.height = 'auto';
	var textEleHeight = textEle.prop('scrollHeight');
	textEle.css('height', textEleHeight);
};
console.log("${community.comment}");
</script>
<style>
div#board-container {
	width: 400px;
}

input, button, textarea {
	margin-bottom: 15px;
}

button {
	overflow: hidden;
}
/* 부트스트랩 : 파일라벨명 정렬*/
div#board-container label.custom-file-label {
	text-align: left;
}

textarea {
	resize: none;
}

.modal-body p {
	display: inline-block;
	width: 100px;
	text-align: right;
	margin-right: 30px;
}

.modal-body input {
	width: auto;
}
</style>
<div id="board-container" class="mx-auto text-center">
	<input type="submit" value="수정" id="modify"
		onclick="updateCommunity();"> <input type="button" value="삭제"
		id="delete" onclick="communityDelete();"> <input type="button"
		value="리스트로" onclick="goCommunityList();">
	<p>${community.category}</p>
	<p>${community.title}</p>
	<p>[${community.commentCount}]</p>
	<!-- 프로필 이미지 -->
	<img
		src="${pageContext.request.contextPath}/resources/img/profile/${community.profileImage}"
		height="30px" />
	<p>${community.nickname}</p>
	<p>${community.regDate}</p>
	<p>${community.readCount}</p>
	<p>${community.likeCount}</p>

	<!-- 파일 이미지 -->
	<c:if test="${!empty community.file}">
		<c:forEach items="${community.file}" var="file">
			<img
				src="${pageContext.request.contextPath}/resources/img/board/${file.renamedFilename}">
		</c:forEach>
	</c:if>

	<!-- 글 내용 -->
	<p>${community.content}</p>
	<p>${community.likeCount}</p>

	<!-- 파일 다운로드 -->
	<c:forEach items="${community.file}" var="file" varStatus="vs">
		<a
			href="${pageContext.request.contextPath}/board/fileDownload.do?fileNo=${file.no}"
			role="button" class="btn btn-outline-success btn-block"> 첨부파일
			${vs.count} - ${file.originalFilename}</a>
		<hr>
	</c:forEach>

	<hr>

	<table>
		<c:choose>
			<c:when test="${community.comment ne null}">
				<c:forEach items="${community.comment}" var="comment">
					<tr data-no="${comment.no}">
						<c:choose>
							<c:when test="${comment.deleteYn == 'N'}">
								<td>${comment.nickname}</td>
								<td><fmt:formatDate value="${comment.regDate}"
										pattern="yy/MM/dd HH:mm" /></td>
								<td><pre>${comment.content}</pre></td>
								<td><c:if test="${comment.writer != loginMember.id}">
										<button class="btn btn-primary btn-icon-split"
											value="${comment.no}" onclick="writeReComment();"
											style="padding: 5px; margin-top: 20px;">답글</button>

										<form>
											<input type="hidden" name="no"
												value="${community.communityNo}" /> <input type="hidden"
												name="commentLevel" value="2" /> <input type="hidden"
												name="commentRef" value="0" />
											<div class="reCommentInput" style="display: none;">
												<textarea id="reCommentContent" name="content" cols="120"
													rows="3" style="resize: none;" placeholder="댓글을 입력해주세요"></textarea>
												<br />
												<button id="reComment" onClick="btnReCommentSubmit()"
													class="btn btn-primary btn-icon-split"
													style="padding: 5px; margin-top: 20px;">등록</button>
											</div>
										</form>

									</c:if> <c:if test="${comment.writer == loginMember.id}">

										<button type="button" class="btn btn-primary btn-icon-split"
											onclick="showUpdateCommentFrm(${comment.no});" name="btn-update"
											id="showUpdateCommentFrm" value="${comment.no}"
											style="padding: 5px; margin-top: 20px;">수정</button>

										<div class="updateCommentFrm_${comment.no}" style="display: none;">
											<form class="comment-update-form" action="comment_update.do"
												method="post">
												<input type="hidden" name="num" value="${comment.no}" />
												<textarea class="comment_content_${comment.no}">${comment.content}</textarea>

												<button type="button" id="updateComment"
													onClick="updateCommentEvent(${comment.no});"
													class="btn btn-primary btn-icon-split"
													style="padding: 5px; margin-top: 20px;">수정</button>

											</form>
										</div>

										<button class="btn btn-primary btn-icon-split"
											onclick="deleteComment();" value="${comment.no}"
											style="padding: 5px; margin-top: 20px;">삭제</button>

									</c:if></td>
								<c:choose>
									<c:when test="${comment.isParent == 'Y'}">
										<c:forEach items="${comment.reComments}" var="reComment">
											<tr data-no="${reComment.no}">

												<td>${reComment.nickname}</td>
												<td><fmt:formatDate value="${reComment.regDate}"
														pattern="yy/MM/dd HH:mm" /></td>
												<td>${reComment.content}</td>
										</c:forEach>
									</c:when>
								</c:choose>
							</c:when>


							<c:when
								test="${comment.isParent == 'Y' && comment.deleteYn == 'Y' && comment.commentLevel == 1}">
								<td>삭제된 댓글입니다.</td>
								<c:forEach items="${comment.reComments}" var="reComment">
									<tr data-no="${reComment.no}">
										<td>${reComment.nickname}</td>
										<td><fmt:formatDate value="${reComment.regDate}"
												pattern="yy/MM/dd HH:mm" /></td>
										<td>${reComment.content}</td>
								</c:forEach>
							</c:when>
						</c:choose>
					</tr>
				</c:forEach>

			</c:when>

			<c:otherwise>
						테스트
					</c:otherwise>
		</c:choose>
	</table>
	<!--  댓글이 없으면 = 출력 안함 -->
	<!-- 댓글입력칸 -->
	<form>

		<input type="hidden" name="no" value="${community.communityNo}" /> <input
			type="hidden" name="commentLevel" value="1" /> <input type="hidden"
			name="commentRef" value="0" />
		<div id="comment-input">

			<textarea id="comment_content" name="content" cols="120" rows="3"
				style="resize: none;" placeholder="댓글을 입력해주세요"></textarea>

			<br />

			<button type="submit" onClick="btnCommentSubmit()"
				class="btn btn-primary btn-icon-split"
				style="padding: 5px; margin-top: 20px;">등록</button>
		</div>
	</form>
</div>


<div class="likeReport" style="text-align: center;">
	<h3 id="empty" style="diaplay: inline-block;">
		<a href="#" onclick="likeCheck(0);"><i class="far fa-thumbs-up"></i></a>
	</h3>
	<h3 id="full" style="display: none">
		<a href="#" onclick="likeCheck(1);"><i class="fas fa-thumbs-up"></i></a>
	</h3>
	<h3>
		<a href="#" data-toggle="modal" data-target="#reportBoardEnrollModal"><i
			class="fas fa-ban" style="display: inline-block;"></i></a>
	</h3>
</div>
<br>




<!-- 게시글 신고 등록 Modal -->
<div class="modal fade" id="reportBoardEnrollModal" tabindex="-1"
	role="dialog" aria-labelledby="reportBoardEnrollModalLabel"
	aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="reportBoardEnrollModalLabel">신고
					상세내용</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">×</span>
				</button>
			</div>
			<form:form method="POST"
				action="${pageContext.request.contextPath}/report/reportBoardEnroll.do">
				<div class="modal-body">
					<div>
						<p>신고자ID</p>
						<input type="text" name="reporter" value="${loginMember.id}"
							readonly />
					</div>
					<div>
						<p>게시판</p>
						<input type="text" name="boardName" value="community" readonly />
					</div>
					<div>
						<p>게시글NO</p>
						<input type="text" name="boardNo" value="${community.communityNo}"
							readonly />
					</div>
					<div>
						<p>사유</p>
						<input type="radio" name="reason" id="badword" value="욕설">
						<label for="badword">욕설</label>&nbsp; <input type="radio"
							name="reason" id="cheat" value="사기"> <label for="cheat">사기</label>&nbsp;
						<input type="radio" name="reason" id="loop" value="도배"> <label
							for="loop">도배</label>&nbsp; <input type="radio" name="reason"
							id="ad" value="광고"> <label for="ad">광고</label>&nbsp; <input
							type="radio" name="reason" id="weird" value="음란물"> <label
							for="weird">음란물</label>&nbsp;
					</div>
					<div>
						<p>상세내용</p>
						<textarea name="detail" cols="40" onkeyup="adjustHeight();"
							placeholder="내용을 입력하세요"></textarea>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">Close</button>
					<button type="submit" class="btn btn-success">신고</button>
				</div>
			</form:form>
		</div>
	</div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>