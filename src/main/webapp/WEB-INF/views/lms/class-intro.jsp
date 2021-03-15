<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>
    <link rel="stylesheet" type="text/css" href="<c:url value="/resources/lms/css/img-icon.css" />">
    <link rel="stylesheet" type="text/css" href="<c:url value="/resources/lms/css/style.css" />">
    <style>
        .bg-img{
            background-image:url('/resources/lms/img/intro-img-1920x3000.jpg');
            background-position: center;
            background-size: cover;
            background-repeat: no-repeat;
            width:100%;
            height:0;
            position:relative;
            padding-top: calc(3480 / 1920 * 100%);
        }
        .btn-pColor{
            width: 17.5%;
            height: 3%;
            font-size: 1.286rem;
            line-height: 3%;
            bottom: calc((3480 / 1920) * 2.5%);
            right: calc((3480 / 1920) * 17.5%);
            position:absolute;
        }
        @media(max-width:1024px){
            .bg-img{
            }
            .btn-pColor{
            }
        }
        @media(max-width:767px){
            .bg-img{
            }
            .btn-pColor{
                font-size: 1rem;
            }
        }
    </style>
</head>
<body>
    <div class="bg-img">
        <button class="btn-pColor button" type="button" onclick="location.href='/lms/course/foreign/sub02-01-01-01'">
            신청하기
        </button>
    </div>

</body>
</html>
