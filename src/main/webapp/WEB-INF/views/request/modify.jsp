<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%
	request.setCharacterEncoding("utf-8");
%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html>
<!-- <head> -->
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


<head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Blog Post - Start Bootstrap Template</title>
        <!-- Favicon-->
        <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="${appRoot }/resources/css/requestGet/styles.css" rel="stylesheet" />
</head>

<script>
	 $(document).ready(function() {
		 
		 $('#summernote').summernote({
			 	maximumImageFileSize: 1024*1024,
				height : 500,
				placeholder: '?????? 500??? ?????? ???????????????.',
				lang: 'ko-KR',
				toolbar : [
					// ????????? ??????????????? ?????? ???????????????
				    // ??????, ????????????, ??????,?????? ???, ???????????????
				    ['style', ['bold', 'italic', 'underline','strikethrough', 'clear']],
				    // ?????????
				    ['color', ['forecolor','color']],
				    // ????????????
				    ['table', ['table']],
				    // ????????? ??????, ???????????????, ????????????
				    ['para', ['ul', 'ol', 'paragraph']],
				    // ?????????
				    ['height', ['height']],
				    // ????????????, ???????????????, ???????????????
				    ['insert',['picture','link','video']],
				    // ????????????, ??????????????????, ?????????
				    ['view', ['codeview','fullscreen', 'help']]
				  ],
				onImageUpload : function(files, editor, welEditable) {
					console.log(files);
					console.log( files[0] );
					data = new FormData();
					data.append("file", files[0]);
					var $note = $(this);
					$.ajax({
						data : data,
						type : "POST",
						url : '/request/Imageupload',
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
</script>

 <body>
 		<my:navBar/>
 		<form id="form" action="${appRoot }/request/modify" method="post">
 		<input type="hidden" name="id" value="${request.id }" />
        <!-- Page content-->
        <div class="container mt-5">
            <div class="row">
                <div class="col-lg-8">
                    <!-- Post content-->
                    <article>
                        <!-- Post header-->
                        <header class="mb-4">
                            <!-- Post title-->
                            <div>
								<label class="form-label" for="input1">??????</label>
								<input class="form-control" type="text" name="title" required
									id="input1" value="${request.title }" />
							</div>
                        </header>
                        <!-- Post content-->
                        <section class="mb-5">
							<label class="form-label">??????</label>
							<textarea name="body" id="summernote">${request.body }</textarea>
                        </section>
                    </article>
                </div>
                <!-- Side widgets-->
                <div class="col-lg-4">
                    <!-- Side widget-->
                    <div class="card mb-4">
	                    <select id="select1" class="form-select"
							aria-label="Default select example" name="state">
							<option selected>?????? ????????????</option>
							<option value="?????????">?????????</option>
							<option value="?????????">?????????</option>
							<option value="??????">??????</option>
						</select>
					</div>
					
					<div class="card mb-4">
                        <div class="card-header">??????</div>
                        <div class="card-body">
                            <div class="input-group">
                                <input name="term" class="form-control" type="text" value="${request.term }" />
                            </div>
                        </div>
                    </div>
                    
                    <div class="card mb-4">
                        <div class="card-header">??????</div>
                        <div class="card-body">
                            <div class="input-group">
                                <input name="price" class="form-control" type="text" value="${request.price }" />
                            </div>
                        </div>
                    </div>
                    <button id="modify-submit1" class="btn btn-outline-primary">??????</button>
                </div>
            </div>
        </div>
        </form>
        <!-- Footer-->
        <footer class="py-5 bg-dark">
            <div class="container"><p class="m-0 text-center text-white">Copyright &copy; Your Website 2022</p></div>
        </footer>
        <!-- Bootstrap core JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Core theme JS-->
        <script src="${appRoot }/resources/css/requestGet/scripts.js"></script>
    </body>
    
</html>