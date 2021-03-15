<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Error 500</title>
    <style>
        
        .errorImg{
            width:100%;
            height:900px;
            background-image: url(/resources/images/500error.jpg); /* url('경로 입력') */
            background-size: contain;
            background-repeat:no-repeat;
            margin: 0 auto;
            position : relative;
        }
        .errorBtn{
            width:300px;
            height:60px;
            line-height: 60px;
            border-radius:10px;
            border:2px solid #ec6621;
            background-color: fff;
            color: #ec6621;
            text-align: center;
            font-weight: bold;
            margin : auto;
            font-size : 20px;
            text-decoration: none;
            position : absolute;
            left : 0;
            right : 0;
            bottom : 80px;
        }
        .errorBtn:hover{
           background-color: #ec6621;
           color : #fff;
        }
        @media(max-width:1024px){
            body{
                background-color: inherit;
            }
            .errorImg{
                width:100%;
                height:0;
                padding-top:calc(900 / 1920 * 100%);
        }
            .errorBtn{
               width:250px;
               height:40px;
               line-height:40px;
               bottom : -40px;
            }
        }
        @media(max-width:767px){
            .errorBtn{
                display:none;
            }
        }
    </style>
</head>
<body>
    <div class="img errorImg">
       <a href="/"><div class="btn errorBtn">홈페이지 메인으로 이동</div></a>
   </div>
   
</body>
</html>
