<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
    							  <!-- ▲ 공백을 잘라줌 -->

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>    

<pictures> <!-- 내 마음대로 적은 태그명 -->
	<c:if test="${not empty imgList}">
		<c:forEach var="map" items="${imgList}">
			<picture> <!-- 내 마음대로 적은 태그명 -->
				<imgno>${map.IMGNO}</imgno>
				<!-- 		 ▲ VO는 get다음에 나오는 이름 적지만, 여기서는 key값을 적어줌! -->
				
				<imgfilename>${map.IMGFILENAME}</imgfilename>
			</picture> <!-- 한 행 -->
		</c:forEach> <!-- 여러 번 -->
	</c:if>
</pictures>