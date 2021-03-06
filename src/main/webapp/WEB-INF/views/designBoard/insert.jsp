<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
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



<!-- include summernote css/js -->
<script
	src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/lang/summernote-ko-KR.js"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.20/summernote-bs5.min.css"
	integrity="sha512-ngQ4IGzHQ3s/Hh8kMyG4FC74wzitukRMIcTOoKT3EyzFZCILOPF0twiXOQn75eDINUfKBYmzYn2AA8DkAk8veQ=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.20/summernote-bs5.min.js"
	integrity="sha512-6F1RVfnxCprKJmfulcxxym1Dar5FsT/V2jiEUvABiaEiFWoQ8yHvqRM/Slf0qJKiwin6IDQucjXuolCfCKnaJQ=="
	crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<!-- ckeditor -->
<script type="text/javascript" src="../resources/ckeditor/ckeditor.js"></script>
<title>Insert title here</title>
</head>
<body>

	<my:navBar />

	<!-- <script src="/static/vendor/summernote/dist/summernote.min.js"></script> -->
	??
	<script>
		$(document).ready(function() {
			$('#summernote').summernote({	
						height : 400,
						placeholder : '???????????? ???????????? ???????????? ???????????????',
						lang : 'ko-KR',
						toolbar : [
						// ????????? ??????????????? ?????? ???????????????
						// ??????, ????????????, ??????,?????? ???, ???????????????
						['style',['bold','italic','underline','strikethrough','clear' ] ],
						// ?????????
						['color',[ 'forecolor','color' ] ],
						// ????????????
						[ 'table', [ 'table' ] ],
						// ????????? ??????, ???????????????, ????????????
						['para',[ 'ul', 'ol','paragraph' ] ],
						// ?????????
						[ 'height',[ 'height' ] ],
						// ????????????, ???????????????, ???????????????
						['insert',[ 'picture','link','video' ] ],
						// ????????????, ??????????????????, ?????????
						['view',['codeview','fullscreen','help' ] ] ],
						onImageUpload : function(files, editor, welEditable) {
							console.log(files);
							console.log(files[0]);
							data = new FormData();
							data.append("file", files[0]);
							var $note = $(this);
							$.ajax({
								data : data,
								type : "POST",
								url : '/designBoard/imageupload',
								cache : false,
								contentType : false,
								processData : false,
								success : function(url) {
									alert(url);
									$note.summernote('insertImage', url);
									}
								});
							}
						});
					});
		
	 	// ????????????????????? alert ?????????
		   function goWrite(frm) {
				let body = $("<div>" +  frm.body.value + "</div>");
				let imgElems = body.find("img");
				
				console.log(body);
				console.log("?????????", imgElems.length);
				
				if (imgElems.length <= 0) {
					alert("????????? ???????????????");
				} else {
					frm.submit();
				} 
	 	}
	</script>

	<!-- page content -->
	<section style="margin-bottom: 20%;">
	<form action="${appRoot }/designBoard/insert" method="post"
		enctype="multipart/form-data">
		<div class="container" style="padding-top: 4%;">
			<div class="row">
				<div class="col-lg-9" style="">
					<div class="card shadow mb-4">
						<div class="card-body">
							<input class="form-control" type="text" name="title" required
								id="input1" placeholder="????????? ??????????????????." aria-label="????????? ??????????????????." />
							<label class="form-label" for="textarea1"></label>
							<textarea class="form-control" name="body" id="summernote"
								cols="30" rows="10"></textarea>
						</div>
					</div>
				</div>
				<!-- Side widgets-->
				<div class="col-lg-3">
					<div class="card shadow mb-4">
						<div class="card-header py-2">
							<h6 class="m-0 font-weight-bold text-secondary">??????</h6>
						</div>
						<div class="card-body">
							<input class="form-control" type="text" name="price"
								placeholder="????????? ??????????????????." aria-label="????????? ??????????????????." />
						</div>
					</div>
					
					<div class="card shadow mb-4">
						<div class="card-header py-2">
							<select class="form-select small text-muted" aria-label="Default select example" name="categoryName">
								<option value="illust">?????????????????????</option>
								<option value="web">??? ?????????</option>
								<option value="interior">????????????</option>
							</select>
						</div>
					</div>

					<div class="my-4">
						<button type="button"
							class="btn btn-secondary btn-icon-split btn-block" onclick="goWrite(this.form)">?????????
						</button>
					</div>

				</div>
			</div>
		</div>
	</form>
	</section>
	  <!-- ?????? -->
  
      <my:footer2 />
   
 
   
</body>
</html>