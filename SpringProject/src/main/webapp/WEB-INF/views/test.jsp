<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>Document</title>
<!-- include libraries(jQuery, bootstrap) -->
<link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<!-- include summernote css/js -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>

<script>
$(document).ready(function() {
  $('#summernote').summernote({
            height: 300,                 // 에디터 높이
            minHeight: null,             // 최소 높이
            maxHeight: null,             // 최대 높이
            focus: true,                  // 에디터 로딩후 포커스를 맞출지 여부
            lang: "ko-KR",					// 한글 설정
            placeholder: '최대 2048자까지 쓸 수 있습니다',	//placeholder 설정

            toolbar: [
                ['style', ['style']], // 글자 스타일 설정 옵션
                ['fontsize', ['fontsize']], // 글꼴 크기 설정 옵션
                ['font', ['bold', 'underline', 'clear']], // 글자 굵게, 밑줄, 포맷 제거 옵션
                ['color', ['color']], // 글자 색상 설정 옵션
                ['table', ['table']], // 테이블 삽입 옵션
                ['para', ['ul', 'ol', 'paragraph']], // 문단 스타일, 순서 없는 목록, 순서 있는 목록 옵션
                ['height', ['height']], // 에디터 높이 조절 옵션
                ['insert', ['picture', 'link', 'video']], // 이미지 삽입, 링크 삽입, 동영상 삽입 옵션
                ['view', ['codeview', 'fullscreen', 'help']], // 코드 보기, 전체 화면, 도움말 옵션
            ],

            // fontSizes: [
            //     '8', '9', '10', '11', '12', '14', '16', '18',
            //     '20', '22', '24', '28', '30', '36', '50', '72',
            // ], // 글꼴 크기 옵션

            styleTags: [
                'p',  // 일반 문단 스타일 옵션
                {
                    title: 'Blockquote',
                    tag: 'blockquote',
                    className: 'blockquote',
                    value: 'blockquote',
                },  // 인용구 스타일 옵션
                'pre',  // 코드 단락 스타일 옵션
                {
                    title: 'code_light',
                    tag: 'pre',
                    className: 'code_light',
                    value: 'pre',
                },  // 밝은 코드 스타일 옵션
                {
                    title: 'code_dark',
                    tag: 'pre',
                    className: 'code_dark',
                    value: 'pre',
                },  // 어두운 코드 스타일 옵션
                'h1', 'h2', 'h3', 'h4', 'h5', 'h6',  // 제목 스타일 옵션
            ],

            callbacks: {
                onImageUpload: function (files, editor, welEditable) {
                    // 파일 업로드 (다중 업로드를 위해 반복문 사용)
                    for (var i = files.length - 1; i >= 0; i--) {
                        var fileName = files[i].name

                        // 이미지 alt 속성 삽일을 위한 설정
                        var caption = prompt('이미지 설명 :', fileName)
                        if (caption == '') {
                            caption = '이미지'
                        }
                        uploadSummernoteImageFile(files[i], this, caption)
                    }
                },
            },
  });
});

function uploadSummernoteImageFile(file, el, caption) {
        data = new FormData()
        data.append('file', file)
        $.ajax({
            data: data,
            type: 'POST',
            url: '/uploadSummernoteImageFile',
            contentType: false,
            enctype: 'multipart/form-data',
            processData: false,
            success: function (data) {
                $(el).summernote(
                    'editor.insertImage',
                    data.url,
                    function ($image) {
                        $image.attr('alt', caption) // 캡션 정보를 이미지의 alt 속성에 설정
                    }
                )
            },
        })
    } 
</script>
</head>
<body>
<form method="post">
    <table border=1 width="400"> <!-- table 너비 지정 -->
        <tr>
            <td>제목</td>
            <td><input type="text" name="subject" style="width:100%;"></td>
        </tr>
        <tr>
            <td colspan="2">
                <textarea id="summernote" name="board"></textarea>
            </td>
        </tr>
    </table>
    <input type="submit" value="전송">
</form>
  
</body>
</html>