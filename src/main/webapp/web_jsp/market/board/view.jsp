<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page import="mvc.model.BoardDTO" %>

<%
    BoardDTO board = (BoardDTO) request.getAttribute("board");
    int num = ((Integer) request.getAttribute("num")).intValue();
    int nowpage = ((Integer) request.getAttribute("page")).intValue();
%>
<!doctype html>
<html lang="ko">
<head>
    <link rel="stylesheet" href="../resources/css/bootstrap.min.css"/>
    <meta charset="UTF-8">
    <title>Board</title>
    <script>
        let goUpdate=function() {
            const frm = document.frmUpdate;
            // document.querySelector("#del").setAttribute("href", "./BoardDeleteAction.do?num=<%=board.getNum()%>&pageNum=<%=nowpage%>");
            frm.action="../boardController/BoardUpdateForm.do";
            frm.submit();
        }
        let goDelete = function(){
            if(confirm("삭제하시겠습니까?"))
            {
                const frm = document.frmUpdate;
                frm.action = "../boardController/BoardDeleteAction.do";
                frm.submit();
            }
        }
    </script>
</head>
<body>
<jsp:include page="../inc/menu.jsp" />
<div class="jumbotron">
    <div class="container">
        <h1 class="display-3">게시판</h1>
    </div>
</div>

<div class="container">
    <!--form name="newUpdate" class="form-horizontal"  action="./BoardUpdateAction.do?num=<%=board.getNum()%>&pageNum=<%=nowpage%>" method="post"-->
    <div class="form-group  row">
        <label class="col-sm-2 control-label">성명</label>
        <div class ="col-sm-3"><%=board.getName() %></div>

    </div>
    <div class="form-group  row">
        <label class="col-sm-2 control-label">제목</label>
        <div class="col-sm-5"><%=board.getSubject() %></div>
    </div>
    <div class="form-group  row">
        <label class="col-sm-2 control-label">내용</label>
        <div class="col-sm-8" style="word-break: break-all">
            <%=board.getContent()%>
        </div>
    </div>
    <% if(board.getFilename() != null && ! board.getFilename().isEmpty()){ %>
    <div class="form-group row">
        <label class="col-sm-2 control-Label" >이미지</label>
        <div class="col-sm-8" style="word-break: break-all;">
            <img src="/img/<%=board.getFilename()%>" class="user-gallery-image">
        </div>
    </div>
    <%} %>
    <div class="form-group row">
        <div class="col-sm-offset-2 col-sm-10 ">
            <c:set var="userId" value="<%=board.getId()%>" />
            <c:if test="${sessionId==userId}">
                <p>
                    <span class="btn btn-danger" onclick="goDelete();">삭제</span>
                    <span class="btn btn-success" onclick="goUpdate();">수정</span></p>

                </p>
            </c:if>
            <a href="./BoardListAction.do?pageNum=<%=nowpage%>" class="btn btn-primary"> 목록</a>
        </div>
    </div>
    <!--/form-->
    <hr>

    <form name="frmUpdate" method="post">
        <input type="hidden" name="num" value="<%=num%>">
        <input type="hidden" name="pageNum" value="<%=nowpage%>">

    </form>


    <!-- 리플 목록. -->
    <div class ="form-group row user-repple-list">

        <ul>

        </ul>
    </div>
    <form name="frmRippleDelete" class="form-horizontal" method="post">
        <input type="hidden" name="num" value="<%=board.getNum() %>">
        <input type="hidden" name="pageNum" value="${page}">
        <input type="hidden" name="rippleId">

    </form>

    <!--리플목록-->
    <!-- 리플쓰기, 로그인 상태에서만 나옴. -->
    <hr>
    <c:if test="${sessionId != null}">
        <form name="frmRipple" class="form-horizontal" method="post">
            <input type="hidden" name="num" value="<%=board.getNum() %>">
            <input type="hidden" name="pageNum" value="${page}">
            <div class="form-group row">
                <label class="col-sm-2 control-Label" >성명</label>
                <div class="col-sm-3">
                    <input name="name" type="text" class="form-control" value="${sessionMemberName}" placeholder="성명">
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2 control-Label" >내용</label>
                <div class="col-sm-8" style="word-break: break-all;">
                    <textarea name="content" class="form-control" cols="50" rows="3"></textarea>
                </div>
            </div>

            <div class="form-group row">
                <label class="col-sm-2 control-Label"></label>
                <div class="col-sm-3">
                    <span class="btn btn-primary" name="goRippleSubmit">등록</span>
                </div>
            </div>
        </form>

        <script>
            function goRippleSubmit() {
                let frm = document.frmRipple;
                //컨트롤러로 전달
                frm.action = "BoardRippleWriteAction.do";
                frm.submit();
            }
        </script>



    </c:if>
    <script>
        const xhr = new XMLHttpRequest(); //XMLHttpRequest 객체 생성
        //함수 선언
        const insertItem = function (item) {
            // 목록에 요소를 추가. 처음 로딩시 목록을 출력하거나 새로운 글 등록시 사용
            let tagNew = document.createElement('li');
            tagNew.innerHTML = item.content + ' | ' + item.name;
            if (item.isWriter === 'true') {
                tagNew.innerHTML += '<span class="btn btn-danger" onclick="goRippleDelete(\'' + item.rippleId + '\');">>삭제</span>'
            }
            let tagUl = document.querySelector('.user-repple-list ul');
            tagUl.append(tagNew);
        }

        const insertList = function() {
            //목록을 가지고 옴
            let num = document.querySelector('form[name=frmRippleDelete] input[name=num]');
          //  xhr.open('GET', '../board/ajax_list_item.jsp?boardName=board&num=' + num.value);
            xhr.open('GET', '../boardController/RippleListAction.do?boardName=board&num=' + num.value);
            xhr.send();
            xhr.onreadystatechange = function (){
                if(xhr.readyState !== XMLHttpRequest.DONE) return;

                if(xhr.status===200){// 서버 (url)에 문서가 존재함
                    console.log(xhr.response);
                    const json = JSON.parse(xhr.response);

                    let tagUl = document.querySelector('.user-repple-list ul');
                    tagUl.innerHTML=""; //내부 태그 삭제후 인서트

                    for(let data of json.listData){
                        console.log(data);
                        insertItem(data);
                    }
                } else {//서버(url)에 문서가 존재하지 않음
                    console.error('Error', xhr.status, xhr.statusText);
                }
            }
        }

        const goRippleDelete = function (ID){
            if(confirm("삭제하시겠습니까?")){
                const xhr = new XMLHttpRequest(); //XMLHttpRequest 객체 생성
               // xhr.open('POST', '../board/ajax_delete.jsp?rippleId=' + ID);

                xhr.open('POST', '../boardController/RippleDeleteAction.do?rippleId=' + ID);
                xhr.send();
                xhr.onreadystatechange = () => {
                    if(xhr.readyState !== XMLHttpRequest.DONE) return;

                    if(xhr.status ===200){ //서버(url)에 문서가 존재함
                        console.log(xhr.response);
                        const json = JSON.parse(xhr.response);
                        if(json.result ==='true'){
                        insertList();
                        }
                        else {
                            alert("삭제에 실패했습니다.");
                        }
                    } else {
                        //서버(url)에 문서가 존재하지 않음
                        console.error('Error', xhr.status, xhr.statusText);
                    }
                }
            }
        }
    </script>

    <script>
        document.addEventListener("DOMContentLoaded", function(){
            insertList();
        });
    </script>
    <script>
        document.addEventListener("DOMContentLoaded", function(){
            const xhr = new XMLHttpRequest(); // XMLHttpRequest 객체 생성

            document.querySelector('span[name=goRippleSubmit]').addEventListener('click', function (){
                /* 등록 버튼 클릭 시
                1) 데이터베이스에 데이터 등록 2) 화면에 표시 */
                let num = document.querySelector('input[name=num]');
                let name = document.querySelector('input[name=name]');
                let content = document.querySelector('textarea[name=content]');

                //xhr.open('POST', '../board/ajax_insert_content.jsp?boardName=board&num=' +
                   // num.value + '&name=' + name.value + '&content=' + content.value);
                	xhr.open('POST', '../boardController/RippleWriteAction.do?boardName=board&num=' +
                			num.value + '&name=' + name.value + '&content=' + content.value);
                xhr.send();
                xhr.onreadystatechange = () => {
                    if (xhr.readyState !== XMLHttpRequest.DONE) return;

                    if (xhr.status === 200) { // 서버(url)에 문서가 존재함
                        console.log(xhr.response);
                        const json = JSON.parse(xhr.response);
                        if (json.result === 'true') {
                            content.value = ''; // input태그에 입력된 값 삭제.
                            insertList();
                        }
                        else {
                            alert("등록에 실패했습니다.");
                        }
                    }
                    else { // 서버(url)에 문서가 존재하지 않음.
                        console.error('Error', xhr.status,xhr.statusText);
                    }
                }
            });

        });
    </script>
</div>
<!-- //리플 쓰기 -->
<jsp:include page="../inc/footer.jsp"/>
</body>
</html>
