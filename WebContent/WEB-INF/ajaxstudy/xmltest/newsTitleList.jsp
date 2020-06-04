<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>    

<newsTitleList>
	<c:if test="${not empty newsTitleList}">
		<c:forEach var="vo" items="${newsTitleList}">
			<newsTitle> 
				<seqtitleno>${vo.seqtitleno}</seqtitleno>
				<jemok>${vo.title}</jemok>
				<registerday>${vo.registerday}</registerday>
			</newsTitle> 
		</c:forEach> 
	</c:if>
</newsTitleList>

