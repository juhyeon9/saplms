<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
						   
							<c:if test="${searchlistcnt eq 0 }">
								<tr>
									<td colspan="6">데이터가 존재하지 않습니다.</td>
								</tr>
							</c:if>
							<c:if test="${searchlistcnt > 0 }">
								<c:forEach items="${searchlist}" var="list">
									<tr>
										<td>${list.id}</td>
										<td><a href="javascript:fselectone('${list.carnum}')">${list.carnum}</a></td>
										<td>${list.model}</td>
										<td>${list.modelyear}</td>
										<td>${list.make}</td>
										<td>${list.price}</td>
										
									</tr>
								</c:forEach>
							</c:if>
							
							<input type="hidden" id="searchlistcnt" name="searchlistcnt" value ="${searchlistcnt}"/>