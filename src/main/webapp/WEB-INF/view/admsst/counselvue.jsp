<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${sessionScope.userType ne 'A'}">
    <c:redirect url="/dashboard/dashboard.do"/>
</c:if>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>학습지원관리</title>
<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<!-- sweet swal import -->

<script type="text/javascript">
    
    var pagesize = 3;
    var pagenumsize = 5;
    var counselvue;
    var searchcounsel;
    var dtlcounselvue;
    var subcounselvue;
    var savepopup;
    var subpopup;
	
	/** OnLoad event */ 
	$(function() {
	
		init();
		
		searchlist();

		fRegisterButtonClickEvent();

	});
	
	/** 버튼 이벤트 등록 */
	function fRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();

			var btnId = $(this).attr('id');
			
			switch (btnId) {
				case 'btnSearch' :
					searchlist();
					break;
				case 'btnSave' :
					savecounsel();
					break;
				case 'btnClose' :
					gfCloseModal();
					break;
			}
		});
	}
	
	function init(){

		counselvue = new Vue({
								el : "#listarea",
							  data : {
								  	 listitem : [],
								  	 pagenavi : "",
								  	 /* 밑의 dtlsearchlist에 no를 넣기 싫어서 data에 초기화 해주고 methods에 넘겨줌 */
								  	 li_no:""
							  },
							methods : {
								detailview : function(no){
									this.li_no = no;
									dtlsearchlist();
								} 
							}
		})

		dtlcounselvue = new Vue({
								el : "#dtllistvue",
							  data : {
								  dtllistitem : [],
								  dtlpagenavi : "",
								  li_no : "",
								  login_ID : ""
							  },
								methods : {
									dtldetailview : function(no, loginID){
										this.li_no = no;
										this.loginID = loginID;
										subsearchlist();
									}
									
							  
								}
		})
		
		subcounselvue = new Vue({
								el : "#sublistvue",
							  data : {
								  sublistitem : [],
								  subpagenavi : "",
								  li_no : "",
								  loginID : ""
							  },
							  methods : {
								  subdetailview : function(no, loginID){
									 this.li_no = no;
									 this.loginID = loginID;

									 
								  }
							  }
		})
		
		searchcounsel = new Vue({
								el : "#listcounselvue",
							  data : {
								  	 searchvalue : ""
							  }
		})
		/* 등록버튼 모달 팝업 */
		savepopup = new Vue({
								el : "#layer1",
							  data : {
								  	 li_no : "",
								  	 id : "",
								  	 nm : "",
								  	 cont : "",
								  	 action : ""
								  	
							  }
		})
		/* 등록 버튼 */
		subpopup = new Vue({
							el : "#subbutton",
							data : {
								showln : false
							}
		})
	}
		// 등록
		function consultsave() {
			
			console.log("consultsave : " + $("#loginID").val());
			
			var param = {
					li_no : $("#id").val(),
					loginID : $("#nm").val(),					
					cs_ct : $("#cont").val(),
					action : $("#action").val()
			};
				
			var savecallback= function(rtn) {

				alert("저장 되었습니다.");
				
				gfCloseModal();
				
				Listconsulting($("#loginID").val());
				
			}
		
			callAjax("/admsst/saveConsult.do", "post", "json", true, param, savecallback);
		}					

	
	function searchlist(clickpagenum){
		
		clickpagenum = clickpagenum || 1;
		
		var param = {
				
				clickpagenum : clickpagenum,
				pagesize : pagesize,
				searchvalue : searchcounsel.searchvalue
		};
		
		var listcallback = function(returndata) {
			console.log(  "listcallback " + JSON.stringify(returndata) );
			
			counselvue.listitem = returndata.searchlist;
			
			var paginationHtml = getPaginationHtml(clickpagenum, returndata.searchlistcnt, pagesize, pagenumsize, 'searchlist');
			console.log("paginationHtml : " + paginationHtml);
			
			counselvue.pagenavi = paginationHtml;
			
		}
		
		callAjax("/admsst/listCounselvue.do", "post", "json", true, param, listcallback);
	}
	
	function dtlsearchlist(clickpagenum){
		
		clickpagenum = clickpagenum || 1;
		
		var param = {
				
				li_no : counselvue.li_no,
				clickpagenum : clickpagenum,
				pagesize : pagesize
				
		}
		
		var dtlsearchlistcallback = function(returndata){
			console.log("listcallback" + JSON.stringify(returndata));
			
			dtlcounselvue.dtllistitem = returndata.listCounselDtl;
			
			var paginationHtml = getPaginationHtml(clickpagenum, returndata.searchlistcnt, pagesize, pagenumsize, 'dtlsearchlist');
			console.log("paginationHtml : " + paginationHtml);
			
			dtlcounselvue.dtlpagenavi = paginationHtml;
			
		}
		
		callAjax("/admsst/listCounselDtlvue.do", "post", "json", true, param, dtlsearchlistcallback);
		
	}
	
	function subsearchlist(clickpagenum){
		
		clickpagenum = clickpagenum || 1;
		
		var param = {
				
				li_no : dtlcounselvue.li_no,
				loginID : dtlcounselvue.loginID,
				clickpagenum : clickpagenum,
				pagesize : pagesize
				
		}
		
		var subsearchlistcallback = function(returndata){
			console.log("listcallback" + JSON.stringify(returndata));
			
			subcounselvue.sublistitem = returndata.listCounselDtl2;
			
			var paginationHtml = getPaginationHtml(clickpagenum, returndata.searchlistcnt2, pagesize, pagenumsize, 'subsearchlist');
			console.log("paginationHtml : " + paginationHtml);
			
			subcounselvue.subpagenavi = paginationHtml;
			showpopup(); 
			savecounselhide();
		}
		
		callAjax("/admsst/listCounselDtl2vue.do", "post", "json", true, param, subsearchlistcallback);
		
	}
	
	function showpopup(){
		if(subcounselvue.sublistvue == 0){
			subpopup.showln = false;
		} else{
			subpopup.showln = true;
		}
	}
	
	function fPopModal(){
		
		forminit();
		
		gfModalPop("#layer1");
		
	}

	function forminit(object){
		
		if(object == null || object == ""){
			savepopup.id = dtlcounselvue.loginID;
			savepopup.nm =  dtlcounselvue.li_no;
			savepopup.cont = "";
			savepopup.action = "I";
		} else {
			savepopup.id = dtlcounselvue.loginID;
			savepopup.nm = dtlcounselvue.li_no;
			savepopup.cont = object.cs_ct;
			savepopup.action = "U";
		}
	}
	
	function savecounsel(){
		
		var param = {
				loginID : savepopup.id,
				li_no : savepopup.nm,				
				cs_ct : savepopup.cont,
				action : savepopup.action
		}
		
		var savelistcallback = function(returndata) {
			console.log(  "savelistcallback " + JSON.stringify(returndata) );
			
			if(returndata.result == "SUCESS") {
				alert("저장 되었습니다.");
				
				gfCloseModal();
			}
		}
		subsearchlist();
		
		callAjax("/admsst/saveConsult.do", "post", "json", true, param, savelistcallback);		

	}
	
	function fn_selectone(no) {
		
		var param = {
				li_no : dtlcounselvue.li_no				
		}
		
		var selectoncallback = function(returndata) {
			console.log(  "listcallback " + JSON.stringify(returndata) );
			
			forminit(returndata.listCounselDtl3);
			
			gfModalPop("#layer1");
		}		
		callAjax("/admsst/listCounselDtl3.do", "post", "json", true, param, selectoncallback);		
	}

	function savecounselhide(){
		if($("#sublistvue").val() == 0){
			$("#btnreg").css("display", "block");
		} else {
			$("#btnreg").css("display", "none");
		}
	}

	


</script>

</head>
<body>
<form id="myForm" action=""  method="">
	<input type="hidden" id="hclickpagenum" name="hclickpagenum"  value="" />
	<input type="hidden" id="action" name="action"  value="" />
	<input type="hidden" id="li_no" name="li_no"  value="" />
	<input type="hidden" id="loginID" name="loginID" value =""/>
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
								class="btn_nav bold">학습지원</span> <span class="btn_nav bold">수강상담이력</span> <a href="../admsst/counsel.do" class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle">
							<span>수강상담이력</span> <span class="fr"> 
							</span>
						</p>
						<div id="listcounselvue">
							<table style="margin-top: 10px" width="100%" cellpadding="5" cellspacing="0" border="1"  align="left"   style="collapse; border: 1px #50bcdf;">
		                        <tr style="border: 0px; border-color: blue">
		                        
		                           <td width="50" height="25" style="font-size: 100%; text-align:left; padding-right:25px;">
	
									     <span>과정명</span>
	
		     	                       <input type="text" style="width: 700px; height: 25px;" id="searchvalue" name="searchvalue" v-model="searchvalue">                    
			                           <a href="" class="btnType blue" id="btnSearch" name="btn"><span>검  색</span></a>
		                           </td> 
		                           
		                        </tr>
	                        </table>
	                    </div> 
						<div id="listarea">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="30%">
									<col width="70%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">과정명</th>
										<th scope="col">기간</th>

									</tr>
								</thead>
								<tbody id="listCounsel" v-for="(item, index) in listitem">
									<tr @click="detailview(item.li_no)">
										<td>{{ item.li_nm }}</td>
										<td>{{ item.li_date }}</td>
									</tr>
								</tbody> 
							</table>
							<div class="paging_area"  id="comnfileuploadPagination" v-html="pagenavi"> </div>
						</div>
	

						
						<p class="conTitle mt50">
							<span>참여학생목록</span> <span class="fr"> 
							</span>
						</p>
						<div id="dtllistvue">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="30%">
									<col width="70%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">학생명</th>
										<th scope="col">시험최종점수</th>

									</tr>
								</thead>
								<tbody id="listCounselDtl" v-for="(item, index) in dtllistitem">
									<tr @click="dtldetailview(item.li_no, item.loginID)">
										<td>{{item.ui_name}}</td>
										<td>{{item.ss_score}}</td>
									</tr>
								</tbody>								
							</table>
							<div class="paging_area"  id="comnfileuploadPagination2" v-html="dtlpagenavi"> </div>
						</div>
	
						
						<div id="subbutton">
						<p class="conTitle mt50">
							<span>상담이력 목록 조회</span> <span class="fr"> 
							<!-- style="display : none;" : 화면에서 안보여주게 함 -->
							<a href="javascript:fPopModal();" class="btnType blue" id="btnreg" name="modal" v-show="showln" style="display : none;"> <span>등 록</span> </a>
							</span>
						</p>
						</div>
						<div id="sublistvue">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="10%">
									<col width="30%">
									<col width="30%">
									<col width="30%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">강의번호</th>
										<th scope="col">상담일자</th>
										<th scope="col">상담장소</th>
										<th scope="col">상담자</th>
									</tr>
								</thead>
								<tbody id="listCounselDtl2" v-for="(item, index) in sublistitem">
									<tr @click="subdetailview(item.li_no, item.loginID)">
										<td>{{item.li_no}}</td>
										<td>{{item.cs_date}}</td>
										<td>{{item.cs_place}}</td>
										<td>{{item.cs_nm}}</td>
									</tr>
								</tbody> 
							</table>
							<div class="paging_area"  id="comnfileuploadPagination3" v-html="subpagenavi"> </div>
						</div>

						
					</div> <!--// content -->
							
					<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>

	<!-- 모달팝업 -->
	<div id="layer1" class="layerPop layerType2" style="width: 600px;">
		<dl>
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
							<th scope="row">학생ID <span class="font_red">*</span></th>
							<td><input type="text" id= "kaksangID" v-model="id" readonly></td>
							<th scope="row">과목명 <span class="font_red">*</span></th>
							<td><input type="text" id= "kuamockMiang" v-model="nm" readonly></td>
						</tr>
						<tr>
							<th scope="row">내용 <span class="font_red">*</span></th>
							<td colspan="3">
							     <textarea class="inputTxt p300"	name="cont" id="cont" v-model="cont"> </textarea>
						   </td>
						</tr>
					</tbody>
				</table>

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a href="" class="btnType blue" id="btnSave" name="btn"><span>저장</span></a>
					<a href=""	class="btnType gray"  id="btnClose" name="btn"><span>취소</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>

</form>
</body>
</html>