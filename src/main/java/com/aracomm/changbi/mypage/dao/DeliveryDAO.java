package com.aracomm.changbi.mypage.dao;

import java.util.HashMap;
import java.util.List;

import com.aracomm.changbi.mypage.vo.DeliverySearchVo;

public interface DeliveryDAO {

	int selectDeliveryListCnt(DeliverySearchVo searchVO);

	List<HashMap<String, Object>> selectDeliveryList(DeliverySearchVo searchVO);

}
