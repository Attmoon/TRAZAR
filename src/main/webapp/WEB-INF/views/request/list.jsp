<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.*" %>
<% request.setCharacterEncoding("utf-8"); %>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>

<!DOCTYPE html>
<html>

<head>
		<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css"
	integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Shop Homepage - Start Bootstrap Template</title>
        <!-- Favicon-->
        <link rel="icon" type="image/x-icon" href="${appRoot }/resources/css/requestList/favicon.ico" />
        <!-- Bootstrap icons-->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="${appRoot }/resources/css/requestList/styles.css" rel="stylesheet" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/css/bootstrap.min.css" integrity="sha512-GQGU0fMMi238uA+a/bdWJfpUGKUkBdgfFdgBm72SUQ6BeyWjoY/ton0tEjH+OSH9iP4Dfh+7HM0I9f5eR0L/4w==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
</head>
<style>
	.card-img-top {
		height : 150px;
		width : 100%;
	}
	.navs{
	  color : black;
	  font-weight:bold;
	}
</style>
<body>
        <!-- Navigation-->
        <my:navBar/>
        <!-- Header-->
        <header class="bg-white ">
            <div class="container px-4 px-lg-5 my-5">
                <div class="text-center text-black">
                    <h1 class="display-4 fw-bolder">Commission</h1>
                    <p class="lead fw-normal text-black-50 mb-4">Write your commission here</p>
                    <div class="searchAll" style="display: flex; justify-content: center;">
	                    <form action="${appRoot }/request/list" class="d-flex">
					      	<div class="input-group">
						      	<select name="type" id="" class="form-select" style="flex:0 0 100px;">
						      		<option value="all" ${param.type != 'title' && param.type != 'body' ? 'selected' : '' }>전체</option>
						      		<option value="title" ${param.type == 'title' ? 'selected' : '' }>제목</option>
						      		<option value="body" ${param.type == 'body' ? 'selected' : ''}>내용</option>
						      	</select>
						      	<input type="search" class="form-control" name="keyword"/>
						      	<button class="btn btn-outline-dark"><i class="fa-solid fa-magnifying-glass"></i></button>
					      	</div>
				        </form>
                    </div>
                </div>
            </div>
            
        </header>
        <!-- Section-->
        <section class="py-5">
        	
            <div class="container px-4 px-lg-5 mt-5">
            <div class="mt-5">
                    
            </div>
				<form action="${appRoot }/request/insert" method="get" id="insertForm"></form>
            	<ul class="nav nav-tabs mt-1">
					  <li class="nav-item">
					    <a class="nav-link navs" aria-current="page" href="${appRoot }/request/list">전체</a>
					  </li>
					  <li class="nav-item">
					    <a class="nav-link navs" aria-current="page" href="${appRoot }/request/list?categoryName=illust">일러스트</a>
					  </li>
					  <li class="nav-item">
					    <a class="nav-link navs" aria-current="page" href="${appRoot }/request/list?categoryName=web">웹 디자이너</a>
					  </li>
					  <li class="nav-item">
					    <a class="nav-link navs" aria-current="page" href="${appRoot }/request/list?categoryName=interior">인테리어</a>
					  </li>
					  <li class="nav-item ms-auto" >
						<button form="insertForm" id="requestAdd" class="btn btn-outline-dark" >의뢰 작성</button>
					  </li>
				</ul>
					
                <div class="row gx-4 gx-lg-5 row-cols-2 row-cols-md-3 row-cols-xl-4 justify-content-center mt-3">
		        	<c:forEach items="${requestList }" var="req" varStatus="status">
						<input type="hidden" name="memberId" value="${req.memberId }" />
							<c:url value="/request/get" var="getUrl">
								<c:param name="id" value="${req.id }"></c:param>
								<c:param name="memberId" value="${req.memberId }"></c:param>
							</c:url>
		                    <div class="col mb-5">
		                        <div class="card h-100">
		                            <!-- Product image-->
		                            <img class="card-img-top" src="${req.imgthumbnail }" alt="..." />
		                            <!-- Product details-->
		                            <div class="card-body p-4">
		                                <div class="text-center">
		                                    <h5 class="fw-bolder">${req.state }</h5>
		                                    <h6>기간 : ${req.term }</h6>
		                                    예산 : ${req.price }
		                                </div>
		                            </div>
	                            <!-- Product actions-->
	                            <div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
	                                <div class="text-center"><a class="btn btn-outline-dark mt-auto" href="${getUrl }">자세히</a></div>
                            	</div>
                        	</div>
                    	</div>
            		</c:forEach>
                </div>
            </div>
        </section>
        <!-- Footer-->
        <section class="mt-5">
			<my:footer2/>
        </section>
</body>
</html>