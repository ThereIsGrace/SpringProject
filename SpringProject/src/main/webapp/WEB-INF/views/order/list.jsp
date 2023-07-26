<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style>


</style>
<link rel="stylesheet" type="text/css" href="../resources/css/orderlist.css">



<body class="animsition">
	<!-- Product -->
	<section class="bg0 p-t-23 p-b-140">
		<div class="container">
			<div class="p-b-10">
				<h3 class="ltext-103 cl5">배송 조회</h3>
			</div>

			<div class="flex-w flex-sb-m p-b-52">
				<c:forEach var="item" items="${list}" >
					<div class="content">
						<div class="content-head">
							<div class="update-date">${item.payDate} 주문</div>
							<div class="head-data">
								<a href="/goodsDetail/${item.gno}" target="_blank" class="sc-gnmni8-10 sc-8q24ha-0 yma-DD hPjYZj">
 									<span class="head-text">주문 상세보기</span>
 								</a>
							</div>
						</div>
						<div class="card">
							<table>
								<colgroup>
									<col width="1000">
									<col width="">
								</colgroup>
								<tbody>
									<tr>
										<td class="tablerow">
											<div class="left-head">
												<div class="left-data">
													<span font-weight="bold" color="#111111" style="font-size: 1.25rem" class=" hullgd">${item.dstatusStr}</span>
													<span size="4" class="SWzAJ">
														<span size="4" class="sc-13xhsmd-1 kMeFyN"></span>
													</span>
													<c:if test="${item.dstatus ne '1'}">
														<span font-weight="normal" color="#008C00" class="font-green font-size125">${item.parcelDate} 도착</span>
													</c:if>
												</div>
											</div>
											<div class="table-content">
												<div class="margin-top">
													<div class="order-data">
														<div class="image-form">
															<a class="thimage"  href="" target="_blank">
																<img loading="lazy" width="64" height="64" src="/upload">
															</a>
														</div>
														<div class="text-form">
															<div class="jBCCpd">
																<a href="/goodsDetail/${item.gno}" target="_blank" class="sc-gnmni8-10 sc-8q24ha-0 yma-DD hPjYZj">
																	<span style="color:#111111;">${item.pname}</span>
																</a>
																<a class="yma-DD iDQVMP">
																	<div class="gFbjJh">
																		<div class="jxRaeI">
																			<span style="font-weight:normal;"  class="kftgZM">${item.originalPrice}원</span>
																			<span class="kYtEGM">
																				<span class="joIhoV"></span>
																			</span>
																			<span class="jtWNEg">1 개</span>
																		</div>
																	</div>
																	<div class="cUFnye">
																		<button class="iCTfhh bZaQeF">장바구니 담기</button>
																		<div class="sc-xuyxga-1 hxalxw"></div>
																	</div>
																</a>
																<div class="igPkOG"></div>
															</div>
														</div>
													</div>
												</div>
											</div>
										</td>
										<td class="sc-gnmni8-6 gbTJl">
											<div class="sc-gnmni8-7 bCQoer">
												<c:if test="${item.dstatus ne '1'}">
													<button id="myButton1" class="sc-1k9quwu-0 fUUUKW sc-4d0nwb-0 iiEWkt" onclick="fn_Track('/track/list.do',${item.orderNo})">배송조회</button>
												</c:if>
												<button class="sc-1k9quwu-0 fTrGbC sc-gnmni8-8 kiiuoA" onclick="fn_Review('/review/form.do',${item.gno})">리뷰 작성하기</button>
												<input type="hidden" id="code" value="${item.parcelCd}">
												<input type="hidden" id="invoice" value="${item.waybillNum}">
											</div>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
						<div class="sc-h20x0n-0 gcWEbw"></div>
					</div>
				</c:forEach>

				<!-- Load more -->
				<div class="flex-c-m flex-w w-full p-t-45">
					<a href="#" class="flex-c-m stext-101 cl5 size-103 bg2 bor1 hov-btn1 p-lr-15 trans-04">Load More</a>
				</div>
			</div>
		</div>
	</section>

</body>

<script>
	function fn_Review(url,data){
		var form = document.createElement("form");
		form.setAttribute("method", "get");
		form.setAttribute("action", url);
	    var parentNOInput = document.createElement("input");
	    parentNOInput.setAttribute("type","hidden");
	    parentNOInput.setAttribute("value",data);
	    parentNOInput.setAttribute("name","gno");
	
	    form.appendChild(parentNOInput);
	 	document.body.appendChild(form);
	    
	 	console.log(form);
	 	
		form.submit();
	 }
	
	function fn_Track(url,data){
		var form = document.createElement("form");
		form.setAttribute("method", "get");
		form.setAttribute("action", url);
	    var parentNOInput = document.createElement("input");
	    parentNOInput.setAttribute("type","hidden");
	    parentNOInput.setAttribute("value",data);
	    parentNOInput.setAttribute("name","orderlistNo");
	
	    form.appendChild(parentNOInput);
	 	document.body.appendChild(form);
	    
	 	console.log(form);
	 	
		form.submit();
	 }

	
	$(document).ready(function(){
	    var myKey = "1IpHWyVmFmT5fjba9CLngQ"; // sweet tracker에서 발급받은 자신의 키 넣는다.
	    
	        // 택배사 목록 조회 company-api
	        $.ajax({
	            type:"GET",
	            dataType : "json",
	            url:"http://info.sweettracker.co.kr/api/v1/companylist?t_key="+myKey,
	            success:function(data){
	                    
	                    // 방법 1. JSON.parse 이용하기
	                    var parseData = JSON.parse(JSON.stringify(data));
	                     console.log(parseData.Company); // 그중 Json Array에 접근하기 위해 Array명 Company 입력
	                    
	                    // 방법 2. Json으로 가져온 데이터에 Array로 바로 접근하기
	                    var CompanyArray = data.Company; // Json Array에 접근하기 위해 Array명 Company 입력
	                    console.log(CompanyArray); 
	                    
	                    var myData="";
	                    $.each(CompanyArray,function(key,value) {
	                            myData += ('<option value='+value.Code+'>' +'key:'+key+', Code:'+value.Code+',Name:'+value.Name + '</option>');                        
	                    });
	                    $("#tekbeCompnayList").html(myData);
	            }
	        });
	        // 배송정보와 배송추적 tracking-api
	        $("#myButton1").click(function() {
	            var t_code = $('#code').val();
	            var t_invoice = $('#invoice').val();
	            $.ajax({
	                type:"GET",
	                dataType : "json",
	                url:"http://info.sweettracker.co.kr/api/v1/trackingInfo?t_key="+myKey+"&t_code="+t_code+"&t_invoice="+t_invoice,
	                success:function(data){
	                    console.log(data);
	                    var myInvoiceData = "";
	                    if(data.status == false){
	                        myInvoiceData += ('<p>'+data.msg+'<p>');
	                    }else{
	                        myInvoiceData += ('<tr>');                
	                        myInvoiceData += ('<th>'+"보내는사람"+'</td>');                     
	                        myInvoiceData += ('<th>'+data.senderName+'</td>');                     
	                        myInvoiceData += ('</tr>');     
	                        myInvoiceData += ('<tr>');                
	                        myInvoiceData += ('<th>'+"제품정보"+'</td>');                     
	                        myInvoiceData += ('<th>'+data.itemName+'</td>');                     
	                        myInvoiceData += ('</tr>');     
	                        myInvoiceData += ('<tr>');                
	                        myInvoiceData += ('<th>'+"송장번호"+'</td>');                     
	                        myInvoiceData += ('<th>'+data.invoiceNo+'</td>');                     
	                        myInvoiceData += ('</tr>');     
	                        myInvoiceData += ('<tr>');                
	                        myInvoiceData += ('<th>'+"송장번호"+'</td>');                     
	                        myInvoiceData += ('<th>'+data.receiverAddr+'</td>');                     
	                        myInvoiceData += ('</tr>');                                       
	                    }
	                    
	                    
	                    $("#myPtag").html(myInvoiceData)
	                    
	                    var trackingDetails = data.trackingDetails;
	                    
	                    
	                    var myTracking="";
	                    var header ="";
	                    header += ('<tr>');                
	                    header += ('<th>'+"시간"+'</th>');
	                    header += ('<th>'+"장소"+'</th>');
	                    header += ('<th>'+"유형"+'</th>');
	                    header += ('<th>'+"전화번호"+'</th>');                     
	                    header += ('</tr>');     
	                    
	                    $.each(trackingDetails,function(key,value) {
	                        myTracking += ('<tr>');                
	                        myTracking += ('<td>'+value.timeString+'</td>');
	                        myTracking += ('<td>'+value.where+'</td>');
	                        myTracking += ('<td>'+value.kind+'</td>');
	                        myTracking += ('<td>'+value.telno+'</td>');                     
	                        myTracking += ('</tr>');                                    
	                    });
	                    
	                    $("#myPtag2").html(header+myTracking);
	                    
	                }
	            });
	        });
	        
	});
	
</script>
