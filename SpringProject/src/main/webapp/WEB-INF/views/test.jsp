<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <!-- <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css" /> -->
    <link rel="stylesheet" href="../resources/css/w3.css" />
    <title>Document</title>
  </head>
  <body>
    <div class="w3-container">
      <h2>테스트 게시판</h2>
      <div class="w3-responsive">
        <table class="w3-table-all">
          <tr>
            <th>번호</th>
            <th>글 제목</th>
            <th>작성일</th>
            <th>작성자</th>
            <th>조회수</th>
          </tr>
          <tr>
            <td>3</td>
            <td>테스트3</td>
            <td>2017.01.10</td>
            <td>김대성</td>
            <td>50</td>
          </tr>
          <tr>
            <td>2</td>
            <td>테스트2</td>
            <td>2017.01.10</td>
            <td>김대성</td>
            <td>50</td>
          </tr>
          <tr>
            <td>1</td>
            <td>테스트1</td>
            <td>2017.01.10</td>
            <td>김대성</td>
            <td>50</td>
          </tr>
        </table>
      </div>

      <br />

      <div class="w3-center">
        <ul class="w3-pagination">
          <li><a href="#">&laquo;</a></li>
          <li><a class="w3-green" href="#">1</a></li>
          <li><a href="#">2</a></li>
          <li><a href="#">3</a></li>
          <li><a href="#">4</a></li>
          <li><a href="#">5</a></li>
          <li><a href="#">&raquo;</a></li>
        </ul>
      </div>
    </div>
  </body>
</html>
