<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<!-- abc -->
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>파일업로드 샘플</title>
<!-- 캘린더 -->
<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css"/>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>

<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<!-- sweet swal import -->

<script type="text/javascript">
    
    // 그룹코드 페이징 설정
    var pagesize = 5;
    var pagenumsize = 5; // 페이지에서 한번에 보여주는 ROW값
    // 목록 데이터 
    var lecnoticelist;
    // 검색
    var searcharea;
    // 저장
    var savepopup;
    
	/** OnLoad event */ 
	$(function() { // DOM(HTML관련코드)실행이 끝나면 가장 먼저 실행 되는 함수  == '$(document).ready(function(){});'
		//comcombo("GRADE", "samplecom", "all", "");
	   	
	   	init(); // 해당 함수가 실행되면 아래에 있는 함수 본체가 실행된다.
	   
  		// 게시판 조회
		listsearch();
  		
		/* 재직자 분류 콤보박스 (plectype : object.li_type) */
	  	comcombo("lectype", "plectype", "sel", "");
		
		fRegisterButtonClickEvent();
	
	});
	
    
	/** 버튼 이벤트 등록 */
	function fRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();

			var btnId = $(this).attr('id');
			
			switch (btnId) {
				case 'btnSearch' :
					listsearch();
					break;
				case 'btnSave' :
					savelecNotice();
					break;	
				case 'btnDelete' :
	//				$("#action").val("D");
					savepopup.action = "D";
					savelecNotice();
					break;		
				case 'btnClose' :
					gfCloseModal();
					break;
			}
		});
	}
	
	function init() {
		
		/* 강의계획서 목록 */
		lecnoticelist = new Vue({
						  el : "#divfileuploadList",
						data : {
									listitem : [],
									pagenavi : ""
						},
						methods : {
							detailview : function(no){
								fn_selectone(no);
							}
						}
		})
		/* 검색 */
		searcharea = new Vue({
						  el : "#searcharea",
						data : {
									searchtype : "",
									searchvalue : "",
									startdate : "",
									enddate : ""
						}
		})
		/* 계획서 등록 */
		savepopup = new Vue({
							el : "#layer1",
						  data : {
							  		no : 0,
							  		/* 숫자, 문자 동시사용 가능한가? X */
							  		titlenm : "",
							  		plectype : 0,
							  		titlename : "",
							  		titlehp : "",
							  		titleemail : "",
							  		titlelino2 : "",
							  		titledate : "",
							  		titleredate : "",
							  		titleap : 0,
							  		titlegarden : 0,
							  		titletarget : "",
							  		titlead : "",
							  		titleplan : "",
							  		action : "",
							  		showln : false
						  }
		})
		
		
	}
	
	
	
	/* 페이지 네비게이션 */
	function listsearch(clickpagenum){
		clickpagenum = clickpagenum || 1;
		
		console.log("searcharea.searchtype : " + searcharea.searchtype + " searcharea.searchvalue : " + searcharea.searchvalue);
		
		var param = {
				clickpagenum : clickpagenum,
				pagesize : pagesize,
				searchtype : searcharea.searchtype,
				searchvalue : searcharea.searchvalue,
				startdate : searcharea.startdate,
				enddate : searcharea.enddate
		}
		
		var listcallback = function(returndata){
			console.log(  "listcallback " + JSON.stringify(returndata) );
			
			lecnoticelist.listitem = returndata.searchlist;
			
			var paginationHtml = getPaginationHtml(clickpagenum, returndata.searchlistcnt, pagesize, pagenumsize, 'listsearch');
			console.log("paginationHtml : " + paginationHtml);
			
			lecnoticelist.pagenavi = paginationHtml;
			
		}
		
		callAjax("/supportD/listLecNoticevue.do", "post", "json", true, param, listcallback);
	}
	
	function fPopModal(){
		
		forminit();
		gfModalPop("#layer1");
	}
	
	function forminit(object){
		if(object == null || object == ""){
			savepopup.no = "";
			savepopup.titlenm = "";
			savepopup.plectype = "";
			/* name, hp, email */
			savepopup.titlename = $("#user_name").val();
			savepopup.titlehp = $("#user_hp").val();
			savepopup.titleemail = $("#user_email").val();
			savepopup.titlelino2 = "";
			savepopup.titledate = "";
			savepopup.titleredate = "";
			savepopup.titleap = "";
			savepopup.titlegarden = "";
			savepopup.titletarget = "";
			savepopup.titlead = "";
			savepopup.titleplan = "";
			savepopup.action = "I";
			
			$("#action").val("I");
			savepopup.showln = false;

		} else {
			savepopup.no = object.li_no;
			savepopup.titlenm = object.li_nm;
			savepopup.plectype = object.li_type;
			savepopup.titlename = object.name;
			savepopup.titlehp = object.hp;
			savepopup.titleemail = object.email;
			savepopup.titlelino2 = object.li_no2;
			savepopup.titledate = object.li_date;
			savepopup.titleredate = object.li_redate;
			savepopup.titleap = object.li_ap;
			savepopup.titlegarden = object.li_garden;
			savepopup.titletarget = object.li_target;
			savepopup.titlead = object.li_ad;
			savepopup.titleplan = object.li_plan;
			savepopup.action = "U";
			
			$("#action").val("U");
			$("#li_no").val(object.li_no);
			savepopup.showln = true;
		}
	}
	
	function savelecNotice() {
		
		var param = {
				/* Mybatis의 파라미터값 : Vue의 data값 */
				li_no : savepopup.no,
				titlenm : savepopup.titlenm,
				plectype : savepopup.plectype,
				name : savepopup.titlename,
				hp : savepopup.titlehp,
				email : savepopup.titleemail,
				titlelino2 : savepopup.titlelino2,
				titledate : savepopup.titledate,
				titleredate : savepopup.titleredate,
				li_ap : savepopup.titleap,
				titlegarden : savepopup.titlegarden,
				cont1 : savepopup.titletarget,
				cont2 : savepopup.titlead,
				cont3 : savepopup.titleplan,
				action : savepopup.action				
		}
		
		var listcallback = function(returndata) {
			console.log(  "listcallback " + JSON.stringify(returndata) );
			
			if(returndata.result == "SUCESS") {
				alert("저장 되었습니다.");
				
				gfCloseModal();
			}
			
			listsearch();
		}
		
		callAjax("/supportD/saveLecNotice.do", "post", "json", true, param, listcallback);
		
	}
	
	function fn_selectone(no){
		
		var param = {
				li_no : no
		}
		
		var selectonecallback = function(returndata){
			console.log("listcallback" + JSON.stringify(returndata));
			
			forminit(returndata.searchone);
			
			gfModalPop("#layer1");
		}
		
		callAjax("/supportD/selectLecNotice.do", "post", "json", true, param, selectonecallback);
	}
</script>

</head>
<body>
<form id="myForm" action=""  method="">
	<input type="hidden" id="hclickpagenum" name="hclickpagenum"  value="" />
	<input type="hidden" id="action" name="action"  value="" />
	<input type="hidden" id="li_no" name="li_no"  value="" />
	<!-- 초기값 넣어주기 : LoginController, LoginInfoModel, LoginMapper 사용 -->
	<input type="hidden" id="user_email" name="user_email"  value="${sessionScope.email}" />
	<input type="hidden" id="user_hp" name="user_hp"  value="${sessionScope.hp}" />
	<input type="hidden" id="user_name" name="user_name"  value="${sessionScope.userNm}" />
	
	
	
	
	<!-- 모달 배경 -->
	<div id="mask"></div>

	<div id="wrap_area">

		<h2 class="hidden">header 영역</h2>
		<jsp:include page="/WEB-INF/view/common/header.jsp"></jsp:include>

		<h2 class="hidden">컨텐츠 영역</h2>
		<div id="container">
			<ul>
				<li class="lnb">
					<!-- lnb 영역 --> <jsp:include
						page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include> <!--// lnb 영역 -->
				</li>
				<li class="contents">
					<!-- contents -->
					<h3 class="hidden">contents 영역</h3> <!-- content -->
					<div class="content">

						<p class="Location">
							<a href="../dashboard/dashboard.do" class="btn_set home">메인으로</a> <span
								class="btn_nav bold">학습지원</span> <span class="btn_nav bold">강의계획서 및 공지</span> <a href="../supportD/lecNotice.do" class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle">
							<span>강의계획서 관리</span> <span class="fr"> 
							    <a	 class="btnType blue" href="javascript:fPopModal();" name="modal"><span>계획서 등록</span></a>
							</span>
						</p>
					<!-- class(X) id(O) -->
					<div id="searcharea">
						<table style="margin-top: 10px" width="100%" cellpadding="5" cellspacing="0" border="1"  align="left"   style="collapse; border: 1px #50bcdf;">
	                        <tr style="border: 0px; border-color: blue">
	                           <td width="50" height="25" style="font-size: 100%; text-align:left; padding-right:25px;">
	                           		<!-- 분류 -->									
		     	                    <select id="searchtype" name="searchtype" style="width: 100px;" v-model="searchtype">
		     	                            <option value="" >전체</option>
											<option value="title" >과목</option>
											<option value="writer" >강사명</option>
									</select>
									<!-- 검색바  -->
	     	                       <input type="text" style="width: 200px; height: 25px;" placeholder="순번/과목/강사명만 입력해주세요." id="searchvalue" name="searchvalue" v-model="searchvalue">
	     	                       &nbsp;
	     	                       <input type="text" style="width: 60px; height: 25px; border:none; font-weight : bold ;" placeholder="강의기간 : " readonly>
	     	                       &nbsp;
	     	                       <!-- 캘린더 -->
								   <input type="date" style="width: 100px; height: 25px;" placeholder="0000-00-00" id="startdate" name="startdate" v-model="startdate">
								   <input type="date" style="width: 100px; height: 25px;" placeholder="0000-00-00" id="enddate" name="enddate" v-model="enddate">
		                           <a href="" class="btnType blue" id="btnSearch" name="btn"><span>검  색</span></a>
	                           </td>
	                        </tr>
                        </table> 
                    </div>
                    	<!-- class(X) id(O) -->
						<div id="divfileuploadList">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="10%">
									<col width="10%">
									<col width="10%">
									<col width="10%">
									<col width="20%">
									<col width="20%">
									<col width="10%">
									<col width="10%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">순번</th>
										<th scope="col">분류</th>
										<th scope="col">과목명</th>
										<th scope="col">강사명</th>
										<th scope="col">강의시작일</th>
										<th scope="col">강의종료일</th>
										<th scope="col">신청인원</th>
										<th scope="col">정원</th>
									</tr>
								</thead>
								<!-- 강의계획서 목록 데이터  -->
								<tbody id="listfileupload" v-for="(item, index) in listitem">
									<tr>
										<td @click="detailview(item.li_no)">{{item.li_no}}</td>
										<td @click="detailview(item.li_no)">{{item.detail_name}}</td>
										<td @click="detailview(item.li_no)">{{item.li_nm}}</td>
										<td @click="detailview(item.li_no)">{{item.name}}</td>
										<td @click="detailview(item.li_no)">{{item.li_date}}</td>
										<td @click="detailview(item.li_no)">{{item.li_redate}}</td>
										<td @click="detailview(item.li_no)">{{item.li_ap}}</td>
										<td @click="detailview(item.li_no)">{{item.li_garden}}</td>
									</tr>								
								</tbody>
							</table>
							<!-- 페이지 네비게이션 -->
							<div class="paging_area"  id="comnfileuploadPagination" v-html="pagenavi"> </div>
						</div>
	
						
						
						
						
					</div> <!--// content -->

					<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>

	<!-- 모달팝업 -->
	<div id="layer1" class="layerPop layerType2" style="width: 900px;">
		<dl>
			<dt>
				<strong>강의계획서</strong>
			</dt>
			<dd class="content">
				<!-- s : 여기에 내용입력 -->
				<table class="row">
					<caption>caption</caption>
					<colgroup>
						<col width="120px">
						<col width="*">
					</colgroup>					
					<tbody>
						<tr>
							<th scope="row">과정명 <span class="font_red">*</span></th>
							<td colspan='3'><input type="text" class="inputTxt p100" name="titlenm" id="titlenm" v-model="titlenm"/></td>
							<th scope="row">분류 <span class="font_red">*</span></th>
							<td>
								<select id="plectype" name="plectype" style="width: 150px;" v-model="plectype">
								</select>
								
							</td>
						</tr>
						<tr>
							<th scope="row">강사명 <span class="font_red">*</span></th>
							<td colspan='3'><input type="text" class="inputTxt p100" name="titlename" id="titlename" v-model="titlename" readonly/></td>
							<th scope="row">연락처 <span class="font_red">*</span></th>
							<td>
								<input type="text" class="inputTxt p100" name="titlehp" id="titlehp" v-model="titlehp" readonly/>
							</td>
						</tr>
						<tr>
							<th scope="row">이메일 <span class="font_red">*</span></th>
							<td colspan='3'><input type="text" class="inputTxt p100" name="titleemail" id="titleemail" v-model="titleemail" readonly/></td>
							<th scope="row">강의실 <span class="font_red">*</span></th>
							<td>
							    <select id="titlelino2" name="titlelino2" v-model="titlelino2">
							             <option value="">선택</option>
						          <c:forEach items="${roominfolist}" var="list">
						                 <option value="${list.li_no}">${list.ci_nm}</option>
						          </c:forEach>
							    </select>
							</td>							
						</tr>
						<tr>
							<th scope="row">강의 시작일 <span class="font_red">*</span></th>
							<td><input type="date" class="inputTxt p100" name="titledate" id="titledate" v-model="titledate"/></td>
							<th scope="row">강의 종료일 <span class="font_red">*</span></th>
							<td><input type="date" class="inputTxt p100" name="titleredate" id="titleredate" v-model="titleredate"/></td>
							
							<th scope="row">정원 <span class="font_red">*</span></th>
							<td><input type="hidden" class="inputTxt p100" name="titleap" id="titleap" v-model="titleap"/>
							<input type="text" class="inputTxt p100" name="titlegarden" id="titlegarden" v-model="titlegarden"/></td>
						</tr>
						<tr>
							<th scope="row">수업목표</th>
							<td colspan='5'>
							     <textarea class="inputTxt p100"	name="cont1" id="cont1" v-model="titletarget"></textarea>
						   </td>
						</tr>
						<tr>
							<th scope="row">출석</th>
							<td colspan='5'>
							     <textarea class="inputTxt p100"	name="cont2" id="cont2" v-model="titlead"></textarea>
						   </td>
						</tr>
						<tr>
							<th scope="row">강의계획</th>
							<td colspan='5'>
							     <textarea class="inputTxt p100"	name="cont3" id="cont3" v-model="titleplan"></textarea>
						   </td>
						</tr>							
					</tbody>

				</table>

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a href="" class="btnType blue" id="btnSave" name="btn"><span>저장</span></a>
					<a href="" class="btnType blue" id="btnDelete" name="btn" v-show="showln"><span>삭제</span></a> 
					<a href=""	class="btnType gray"  id="btnClose" name="btn"><span>취소</span></a>
				</div>
			</dd>
		</dl>
		<a href="javascript:gfCloseModal();" class="closePop"><span class="hidden">닫기</span></a>
	</div>


	<!--// 모달팝업 -->
</form>
</body>
</html>