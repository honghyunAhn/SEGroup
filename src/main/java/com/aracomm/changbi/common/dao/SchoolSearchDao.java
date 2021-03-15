package com.aracomm.changbi.common.dao;

import java.util.List;
import java.util.Map;

import com.aracomm.changbi.common.base.BaseSearchVo;

public interface SchoolSearchDao {

	int selectSchoolListTotCnt(BaseSearchVo searchVo);

	List<Map<String, Object>> selectSchoolList(BaseSearchVo searchVo);

}
