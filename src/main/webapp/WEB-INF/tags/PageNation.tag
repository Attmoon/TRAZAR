<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ attribute name="path" required="false"%>



<nav aria-label="Page navigation example">
	<ul class="pagination justify-content-center">
		<c:url value="${path }" var="link">
			<c:param name="page" value="${pageInfo.current - 1 }"></c:param>
		</c:url>
		<c:if test="${pageInfo.current != 1 }">
			<li class="page-item">
				<a class="page-link" href="${link }" aria-label="Previous">
					<span aria-hidden="true">&laquo;</span>
				</a>
			</li>
		</c:if>
		<c:forEach begin="${pageInfo.left }" end="${pageInfo.right }"
			var="pageNum">

			<c:url value="${path }" var="link">
				<c:param name="page" value="${pageNum }"></c:param>

			</c:url>

			<li class="page-item ${pageInfo.current == pageNum ? 'active' : '' }">
				<a class="page-link" href="${link }">${pageNum }</a>
			</li>
		</c:forEach>
		<c:if test="${pageInfo.current != pageInfo.end }">
			<c:url value="${path }" var="link">


				<c:param name="page" value="${pageInfo.current + 1 }"></c:param>

			</c:url>
			<li class="page-item">
				<a class="page-link" href="${link }" aria-label="Next">
					<span aria-hidden="true">&raquo;</span>
				</a>
			</li>
		</c:if>
	</ul>
</nav>