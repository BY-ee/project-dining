<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:forEach var="store" items="${stores}">
    <div class="store-item-box" onclick="goToStoreDetail(${store.id})">
        <div class="store-item">
            <img src="<c:url value='/images/store/${store.mainImage1}' />" alt="${store.storeName} 이미지">
        </div>
        <div class="store-name">${store.storeName}</div>
    </div>
</c:forEach>