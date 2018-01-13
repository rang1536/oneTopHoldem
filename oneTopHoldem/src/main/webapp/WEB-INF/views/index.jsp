<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:import url="./module/side.jsp"></c:import>
<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.css"/>
	<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.15/css/dataTables.bootstrap.css"/>
	
	<!-- <script type="text/javascript" src="https://code.jquery.com/jquery-2.2.4.js"></script> -->
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.js"></script>
	
	<script type="text/javascript" src="https://cdn.datatables.net/1.10.15/js/jquery.dataTables.js"></script>
	<script type="text/javascript" src="https://cdn.datatables.net/buttons/1.3.1/js/dataTables.buttons.min.js"></script>
	<script type="text/javascript" src="https://cdn.datatables.net/buttons/1.3.1/js/buttons.bootstrap.min.js"></script>
	
	<script type="text/javascript" src="https://cdn.datatables.net/1.10.15/js/dataTables.bootstrap.js"></script>
	<script type="text/javascript" src="https://cdn.datatables.net/buttons/1.3.1/js/buttons.html5.min.js"></script>
	<script type="text/javascript" src="https://cdn.datatables.net/buttons/1.3.1/js/buttons.print.min.js"></script>
	<script type="text/javascript" src="https://cdn.datatables.net/buttons/1.3.1/js/buttons.colVis.min.js"></script>
	<script type="text/javascript" src="https://cdn.rawgit.com/bpampuch/pdfmake/0.1.27/build/vfs_fonts.js"></script>
	<script type="text/javascript" src="https://cdn.rawgit.com/bpampuch/pdfmake/0.1.27/build/pdfmake.min.js"></script>
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"></script>
	               
	<link rel="StyleSheet" href="<c:url value='resources/css/datatable.css'/>" type="text/css">
	<link rel="StyleSheet" href="<c:url value='resources/css/datatableUse.css'/>" type="text/css"> 
	
	<script>
	$(document).ready(function(){
		$('.topMenu:eq(0)').css('background','#FFC19E');
		
   		var table = 
        $('#payList').DataTable( {
          dom: 'Bfrtip',
          lengthChange: false,
          autoWidth : false,
          processing: false,
          ordering: true,
          serverSide: false,
          searching: true,
          //lengthMenu : [ [ 3, 5, 10, -1 ], [ 3, 5, 10, "All" ] ],
          pageLength: 50,
          bPaginate: true,
          bLengthChange: false,
          bAutoWidth: false,
          bStateSave: true,
          buttons: [], 
          oLanguage : {
             sProcessing : "처리중...",
             sZeroRecords : "데이터가 없습니다(전체보기시 10초정도 소요될 수 있습니다)",
             oPaginate : {
                   sFirst : "처음",
                   sNext : ">",
                   sPrevious : "<",
                   sLast : "끝"
 
             },
             sInfo : "총_TOTAL_건 중, _START_건부터_END_건까지 표시",
             sInfoEmpty : "0 건 중, 0부터 0 까지 표시", 
             sInfoFiltered : "(총 _MAX_ 건에서 추출 )",
             sSearch : "상세 검색 : "                
       },
	    ajax : {
	   
	      "url":"userList",
	      "type":"POST",
	      "dataSrc": function(json){
	    	   var list = json.list;
	    	   
	    	   for(var i=0; i<list.length; i++){
	    		    list[i].goldText = "<span class='numberInput'>"+list[i].gold+"</span>"
					// 데이터 수정버튼 추가
	   	      		list[i].btnGroup ="<div align='center'>"
	   	      		list[i].btnGroup += "<button type='button' class='btn btn-success' onclick='modifyAccount("+list[i].accountId+")'>수정</button>"
	   	      		list[i].btnGroup += "&nbsp;&nbsp;&nbsp;<button type='button' class='btn btn-warning' onclick='changeStatus("+list[i].accountId+");'>정지</button>"
	   	      		list[i].btnGroup += "&nbsp;&nbsp;&nbsp;<button type='button' class='btn btn-danger' onclick='deleteAccount("+list[i].accountId+");'>삭제</button></div>";		   	    			   	    	
   	           }
	    	   console.log("list : "+list)
	    	   return list;
	      	}
		  },            
		  columns : [
		      {data: "loginId"},
		      {data: "commission"},
		      {data: "createdDate"},
		      {data: "goldCount"},
		      {data: "btnGroup"}	     
		  ],
	         initComplete : function() {
	  
	        	 $('#payList_filter').prepend( $('#buttonWrap')) ;
	        	 
	         } 
	   });
   		
	});
	
	//지점등록
	function addBranchPop(){
		$('#addBranch').modal();
	}
	
	//지점수정
	function modifyAccount(accountId){
		/* alert(accountId); */
		$.ajax({
			url : 'readAccount',
			data : {'accountId':accountId},
			dataType:'json',
			type:'post',
			success:function(data){
				$('#modifyAccount').find('#accountId').val(data.accountId);
				$('#modifyAccount').find('#todayTd').text(data.createdDate);
				$('#modifyAccount').find('#commission').val(data.commission);
				$('#modifyAccount').find('#recommendAccountId').val(data.recommendAccountId);
				$('#modifyAccount').find('#telephone').val(data.telephone);
				$('#modifyAccount').find('#accountText').val(data.accountText);
				
				$('#modifyAccount').modal();
			}
		})
	}
	
	//지점 상태변경( >>정지)
	function changeStatus(accountId){
		if(confirm('해당지점을 정지로 바꾸겠습니다?')){
			//accountStatus > 1로 수정
		}
	}
	
	//지점 삭제
	function deleteAccount(accountId){
		if(confirm('해당지점을 삭제하시겠습니까?')){
			//계정 삭제
		}
	}	
	
	//단체문자
	function sendMms(){
		$('#mms').modal();
	}
	
	</script>
</head>
<body>
<div id="page-wrapper">
	<br/>
	<div class="row" style="text-align:right;margin-right:10px;">
		<div>
			<button type="button" class="btn btn-success" onclick="sendMms();">일괄메세지</button>
			<button type="button" class="btn btn-primary" onclick="addBranchPop();">지점등록</button>
		</div>
		
	</div>
	<div class="row">
		<div class="col-lg-12">
            <a href="#"><i class="fa fa-home fa-fw"></i></a>  >  지점관리
        </div>
	</div>
	
	<div class="row">
		<div id="content">
			<table id="payList">
				<colgroup>
					<col width="150px">
					<col width="100px">
					<col width="150px">
					<col width="150px">               
					<col width="300px">
				</colgroup>
				<thead>
					<tr>
						<th>ID</th>
						<th>커미션</th>
						<th>가입일</th>
						<th>보유머니</th>
						<th>-</th>						
					</tr>
				</thead>
				<tbody>
				    
				</tbody>
			</table>
		</div>
	</div>
</div>

<c:import url="./popup/add_branch.jsp"></c:import>
<c:import url="./popup/modify_account.jsp"></c:import>
<c:import url="./popup/mms.jsp"></c:import>
</body>
</html>