<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/css/bootstrap.min.css" integrity="sha512-GQGU0fMMi238uA+a/bdWJfpUGKUkBdgfFdgBm72SUQ6BeyWjoY/ton0tEjH+OSH9iP4Dfh+7HM0I9f5eR0L/4w==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" referrerpolicy="no-referrer"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>

<title>Insert title here</title>
</head>

<style>
table.type09 {
	border-collapse: collapse;
	text-align: left;
	line-height: 1.5;
}

table.type09 thead th {
	padding: 10px;
	font-weight: bold;
	vertical-align: top;
	color: #369;
	border-bottom: 3px solid #036;
}

table.type09 tbody th {
	width: 150px;
	padding: 10px;
	font-weight: bold;
	vertical-align: top;
	border-bottom: 1px solid #ccc;
	background: #f3f6f7;
}

table.type09 td {
	width: 350px;
	padding: 10px;
	vertical-align: top;
	border-bottom: 1px solid #ccc;
}

.copyright {
	text-align: center;
	padding: 4% 0 0;
	font-weight: bold;
	color: white;
}
</style>
<body>
	<my:navBar />

	<div class="container mt-5" style="margin-bottom: 20%;">
		<div class="row">
			<div class="col-8">
				<h1>내 의뢰 목록</h1>
				<table class="type09 text-center mt-5"">
					<c:if test="${not empty message }">
						<div class="alert alert-primary">${message }</div>
					</c:if>
					<thead>
						<tr>
							<th scope="cols">번호</th>
							<th scope="cols">제목</th>
							<th scope="cols">날짜</th>
							<th scope="cols">상태</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${requestMyList }" var="my">
							<tr>
								<th scope="row">${my.id }</th>
								<td>
									<c:url value="/request/get" var="getUrl">
										<c:param name="id" value="${my.id }"></c:param>
										<c:param name="memberId" value="${my.memberId }"></c:param>
									</c:url>
									
									<a href="${getUrl }">
										<c:out value="${my.title }" />
									</a>
								</td>
								<td>${my.inserted }</td>
								<td>${my.state }</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<div class="mt-3">
					<my:myPagination path="myList" />
				</div>
			</div>
			<div class="col" style="height: 30%">
				<div class="card"
					style="height: 50%; width: 100%; cursor: pointer;"
					onclick="location.href='https://notefolioacademy.com/products/7';">
					<img src="../resources/picture/ad/펜2.PNG" class="card-img-top">
				</div>

				<div class="card"
					style="height: 50%; width: 100%; cursor: pointer;"
					onclick="location.href='https://notefolioacademy.com/products/30';">
					<img src="../resources/picture/ad/아이패드.PNG" class="card-img-top">
				</div>
			</div>
		</div>
	</div>
	<section class="mt-5">
			<my:footer2/>
    </section>
</body>

</html>