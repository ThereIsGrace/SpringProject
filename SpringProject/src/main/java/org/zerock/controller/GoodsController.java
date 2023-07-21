package org.zerock.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.zerock.domain.Goods;
import org.zerock.service.GoodsService;

import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnailator;


@Controller
@Log4j 
public class GoodsController {
	
	@Autowired
	private GoodsService service;
	
	@GetMapping("/list")
	public String showItemList(Model model) {
		log.info("show Admin List start...");
		
		List<Goods> goodsList = service.goodsList();
		model.addAttribute("goodsList", goodsList);
		
		return "/goods/goodsAdminList";
		
	}
	
	@GetMapping("/showItem")
	public String showOneItem(Model model) {
		
		log.info("showOneItem start....");
		
		//Goods good = service.showOneItem(pno);
		
		//model.addAttribute("good", good);
		
		return "item";
	}	
	
	@GetMapping("/put")
	public String putCart(Model model) {
		
		/*
		 * for(Goods good: goodsList) { service.putCart(good.getPno()); }
		 * 
		 * model.addAttribute("cartList", goodsList);
		 */
		
		return "mycart"; 	// tiles 적용
	}
	
	/*
	 * @GetMapping("/delete/${pno}") public String removeCart(@RequestParam("pno")
	 * int pno, Model model) {
	 * 
	 * 
	 * }
	 */
	/*@RequestParam("price") String price, @RequestParam("pname") String pname, @RequestParam("stock") int stock*/
//	@PostMapping(value = "/registerGoods", consumes = MediaType.APPLICATION_JSON_VALUE)	
	
//	public Goods registerGoods(@RequestParam("sellPrice") String  sellPrice,@RequestParam("originalPrice") String  originalPrice,@RequestParam("pname") String pname, @RequestParam("stock") String stock,
//			@RequestParam("skintype") String skintype, @RequestParam("category") String category, ) {
	@PostMapping("/registerGoods")	
	public String registerGoods(Goods goods, @RequestParam("uploadFile") MultipartFile[] uploadFile) {
		log.info("registerGoods");
		
		log.info(goods); 		
	
		goods.setStatus("1");
		
	

		List<Goods> list = new ArrayList<>();
		String uploadFolder = "C:\\upload\\main";

		System.out.println("내가 받은 상품 번호: ");
		String uploadFolderPath = String.format("%d", goods.getGno());

		
		
		

		// make folder ---------
		File uploadPath = new File(uploadFolder, uploadFolderPath); // 상품 번호로 경로를 만듦
		log.info("upload path: " + uploadPath);

		if (uploadPath.exists() == false) { // 해당 상품 폴더가 없으면
			uploadPath.mkdirs(); // 해당 경로에 폴더를 만든다.
		}
		// make gno folder

		for (MultipartFile multipartFile : uploadFile) {

			int i = 1;

			log.info("test : i" + i++);

			log.info("-----------------------------------");
			log.info("Upload File Name: " + multipartFile.getOriginalFilename());
			log.info("Upload File Size: " + multipartFile.getSize());



			String uploadFileName = multipartFile.getOriginalFilename();

			// IE has file path
			uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\") + 1);
			log.info("only file name: " + uploadFileName);

			UUID uuid = UUID.randomUUID(); // 첨부파일은 randomUUID를 이용해서 임의의 값을 생성할 수 있다.

			uploadFileName = uuid.toString() + "_" + uploadFileName; // 생성된 값은 원래의 파일 이름과 구분할 수 있도록 중간에 '_'를 추가할 수 있음

			// File saveFile = new File(uploadFolder, uploadFileName);

			try {

				File saveFile = new File(uploadPath, uploadFileName); // c:upload/main/{상품 번호 폴더}/파일이름으로 최종 경로 생성
				multipartFile.transferTo(saveFile); // 파일을 최종 경로로 이동

				int gno2 = goods.getGno();
				goods.setUuid(uploadFileName);
				goods.setImagepath(uploadFolderPath + "/" + uploadFileName);
				

				//service.updateFilePath(goods);
				list.add(goods);

				// 만일 이미지 타입이라면 섬네일을 생성하도록 한다.
				// check image type file
				if (checkImageType(saveFile)) {
					// FileOutputStream :데이터를 파일에 바이트 스트림으로 저장
					// File 클래스는 파일과 디렉터리를 다룸. 그래서 File 인스턴스는 파일일 수도 있고 디렉터리 일수도 있다.
					// File(String parent, String child) - parent 폴더 경로의 child라는 파일에 대한 File 객체 생성
					FileOutputStream thumbnail = new FileOutputStream(new File(uploadPath, "s_" + uploadFileName));

					Thumbnailator.createThumbnail(multipartFile.getInputStream(), thumbnail, 100, 100);

					thumbnail.close();

					goods.setUuid(uuid.toString());	
				}

			} catch (Exception e) {
				e.printStackTrace();
			} // end catch
		} // end for

		
		
		
		//Goods goods = new Goods();
		
			/*
			 * int gno = service.getGno() + 1; System.out.println("내가 보낸 gno:" + gno);
			 * goods.setGno(gno); goods.setPname(pname); goods.setStock(stock2); int
			 * realprice = Integer.parseInt(price); // goods.setPrice(realprice);
			 */		 
		service.registerItem(goods); 
		 
		return "redirect:/goodsWrite/write";
		 
		 
	}
	
	@GetMapping("/registerGoods2")
	public String registerGoods2() {
		log.info("register goods");
		return "registerGoods";
	}
	
	@GetMapping("/goodsWrite/{type}")
	public String goodsWrite(Model model, @PathVariable("type") String type) {
		int gno = service.getGno();
		log.info(gno);
		model.addAttribute("type", type);
		model.addAttribute("gno", gno);
		log.info("goods write");
		return "/goods/goodsWrite";
	}
	
	private String fileUpload() {
		
		return null;
	}
	
	private boolean checkImageType(File file) {

		try {
			String contentType = Files.probeContentType(file.toPath());

			return contentType.startsWith("image");

		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return false;
	}
	
	
	@GetMapping("/goodsDetail/{gno}")
	public String goodsDetail(Model model, @PathVariable("gno") int gno) {
		log.info("goods detail");
		Goods goods = service.showOneItem(gno);
		String optionList = goods.getOption_list();
		String[] optionListAll = optionList.split("\n");
		goods.setOption_list_split(optionListAll);
		model.addAttribute("goods", goods);
		return "/goods/goodsDetail";
	}
}
