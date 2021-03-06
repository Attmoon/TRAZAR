	<%@ page language="java" contentType="text/html; charset=UTF-8"
		pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
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
</head>

<script>
	$(document).ready(function() {
		$("#passwordModify3, #passwordModify4").keyup(function() {
			const pw3 = $("#passwordModify3").val();
			const pw4 = $("#passwordModify4").val();

			if (pw3 === pw4) {
				$("#passwordMessageModify1").text("패스워드가 일치합니다.")
				$("#passwordMessageModify1").css("color", "blue")
				$("#button").removeAttr("disabled")
			} else {
				$("#passwordMessageModify1").text("패스워드가 일치하지 않습니다.")
				$("#passwordMessageModify1").css("color", "red")
				$("#button").attr("disabled","")
			}
		})
	})
</script>

<style>
	.form-control:focus {
		box-shadow : 0 0;
	}
	
	.main{
		display: flex;
		height: 100%;
		margin: 0;
		padding:0;
	}
	.main2{
		display: flex;
		flex:1 1;
	}
	.left-area{
		position: relative; 
		flex: 1 1; 
		background-color: #303134; 
		display: block;
	}
	.left{
		color: white; 
		text-decoration: none; 
		font-size: 500%; 
		left: 15%; 
		top: 30%; 
		z-index: 60; 
		position: fixed;
	}
	.team{
		padding-top: 48px; 
		color: white; 
		font-size: 25px; 
		text-align: center; 
		left: 15%; 
		top: 30%; 
		z-index: 60;
	}
	.left-under{
		position: absolute; 
		bottom: 42px; 
		left: 3%; 
		width: 90%;
	}
	.left-under-team{
		color: white; 
		font-size: 15px;
	}
	.right-area{
		position: relative; 
		align-items: center; 
		flex-basis: 55%; 
		display: flex; 
		padding: 120px 0;
		font-size: 1.4rem; 
		flex-direction: column;
	}
	h1{
		font-weight: 700; 
		font-size: 25px; 
		line-height: 130%; 
		margin-bottom: 12px; 
		padding-bottom: 14px; 
		text-align: center; 
		font-size: 150%;
	}
</style>

<body>

	<div class="main">
	
	<div class="main2">
	
	
		<div class="left-area">
			<div class="left">
			<a href="${appRoot }/designBoard/list" style="text-decoration: none; color: white;">TRAZAR</a>
			<div class="team">produce by HYS</div>
			</div>
		</div>
		
		<div class="left-under">
			<div class="left-under-team">TRAZAR</div>
		</div>
	
		<div class="right-area justify-content-center">
				<div class="col-12 col-lg-5">
					<h1> 비밀번호 찾기</h1>
					<form action="${appRoot }/sign/passwordUpdate1" method="post">

						<input id="idInput1" class="form-control" type="hidden" name="id"
							value="${member.id}" readonly />

						<label for="passwordInput1" class="form-label"> 변경 할 암호 </label>
						<input class="form-control" id="passwordModify3" name="password"
							type="password" />
						<label for="passwordInput2" class="form-label"> 변경 후 암호확인
						</label>
						<input class="form-control" id="passwordModify4" type="password"
							value="" />
						<p class="form-text" id="passwordMessageModify1"></p>
						<br />
						<input id="button" class="btn btn-dark" type="submit" value="비밀번호 변경" style="width: 100%;" disabled />
					</form>



				</div>
			</div>
		</div>
	</div>

</body>