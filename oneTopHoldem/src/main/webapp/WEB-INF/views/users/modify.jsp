<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>원탑홀덤</title>
<link rel="stylesheet" href="resources/css/default.css">
<script src="resources/js/jquery-3.2.1.min.js"></script>
<script src="resources/js/common.js"></script>

<script>
$(document).ready(function(){
	$("#btn_finish").click(function(){
		if(gfn_isNull($("#reg_mb_password").val())){
			alert("비밀번호를 입력하세요.");
			$("#reg_mb_password").focus();
			return;
		}
		
		if(gfn_isNull($("#reg_mb_password_re").val())){
			alert("비밀번호(확인)를 입력하세요.");
			$("#reg_mb_password_re").focus();
			return;
		}
		
		if(gfn_isNull($("#reg_mb_nick").val())){
			alert("닉네임을 입력하세요.");
			$("#reg_mb_nick").focus();
			return;
		}
		
		if(gfn_isNull($("#reg_mb_email").val())){
			alert("이메일을 입력하세요.");
			$("#reg_mb_email").focus();
			return;
		}
		
		if(gfn_isNull($("#reg_mb_hp").val())){
			alert("휴대폰번호를 입력하세요.");
			$("#reg_mb_hp").focus();
			return;
		}
		
		if(gfn_isNull($("#reg_mb_recom").val())){
			$("#reg_mb_recom").val('0');		
		} 
		
		if($("#reg_mb_password").val() != $("#reg_mb_password_re").val()){
			alert('비밀번호를 다시 확인해주세요');
			$("#reg_mb_password_re").val('');
			$("#reg_mb_password_re").focus();
			return;
		}
		
		if($('#emailAuthCheck').val() == 1){
			alert('이메일 인증을 진행해주세요');
			return;
		};
		var param = {};
		param.loginId = $("#reg_mb_id").val();
		param.telephone = $("#reg_mb_hp").val();
		param.email = $("#reg_mb_email").val();
		param.loginId = $("#reg_mb_id").val();
		param.loginPassword = $("#reg_mb_password").val();
		param.nickname = $("#reg_mb_nick").val();
		param.recommenderAccountId = $("#reg_mb_recom").val();
		
		$.ajax({
			url : 'modifyMember',
			data: param,
			dataType: 'json',
			type : 'post',
			success : function(data){
				console.log(data);
				if(data.result == 'succ'){
					alert("수정완료");
					location.href = 'index';
				}else {
					alert("수정실패");
				}
			}
		})
	});
});

function authEmail(){
	var add = $('#reg_mb_email').val();
	
	if(add == null || add == ''){
		alert('메일주소를 입력하세요');
	}
	
	$.ajax({
		url : 'sendAuthEmail',
		data : {'add':add},
		dataType : 'json',
		type:'post',
		success : function(data){
			if(data.result == 1){
				alert('메일을 발송하였습니다');
				$('#authCode').val(data.authCode);
				$('#authTr').css('display','');
			}
		}
	})
	
}

$(document).on('click','#authBtn',function(){
	var inputCode = $('#reg_mb_authCode').val();
	var authCode = $('#authCode').val();
	
	if(inputCode == authCode){
		$('#authResultTd').text('인증이 완료되었습니다');
		$('#emailAuthCheck').val('2');
		$('#authTr').css('display','none');
		$('#authResultTr').css('display','');
	}else{
		alert('인증번호를 다시 확인해주세요');
		return;
	}
})
</script>
</head>
	

<body>

<!---- headr ---------->
<c:import url="../module/top.jsp"></c:import>
<!---- headr ---------->

<div id="warp">
	<!---- content ---------->

	<div id="content">
		<div id="aside">
			<div class="tit">
				<div class="tt"><span class="big">멤버쉽</span><br>MEMBERSHIP</div>
			</div>
			<div class="sub_menu">
				<ul>
					<li class="over"><a href="modify">· 회원정보수정</a></li>
				</ul>
			</div>
			<div><a href="https://s3.ap-northeast-2.amazonaws.com/onetop/HoldemSetup.exe"><img src="resources/img/sub_down_btn.jpg"></a></div>
		</div>
		<div id="container">
			<div style="padding-bottom:10px;">
				<span id="container_title">회원정보수정</span>
				<div class="sub_nav"><img src="resources/img/home_icon.jpg"> HOME&nbsp;&nbsp;>&nbsp;&nbsp;멤버쉽&nbsp;&nbsp;>&nbsp;&nbsp;<b>회원정보수정</b></div>
			</div>
			
			<div style="padding-top:20px;">
				<div style="border:3px solid #dddddd;text-align:center;padding:10px;">
					<img src="resources/img/join_1_out.jpg"><img src="resources/img/join_bar.jpg">
					<img src="resources/img/join_2_over.jpg"><img src="resources/img/join_bar.jpg">
					<img src="resources/img/join_3_out.jpg">
				</div>
			</div>
			
			<div class="join_tt">회원정보수정 <span class="cm">&nbsp;|&nbsp;&nbsp;필수입력사항</span></div>

			<form id="fregisterform" name="fregisterform" action="modify" onsubmit="return fregisterform_submit(this);" method="post" enctype="multipart/form-data" autocomplete="off">
			<div class="tbl_frm01 tbl_wrap">
				<input type="hidden" id="emailAuthCheck" value="1"/>
				<table>
					<tbody>
						<tr>
							<th scope="row"><label for="reg_mb_id">아이디</label></th>
							<td>					
								<span class="frm_info">영문자, 숫자, _ 만 입력 가능. 최소 16자이상 입력하세요.</span>
								<input type="text" name="mb_id" id="reg_mb_id" class="frm_input" minlength="3" maxlength="20" value="${account.loginId }" readonly >
								<span id="msg_mb_id"></span>
							</td>
						</tr>
						<tr>
							<th scope="row"><label for="reg_mb_password">비밀번호</label></th>
							<td><input type="password" name="mb_password" id="reg_mb_password" class="frm_input" minlength="3" maxlength="20"></td>
						</tr>
						<tr>
							<th scope="row"><label for="reg_mb_password_re">비밀번호 확인</label></th>
							<td><input type="password" name="mb_password_re" id="reg_mb_password_re" class="frm_input" minlength="3" maxlength="20"></td>
						</tr>
						<%-- <tr>
							<th scope="row"><label for="reg_mb_name">이름</label></th>
							<td><input type="text" id="reg_mb_name" name="mb_name" value="${account.nickname }" class="frm_input" size="10"></td>
						</tr> --%>
						<tr>
							<th scope="row"><label for="reg_mb_nick">닉네임</label></th>
							<td>
								<span class="frm_info">
									공백없이 한글,영문,숫자만 입력 가능 (한글2자, 영문4자 이상)<br>
									닉네임을 바꾸시면 앞으로 30일 이내에는 변경 할 수 없습니다.
								</span>
								<input type="hidden" name="mb_nick_default" value="">
								<input type="text" name="mb_nick" id="reg_mb_nick" class="frm_input  nospace" size="10" maxlength="20" value="${account.nickname }">
								<span id="msg_mb_nick"></span>
							</td>
						</tr>
		
						<tr>
							<th scope="row"><label for="reg_mb_email">E-mail</label></th>
							<td>
								<input type="text" name="mb_email" id="reg_mb_email" class="frm_input email" size="70" maxlength="100" value="${account.email }">
								<input type="button" onclick="authEmail()" value="이메일인증"/>
							</td>
						</tr>
						<tr id="authTr" style="display:none;">
							<th scope="row"><label for="reg_mb_tel">인증번호</label></th>
							<td>
								<input type="text" name="mb_authCode" id="reg_mb_authCode" class="frm_input" maxlength="20">
								<input type="button" id="authBtn" value="이메일인증"/>
								<input type="hidden" id="authCode"/>
							</td>
						</tr> 
						<tr id="authResultTr" style="display:none;">
							<th scope="row"><label for="reg_mb_tel">이메일인증</label></th>
							<td id="authResultTd" style="color:#030066;font-weight:bold;"></td>
						</tr>
						<tr>
							<th scope="row"><label for="reg_mb_hp">휴대폰번호</label></th>
							<td><input type="text" name="mb_hp" id="reg_mb_hp" class="frm_input" maxlength="20" value="${account.telephone }"></td>
						</tr>
						<!-- <tr>
							<th scope="row">주소</th>
							<td>
								<label for="reg_mb_zip" class="sound_only">우편번호</label>
								<input type="text" name="mb_zip" value="" id="reg_mb_zip" class="frm_input" size="5" maxlength="6">
								<button type="button" class="btn_frmline" onclick="win_zip('fregisterform', 'mb_zip', 'mb_addr1', 'mb_addr2', 'mb_addr3', 'mb_addr_jibeon');">주소 검색</button><br>
								<input type="text" name="mb_addr1" value="" id="reg_mb_addr1" class="frm_input frm_address" size="50">
								<label for="reg_mb_addr1">기본주소</label><br>
								<input type="text" name="mb_addr2" value="" id="reg_mb_addr2" class="frm_input frm_address" size="50">
								<label for="reg_mb_addr2">상세주소</label>
								<br>
								<input type="text" name="mb_addr3" value="" id="reg_mb_addr3" class="frm_input frm_address" size="50" readonly="readonly">
							</td>
						</tr> -->
						<tr>
							<th scope="row"><label for="reg_mb_recom">추천인ID</label></th>
							<td><input type="text" name="mb_chu" id="reg_mb_recom" class="frm_input" maxlength="20" value="${account.recommenderAccountId }"></td>
						</tr>
					</tbody>
				</table>
			</div>

			<div class="btn_confirm">
				<input type="button" class="myButton" value="✔ 수정완료" id="btn_finish">
			</div>
			</form>
			<br>
		</div>
	</div>

	<!---- content ---------->


	<!---- footer ---------->

	<c:import url="../module/footer.jsp"></c:import>
	<!---- footer ---------->
</div>

</body>
</html>