<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/css/bootstrap.min.css" integrity="sha512-GQGU0fMMi238uA+a/bdWJfpUGKUkBdgfFdgBm72SUQ6BeyWjoY/ton0tEjH+OSH9iP4Dfh+7HM0I9f5eR0L/4w==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" referrerpolicy="no-referrer"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<link href="${appRoot }/resources/css/get.css" rel="stylesheet"
	type="text/css">
	
	
<!-- 댓글 스크립트 -->
<script>
	$(document).ready(function() {
		
		
		// 페이지 로딩 후 review list 가져오는 ajax 요청
		// 수정버튼 클릭스 스크립트 
		$("#edit-button1").click(function() {
			$("#input1").removeAttr("readonly");
			//$("#summernote").removeAttr("readonly");
			$("#summernote").removeClass("d-none");
			$("#summernoteView").addClass("d-none");
			$("#summernote").summernote();
			$("#modify-submit1").removeClass("d-none");
			$("#delete-submit1").removeClass("d-none");
		});
		
		$("#delete-submit1").click(function(e) {
			e.preventDefault();
			
			if (confirm("삭제하시겠습니까?")) {
				let form1 = $("#form1");
				let actionAttr = "${appRoot}/designBoard/remove";
				form1.attr("action", actionAttr);
				form1.submit();
			}
			
		});
		
	// 댓글 목록 (review list) 가져오는 ajax
		const listReview = function() {
			
			const data = {designBoardId : ${designBoard.id}};
			
			$.ajax({
				url : "${appRoot}/review/list",
				type : "get",
				data : data,
				success : function(list) {
					
					const reviewListElement = $("#reviewList1");
					reviewListElement.empty();
					
					// 댓글 개수 표시
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
						
						// own(memberId)이 true(1)일 때만 수정,삭제 버튼 보이기
						 if (list[i].own) {
							$("#modifyButtonWrapper" + list[i].id).html(`
								<span class="review-edit-toggle-button badge text-dark"
									id="reviewEditToggleButton\${list[i].id }"
									data-review-id="\${list[i].id }">
									<%-- <i class="fa-solid fa-pen-to-square"></i> --%> 수정
								</span>
								<span class="review-delete-button badge text-dark"
									data-review-id="\${list[i].id }">
									<%-- <i class="fa-solid fa-trash-can"></i> --%> 삭제
								</span>
							`);
						} 
						
					} // end of for
					
					// 댓글 수정
					$(".review-modify-submit").click(function(e) {
						e.preventDefault();
						
						const id = $(this).attr("data-review-id");
						const formElem = $("#reviewEditFormContainer" + id).find("form");
						// const data = formElem.serialize(); // put 방식은 못 controller에서 못받음
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
								console.log("수정 성공");
								
								// 메세지 보여주기
								$("#reviewMessage1").show().text(data).fadeOut(3000);
								
								// 댓글 refresh
								listReview();
							},
							error : function() {
								$("#reviewMessage1").show().text("댓글을 수정할 수 없습니다.").fadeOut(3000);
								console.log("수정 실패");
							},
							complete : function() {
								console.log("수정 종료");
							}
						});
					});
					
					// review-edit-toggle 버튼 클릭시 댓글 보여주는 div 숨기고,
					// 수정 form 보여주기
					$(".review-edit-toggle-button").click(function() {
						console.log("버튼클릭");
						const reviewId = $(this).attr("data-review-id");
						const displayDivId = "#reviewDisplayContainer" + reviewId;
						const editFormId = "#reviewEditFormContainer" + reviewId;

						console.log(reviewId);
						console.log(displayDivId);
						console.log(editFormId);

						$(displayDivId).addClass("d-none");
						$(displayDivId).removeClass("d-flex");
						$(editFormId).show();
					});

					
					// 삭제 버튼 클릭 이벤트 메소드 등록
					// review-delete-button 클릭시
					$(".review-delete-button").click(function() {
						const reviewId = $(this).attr("data-review-id");
						const message = "댓글을 삭제하시겠습니까?";

						if (confirm(message)) {
							// $("#replyDeleteInput1").val(replyId);
							// $("#replyDeleteForm1").submit();
							
							$.ajax({
								url : "${appRoot}/review/delete/" + reviewId,
								type : "delete",
								success : function(data) {
									
									// 댓글 list refresh
									listReview();
									
									// 메세지 출력
									$("#reviewMessage1").show().text(data).fadeOut(3000);
								},
								error : function() {
									$("#reviewMessage1").show().text("댓글을 삭제할 수 없습니다.").fadeOut(3000);
									console.log(reviewId + "댓글 삭제 중 문제 발생됨");
								},
								complete : function() {
									console.log(reviewId + "댓글 삭제 요청 끝");
								}
							});
						}
					});
				},
				error : function() {
					console.log("댓글 가져오기 실패");
				}
			});
		}
		
		// 댓글 가져오는 함수 실행
		listReview();
		
		// addReviewSubmitButton1 버튼 클릭시 ajax 댓글 추가 요청
		// 댓글 insert 
		$("#addReviewSubmitButton1").click(function(e) {
			e.preventDefault();
			
			const data = $("#insertReviewForm1").serialize();
			
			$.ajax({
				url : "${appRoot }/review/insert",
				type : "post",
				data : data,
				success : function(data) {
					
					// 새 댓글 등록되었다는 메시지 출력
					$("#reviewMessage1").show().text(data).fadeOut(3000);
					
					// text input 초기화 
					$("#insertReviewContentInput1").val("");
					
					// 모든 댓글 가져오는 ajax 요청 
					// 댓글 가져오는 함수 실행
					listReview();
					
				},
				error : function() {
					$("#reviewMessage1").show().text("댓글을 작성할 수 없습니다.").fadeOut(3000);
					console.log("문제 발생");
				},
				complete : function() {
					console.log("요청 완료");
				}
			});
		});
	});

	</script>
<title>Insert title here</title>
</head>
<body>

	<!--  -->
	<!-- Portfolio Section-->
	<section class="page-section portfolio" id="portfolio">
		<div class="container">
			<!-- Portfolio Grid Items-->
			<div class="row justify-content-center">
				<!-- Portfolio Item 1-->
				<div class="col-md-6 col-lg-4 mb-5">
					<div class="portfolio-item mx-auto" data-bs-toggle="modal"
						data-bs-target="#portfolioModal1">
						<div
							class="portfolio-item-caption d-flex align-items-center justify-content-center h-100 w-100">
							<div
								class="portfolio-item-caption-content text-center text-white">
								<i class="fas fa-plus fa-3x"></i>
							</div>
						</div>
						<img class="img-fluid"
							src="https://cdn-bastani.stunning.kr/prod/portfolios/5091d7c7-81a2-4bdb-ab81-44cb28316371/contents/d5bd48c65cecfec721b2e868bf7825a0ad46f5c0fa5900c788d34264a8c7366a_v1.jpg"
							alt="..." />
					</div>
				</div>
			</div>
		</div>

		<!--  -->
	
		<!-- modal 돌리기 -->
		<!-- Portfolio Modals-->
		<!-- Portfolio Modal 1-->
		<div class="portfolio-modal modal fade" id="portfolioModal1"
			tabindex="-1" aria-labelledby="portfolioModal1" aria-hidden="true">
			<div class="modal-dialog modal-xl">
				<div class="modal-content">
					<div class="modal-header border-0">
						<button class="btn-close" type="button" data-bs-dismiss="modal"
							aria-label="Close"></button>
					</div>
					<div class="modal-body text-center pb-5">
						<div class="container">
							<div class="row justify-content-center">
								<div class="col-lg-8">
									
									<form id="form1" action="${appRoot }/designBoard/modify"
										method="post">
										<input type="hidden" name="id" value="${designBoard.id }" />
										
										<!-- Portfolio Modal - Title-->
										<h2
											class="portfolio-modal-title text-secondary text-uppercase mb-0">
											${designBoard.title }
											<button 수정버튼 밑으로 내리기 id="edit-button1"  data-bs-dismiss="modal" class="btn btn-secondary">
												<i class="fa-solid fa-pen-to-square"></i>
											</button>
										</h2>

										<c:if test="${not empty message }">
											<div class="alert alert-primary">${message }</div>
										</c:if>
										
										
										<!-- Icon Divider-->
										<div class="divider-custom"
											style="display: flex; flex-direction: row;">

											<div class="divider-custom-icon"
												style="flex: 1; flex-direction: column; align-items: center;">

												<div class="view">
													<i class="fa-solid fa-eye"></i>
													<span>조회수</span>
												</div>

												<div class="like">
													<i class="fa-solid fa-heart"></i>
													<span>좋아요 수</span>
												</div>

												<div class="comment">
													<i class="fa-solid fa-message"></i>
													<span>댓글 수</span>
												</div>

											</div>
										</div>
										<input class="text" type="datetime-local"
											value="${designBoard.inserted }" />
										<p>시간 날짜 넣고 싶은데 안예뿌네ㅜ ㅜ</p>


										<!-- Portfolio Modal - Image-->

										<div class="img-fluid rounded mb-5" id="summernoteView"
											cols="30" rows="10">${designBoard.body }</div>
										<textarea class="img-fluid rounded mb-5 d-none" name="body"
											id="summernote">${designBoard.body }</textarea>


										<!-- Portfolio Modal - Text-->
										<!--  
										<p class="mb-4">
											<strong>특수설정 미스터리 소설 &lt;낙원은 탐정의 부재&gt; 표지, 본문 디자인</strong>
											<strong>일러스트: Sujan</strong>
										</p> 
										-->
										<button id="modify-submit1"  data-bs-dismiss="modal" class="btn btn-primary d-none">수정</button>
									</form>
								</div>
								<c:url value="/designBoard/remove" var="removeLink" />
								<form action="${removeLink }" method="post">
									<input type="hidden" name="id" value="${designBoard.id }" />
									<button id="delete-submit1" data-bs-dismiss="modal" class="btn btn-danger d-none">삭제</button>
								</form>
								<button class="btn btn-primary" data-bs-dismiss="modal">
									<i class="fas fa-xmark fa-fw"></i>
									Close Window
								</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		</div>
		<!--  -->
	<!--  -->

		<div class="work-add-info-container">
			<div class="work-button-group">
				<a class="btn-like">
					<svg class="like-icon">
			                                <i class="fa-regular fa-heart"></i>
			                            </svg>

					<svg class="like-icon-fill">
			                                <i class="fa-solid fa-heart"></i>
			                            </svg>

					<span class="btn-name">좋아요</span>
					<span class="like-cnt">갯수</span>
				</a>

			</div>
		</div>

		<!-- work-add-info-container end -->

		<!--  -->
		<div class="work-actions">
			<div class="comment-wrapper">
				<!---->
				<form class="comment-block create">
					<div class="comment-profile-input-form">
						<a class="comment-profile-area">
							<div class="profile-item" style="width: 48px; height: 48px;">
								<img
									src="https://cdn.notefolio.net/profiles/rhdtlr3006380_face.jpg"
									class="hide">
								<span class="show">R</span>
								<!---->
								<!---->
							</div>
						</a>

						<textarea tabindex="1" rows="4" placeholder=" 이 작업에 대한 댓글을 남겨주세요."
							class="comment-textarea comment-textform comment-textarea-form"></textarea>
					</div>
					<div class="comment-action-area">
						<div tabindex="2" class="comment-submit-btn">댓글작성</div>
					</div>
				</form>
			</div>
		</div>
		
			<!--  -->

		<div class="preview-sidebar">
			<div class="profile">
				<div class="profile-wrapper">
					<div class="profile-image-container">
						<div class="v-popover">
							<div class="trigger" style="display: inline-block;">
								<div class="profile-image">
									<div class="profile-item pointer-cursor"
										style="width: 46px; height: 46px;">
										<img
											src="https://cdn-bastani.stunning.kr/prod/users/0c9b5107-86f1-4e2f-ab14-e423b7df62c7/avatar/aezcK9ztSbZ3a7hU.시현하다_시원.jpeg.small?q=80&amp;t=crop&amp;s=100x100&amp;version=1a22780">
										<span class="hide">S</span>
										<!---->
										<!---->
									</div>
								</div>
							</div>
						</div>
					</div>
					<span>프로필</span>
				</div>
			</div>


			<div class="like">
				<div class="like-work-wrapper">
					<div class="v-popover">
						<div class="trigger" style="display: inline-block;">
							<div class="btn-like pointer-cursor">
								<svg class="like-icon">
	                                    <use href="#like-icon"></use>
	                                </svg>
								<svg class="like-icon-fill">
	                                    <use href="#like-icon-fill"></use>
	                                </svg>
							</div>
						</div>
					</div>
					<span>좋아요</span>
				</div>
			</div>
		</div>


	<%-- 댓글 추가 --%>
		<div class="border border-black border-2 rounded-3 p-4 container">
			<div class="row mt-3">
				<div class="col">
					<h4>댓글</h4>
					<form class="mt-3" id="insertReviewForm1">
						<div class="input-group">
							<input type="hidden" name="designBoardId"
								value="${designBoard.id }" />

							<input id="insertReviewContentInput1" class="form-control"
								type="text" name="body" required />
							<button id="addReviewSubmitButton1"
								class="btn btn-outline-secondary">등록</button>

						</div>
					</form>
				</div>
			</div>
			<div class="row">
				<div class="alert alert-primary" style="display: none;" id="reviewMessage1"></div>
			</div>

			<%-- 댓글 목록 --%>
			<div class="row mt-3">
				<div class="col">

					<ul id="reviewList1" class="list-group" />

				</div>
			</div>
		</div>

		<%-- 댓글 삭제 --%>
		<div class="d-none">
			<form id="reviewDeleteForm1" action="${appRoot }/review/delete"
				method="post">
				<input id="reviewDeleteInput1" type="text" name="id" />
				<input type="text" name="designBoardId" value="${designBoard.id }" />
			</form>
		</div>


		
</body>
</html>