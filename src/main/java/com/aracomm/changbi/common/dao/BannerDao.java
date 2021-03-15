package com.aracomm.changbi.common.dao;

import java.util.List;
import java.util.Map;

public interface BannerDao {

	List<Map<String, Object>> selectBannerList(String position);

}
