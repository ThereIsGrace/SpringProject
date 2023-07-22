package org.zerock.domain;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString 
public class OrderList {
	private int orderlist_no;
	private String mem_id;
	private int totprice;
	private Date regidate;
	private String dsstatus;
	private String waybill_num;
	private String parcel_cd;
}
