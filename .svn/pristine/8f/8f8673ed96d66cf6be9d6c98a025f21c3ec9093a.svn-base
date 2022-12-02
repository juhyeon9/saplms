package kr.happyjob.study.car.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.happyjob.study.admsst.model.FileuploadModel;
import kr.happyjob.study.car.model.CarModel;
import kr.happyjob.study.car.service.CarService;

@Controller
@RequestMapping("/car/")
public class CarController {
	
	@Autowired
	CarService  carService;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	
	  
	/**
	 * 파일 업로드 샘플 초기화면
	 */
	@RequestMapping("car.do")
	public String fileupload(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".initComnCod");
		logger.info("   - paramMap : " + paramMap);
		
		logger.info("+ End " + className + ".initComnCod");

		return "car/car";
	}

	@RequestMapping("listFileupload.do")
	public String listFileupload(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".listFileupload");
		logger.info("   - paramMap : " + paramMap);			
		
		int clickpagenum = Integer.parseInt( String.valueOf(paramMap.get("clickpagenum"))) ;   
		int pagesize = Integer.parseInt( String.valueOf(paramMap.get("pagesize"))) ;  
		int startnum = (clickpagenum - 1) * pagesize;
		
		paramMap.put("startnum", startnum);
		paramMap.put("pagesize", pagesize);
		
		
		List<CarModel> searchlist = carService.listFileupload(paramMap);		
		model.addAttribute("searchlist", searchlist);
		
		int searchlistcnt = carService.searchlistcnt(paramMap);
		model.addAttribute("searchlistcnt", searchlistcnt);
		
		logger.info("+ End " + className + ".listFileupload");

		return "car/carlist";
	}
	
	@RequestMapping("listFileuploadvue.do")
	@ResponseBody
	public Map<String, Object> listFileuploadvue(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".listFileupload");
		logger.info("   - paramMap : " + paramMap);			
		
        Map<String, Object> returnmap = new HashMap<String, Object>();
		
		returnmap.put("result", "SUCESS");
		
		int clickpagenum = Integer.parseInt( String.valueOf(paramMap.get("pagenum"))) ;   
		int pagesize = Integer.parseInt( String.valueOf(paramMap.get("pagesize"))) ;  
		int startnum = (clickpagenum - 1) * pagesize;
		
		paramMap.put("startnum", startnum);
		paramMap.put("pagesize", pagesize);
		
		
		List<CarModel> searchlist = carService.listFileupload(paramMap);		
		returnmap.put("searchlist", searchlist);
		
		int searchlistcnt = carService.searchlistcnt(paramMap);
		returnmap.put("searchlistcnt", searchlistcnt);
		
		logger.info("+ End " + className + ".listFileupload");

		return returnmap;
	}	
 
	
	@RequestMapping("selectFileupload.do")
	@ResponseBody
	public Map<String, Object> selectFileupload(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".selectFileupload");
		logger.info("   - paramMap : " + paramMap);			
		
		CarModel searchone = carService.selectFileupload(paramMap);
		
		Map<String, Object> returnmap = new HashMap<String, Object>();
		
		returnmap.put("result", "SUCESS");
		returnmap.put("searchone", searchone);
		
		logger.info("+ End " + className + ".selectFileupload");

		return returnmap;
	}	
	
	@RequestMapping("saveFileupload.do")
	@ResponseBody
	public Map<String, Object> saveFileupload(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".saveFileupload");
		logger.info("   - paramMap : " + paramMap);			
		
		paramMap.put("loginID",(String) session.getAttribute("loginId"));
		
		String action = String.valueOf(paramMap.get("action"));
		
		if("I".equals(action)) {
			carService.insertFileupload(paramMap);
		} else if("U".equals(action)) {
			carService.updateFileupload(paramMap);
		} else if("D".equals(action)) {
			carService.deleteFileupload(paramMap);
		}
		
		Map<String, Object> returnmap = new HashMap<String, Object>();
		
		returnmap.put("result", "SUCESS");
		
		logger.info("+ End " + className + ".saveFileupload");

		return returnmap;
	}		
	
}  
