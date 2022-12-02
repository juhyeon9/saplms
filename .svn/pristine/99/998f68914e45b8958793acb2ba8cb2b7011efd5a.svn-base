<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>자동차를 불러오자</title>
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<script type="text/javascript">

			var pagesize = 20;
			var pagenumsize = 10;	
			
			
			/** OnLoad event */ 
			$(function() {
				
				init();
				
				listsearch();
				
				comcombo("GRADE", "samplecom", "all", "");
				
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
							fsavefileupload();
							break;	
						case 'btnDelete' :
							//$("#action").val("D");
							nofilepopup.action = "D";	
							fsavefileupload();
							break;	
						case 'btnSavefile' :
							fsavefileuploadatt();
							break;		
						case 'btnDeletefile' :
							$("#action").val("D");
							fsavefileuploadatt();
							break;		
						case 'btnClose' :
							gfCloseModal();
							break;
						case 'btnClosefile' :
							gfCloseModal();
							break;
					}
				});
			}
			
			function init() {
				
				listnoticevue = new Vue({
				                                      el : "#divfileuploadList",
					                               data : {
					                            	           listitem : [],
				                                               pagenavi : ""
					                               },
					                               methods : {
					                            	   detailview : function(carnum) {
					                            		      
					                            		        fn_selectone(carnum);	
					                            	   },
					                        
					                               }
				})
				
				sraecharea = new Vue({
									                    el : "#sraecharea",
									                 data : {
									                	   searchKey : "",
									                	 searchvalue : "",
									                	 samplecom : ""
				                 }     
				
				})
		
				nofilepopup = new Vue({
                    el : "#layer1",
                 data : {
                		  id : "",
                		  carnum : "",
                		  carnum2 : "",
                		  model : "",
                		  modelyear : "",
                		  make :  "",
                		  price :  "",
               	          delshow : false
                 } 
})
			
			
			
			
			
			
		}
		//첫번째 리스트 뿌린부분. 
		function listsearch(pagenum) {
		
		pagenum = pagenum || 1;
		
		console.log("sraecharea.searchKey : " + sraecharea.searchKey + " sraecharea.searchvalue : " + sraecharea.searchvalue);

		var param = {
				pagenum : pagenum,
				pagesize : pagesize,
				searchtype : sraecharea.searchKey, //검색조건 위해 사용. 
				searchvalue : sraecharea.searchvalue // 검색 위해 사용. 
		}
		
		var listcallback = function(returndata) {
			
			console.log(  "listcallback " + JSON.stringify(returndata) );
			
			listnoticevue.listitem = returndata.searchlist;
			
			var paginationHtml = getPaginationHtml(pagenum, returndata.searchlistcnt, pagesize, pagenumsize, 'listsearch');
			console.log("paginationHtml : " + paginationHtml);
			
			listnoticevue.pagenavi = paginationHtml;
			
		}
		
		callAjax("/car/listFileuploadvue.do", "post", "json", true, param, listcallback);
	}
		
	//   파일 미첨부   팝업 처리  시작	
		function fPopModal() {
			
			fn_forminit();
			gfModalPop("#layer1");
			
		}
		
		
		function fn_forminit(data) {
			
			
			if (data == null || data=="") {
				nofilepopup.id = "";
				nofilepopup.carnum = "";
				nofilepopup.carnum2 = "";
				nofilepopup.model = "";
				nofilepopup.modelyear = "";
				nofilepopup.make = "";
				nofilepopup.price = "";
				nofilepopup.action = "I";
				
				nofilepopup.delshow = false;
			} else {
				console.log(data.carnum);
				
				nofilepopup.id = data.id;
				nofilepopup.carnum2 = data.carnum;
				nofilepopup.carnum = data.carnum;
				nofilepopup.model = data.model;
				nofilepopup.modelyear = data.modelyear;
				nofilepopup.make = data.make;
				nofilepopup.price = data.price;
				nofilepopup.action = "U";			
				
				nofilepopup.delshow = true;
			}	

		} 	
		function fsavefileupload() {
			
			var param = {
					carnum : nofilepopup.carnum ,
					carnum2 : nofilepopup.carnum2 ,
					model : nofilepopup.model,
					modelyear : nofilepopup.modelyear ,
					make : nofilepopup.make,
					price : nofilepopup.price,
				
					action : nofilepopup.action,
					id : nofilepopup.id				
			}
			
			var listcallback = function(returndata) {
				console.log(  "listcallback " + JSON.stringify(returndata) );
				
				if(returndata.result == "SUCESS") {
					alert("저장 되었습니다.");
					
					gfCloseModal();
				}
				
				listsearch();
			}
			
			callAjax("/car/saveFileupload.do", "post", "json", true, param, listcallback);		
		}
		
		function fn_selectone(carnum) {
			
			var param = {
					carnum : carnum				
			}
			
			var selectoncallback = function(returndata) {
				console.log(  "listcallback " + JSON.stringify(returndata) );
				
				fn_forminit(returndata.searchone);
				
				gfModalPop("#layer1");
			}		
			callAjax("/car/selectFileupload.do", "post", "json", true, param, selectoncallback);		
		} 
		//   파일 미첨부   팝업 처리  끝	
		
</script>
</head>
<body>
<form id="myForm" action=""  method="">
	<input type="hidden" id="hclickpagenum" name="hclickpagenum"  value="" />
	<input type="hidden" id="action" name="action"  value="" />
	<input type="hidden" id="id" name="id"  value="" />
	<input type="hidden" id="carnum" name="carnum"  value="carnum" />
	
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
								class="btn_nav bold">학습관리</span> <span class="btn_nav bold">게시판</span> <a href="../system/comnCodMgr.do" class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle">
							<span>게시판</span> <span class="fr"> 
							    <a	 class="btnType blue" href="javascript:fPopModal();" name="modal"><span>신규등록</span></a>
						</span>
						</p>
						
						<div id="sraecharea">
							<table style="margin-top: 10px" width="100%" cellpadding="5" cellspacing="0" border="1"  align="left"   style="collapse; border: 1px #50bcdf;">
		                        <tr style="border: 0px; border-color: blue">
		                           <td width="50" height="25" style="font-size: 100%; text-align:left; padding-right:25px;">
		                                  <select id="samplecom"  style="width: 150px;" v-model="samplecom">
										</select> 
										
			     	                      <select id="searchtype" name="searchtype" style="width: 150px;" v-model="searchKey">
			     	                            <option value="" >전체</option>
												<option value="id" >아이디</option>
												<option value="carnum" >차대번호</option>
												<option value="model" >모델</option>
												<option value="modelyear" >년식</option>
												<option value="make" >회사</option>
												<option value="price" >가격</option>
										</select> 
									
		     	                       <input type="text" style="width: 300px; height: 25px;" id="searchvalue" name="searchvalue"  v-model="searchvalue">                    
			                           <a href="" class="btnType blue" id="btnSearch" name="btn"><span>검  색</span></a>
		                           </td> 
		                           
		                        </tr>
	                        </table> 
                        </div>
                        
                        
						<div id="divfileuploadList">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="10%">
									<col width="30%">
									<col width="15%">
									<col width="15%">
									<col width="15%">
									<col width="15%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">아이디</th>
										<th scope="col">차대번호</th>
										<th scope="col">모델</th>
										<th scope="col">년식</th>
										<th scope="col">회사</th>
										<th scope="col">가격</th> 
									</tr>
								</thead>
								<tbody id="listfileupload" v-for=" (item, index) in listitem" >
								     <tr>
								     	<td> {{ item.id }}  </td>
								        <td @click="detailview(item.carnum)"> {{ item.carnum }}  </td>
								         <td> {{ item.model }}  </td>
								         <td> {{ item.modelyear }}  </td>
								         <td> {{ item.make }}  </td>
								         <td> {{ item.price }}  </td>
								         </tr>    
								</tbody>
							</table>
							
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
	<div id="layer1" class="layerPop layerType2" style="width: 600px;">
	
		<dl>
			<dt>
				<strong>글 편집</strong>
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
							<th scope="row">아이디 <span class="font_red">*</span></th>
							<td><input type="text" class="inputTxt p100" name="id" id="id" v-model="id" /></td>
						</tr>
						<tr>
							<th scope="row">차대번호 <span class="font_red">*</span></th>
							<td><input type="text" class="inputTxt p100" name="carnum" id="carnum2" v-model="carnum2" />
									<input type="hidden" class="inputTxt p100" name="carnum" id="carnum" v-model="carnum" />
							</td>
						</tr>
						<tr>
							<th scope="row">모델 <span class="font_red">*</span></th>
							<td><input type="text" class="inputTxt p100" name="model" id="model" v-model="model" /></td>
						</tr>
						<tr>
							<th scope="row">년식 <span class="font_red">*</span></th>
							<td><input type="text" class="inputTxt p100" name="modelyear" id="modelyear" v-model="modelyear" /></td>
						</tr>
						<tr>
							<th scope="row">제조사 <span class="font_red">*</span></th>
							<td>
							     <textarea class="inputTxt p100"	name="make" id="make" v-model="make" > </textarea>
						   </td>
						</tr>
						<tr>
							<th scope="row">가격 <span class="font_red">*</span></th>
							<td>
							     <textarea class="inputTxt p100"	name="price" id="price" v-model="price" > </textarea>
						   </td>
						</tr>
					</tbody>
				</table>

				<!-- e : 여기에 내용입력 -->
				<div class="btn_areaC mt30">
					<a href="" class="btnType blue" id="btnSave" name="btn"><span>저장</span></a> 
					<a href="" class="btnType blue" id="btnDelete" name="btn" v-show="delshow"><span>삭제</span></a> 
					<a href=""	class="btnType gray"  id="btnClose" name="btn"><span>취소</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>

	

	<!--// 모달팝업 -->
</form>
</body>
</html>