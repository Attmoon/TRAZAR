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
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/css/bootstrap.min.css"
	integrity="sha512-GQGU0fMMi238uA+a/bdWJfpUGKUkBdgfFdgBm72SUQ6BeyWjoY/ton0tEjH+OSH9iP4Dfh+7HM0I9f5eR0L/4w=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"
	referrerpolicy="no-referrer"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
	crossorigin="anonymous"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.20/summernote-bs5.min.css"
	integrity="sha512-ngQ4IGzHQ3s/Hh8kMyG4FC74wzitukRMIcTOoKT3EyzFZCILOPF0twiXOQn75eDINUfKBYmzYn2AA8DkAk8veQ=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.20/summernote-bs5.min.js"
	integrity="sha512-6F1RVfnxCprKJmfulcxxym1Dar5FsT/V2jiEUvABiaEiFWoQ8yHvqRM/Slf0qJKiwin6IDQucjXuolCfCKnaJQ=="
	crossorigin="anonymous" referrerpolicy="no-referrer"></script>


<link href="${appRoot }/resources/css/designBoard/style.css"
	rel="stylesheet" type="text/css">

<link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet"
	type="text/css">
<link
	href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet">
<link href="css/sb-admin-2.min.css" rel="stylesheet">

<style>
.list-group-item {
	border: none;
}
.card-img-top img{
		
	max-width:100%;
	width : auto !important;
	height : auto !important;
}
</style>


<!-- ?????? ???????????? -->
<script>
	$(document).ready(function() {
		
		// ????????? ?????? ??? review list ???????????? ajax ??????
		// ???????????? ????????? ???????????? 
/* 		$("#edit-button1").click(function() {
			$("#input1").removeAttr("readonly");
			//$("#summernote").removeAttr("readonly");
			$("#summernote").removeClass("d-none");
			$("#summernoteView").addClass("d-none");
			$("#summernote").summernote();
			$("#modify-submit1").removeClass("d-none");
			$("#delete-submit1").removeClass("d-none");
		}); */
		
	 	 $("#delete-submit1").click(function(e) {
			e.preventDefault();
			
			if (confirm("?????????????????????????")) {
				let form1 = $("#form1");
				let actionAttr = "${appRoot}/designBoard/remove";
				form1.attr("action", actionAttr);
				form1.submit();
			}
			
		});
		
	// ?????? ?????? (review list) ???????????? ajax
		const listReview = function() {
			
			const data = {designBoardId : ${designBoard.id}};
			
			$.ajax({
				url : "${appRoot}/review/list",
				type : "get",
				data : data,
				success : function(list) {
					
					const reviewListElement = $("#reviewList1");
					reviewListElement.empty();
					
					// ?????? ?????? ??????
					$("#numOfReview1").text(list.length);
					
					for (let i = 0; i < list.length; i++) {
						const reviewElement = $("<li class='list-group-item' />");
						reviewElement.html(`
								
								<div>
									<div id="reviewDisplayContainer\${list[i].id }" class="fw-bold">
										<div class="d-flex">
											<span class="badge text-dark">
												<i class="fa-solid fa-circle-user fa-3x"></i>
											</span>
											<span class="me-auto" style="font-size:large;">\${list[i].memberId}</span> 
											<div>
												<span id="modifyButtonWrapper\${list[i].id }"></span>
											</div>
										</div>
											
										<div class="border border-black border-2 rounded-3 p-2 container">
											<div class="row mt-3">
												<div class="col">
													<div id="reviewContent\${list[i].id }"></div>
												</div>
											</div>
										</div>
										<span style="font-size:small; color:grey;">\${list[i].prettyInserted}</span>
											<%-- <div>\${list[i].prettyInserted}</div> --%>
									</div>
	
									<div id="reviewEditFormContainer\${list[i].id }"
										style="display: none;">
										<form action="${appRoot }/review/modify" method="post">
											<div class="input-group">
												<input type="hidden" name="designBoardId" value="${designBoard.id }" />
												<input type="hidden" name="id" value="\${list[i].id }" />
												<input class="form-control" value="\${list[i].body }"
													type="text" name="body" required />
												<button data-review-id="\${list[i].id}" 
												        class="review-modify-submit btn btn-outline-secondary">
													<i class="fa-solid fa-comment-dots"></i>
												</button>
											</div>
										</form>
									</div>
								</div>
								`);
						reviewListElement.append(reviewElement);
						$("#reviewContent" + list[i].id).text(list[i].body);
						
						// own(memberId)??? true(1)??? ?????? ??????,?????? ?????? ?????????
						 if (list[i].own) {
							$("#modifyButtonWrapper" + list[i].id).html(`
								<span class="review-edit-toggle-button badge text-dark"
									id="reviewEditToggleButton\${list[i].id }"
									data-review-id="\${list[i].id }">
									<%-- <i class="fa-solid fa-pen-to-square"></i> --%> ??????
								</span>
								<span class="review-delete-button badge text-dark"
									data-review-id="\${list[i].id }">
									<%-- <i class="fa-solid fa-trash-can"></i> --%> ??????
								</span>
							`);
						} 
						
					} // end of for
					
					// ?????? ??????
					$(".review-modify-submit").click(function(e) {
						e.preventDefault();
						
						const id = $(this).attr("data-review-id");
						const formElem = $("#reviewEditFormContainer" + id).find("form");
						// const data = formElem.serialize(); // put ????????? ??? controller?????? ?????????
						const data = {
							designBoardId : formElem.find("[name=designBoardId]").val(),
							id : formElem.find("[name=id]").val(),
							body : formElem.find("[name=body]").val()
						};
						
						$.ajax({
							url : "${appRoot}/review/modify",
							type : "put",
							data : JSON.stringify(data),
							contentType : "application/json",
							success : function(data) {
								console.log("?????? ??????");
								
								// ????????? ????????????
								$("#reviewMessage1").show().text(data).fadeOut(3000);
								
								// ?????? refresh
								listReview();
							},
							error : function() {
								$("#reviewMessage1").show().text("????????? ????????? ??? ????????????.").fadeOut(3000);
								console.log("?????? ??????");
							},
							complete : function() {
								console.log("?????? ??????");
							}
						});
					});
					
					// review-edit-toggle ?????? ????????? ?????? ???????????? div ?????????,
					// ?????? form ????????????
					$(".review-edit-toggle-button").click(function() {
						console.log("????????????");
						const reviewId = $(this).attr("data-review-id");
						const displayDivId = "#reviewDisplayContainer" + reviewId;
						const editFormId = "#reviewEditFormContainer" + reviewId;
						$(displayDivId).addClass("d-none");
						$(displayDivId).removeClass("d-flex");
						$(editFormId).show();
					});
					
					// ?????? ?????? ?????? ????????? ????????? ??????
					// review-delete-button ?????????
					$(".review-delete-button").click(function() {
						const reviewId = $(this).attr("data-review-id");
						const message = "????????? ?????????????????????????";
						if (confirm(message)) {
							// $("#replyDeleteInput1").val(replyId);
							// $("#replyDeleteForm1").submit();
							
							$.ajax({
								url : "${appRoot}/review/delete/" + reviewId,
								type : "delete",
								success : function(data) {
									
									// ?????? list refresh
									listReview();
									
									// ????????? ??????
									$("#reviewMessage1").show().text(data).fadeOut(3000);
								},
								error : function() {
									$("#reviewMessage1").show().text("????????? ????????? ??? ????????????.").fadeOut(3000);
									console.log(reviewId + "?????? ?????? ??? ?????? ?????????");
								},
								complete : function() {
									console.log(reviewId + "?????? ?????? ?????? ???");
								}
							});
						}
					});
				},
				error : function() {
					console.log("?????? ???????????? ??????");
				}
			});
		}
		
		// ?????? ???????????? ?????? ??????
		listReview();
		
		// addReviewSubmitButton1 ?????? ????????? ajax ?????? ?????? ??????
		// ?????? insert 
		
		$("#addReviewSubmitButton1").click(function(e) {
			e.preventDefault();
			
			const data = $("#insertReviewForm1").serialize();
			
			$.ajax({
				url : "${appRoot }/review/insert",
				type : "post",
				data : data,
				success : function(data) {
					
					// ??? ?????? ?????????????????? ????????? ??????
					$("#reviewMessage1").show().text(data).fadeOut(3000);
					
					// text input ????????? 
					$("#insertReviewContentInput1").val("");
					
					// ?????? ?????? ???????????? ajax ?????? 
					// ?????? ???????????? ?????? ??????
					listReview();
					
				},
				error : function() {
					$("#reviewMessage1").show().text("???????????? ???????????????.").fadeOut(3000);
					console.log("?????? ??????");
				},
				complete : function() {
					console.log("?????? ??????");
				}
			});
		});
		
		$('#likebtn').click(function(){
			likeUpdate();
		});
		
		function likeUpdate(){
			likeurl = "${appRoot}/designBoard/likeUpdate",
			memberId = $('#memberId').val(),
			designBoardId = $('#designBoardId').val(),
			count = $('#likecheck').val(),
			data = {"memberId" : memberId,
					"designBoardId" : designBoardId,
					"count" : count};
			
		$.ajax({
			url : likeurl,
			type : 'post',
			contentType: 'application/json',
			data : JSON.stringify(data),
			success : function(result){
				console.log("??????" + result.result);
				if(count == 1){
					console.log("????????? ??????");
					 $('#likecheck').val(0);
					 $('#likebtn').attr('class','fa-regular fa-heart');
					 $("#likeCount").html(result.count);
				}else if(count == 0){
					console.log("?????????!");
					$('#likecheck').val(1);
					$('#likebtn').attr('class','fa-solid fa-heart');
					$("#likeCount").html(result.count);
				}
			}, error : function(result){
				console.log("??????" + result.result)
			}
			
			});
		};
	});
	</script>

<title>get jsp</title>
<script>
$(document).ready(function() {
	$("#message").fadeOut(2000);
});
</script>


</head>
<body>
		<input type="hidden" id="memberId" value="${likeDto.memberId }" />
		<input type="hidden" id="likecheck" value="${likeCheck }">
	<my:navBar />

	<c:if test="${not empty message }">
		<div id="message" class="alert alert-light">${message }</div>
	</c:if>


	<!-- Page Content -->
	<section style="margin-bottom: 20%;">
	<div class="container" style="padding-top: 4%;">
		<div class="row">
			<div class="col-lg-10">

				<!-- ????????? ?????? + ?????? -->
				<div class="card shadow mb-4">

					<div class="card-body">
						<div class="form-group row" style="text-align: center;">

							<div class="mb-3 mb-sm-2"
								style="display: flex; text-align: left;">
								<c:url value="/designBoard/modify" var="modifyLink">
									<c:param name="id" value="${designBoard.id }"></c:param>
									<c:param name="memberId" value="${designBoard.memberId }"></c:param>
								</c:url>
								<!-- ???????????? -->
								<sec:authorize access="isAuthenticated()">
									<sec:authentication property="principal" var="principal" />
									<c:if test="${principal.username == designBoard.memberId}" var="owner">
									</c:if>
								</sec:authorize>
								<sec:authorize access="hasRole('ADMIN')" var="isAdmin">
								</sec:authorize>
								 
								<c:if test="${owner}">
									<button id="edit-button1"
										class="btn btn-outline-secondary btn-sm"
										onclick="location.href = '${modifyLink}'"
										style="margin-right: 4px;">????????????</button>
										</c:if>
											<c:if test="${owner or isAdmin}">
									<c:url value="/designBoard/remove" var="removeLink" />
									<form id="form1" action="${removeLink }" method="post">
										<input type="hidden" name="id" value="${designBoard.id }" />
										<button id="delete-submit1"
											class="btn btn-outline-secondary btn-sm">????????????</button>
									</form>
								
								</c:if>
							</div>

							<div class="col-sm-6 mb-3 mb-sm-2" style="">
								<h2 class="card-title h4">${designBoard.title }</h2>
								<div class="small text-muted">${designBoard.inserted }</div>
							</div>
							<div class="col-sm-3  mt-1" id="like">
							<!--  -->
						<sec:authorize access="isAuthenticated()">
									<sec:authentication property="principal" var="principal" />
									<c:if test="${principal.username != null }">
						<c:choose>
							<c:when test="${likeCheck ==0}">
								<i class="fa-regular fa-heart" id="likebtn"></i>
								<!-- <button type="button" class="btn btn-light" id="likebtn">?????????</button> -->
							</c:when>					
							<c:when test="${likeCheck ==1}">
								<i class="fa-solid fa-heart" id="likebtn"></i>
								<!-- <button type="button" class="btn btn-danger" id="likebtn">?????????</button> -->
							</c:when>
						</c:choose>	
						</c:if>
						</sec:authorize>
						<c:if test="${principal.username == null }">
						<i class="fa-regular fa-heart" ></i>
						</c:if>
					<div class="d-flex justify-content-center">
						<h5 class="col-lg-3 small text-muted col">?????????</h5>
						<h6 id="likeCount" class="col-lg-1 small text-muted col" >${designBoard.likeCount }</h6>
					</div>
						
							
						
							<input type="hidden" id=likeCon" value="${designBoard.likeCount }" />
							<!--  -->	
							</div>
							<div class="col-sm-2 mt-1">
								<i class="fa-solid fa-eye"></i>
								<h6 class="small text-muted">????????? ${designBoard.clicked }</h6>
							</div>
						</div>
						<div class="mt-5 mb-3" style="text-align: center;">
							<div class="card-img-top">${designBoard.body }</div>
						</div>
						<div class="card-body">
						<h4 class="small text-muted">??????</h4>
						<form class="mt-3" id="insertReviewForm1">
							<div class="input-group">
								<input id="designBoardId" type="hidden" name="designBoardId"
									value="${designBoard.id }" />
								<input class="form-control" type="text" name="body" required
									id="insertReviewContentInput1"
									placeholder="??? ????????? ?????? ????????? ???????????????."
									aria-label="??? ????????? ?????? ????????? ???????????????." />
								<button id="addReviewSubmitButton1"
									class="btn btn-outline-secondary">??????</button>
							</div>
						</form>
						</div>
						<div class="alert alert-primary" style="display: none;"
							id="reviewMessage1"></div>
						<%-- ?????? ?????? --%>
						<ul id="reviewList1" class="list-group" />
						<div class="d-none">
							<form id="reviewDeleteForm1" action="${appRoot }/review/delete"
								method="post">
								<input id="reviewDeleteInput1" type="text" name="id" />
								<input type="text" name="designBoardId"
									value="${designBoard.id }" />
							</form>
						</div>
					</div>
				</div>
			</div>
			<div class="col-lg-2">
				<div class="card shadow mb-4">
					<div class="card-header py-2">
						<h6 class="m-0 font-weight-bold" style="color: black; font-size: 15px;">?????????</h6>
					</div>
					<div class="card-body py-2">${designBoard.memberId }</div>
				</div>
				<div class="card shadow mb-4">
					<div class="card-header py-2">
						<h6 class="m-0 font-weight-bold" style="color: black; font-size: 15px;">??????</h6>
					</div>
					<div class="card-body py-2">${designBoard.price }</div>
				</div>
			</div>
		</div>
	</div>
	</section>
	
	<!-- ?????? -->
	
		<my:footer2 />
	
</body>
</html>