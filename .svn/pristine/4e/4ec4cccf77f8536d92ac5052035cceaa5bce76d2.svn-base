package kr.happyjob.study.car.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import kr.happyjob.study.car.dao.CarDao;
import kr.happyjob.study.car.model.CarModel;;

@Service
public class CarServiceImpl implements CarService {

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Value("${fileUpload.rootPath}")
	private String rootPath;
	
	@Value("${fileUpload.noticePath}")
	private String noticePath;
	
	@Value("${fileUpload.virtualRootPath}")
	private String virtualRootPath;
	
	@Autowired
	CarDao carDao;
	
	/** 목록 조회 */
	public List<CarModel> listFileupload(Map<String, Object> paramMap) throws Exception {
		
		List<CarModel> listupload = carDao.listFileupload(paramMap);
		
		return listupload;
	}


public int searchlistcnt(Map<String, Object> paramMap) throws Exception {
		
		int searchlistcnt = carDao.searchlistcnt(paramMap);
		
		return searchlistcnt;
	}
	
public CarModel selectFileupload(Map<String, Object> paramMap) throws Exception {
	
	CarModel selectupload = carDao.selectFileupload(paramMap);
	
	return selectupload;
}

public void insertFileupload(Map<String, Object> paramMap) throws Exception {
	
	carDao.insertFileupload(paramMap);
	
	return ;
}

public void updateFileupload(Map<String, Object> paramMap) throws Exception {
	
	carDao.updateFileupload(paramMap);
	
	return ;
}

public void deleteFileupload(Map<String, Object> paramMap) throws Exception {
	
	carDao.deleteFileupload(paramMap);
	
	return ;
}

  
    
    
    
}
