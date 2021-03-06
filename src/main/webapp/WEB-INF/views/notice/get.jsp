<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css"
	integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/css/bootstrap.min.css" 
	integrity="sha512-GQGU0fMMi238uA+a/bdWJfpUGKUkBdgfFdgBm72SUQ6BeyWjoY/ton0tEjH+OSH9iP4Dfh+7HM0I9f5eR0L/4w=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"	referrerpolicy="no-referrer"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
	crossorigin="anonymous"></script>

    
    
    <!-- include summernote css/js -->
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/lang/summernote-ko-KR.js"></script>  
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.20/summernote-bs5.min.css" integrity="sha512-ngQ4IGzHQ3s/Hh8kMyG4FC74wzitukRMIcTOoKT3EyzFZCILOPF0twiXOQn75eDINUfKBYmzYn2AA8DkAk8veQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.20/summernote-bs5.min.js" integrity="sha512-6F1RVfnxCprKJmfulcxxym1Dar5FsT/V2jiEUvABiaEiFWoQ8yHvqRM/Slf0qJKiwin6IDQucjXuolCfCKnaJQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>




<title>Insert title here</title>
</head>
<body>
<script>
$(document).ready(function() {
	/* 수정 활성화 버튼 스크립트 */
	$("#edit-button1").click(function() {
		$("#input1").removeAttr("readonly");
		$("#summernote").removeClass("d-none");
		$("#view").addClass("d-none");
		$("#title-text").addClass("d-none");
		$("#id-text").addClass("d-none");
		$("#time-text").addClass("d-none");
		
		$("#summernote").summernote();
		$("#modify-submit1").removeClass("d-none");
		$("#delete-submit1").removeClass("d-none");
		$("#input1").removeClass("d-none");
		$("#input2").removeClass("d-none");
		
	});
		
	$("#delete-submit1").click(function(e) {
		e.preventDefault();
		
		if (confirm("삭제하시겠습니까?")) {
			let form1 = $("#form1");
			let actionAttr = "${appRoot}/notice/remove";
			form1.attr("action", actionAttr);
			form1.submit();
		}
		
	});
});
	
	
	
		
</script>
<my:navBar />
<section style="margin-bottom: 30%;">
<div class="container">
		<div class="row">
			<div class="col">
			
				<h1 class="mt-5" id="title-text">${notice.title }
					<sec:authorize access="isAuthenticated()">
						<sec:authentication property="principal" var="principal" />
						<c:if test="${principal.username == notice.memberId }">
							<button id="edit-button1" class="btn btn-secondary">
								<i class="fa-solid fa-pen-to-square"></i>
							</button>
						</c:if>
					</sec:authorize>
				</h1>
				<h4 id="id-text" >${notice.memberId }</h4>
				<h5 id="time-text">${notice.prettyInserted }</h5>
				<form id="form1" action="${appRoot }/notice/modify"
					method="post">
					<input type="hidden" name="id" value="${notice.id }" />
					<input type="hidden" name="managerId" value="${notice.memberId }"/>
							<input class="form-control d-none mt-5" type="text" name="title" required
							id="input1" value="${notice.title }" />

				<c:if test="${not empty message }">
					<div class="alert alert-primary">${message }</div>
				</c:if>


				<!-- 게시물 보기 + 수정 -->
		

 
					<div class="d-flex justify-content-center card">
						<div id="view"  class="card-body">${notice.body }</div>
						<textarea class="form-control d-none mb-5 mt-5" name="body" id="summernote">${notice.body }</textarea>
					</div>
					
					<div>
						
						<input class="form-control d-none" type="datetime-local"
							value="${notice.inserted }" />
					</div>

					<button id="modify-submit1" class="btn btn-primary d-none">수정</button>
				</form>

				<c:url value="/notice/remove" var="removeLink" />
				<form action="${removeLink }" method="post">
					<input type="hidden" name="id" value="${notice.id }" />
					<button id="delete-submit1" class="btn btn-danger d-none">삭제</button>
				</form>

			</div>
		</div>
	</div>
	
	</section>
	
<my:footer2/>
</body>
</html>


	
				








